/* Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Tests for vboot_api_firmware
 */

#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2secdata.h"
#include "2sysincludes.h"
#include "crc32.h"
#include "host_common.h"
#include "load_kernel_fw.h"
#include "test_common.h"
#include "vboot_kernel.h"
#include "vboot_struct.h"

/* Expected results */

#define MAX_NOTE_EVENTS 10
#define TIME_FUZZ 500
#define KBD_READ_TIME 60

typedef struct {
	uint16_t msec;
	uint16_t freq;
	int time;
} note_event_t;

typedef struct {
	const char *name;
	uint32_t gbb_flags;
	uint32_t keypress_key;
	int keypress_at_count;
	int num_events;
	note_event_t notes[MAX_NOTE_EVENTS];
} test_case_t;

test_case_t test[] = {

	{ "VbBootDeveloperSoundTest( fast )",
	  VB2_GBB_FLAG_DEV_SCREEN_SHORT_DELAY, 0, 0,
	  1,
	  {
		{0, 0, 2000},		// off and return at 2 seconds
	  }},

	{ "VbBootDeveloperSoundTest( normal )",
	  0, 0, 0,
	  3,
	  {
		{250, 400, 20000},	// first beep at 20 seconds
		{250, 400, 20510},	// second beep shortly after
		{0, 0, 30020},	// off and return at 30 seconds
	  }},

	// Now with some keypresses

	{ "VbBootDeveloperSoundTest( normal, Ctrl-D )",
	  0, 4, 20400,			// Ctrl-D between beeps
	  2,
	  {
		{250, 400, 20000},	// first beep at 20 seconds
		{0, 0, 20400},	// sees Ctrl-D, sound off, return
	  }},

	{ "VbBootDeveloperSoundTest( normal, Ctrl-U not allowed )",
	  0, 21, 10000,                          // Ctrl-U at 10 seconds
	  5,
	  {
		{120, 400, 10000},	// complains about Ctrl-U (one beep)
		{120, 400, 10240},	// complains about Ctrl-U (two beeps)
		{250, 400, 20000},	// starts first beep at 20 seconds
		{250, 400, 20510},	// starts second beep
		{0, 0, 30020},	// returns at 30 seconds + 360ms
	  }},
};

/* Mock data */
static uint8_t workbuf[VB2_KERNEL_WORKBUF_RECOMMENDED_SIZE]
	__attribute__((aligned(VB2_WORKBUF_ALIGN)));
static struct vb2_context *ctx;
static struct vb2_shared_data *sd;
static struct vb2_gbb_header gbb;
static uint32_t current_time;
static uint32_t current_ticks;
static int current_event;
static int max_events;
static int matched_events;
static int kbd_fire_at;
static uint32_t kbd_fire_key;
static note_event_t *expected_event;

/* Audio open count, so we can reset it */
extern int audio_open_count;

/* Reset mock data (for use before each test) */
static void ResetMocks(void)
{
	TEST_SUCC(vb2api_init(workbuf, sizeof(workbuf), &ctx),
		  "vb2api_init failed");
	vb2_nv_init(ctx);

	sd = vb2_get_sd(ctx);

	ctx->flags |= VB2_CONTEXT_NO_SECDATA_FWMP;
	sd->status |= VB2_SD_STATUS_SECDATA_FWMP_INIT;

	memset(&gbb, 0, sizeof(gbb));

	current_ticks = 0;
	current_time = 0;

	current_event = 0;
	kbd_fire_at = 0;
	kbd_fire_key = 0;
	audio_open_count = 0;

	matched_events = 0;
	max_events = 0;
}

/****************************************************************************/
/* Mocked verification functions */
struct vb2_gbb_header *vb2_get_gbb(struct vb2_context *c)
{
	return &gbb;
}

vb2_error_t vb2ex_commit_data(struct vb2_context *c)
{
	return VB2_SUCCESS;
}

vb2_error_t VbExDiskGetInfo(VbDiskInfo** infos_ptr, uint32_t* count,
			    uint32_t disk_flags)
{
	return VB2_ERROR_UNKNOWN;
}

vb2_error_t VbExDiskFreeInfo(VbDiskInfo* infos,
			     VbExDiskHandle_t preserve_handle)
{
	return VB2_SUCCESS;
}

vb2_error_t VbExDiskRead(VbExDiskHandle_t handle, uint64_t lba_start,
			 uint64_t lba_count, void* buffer)
{
	return VB2_ERROR_UNKNOWN;
}

vb2_error_t VbExDiskWrite(VbExDiskHandle_t handle, uint64_t lba_start,
			  uint64_t lba_count, const void* buffer)
{
	return VB2_ERROR_UNKNOWN;
}

uint32_t VbExIsShutdownRequested(void)
{
	return 0;
}

uint32_t VbExKeyboardRead(void)
{
	uint32_t tmp;
	uint32_t now;

	vb2ex_msleep(KBD_READ_TIME);
	now = current_time;

	if (kbd_fire_key && now >= kbd_fire_at) {
		VB2_DEBUG("returning %d at %d msec\n",
			  kbd_fire_key, now);
		tmp = kbd_fire_key;
		kbd_fire_key = 0;
		return tmp;
	}
	VB2_DEBUG("returning %d at %d msec\n", 0, now);
	return 0;
}

void vb2ex_msleep(uint32_t msec)
{
	current_ticks += msec;
	current_time = current_ticks;
	VB2_DEBUG("msec=%d at %d msec\n", msec, current_time);
}

uint32_t vb2ex_mtime(void)
{
	return current_ticks;
}

void vb2ex_beep(uint32_t msec, uint32_t frequency)
{
	VB2_DEBUG("msec=%d, frequency=%d at %d msec\n",
		  msec, frequency, current_time);

	if (current_event < max_events &&
	    msec == expected_event[current_event].msec &&
	    frequency == expected_event[current_event].freq &&
	    (current_time - expected_event[current_event].time) < TIME_FUZZ)
		matched_events++;

	if (msec)
		vb2ex_msleep(msec);
	current_event++;
}

vb2_error_t VbExDisplayScreen(uint32_t screen_type, uint32_t locale,
			      const VbScreenData *data)
{
	switch (screen_type) {
		case VB_SCREEN_BLANK:
			VB2_DEBUG("screen_type=BLANK\n");
			break;
		case VB_SCREEN_DEVELOPER_WARNING:
			VB2_DEBUG("screen_type=DEV\n");
			break;
		case VB_SCREEN_RECOVERY_INSERT:
			VB2_DEBUG("screen_type=INSERT\n");
			break;
		case VB_SCREEN_RECOVERY_NO_GOOD:
			VB2_DEBUG("screen_type=NO_GOOD\n");
			break;
		case VB_SCREEN_OS_BROKEN:
			VB2_DEBUG("screen_type=BROKEN\n");
			break;
		default:
			VB2_DEBUG("screen_type=%#x\n", screen_type);
	}

	VB2_DEBUG("current_time is %d msec\n", current_time);

	return VB2_SUCCESS;
}

/****************************************************************************/

static void VbBootDeveloperSoundTest(void)
{
	int i;
	int num_tests =  sizeof(test) / sizeof(test_case_t);

	for (i = 0; i < num_tests; i++) {
		VB2_DEBUG("STARTING %s ...\n", test[i].name);
		ResetMocks();
		gbb.flags = test[i].gbb_flags;
		kbd_fire_key = test[i].keypress_key;
		kbd_fire_at = test[i].keypress_at_count;
		max_events = test[i].num_events;
		expected_event = test[i].notes;
		VbBootDeveloperLegacyClamshell(ctx);
		vb2ex_beep(0, 0);  /* Dummy call to determine end time */
		VB2_DEBUG("INFO: matched %d total %d expected %d\n",
			  matched_events, current_event, test[i].num_events);
		TEST_TRUE(matched_events == test[i].num_events &&
			  current_event == test[i].num_events, test[i].name);
	}
}

int main(int argc, char* argv[])
{
	VbBootDeveloperSoundTest();
	return gTestSuccess ? 0 : 255;
}
