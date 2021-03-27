/* Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Delay/beep functions used in dev-mode kernel selection.
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"
#include "2sysincludes.h"
#include "vboot_api.h"
#include "vboot_audio.h"

int audio_open_count = 0;	/* Times audio has been opened */
static int audio_use_short;	/* Use short delay? */
static uint32_t open_time;	/* Time of last open */
static int beep_count;		/* Number of beeps so far */

/**
 * Initialization function.
 */
void vb2_audio_start(struct vb2_context *ctx)
{
	open_time = vb2ex_mtime(); /* "zero" starts now */
	beep_count = 0;

	if (vb2api_use_short_dev_screen_delay(ctx) &&
	    (audio_open_count++ == 0)) {
		VB2_DEBUG("vb2_audio_start() - using short dev screen delay\n");
		audio_use_short = 1;
	} else {
		audio_use_short = 0;
	}
}

/**
 * Caller should loop without extra delay until this returns false.
 */
int vb2_audio_looping(void)
{
	uint32_t now = vb2ex_mtime() - open_time;

	/* If we're using short delay, wait 2 seconds and don't beep */
	if (audio_use_short)
		return now < 2 * VB2_MSEC_PER_SEC;

	/* Otherwise, beep at 20 and 20.5 seconds */
	if ((beep_count == 0 && now > 20 * VB2_MSEC_PER_SEC) ||
	    (beep_count == 1 && now > 20 * VB2_MSEC_PER_SEC + 500)) {
		vb2ex_beep(250, 400);
		beep_count++;
	}

	/* Stop after 30 seconds */
	return (now < 30 * VB2_MSEC_PER_SEC);
}
