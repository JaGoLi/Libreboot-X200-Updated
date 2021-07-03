/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Tests for developer and recovery mode UIs.
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2struct.h"
#include "2ui.h"
#include "2ui_private.h"
#include "test_common.h"
#include "vboot_kernel.h"

/* Fixed value for ignoring some checks */
#define MOCK_IGNORE 0xffffu

/* Fuzzy matches for check_time() */
#define FUZZ_MS 200

/* Mock data */
/* TODO(b/156448738): Add tests for timer_disabled and error_code */
struct display_call {
	const struct vb2_screen_info *screen;
	uint32_t locale_id;
	uint32_t selected_item;
	uint32_t disabled_item_mask;
	uint32_t hidden_item_mask;
	int timer_disabled;
	uint32_t current_page;
	enum vb2_ui_error error_code;
} __attribute__((packed));

struct beep_call {
	uint32_t msec;
	uint32_t frequency;
	uint32_t time_expected;
};

static uint8_t workbuf[VB2_KERNEL_WORKBUF_RECOMMENDED_SIZE]
	__attribute__((aligned(VB2_WORKBUF_ALIGN)));
static struct vb2_context *ctx;
static struct vb2_shared_data *sd;
static struct vb2_gbb_header gbb;

static struct vb2_ui_context mock_ui_context;
static struct vb2_screen_state mock_state;

static struct display_call mock_displayed[64];
static int mock_displayed_count;
static int mock_displayed_i;

static uint32_t mock_locale_count;

static int mock_calls_until_shutdown;

/* Iteration counter starts from 0
   Mock inputs should response according to this */
static int mock_iters;

static uint32_t mock_key[64];
static int mock_key_trusted[64];
static int mock_key_total;

static uint32_t mock_time_ms;
static const uint32_t mock_time_start_ms = 31ULL * VB2_MSEC_PER_SEC;

static struct beep_call mock_beep[8];
static int mock_beep_count;
static int mock_beep_total;

static enum vb2_dev_default_boot_target mock_default_boot;
static int mock_dev_boot_allowed;
static int mock_dev_boot_altfw_allowed;
static int mock_dev_boot_external_allowed;

static int mock_run_altfw_called;
static uint32_t mock_altfw_last;
static uint32_t mock_altfw_count;

static vb2_error_t mock_vbtlk_retval[32];
static uint32_t mock_vbtlk_expected_flag[32];
static int mock_vbtlk_total;

static int mock_allow_recovery;

/* mock_pp_* = mock data for physical presence button */
static int mock_pp_pressed[64];
static int mock_pp_pressed_total;

static int mock_enable_dev_mode;

#define MOCK_PREPARE_LOG_SIZE 32

static int mock_snapshot_count;
static char mock_prepare_log[64][MOCK_PREPARE_LOG_SIZE];
static int mock_prepare_log_count;
static uint32_t mock_log_page_count;

static void add_mock_key(uint32_t press, int trusted)
{
	if (mock_key_total >= ARRAY_SIZE(mock_key) ||
	    mock_key_total >= ARRAY_SIZE(mock_key_trusted)) {
		TEST_TRUE(0, "  mock_key ran out of entries!");
		return;
	}

	mock_key[mock_key_total] = press;
	mock_key_trusted[mock_key_total] = trusted;
	mock_key_total++;
}

static void add_mock_keypress(uint32_t press)
{
	add_mock_key(press, 0);
}

static void add_mock_vbtlk(vb2_error_t retval, uint32_t get_info_flags)
{
	if (mock_vbtlk_total >= ARRAY_SIZE(mock_vbtlk_retval) ||
	    mock_vbtlk_total >= ARRAY_SIZE(mock_vbtlk_expected_flag)) {
		TEST_TRUE(0, "  mock_vbtlk ran out of entries!");
		return;
	}

	mock_vbtlk_retval[mock_vbtlk_total] = retval;
	mock_vbtlk_expected_flag[mock_vbtlk_total] = get_info_flags;
	mock_vbtlk_total++;
}

static void add_mock_pp_pressed(int pressed)
{
	if (mock_pp_pressed_total >= ARRAY_SIZE(mock_pp_pressed)) {
		TEST_TRUE(0, "  mock_pp ran out of entries!");
		return;
	}

	mock_pp_pressed[mock_pp_pressed_total++] = pressed;
}

static void extend_calls_until_shutdown(void)
{
	if (mock_calls_until_shutdown < mock_key_total)
		mock_calls_until_shutdown = mock_key_total;
	if (mock_calls_until_shutdown < mock_vbtlk_total)
		mock_calls_until_shutdown = mock_vbtlk_total;
	if (mock_calls_until_shutdown < mock_pp_pressed_total)
		mock_calls_until_shutdown = mock_pp_pressed_total;
	mock_calls_until_shutdown++;
}

static void displayed_eq(const char *text,
			 enum vb2_screen screen,
			 uint32_t locale_id,
			 uint32_t selected_item,
			 uint32_t disabled_item_mask,
			 uint32_t hidden_item_mask,
			 uint32_t current_page,
			 int line)
{
	char text_info[32], text_buf[128];

	sprintf(text_info, "(line #%d, displayed #%d)", line, mock_displayed_i);

	if (mock_displayed_i >= mock_displayed_count) {
		sprintf(text_buf, "  %s missing screen %s",
			text_info, text);
		TEST_TRUE(0, text_buf);
		return;
	}

	if (screen != MOCK_IGNORE) {
		sprintf(text_buf, "  %s screen of %s", text_info, text);
		TEST_EQ(mock_displayed[mock_displayed_i].screen->id, screen,
			text_buf);
	}
	if (locale_id != MOCK_IGNORE) {
		sprintf(text_buf, "  %s locale_id of %s", text_info, text);
		TEST_EQ(mock_displayed[mock_displayed_i].locale_id, locale_id,
			text_buf);
	}
	if (selected_item != MOCK_IGNORE) {
		sprintf(text_buf, "  %s selected_item of %s",
			text_info, text);
		TEST_EQ(mock_displayed[mock_displayed_i].selected_item,
			selected_item, text_buf);
	}
	if (disabled_item_mask != MOCK_IGNORE) {
		sprintf(text_buf, "  %s disabled_item_mask of %s",
			text_info, text);
		TEST_EQ(mock_displayed[mock_displayed_i].disabled_item_mask,
			disabled_item_mask, text_buf);
	}
	if (hidden_item_mask != MOCK_IGNORE) {
		sprintf(text_buf, "  %s hidden_item_mask of %s",
			text_info, text);
		TEST_EQ(mock_displayed[mock_displayed_i].hidden_item_mask,
			hidden_item_mask, text_buf);
	}
	if (current_page != MOCK_IGNORE) {
		sprintf(text_buf, "  %s current_page of %s",
			text_info, text);
		TEST_EQ(mock_displayed[mock_displayed_i].current_page,
			current_page, text_buf);
	}
	mock_displayed_i++;
}

static void displayed_no_extra(int line)
{
	char text_info[32], text_buf[128];

	sprintf(text_info, "(line #%d)", line);

	if (mock_displayed_i == 0)
		sprintf(text_buf, "  %s no screen", text_info);
	else
		sprintf(text_buf, "  %s no extra screens", text_info);
	TEST_EQ(mock_displayed_count, mock_displayed_i, text_buf);
}

#define DISPLAYED_EQ(...) displayed_eq(__VA_ARGS__, __LINE__)

#define DISPLAYED_PASS() \
	displayed_eq("", MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, \
		     MOCK_IGNORE, MOCK_IGNORE, __LINE__)

#define DISPLAYED_NO_EXTRA() displayed_no_extra(__LINE__)

static void expect_beep(uint32_t msec,
			uint32_t frequency,
			uint32_t time_expected)
{
	if (mock_beep_total >= ARRAY_SIZE(mock_beep)) {
		TEST_TRUE(0, "  mock_beep ran out of entries!");
		return;
	}

	mock_beep[mock_beep_total++] = (struct beep_call){
		.msec = msec,
		.frequency = frequency,
		.time_expected = time_expected,
	};
}

/* Check if the result time falls in range [expected, expected + FUZZ_MS) */
static void check_time(uint32_t result, uint32_t expected, const char *desc)
{
	TEST_TRUE(result >= expected, desc);
	TEST_TRUE(result - expected < FUZZ_MS, "  within FUZZ_MS");
}

/* Type of test to reset for */
enum reset_type {
	FOR_DEVELOPER,
	FOR_BROKEN_RECOVERY,
	FOR_MANUAL_RECOVERY,
	FOR_DIAGNOSTICS,
};

/* Reset mock data (for use before each test) */
static void reset_common_data(enum reset_type t)
{
	TEST_SUCC(vb2api_init(workbuf, sizeof(workbuf), &ctx),
		  "vb2api_init failed");

	memset(&gbb, 0, sizeof(gbb));

	vb2_nv_init(ctx);

	sd = vb2_get_sd(ctx);
	sd->status |= VB2_SD_STATUS_SECDATA_KERNEL_INIT;

	if (t == FOR_DEVELOPER) {
		ctx->flags |= VB2_CONTEXT_DEVELOPER_MODE;
		sd->flags |= VB2_SD_FLAG_DEV_MODE_ENABLED;
	}

	/* Mock ui_context based on real screens */
	memset(&mock_ui_context, 0, sizeof(mock_ui_context));
	mock_ui_context.ctx = ctx;
	mock_ui_context.state = &mock_state;

	/* For vb2ex_display_ui */
	memset(mock_displayed, 0, sizeof(mock_displayed));
	mock_displayed_count = 0;
	mock_displayed_i = 0;

	/* For vb2ex_get_locale_count */
	mock_locale_count = 1;

	/* For check_shutdown_request */
	if (t == FOR_DEVELOPER)
		mock_calls_until_shutdown = 2000;  /* Larger than 30s */
	else
		mock_calls_until_shutdown = 10;

	/* For iteration counter */
	mock_iters = -1;  /* Accumulates at the beginning of iterations */

	/* For VbExKeyboardRead */
	memset(mock_key, 0, sizeof(mock_key));
	memset(mock_key_trusted, 0, sizeof(mock_key_trusted));
	mock_key_total = 0;

	/* For vb2ex_mtime and vb2ex_msleep  */
	mock_time_ms = mock_time_start_ms;

	/* For vb2ex_beep */
	memset(mock_beep, 0, sizeof(mock_beep));
	mock_beep_count = 0;
	mock_beep_total = 0;

	/* For dev_boot* in 2misc.h */
	mock_default_boot = VB2_DEV_DEFAULT_BOOT_TARGET_INTERNAL;
	mock_dev_boot_allowed = 1;
	mock_dev_boot_altfw_allowed = 0;
	mock_dev_boot_external_allowed = 1;

	/* For vb2ex_run_altfw */
	mock_run_altfw_called = 0;
	mock_altfw_last = -100;
	mock_altfw_count = 2;

	/* For VbTryLoadKernel */
	memset(mock_vbtlk_retval, 0, sizeof(mock_vbtlk_retval));
	memset(mock_vbtlk_expected_flag, 0, sizeof(mock_vbtlk_expected_flag));
	mock_vbtlk_total = 0;

	/* For vb2_allow_recovery */
	mock_allow_recovery = t == FOR_MANUAL_RECOVERY;

	/* For vb2ex_physical_presence_pressed */
	memset(mock_pp_pressed, 0, sizeof(mock_pp_pressed));
	mock_pp_pressed_total = 0;

	/* For vb2_enable_developer_mode */
	mock_enable_dev_mode = 0;

	/* For vb2ex_prepare_log_screen */
	mock_snapshot_count = 0;
	mock_prepare_log_count = 0;
	mock_log_page_count = 1;

	/* Avoid Iteration #0 */
	add_mock_keypress(0);
	if (t == FOR_MANUAL_RECOVERY)
		add_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND,
			       VB_DISK_FLAG_REMOVABLE);
	else
		add_mock_vbtlk(VB2_ERROR_MOCK, 0);
	add_mock_pp_pressed(0);
}

/* Mock functions */
struct vb2_gbb_header *vb2_get_gbb(struct vb2_context *c)
{
	return &gbb;
}

vb2_error_t vb2ex_display_ui(enum vb2_screen screen,
			     uint32_t locale_id,
			     uint32_t selected_item,
			     uint32_t disabled_item_mask,
			     uint32_t hidden_item_mask,
			     int timer_disabled,
			     uint32_t current_page,
			     enum vb2_ui_error error_code)
{
	struct display_call displayed = (struct display_call){
		.screen = vb2_get_screen_info(screen),
		.locale_id = locale_id,
		.selected_item = selected_item,
		.disabled_item_mask = disabled_item_mask,
		.hidden_item_mask = hidden_item_mask,
		.timer_disabled = timer_disabled,
		.current_page = current_page,
		.error_code = error_code,
	};

	/* Ignore repeated calls with same arguments */
	if (mock_displayed_count > 0 &&
	    !memcmp(&mock_displayed[mock_displayed_count - 1], &displayed,
		    sizeof(struct display_call)))
		return VB2_SUCCESS;

	VB2_DEBUG("displayed %d: screen=%#x, locale_id=%u, selected_item=%u, "
		  "disabled_item_mask=%#x, hidden_item_mask=%#x, "
		  "timer_disabled=%d, current_page=%u, error=%#x\n",
		  mock_displayed_count, screen, locale_id, selected_item,
		  disabled_item_mask, hidden_item_mask,
		  timer_disabled, current_page, error_code);

	if (mock_displayed_count >= ARRAY_SIZE(mock_displayed)) {
		TEST_TRUE(0, "  mock vb2ex_display_ui ran out of entries!");
		return VB2_ERROR_MOCK;
	}

	mock_displayed[mock_displayed_count++] = displayed;

	return VB2_SUCCESS;
}

uint32_t vb2ex_get_locale_count(void)
{
	return mock_locale_count;
}

uint32_t VbExIsShutdownRequested(void)
{
	if (mock_calls_until_shutdown < 0)  /* Never request shutdown */
		return 0;
	if (mock_calls_until_shutdown == 0)
		return 1;
	mock_calls_until_shutdown--;

	return 0;
}

uint32_t VbExKeyboardRead(void)
{
	return VbExKeyboardReadWithFlags(NULL);
}

uint32_t VbExKeyboardReadWithFlags(uint32_t *key_flags)
{
	mock_iters++;
	if (mock_iters < mock_key_total) {
		if (key_flags != NULL) {
			if (mock_key_trusted[mock_iters])
				*key_flags = VB_KEY_FLAG_TRUSTED_KEYBOARD;
			else
				*key_flags = 0;
		}
		return mock_key[mock_iters];
	}

	return 0;
}

uint32_t vb2ex_mtime(void)
{
	return mock_time_ms;
}

void vb2ex_msleep(uint32_t msec)
{
	mock_time_ms += msec;
}

void vb2ex_beep(uint32_t msec, uint32_t frequency)
{
	struct beep_call *beep;
	uint32_t cur_time = mock_time_ms - mock_time_start_ms;

	VB2_DEBUG("beep %d: msec = %d, frequency = %d at %d msec\n",
		  mock_beep_count, msec, frequency, cur_time);

	if (mock_beep_total > 0) {
		TEST_TRUE(mock_beep_count < mock_beep_total,
			  "  too many beep calls!");

		beep = &mock_beep[mock_beep_count];

		VB2_DEBUG("beep expected: msec = %d, frequency = %d, "
			  "at %d msec\n",
			  beep->msec, beep->frequency, beep->time_expected);

		TEST_EQ(msec, beep->msec, "  beep duration");
		TEST_EQ(frequency, beep->frequency, "  beep frequency");
		check_time(cur_time, beep->time_expected,
			   "  beep started after expected time");
	}

	mock_time_ms += msec;
	mock_beep_count++;
}

enum vb2_dev_default_boot_target vb2api_get_dev_default_boot_target(
	struct vb2_context *c)
{
	return mock_default_boot;
}

int vb2_dev_boot_allowed(struct vb2_context *c)
{
	return mock_dev_boot_allowed;
}

int vb2_dev_boot_altfw_allowed(struct vb2_context *c)
{
	return mock_dev_boot_altfw_allowed;
}

int vb2_dev_boot_external_allowed(struct vb2_context *c)
{
	return mock_dev_boot_external_allowed;
}

vb2_error_t vb2ex_run_altfw(uint32_t altfw_id)
{
	mock_run_altfw_called++;
	mock_altfw_last = altfw_id;

	return VB2_SUCCESS;
}

uint32_t vb2ex_get_altfw_count(void)
{
	return mock_altfw_count;
}

vb2_error_t VbTryLoadKernel(struct vb2_context *c, uint32_t get_info_flags)
{
	int i = mock_iters;

	/* Return last entry if called too many times */
	if (i >= mock_vbtlk_total)
		i = mock_vbtlk_total - 1;

	TEST_EQ(mock_vbtlk_expected_flag[i], get_info_flags,
		"  unexpected get_info_flags");

	return mock_vbtlk_retval[i];
}

int vb2_allow_recovery(struct vb2_context *c)
{
	return mock_allow_recovery;
}

int vb2ex_physical_presence_pressed(void)
{
	if (mock_iters >= mock_pp_pressed_total)
		return 0;

	return mock_pp_pressed[mock_iters];
}

void vb2_enable_developer_mode(struct vb2_context *c)
{
	mock_enable_dev_mode = 1;
}

const char *vb2ex_get_debug_info(struct vb2_context *c)
{
	return "mocked debug info";
}

const char *vb2ex_get_firmware_log(int reset)
{
	static char mock_firmware_log_buf[MOCK_PREPARE_LOG_SIZE];
	if (reset)
		mock_snapshot_count++;
	snprintf(mock_firmware_log_buf, MOCK_PREPARE_LOG_SIZE,
		 "%d", mock_snapshot_count);
	return mock_firmware_log_buf;
}

uint32_t vb2ex_prepare_log_screen(enum vb2_screen screen, uint32_t locale_id,
				  const char *str)
{
	if (mock_prepare_log_count < ARRAY_SIZE(mock_prepare_log))
		strncpy(mock_prepare_log[mock_prepare_log_count],
			str, MOCK_PREPARE_LOG_SIZE);
	mock_prepare_log_count++;

	return mock_log_page_count;
}

/* Tests */
static void developer_tests(void)
{
	VB2_DEBUG("Testing developer mode...\n");

	/* Power button short pressed = shutdown request */
	if (!DETACHABLE) {
		reset_common_data(FOR_DEVELOPER);
		add_mock_keypress(VB_BUTTON_POWER_SHORT_PRESS);
		mock_calls_until_shutdown = -1;
		TEST_EQ(vb2_developer_menu(ctx),
			VB2_REQUEST_SHUTDOWN,
			"power button short pressed = shutdown");
	}

	/* Proceed to internal disk after timeout */
	reset_common_data(FOR_DEVELOPER);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	expect_beep(250, 400, DEV_DELAY_BEEP1_MS);
	expect_beep(250, 400, DEV_DELAY_BEEP2_MS);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"proceed to internal disk after timeout");
	check_time(mock_time_ms - mock_time_start_ms, DEV_DELAY_NORMAL_MS,
		   "  finished delay");
	TEST_EQ(mock_beep_count, 2, "  beeped twice");
	TEST_TRUE(mock_iters >= mock_vbtlk_total, "  used up mock_vbtlk");

	/* Don't proceed to internal disk after timeout (dev mode disallowed) */
	reset_common_data(FOR_DEVELOPER);
	mock_dev_boot_allowed = 0;
	TEST_EQ(ui_loop(ctx, VB2_SCREEN_DEVELOPER_MODE, NULL),
		VB2_REQUEST_SHUTDOWN,
		"do not proceed to internal disk after timeout "
		"(dev mode disallowed)");

	/* Use short delay */
	reset_common_data(FOR_DEVELOPER);
	gbb.flags |= VB2_GBB_FLAG_DEV_SCREEN_SHORT_DELAY;
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"use short delay");
	check_time(mock_time_ms - mock_time_start_ms, DEV_DELAY_SHORT_MS,
		   "  finished delay");
	TEST_EQ(mock_beep_count, 0, "  never beeped");

	/* Stop timer on any user input: normal delay */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress('A');
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"stop timer on any user input: normal delay");
	TEST_TRUE(mock_time_ms - mock_time_start_ms > DEV_DELAY_NORMAL_MS,
		  "  delay aborted");
	TEST_EQ(mock_calls_until_shutdown, 0, "  loop forever");
	TEST_EQ(mock_beep_count, 0, "  never beeped");

	/* Stop timer on any user input: short delay */
	reset_common_data(FOR_DEVELOPER);
	gbb.flags |= VB2_GBB_FLAG_DEV_SCREEN_SHORT_DELAY;
	add_mock_keypress('A');
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"stop timer on any user input: short delay");
	TEST_TRUE(mock_time_ms - mock_time_start_ms > DEV_DELAY_SHORT_MS,
		  "  delay aborted");
	TEST_EQ(mock_calls_until_shutdown, 0, "  loop forever");
	TEST_EQ(mock_beep_count, 0, "  never beeped");

	/* If fail to load internal disk, don't boot */
	reset_common_data(FOR_DEVELOPER);
	add_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_FIXED);
	TEST_EQ(vb2_developer_menu(ctx), VB2_ERROR_LK_NO_DISK_FOUND,
		"if fail to load internal disk, don't boot");

	/* Select boot internal in dev menu */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"select boot internal in dev menu");

	/* Ctrl+U = boot external */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_CTRL('U'));
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"ctrl+u = boot external");

	/* Ctrl+D = boot internal */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_CTRL('D'));
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"ctrl+d = boot internal");

	/* VB_BUTTON_VOL_DOWN_LONG_PRESS = boot internal */
	if (DETACHABLE) {
		reset_common_data(FOR_DEVELOPER);
		add_mock_keypress(VB_BUTTON_VOL_DOWN_LONG_PRESS);
		add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
		TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
			"VB_BUTTON_VOL_DOWN_LONG_PRESS = boot internal");
	}

	/* Proceed to external disk after timeout */
	reset_common_data(FOR_DEVELOPER);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	mock_default_boot = VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL;
	expect_beep(250, 400, DEV_DELAY_BEEP1_MS);
	expect_beep(250, 400, DEV_DELAY_BEEP2_MS);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"proceed to external disk after timeout");
	check_time(mock_time_ms - mock_time_start_ms, DEV_DELAY_NORMAL_MS,
		   "  finished delay");
	TEST_EQ(mock_beep_count, 2, "  beeped twice");
	TEST_TRUE(mock_iters >= mock_vbtlk_total, "  used up mock_vbtlk");

	/* Default boot from external not allowed, don't boot */
	reset_common_data(FOR_DEVELOPER);
	mock_default_boot = VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL;
	mock_dev_boot_external_allowed = 0;
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"default boot from external disk not allowed, don't boot");

	/* Don't proceed to external disk after timeout (dev mode disallowed) */
	reset_common_data(FOR_DEVELOPER);
	mock_dev_boot_allowed = 0;
	mock_default_boot = VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL;
	TEST_EQ(ui_loop(ctx, VB2_SCREEN_DEVELOPER_MODE, NULL),
		VB2_REQUEST_SHUTDOWN,
		"do not proceed to external disk after timeout "
		"(dev mode disallowed)");

	/* If no external disk, don't boot */
	reset_common_data(FOR_DEVELOPER);
	add_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	mock_default_boot = VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL;
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"if no external disk, don't boot");

	/* Select boot external in dev menu */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	mock_default_boot = VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL;
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"select boot external in dev menu");

	/* Ctrl+L = boot altfw (allowed) */
	reset_common_data(FOR_DEVELOPER);
	mock_dev_boot_altfw_allowed = 1;
	add_mock_keypress(VB_KEY_CTRL('L'));
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"ctrl+l = boot altfw");
	TEST_EQ(mock_run_altfw_called, 1, "  vb2ex_run_altfw called");

	/* Ctrl+L = boot altfw (disallowed) */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_CTRL('L'));
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"ctrl+l = boot altfw");
	TEST_EQ(mock_run_altfw_called, 0,
		"  vb2ex_run_altfw not called");

	/* VB_BUTTON_VOL_UP_LONG_PRESS = boot external */
	if (DETACHABLE) {
		reset_common_data(FOR_DEVELOPER);
		add_mock_keypress(VB_BUTTON_VOL_UP_LONG_PRESS);
		add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
		TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
			"VB_BUTTON_VOL_UP_LONG_PRESS = boot external");
	}

	/* Select to_norm in dev menu and confirm */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_REBOOT,
		"select to_norm in dev menu and confirm");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISABLE_DEV_REQUEST), 1,
		"  disable dev request");

	/* Select to_norm in dev menu and confirm (dev mode disallowed) */
	reset_common_data(FOR_DEVELOPER);
	mock_dev_boot_allowed = 0;
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(ui_loop(ctx, VB2_SCREEN_DEVELOPER_MODE, NULL),
		VB2_REQUEST_REBOOT,
		"select to_norm in dev menu and confirm (dev mode disallowed)");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISABLE_DEV_REQUEST), 1,
		"  disable dev request");

	/* Select to_norm in dev menu and cancel */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"select to_norm in dev menu and cancel");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISABLE_DEV_REQUEST), 0,
		"  disable dev request");

	/* Ctrl+S = to_norm */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_CTRL('S'));
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_REBOOT,
		"ctrl+s = to_norm");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISABLE_DEV_REQUEST), 1,
		"  disable dev request");

	/* Dev mode forced by GBB flag */
	reset_common_data(FOR_DEVELOPER);
	gbb.flags |= VB2_GBB_FLAG_FORCE_DEV_SWITCH_ON;
	add_mock_keypress(VB_KEY_CTRL('S'));
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"dev mode forced by GBB flag");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISABLE_DEV_REQUEST), 0,
		"  disable dev request");

	/* Power off */
	reset_common_data(FOR_DEVELOPER);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	/* Navigate to the bottom most menu item */
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"select power off");

	VB2_DEBUG("...done.\n");
}

static void broken_recovery_tests(void)
{
	VB2_DEBUG("Testing broken recovery mode...\n");

	/* Power button short pressed = shutdown request */
	if (!DETACHABLE) {
		reset_common_data(FOR_BROKEN_RECOVERY);
		add_mock_keypress(VB_BUTTON_POWER_SHORT_PRESS);
		mock_calls_until_shutdown = -1;
		TEST_EQ(vb2_broken_recovery_menu(ctx),
			VB2_REQUEST_SHUTDOWN,
			"power button short pressed = shutdown");
	}

	/* Shortcuts that are always ignored in BROKEN */
	reset_common_data(FOR_BROKEN_RECOVERY);
	add_mock_key(VB_KEY_CTRL('D'), 1);
	add_mock_key(VB_KEY_CTRL('U'), 1);
	add_mock_key(VB_KEY_CTRL('L'), 1);
	add_mock_key(VB_BUTTON_VOL_UP_DOWN_COMBO_PRESS, 1);
	add_mock_key(VB_BUTTON_VOL_UP_LONG_PRESS, 1);
	add_mock_key(VB_BUTTON_VOL_DOWN_LONG_PRESS, 1);
	TEST_EQ(vb2_broken_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"Shortcuts ignored in BROKEN");
	TEST_EQ(mock_calls_until_shutdown, 0, "  loop forever");
	TEST_EQ(mock_displayed_count, 1, "  root screen only");

	VB2_DEBUG("...done.\n");
}

static void manual_recovery_tests(void)
{
	VB2_DEBUG("Testing manual recovery mode...\n");

	/* Timeout, shutdown */
	reset_common_data(FOR_MANUAL_RECOVERY);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"timeout, shutdown");
	TEST_EQ(mock_displayed_count, 1, "  root screen only");

	/* Power button short pressed = shutdown request */
	if (!DETACHABLE) {
		reset_common_data(FOR_MANUAL_RECOVERY);
		add_mock_keypress(VB_BUTTON_POWER_SHORT_PRESS);
		TEST_EQ(vb2_manual_recovery_menu(ctx),
			VB2_REQUEST_SHUTDOWN,
			"power button short pressed = shutdown");
	}

	/* Boots if we have a valid image on first try */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	add_mock_vbtlk(VB2_ERROR_MOCK, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_SUCCESS,
		"boots if valid on first try");

	/* Boots eventually if we get a valid image later */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	add_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	add_mock_vbtlk(VB2_ERROR_MOCK, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_SUCCESS,
		"boots after valid image appears");

	/* Invalid image, then remove, then valid image */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_vbtlk(VB2_ERROR_MOCK, VB_DISK_FLAG_REMOVABLE);
	add_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	add_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	add_mock_vbtlk(VB2_ERROR_MOCK, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_SUCCESS,
		"boots after valid image appears");
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	DISPLAYED_EQ("recovery invalid", VB2_SCREEN_RECOVERY_INVALID,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/* Ctrl+D = to_dev; space = cancel */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_key(VB_KEY_CTRL('D'), 1);
	add_mock_keypress(' ');
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"ctrl+d = to_dev; space = cancel");
	TEST_EQ(mock_enable_dev_mode, 0, "  dev mode not enabled");
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	DISPLAYED_EQ("to_dev", VB2_SCREEN_RECOVERY_TO_DEV,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/* Cancel to_dev transition */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_key(VB_KEY_CTRL('D'), 1);
	if (PHYSICAL_PRESENCE_KEYBOARD)
		add_mock_key(VB_KEY_DOWN, 1);
	add_mock_key(VB_KEY_ENTER, 1);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"cancel to_dev transition");
	TEST_EQ(mock_enable_dev_mode, 0, "  dev mode not enabled");

	/* Confirm to_dev transition */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_key(VB_KEY_CTRL('D'), 1);
	if (PHYSICAL_PRESENCE_KEYBOARD) {
		add_mock_key(VB_KEY_ENTER, 1);
	} else {
		add_mock_pp_pressed(0);
		add_mock_pp_pressed(1);
		add_mock_pp_pressed(1);
		add_mock_pp_pressed(0);
	}
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_REBOOT_EC_TO_RO,
		"confirm to_dev transition");
	if (!PHYSICAL_PRESENCE_KEYBOARD)
		TEST_TRUE(mock_iters >= mock_pp_pressed_total - 1,
			  "  used up mock_pp_pressed");
	TEST_EQ(mock_enable_dev_mode, 1, "  dev mode enabled");

	/* Cannot confirm physical presence by untrusted keyboard */
	if (PHYSICAL_PRESENCE_KEYBOARD) {
		reset_common_data(FOR_MANUAL_RECOVERY);
		add_mock_key(VB_KEY_CTRL('D'), 1);
		add_mock_key(VB_KEY_ENTER, 0);
		TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
			"cannot confirm physical presence"
			" by untrusted keyboard");
		TEST_EQ(mock_enable_dev_mode, 0, "  dev mode not enabled");
	}

	/* Cannot enable dev mode if already enabled */
	reset_common_data(FOR_MANUAL_RECOVERY);
	sd->flags |= VB2_SD_FLAG_DEV_MODE_ENABLED;
	add_mock_key(VB_KEY_CTRL('D'), 1);
	if (PHYSICAL_PRESENCE_KEYBOARD) {
		add_mock_key(VB_KEY_ENTER, 1);
	} else {
		add_mock_pp_pressed(0);
		add_mock_pp_pressed(1);
		add_mock_pp_pressed(0);
	}
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"cannot enable dev mode if already enabled");
	TEST_EQ(mock_enable_dev_mode, 0, "  dev mode already on");

	/* Physical presence button tests */
	if (!PHYSICAL_PRESENCE_KEYBOARD) {
		/* Physical presence button stuck? */
		reset_common_data(FOR_MANUAL_RECOVERY);
		add_mock_key(VB_KEY_CTRL('D'), 1);
		add_mock_pp_pressed(1);  /* Hold since boot */
		add_mock_pp_pressed(0);
		TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
			"physical presence button stuck?");
		TEST_EQ(mock_enable_dev_mode, 0, "  dev mode not enabled");
		DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
			     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
			     MOCK_IGNORE, MOCK_IGNORE);
		DISPLAYED_NO_EXTRA();

		/* Button stuck, enter to_dev again */
		reset_common_data(FOR_MANUAL_RECOVERY);
		add_mock_key(VB_KEY_CTRL('D'), 1);
		add_mock_key(VB_KEY_CTRL('D'), 1);
		add_mock_pp_pressed(1);  /* Hold since boot */
		add_mock_pp_pressed(0);
		add_mock_pp_pressed(1);  /* Press again */
		add_mock_pp_pressed(0);
		TEST_EQ(vb2_manual_recovery_menu(ctx),
			VB2_REQUEST_REBOOT_EC_TO_RO,
			"button stuck, enter to_dev again");
		TEST_TRUE(mock_iters >= mock_pp_pressed_total - 1,
			  "  used up mock_pp_pressed");
		TEST_EQ(mock_enable_dev_mode, 1, "  dev mode enabled");
		DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
			     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
			     MOCK_IGNORE, MOCK_IGNORE);
		DISPLAYED_EQ("to_dev", VB2_SCREEN_RECOVERY_TO_DEV,
			     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
			     MOCK_IGNORE, MOCK_IGNORE);
		DISPLAYED_NO_EXTRA();

		/* Cancel with holding pp button, enter again */
		reset_common_data(FOR_MANUAL_RECOVERY);
		/* Enter to_dev */
		add_mock_key(VB_KEY_CTRL('D'), 1);
		add_mock_pp_pressed(0);
		/* Press pp button */
		add_mock_keypress(0);
		add_mock_pp_pressed(1);
		/* Space = back */
		add_mock_keypress(' ');
		add_mock_pp_pressed(1);
		/* Wait */
		add_mock_keypress(0);
		add_mock_pp_pressed(0);
		/* Enter to_dev again */
		add_mock_key(VB_KEY_CTRL('D'), 1);
		add_mock_pp_pressed(0);
		/* Press pp button again */
		add_mock_pp_pressed(1);
		/* Release */
		add_mock_pp_pressed(0);
		TEST_EQ(vb2_manual_recovery_menu(ctx),
			VB2_REQUEST_REBOOT_EC_TO_RO,
			"cancel with holding pp button, enter again");
		TEST_TRUE(mock_iters >= mock_pp_pressed_total - 1,
			  "  used up mock_pp_pressed");
		TEST_EQ(mock_enable_dev_mode, 1, "  dev mode enabled");
		DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
			     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
			     MOCK_IGNORE, MOCK_IGNORE);
		DISPLAYED_EQ("to_dev", VB2_SCREEN_RECOVERY_TO_DEV,
			     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
			     MOCK_IGNORE, MOCK_IGNORE);
		DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
			     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
			     MOCK_IGNORE, MOCK_IGNORE);
		DISPLAYED_EQ("to_dev", VB2_SCREEN_RECOVERY_TO_DEV,
			     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
			     MOCK_IGNORE, MOCK_IGNORE);
		DISPLAYED_NO_EXTRA();
	}

	/* Enter diagnostics */
	if (DIAGNOSTIC_UI) {
		/* Launch diagnostics is inside manual recovery */
		reset_common_data(FOR_MANUAL_RECOVERY);
		add_mock_keypress(VB_KEY_DOWN);
		add_mock_keypress(VB_KEY_DOWN);
		add_mock_keypress(VB_KEY_ENTER);
		TEST_EQ(vb2_manual_recovery_menu(ctx),
			VB2_REQUEST_REBOOT,
			"Reboot immediately after request diagnostics");
		TEST_EQ(vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST), 1,
			"VB2_NV_DIAG_REQUEST is set");
	}

	VB2_DEBUG("...done.\n");
}

static void language_selection_tests(void)
{
	VB2_DEBUG("Testing language selection...\n");

	/* Enter language menu and change language */
	reset_common_data(FOR_MANUAL_RECOVERY);
	mock_locale_count = 100;
	vb2_nv_set(ctx, VB2_NV_LOCALIZATION_INDEX, 23);
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);	/* select language */
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);	/* select locale 24 */
	add_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"change language");
	DISPLAYED_EQ("RECOVERY_SELECT default", VB2_SCREEN_RECOVERY_SELECT,
		     23, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("RECOVERY_SELECT lang", VB2_SCREEN_RECOVERY_SELECT,
		     23, 0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("LANGUAGE_SELECT 23", VB2_SCREEN_LANGUAGE_SELECT,
		     23, 23, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("LANGUAGE_SELECT 24", VB2_SCREEN_LANGUAGE_SELECT,
		     23, 24, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("RECOVERY_SELECT new locale", VB2_SCREEN_RECOVERY_SELECT,
		     24, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_LOCALIZATION_INDEX), 24,
		"  locale 24 saved to nvdata");

	/* Locale count = 0 */
	reset_common_data(FOR_MANUAL_RECOVERY);
	mock_locale_count = 0;
	vb2_nv_set(ctx, VB2_NV_LOCALIZATION_INDEX, 23);
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);	/* select language */
	add_mock_keypress(VB_KEY_ENTER);	/* select locale 0 */
	add_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"enter language menu");
	DISPLAYED_EQ("RECOVERY_SELECT default", VB2_SCREEN_RECOVERY_SELECT,
		     23, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("RECOVERY_SELECT lang", VB2_SCREEN_RECOVERY_SELECT,
		     23, 0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("LANGUAGE_SELECT index 0", VB2_SCREEN_LANGUAGE_SELECT,
		     23, 0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("RECOVERY_SELECT locale 0", VB2_SCREEN_RECOVERY_SELECT,
		     0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	VB2_DEBUG("...done.\n");
}

static void debug_info_tests(void)
{
	VB2_DEBUG("Testing debug info screen...\n");

	/* Tab = debug info for all menus */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress('\t');
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"tab = debug info in dev mode");
	DISPLAYED_PASS();
	DISPLAYED_EQ("debug info", VB2_SCREEN_DEBUG_INFO, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	reset_common_data(FOR_BROKEN_RECOVERY);
	add_mock_keypress('\t');
	TEST_EQ(vb2_broken_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"tab = debug info in broken recovery mode");
	DISPLAYED_PASS();
	DISPLAYED_EQ("debug info", VB2_SCREEN_DEBUG_INFO, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_keypress('\t');
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"tab = debug info in manual recovery mode");
	DISPLAYED_PASS();
	DISPLAYED_EQ("debug info", VB2_SCREEN_DEBUG_INFO, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/* Failed to enter debug info */
	reset_common_data(FOR_MANUAL_RECOVERY);
	mock_log_page_count = 0;
	add_mock_keypress('\t');
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"failed to enter debug info");
	DISPLAYED_PASS();
	DISPLAYED_PASS();  /* error code */
	DISPLAYED_NO_EXTRA();

	/* Get a one-page debug info */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_keypress('\t');
	add_mock_keypress(VB_KEY_ENTER);  /* back */
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"get a one-page debug info");
	DISPLAYED_PASS();
	DISPLAYED_EQ("debug info", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 3, 0x6, 0x0, 0);
	DISPLAYED_EQ("back to root screen", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/* Get a three-page debug info and navigate */
	reset_common_data(FOR_MANUAL_RECOVERY);
	mock_log_page_count = 3;
	add_mock_keypress('\t');
	add_mock_keypress(VB_KEY_ENTER);  /* page 0, select on page down */
	add_mock_keypress(VB_KEY_ENTER);  /* page 1, select on page down */
	add_mock_keypress(VB_KEY_UP);	  /* page 2, select on page down */
	add_mock_keypress(VB_KEY_ENTER);  /* page 2, select on page up */
	add_mock_keypress(VB_KEY_ENTER);  /* page 1, select on page up */
	add_mock_keypress(VB_KEY_DOWN);	  /* page 0, select on page up */
	add_mock_keypress(VB_KEY_ENTER);  /* page 0, select on page down */
	add_mock_keypress(VB_KEY_DOWN);	  /* page 1, select on page down */
	add_mock_keypress(VB_KEY_ENTER);  /* page 1, select on back */
	extend_calls_until_shutdown();
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"get a three-page debug info and navigate");
	DISPLAYED_PASS();
	DISPLAYED_EQ("debug info page #0", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 2, 0x2, 0x0, 0);
	DISPLAYED_EQ("debug info page #1", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 2, 0x0, 0x0, 1);
	DISPLAYED_EQ("debug info page #2", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 2, 0x4, 0x0, 2);
	DISPLAYED_EQ("debug info page #2", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 1, 0x4, 0x0, 2);
	DISPLAYED_EQ("debug info page #1", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 1, 0x0, 0x0, 1);
	DISPLAYED_EQ("debug info page #0", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 1, 0x2, 0x0, 0);
	DISPLAYED_EQ("debug info page #0", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 2, 0x2, 0x0, 0);
	DISPLAYED_EQ("debug info page #1", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 2, 0x0, 0x0, 1);
	DISPLAYED_EQ("debug info page #1", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, 3, 0x0, 0x0, 1);
	DISPLAYED_EQ("back to root screen", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	VB2_DEBUG("...done.\n");
}

static void firmware_log_tests(void)
{
	VB2_DEBUG("Testing firmware log screens...\n");

	/* Get firmware log */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	if (DIAGNOSTIC_UI)
		add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"get firmware log");
	TEST_EQ(mock_prepare_log_count, 1,
		"  prepared firmware log once");
	TEST_EQ(strcmp(mock_prepare_log[0], "1"), 0,
		"  got correct firmware log");

	/* Enter firmware log screen again will reacquire a newer one */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	if (DIAGNOSTIC_UI)
		add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"enter the screen again and reacquire a new log");
	TEST_EQ(mock_prepare_log_count, 2,
		"  prepared firmware log twice");
	TEST_EQ(strcmp(mock_prepare_log[0], "1"), 0,
		"  got correct firmware log");
	TEST_EQ(strcmp(mock_prepare_log[1], "2"), 0,
		"  got a new firmware log");

	/* Back to firmware log screen again will not reacquire a newer one */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	if (DIAGNOSTIC_UI)
		add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress('\t');  /* enter debug info screen */
	add_mock_keypress(VB_KEY_ESC);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"back to the screen and do not reacquire a new log");
	TEST_EQ(mock_prepare_log_count, 3,
		"  prepared firmware log three times");
	TEST_EQ(strcmp(mock_prepare_log[0], "1"), 0,
		"  got correct firmware log");
	/* Skip entry #1 which is for preparing debug info */
	TEST_EQ(strcmp(mock_prepare_log[2], "1"), 0,
		"  got the same firmware log");

	VB2_DEBUG("...done.\n");
}

static void developer_screen_tests(void)
{
	VB2_DEBUG("Testing developer mode screens...\n");

	/* Dev mode: default selected item */
	reset_common_data(FOR_DEVELOPER);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"dev mode screen: set default selection to boot internal");
	DISPLAYED_EQ("dev mode screen", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);

	reset_common_data(FOR_DEVELOPER);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	mock_default_boot = VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL;
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"dev mode screen: set default selection to boot external");
	DISPLAYED_EQ("dev mode screen", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, 3, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);

	/* Dev mode: disabled and hidden item mask */
	reset_common_data(FOR_DEVELOPER);
	mock_dev_boot_altfw_allowed = 1;
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"dev mode screen: no disabled or hidden item");
	DISPLAYED_EQ("dev mode screen", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, MOCK_IGNORE, 0x0, 0x0, MOCK_IGNORE);

	reset_common_data(FOR_DEVELOPER);
	mock_dev_boot_altfw_allowed = 1;
	gbb.flags |= VB2_GBB_FLAG_FORCE_DEV_SWITCH_ON;
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"dev mode screen: hide to_norm item");
	DISPLAYED_EQ("dev mode screen", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, MOCK_IGNORE, 0x0, 0x2, MOCK_IGNORE);

	reset_common_data(FOR_DEVELOPER);
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	mock_dev_boot_external_allowed = 0;
	mock_dev_boot_altfw_allowed = 1;
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"dev mode screen: hide boot external");
	DISPLAYED_EQ("dev mode screen", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, MOCK_IGNORE, 0x0, 0x8, MOCK_IGNORE);

	/* Dev mode screen */
	reset_common_data(FOR_DEVELOPER);  /* Select #2 by default */
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	/* #0: Language menu */
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	/* #1: Return to secure mode */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #2: Boot internal */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"dev mode screen");
	/* #0: Language menu */
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	DISPLAYED_EQ("dev mode", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, 0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#0: language menu", VB2_SCREEN_LANGUAGE_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #1: Return to secure mode */
	DISPLAYED_PASS();
	DISPLAYED_EQ("dev mode", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, 1, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#1: return to secure mode", VB2_SCREEN_DEVELOPER_TO_NORM,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #2: Boot internal */
	DISPLAYED_PASS();
	DISPLAYED_EQ("dev mode", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	VB2_DEBUG("#2: boot internal (no extra screen)\n");
	DISPLAYED_NO_EXTRA();

	reset_common_data(FOR_DEVELOPER);  /* Select #3 by default */
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	mock_default_boot = VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL;
	/* #3: Boot external */
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_developer_menu(ctx), VB2_SUCCESS,
		"dev mode screen");
	/* #3: Boot external */
	DISPLAYED_EQ("dev mode", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, 3, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	VB2_DEBUG("#3: boot external (no extra screen)\n");
	DISPLAYED_NO_EXTRA();

	reset_common_data(FOR_DEVELOPER);  /* Select #2 by default */
	mock_dev_boot_altfw_allowed = 1;
	/* #4: Alternate boot */
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"dev mode screen");
	TEST_EQ(mock_run_altfw_called, 1, "  vb2ex_run_altfw called");

	reset_common_data(FOR_DEVELOPER);  /* Select #2 by default */
	add_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_FIXED);
	/* #5: Advanced options */
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* End of menu */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);  /* Blocked */
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"dev mode screen");
	/* #5: Advanced options */
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	DISPLAYED_EQ("dev mode", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, 5, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#4: advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* End of menu */
	DISPLAYED_PASS();
	DISPLAYED_EQ("end of menu", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, 6, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/* Advanced options screen: disabled and hidden item mask */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"advanced options screen: hide to_dev");
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, MOCK_IGNORE, 0x0, 0x2, MOCK_IGNORE);

	/* Advanced options screen */
	reset_common_data(FOR_DEVELOPER);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #0: Language menu */
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	/* #1: (Hidden) */
	/* #2: Debug info */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #3: Firmware log */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #4: Back */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* End of menu */
	add_mock_keypress(VB_KEY_ENTER);
	extend_calls_until_shutdown();
	TEST_EQ(vb2_developer_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"advanced options screen");
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	/* #0: Language menu */
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#0: language menu", VB2_SCREEN_LANGUAGE_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #1: (Hidden) */
	/* #2: Debug info */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#2: debug info", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #3: Firmware log */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 3, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#3: firmware log", VB2_SCREEN_FIRMWARE_LOG,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #4: Back */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 4, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#4: back", VB2_SCREEN_DEVELOPER_MODE,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* End of menu */
	DISPLAYED_EQ("end of menu", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	VB2_DEBUG("...done.\n");
}

static void broken_recovery_screen_tests(void)
{
	/* Broken screen: disabled and hidden item mask */
	reset_common_data(FOR_BROKEN_RECOVERY);
	TEST_EQ(vb2_broken_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"broken screen: no disabled and hidden item mask");
	DISPLAYED_EQ("broken screen", VB2_SCREEN_RECOVERY_BROKEN,
		     MOCK_IGNORE, MOCK_IGNORE, 0x0, 0x0, MOCK_IGNORE);

	/* Broken screen */
	reset_common_data(FOR_BROKEN_RECOVERY);
	/* #0: Language menu */
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	/* #1: Advanced options */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* End of menu */
	add_mock_keypress(VB_KEY_ESC);
	extend_calls_until_shutdown();
	TEST_EQ(vb2_broken_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"broken screen");
	/* #0: Language menu */
	DISPLAYED_PASS();
	DISPLAYED_EQ("broken screen", VB2_SCREEN_RECOVERY_BROKEN,
		     MOCK_IGNORE, 0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#0: language menu", VB2_SCREEN_LANGUAGE_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #1: Advanced options */
	DISPLAYED_PASS();
	DISPLAYED_EQ("broken screen", VB2_SCREEN_RECOVERY_BROKEN,
		     MOCK_IGNORE, 1, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#1: advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* End of menu */
	DISPLAYED_EQ("end of menu", VB2_SCREEN_RECOVERY_BROKEN,
		     MOCK_IGNORE, 1, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/* Advanced options screen: disabled and hidden item mask */
	reset_common_data(FOR_BROKEN_RECOVERY);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_broken_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"advanced options screen: hide to_dev item");
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, MOCK_IGNORE, 0x0, 0x2, MOCK_IGNORE);

	/* Advanced options screen */
	reset_common_data(FOR_BROKEN_RECOVERY);
	add_mock_keypress(VB_KEY_ENTER);
	/* #0: Language menu */
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	/* #1: (Hidden) */
	/* #2: Debug info */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #3: Firmware log */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #4: Back */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* End of menu */
	add_mock_keypress(VB_KEY_ENTER);
	extend_calls_until_shutdown();
	TEST_EQ(vb2_broken_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"advanced options screen");
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	/* #0: Language menu */
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#0: language menu", VB2_SCREEN_LANGUAGE_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #1: (Hidden) */
	/* #2: Debug info */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#2: debug info", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #3: Firmware log */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 3, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#3: firmware log", VB2_SCREEN_FIRMWARE_LOG,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #4: Back */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 4, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#4: back", VB2_SCREEN_RECOVERY_BROKEN,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* End of menu */
	DISPLAYED_EQ("end of menu", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	VB2_DEBUG("...done.\n");
}

static void manual_recovery_screen_tests(void)
{
	/* Recovery select screen: disabled and hidden item mask */
	reset_common_data(FOR_MANUAL_RECOVERY);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		DIAGNOSTIC_UI ?
			"recovery select screen: no disabled or hidden item" :
			"recovery select screen: hide `launch diag`");
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, 0x0, DIAGNOSTIC_UI ? 0x0 : 0x8,
		     MOCK_IGNORE);

	/* Recovery select screen */
	reset_common_data(FOR_MANUAL_RECOVERY);
	/* #0: Language menu */
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	/* #1: Phone recovery */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #2: External disk recovery */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_ESC);
	/* #3: Launch diagnostics */
	if (DIAGNOSTIC_UI)
		add_mock_keypress(VB_KEY_DOWN);
	/* #4: Advanced options */
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* End of menu */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);  /* Blocked */
	extend_calls_until_shutdown();
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"recovery select screen");
	/* #0: Language menu */
	DISPLAYED_PASS();
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, 0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#0: language menu", VB2_SCREEN_LANGUAGE_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #1: Phone recovery */
	DISPLAYED_PASS();
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, 1, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#1: phone recovery", VB2_SCREEN_RECOVERY_PHONE_STEP1,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #2: External disk recovery */
	DISPLAYED_PASS();
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#2: disk recovery", VB2_SCREEN_RECOVERY_DISK_STEP1,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	/* #3: Launch diagnostics */
	if (DIAGNOSTIC_UI)
		DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
			MOCK_IGNORE, 3, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	/* #4: Advanced options */
	DISPLAYED_EQ("recovery select", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, 4, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);

	DISPLAYED_EQ("#3: advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* End of menu */
	DISPLAYED_PASS();
	DISPLAYED_EQ("end of menu", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, 5, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/* Advanced options screen: disabled and hidden item mask */
	reset_common_data(FOR_MANUAL_RECOVERY);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	if (DIAGNOSTIC_UI)
		add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"advanced options screen: no disabled or hidden item");
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	if (DIAGNOSTIC_UI)
		DISPLAYED_PASS();
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, MOCK_IGNORE, 0x0, 0x0, MOCK_IGNORE);

	/* Advanced options screen */
	reset_common_data(FOR_MANUAL_RECOVERY);
	/* #0: Language menu */
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	if (DIAGNOSTIC_UI)
		add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	/* #1: Enable dev mode */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #2: Debug info */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #3: Firmware log */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #4: Back */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* End of menu */
	add_mock_keypress(VB_KEY_ENTER);
	add_mock_keypress(VB_KEY_DOWN);
	extend_calls_until_shutdown();
	TEST_EQ(vb2_manual_recovery_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"advanced options screen");
	DISPLAYED_PASS();
	DISPLAYED_PASS();
	if (DIAGNOSTIC_UI)
		DISPLAYED_PASS();
	DISPLAYED_PASS();
	/* #0: Language menu */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 0, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#0: language menu", VB2_SCREEN_LANGUAGE_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #1: Enable dev mode */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 1, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#1: enable dev mode", VB2_SCREEN_RECOVERY_TO_DEV,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #2: Debug info */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#2: debug info", VB2_SCREEN_DEBUG_INFO,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #3: Firmware log */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 3, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#3: firmware log", VB2_SCREEN_FIRMWARE_LOG,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #4: Back */
	DISPLAYED_PASS();
	DISPLAYED_EQ("advanced options", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 4, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#4: back", VB2_SCREEN_RECOVERY_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* End of menu */
	DISPLAYED_PASS();
	DISPLAYED_EQ("end of menu", VB2_SCREEN_ADVANCED_OPTIONS,
		     MOCK_IGNORE, 2, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	VB2_DEBUG("...done.\n");
}

static void diagnostics_screen_tests(void)
{
	VB2_DEBUG("Testing diagnostic screens...\n");

	/* Diagnostics screen: disabled and hidden item mask */
	reset_common_data(FOR_DIAGNOSTICS);
	TEST_EQ(vb2_diagnostic_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"diagnostic screen: no disabled or hidden item");
	DISPLAYED_EQ("diagnostic menu", VB2_SCREEN_DIAGNOSTICS,
		     MOCK_IGNORE, MOCK_IGNORE, 0x0, 0x0, MOCK_IGNORE);

	/* Diagnostics screen */
	reset_common_data(FOR_DIAGNOSTICS);

	/* #0: Language menu */
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	/* #1: Storage screen */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #2: Quick memory test screen */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #3: Full memory test screen */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	/* #4: Power off (End of menu) */
	add_mock_keypress(VB_KEY_ESC);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_ENTER);
	mock_calls_until_shutdown = -1;
	TEST_EQ(vb2_diagnostic_menu(ctx), VB2_REQUEST_SHUTDOWN,
		"diagnostic screen");

	DISPLAYED_EQ("default on first button of menu",
		     VB2_SCREEN_DIAGNOSTICS, MOCK_IGNORE, 1, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE);
	/* #0: Language menu */
	DISPLAYED_EQ("language selection",
		     VB2_SCREEN_DIAGNOSTICS, MOCK_IGNORE, 0, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#0: language menu", VB2_SCREEN_LANGUAGE_SELECT,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE,
		     MOCK_IGNORE);
	/* #1: Storage screen */
	DISPLAYED_PASS();
	DISPLAYED_EQ("storage button",
		     VB2_SCREEN_DIAGNOSTICS, MOCK_IGNORE, 1, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#1: storage screen",
		     VB2_SCREEN_DIAGNOSTICS_STORAGE_HEALTH, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	/* #2: Quick memory test screen */
	DISPLAYED_PASS();
	DISPLAYED_EQ("quick memory test button",
		     VB2_SCREEN_DIAGNOSTICS, MOCK_IGNORE, 2, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#1: quick memory test screen",
		     VB2_SCREEN_DIAGNOSTICS_MEMORY_QUICK, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	/* #3: Full memory test screen */
	DISPLAYED_PASS();
	DISPLAYED_EQ("full memory test button",
		     VB2_SCREEN_DIAGNOSTICS, MOCK_IGNORE, 3, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_EQ("#3: full memory test screen",
		     VB2_SCREEN_DIAGNOSTICS_MEMORY_FULL, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	/* #4: Power of (End of menu) */
	DISPLAYED_PASS();
	DISPLAYED_EQ("power off",
		     VB2_SCREEN_DIAGNOSTICS, MOCK_IGNORE, 4, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	VB2_DEBUG("...done.\n");
}

int main(void)
{
	developer_tests();
	broken_recovery_tests();
	manual_recovery_tests();
	language_selection_tests();
	debug_info_tests();
	firmware_log_tests();

	/* Screen displayed */
	developer_screen_tests();
	broken_recovery_screen_tests();
	manual_recovery_screen_tests();
	diagnostics_screen_tests();

	return gTestSuccess ? 0 : 255;
}
