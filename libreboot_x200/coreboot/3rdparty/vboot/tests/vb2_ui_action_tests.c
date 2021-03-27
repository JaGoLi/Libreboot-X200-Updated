/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Tests for UI related actions.
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2ui.h"
#include "2ui_private.h"
#include "test_common.h"
#include "vboot_kernel.h"

/* Fixed value for ignoring some checks. */
#define MOCK_IGNORE 0xffffu

/* Mock screen index for testing screen utility functions. */
#define MOCK_NO_SCREEN 0xef00
#define MOCK_SCREEN_BASE 0xef10
#define MOCK_SCREEN_MENU 0xef11
#define MOCK_SCREEN_TARGET0 0xef20
#define MOCK_SCREEN_TARGET1 0xef21
#define MOCK_SCREEN_TARGET2 0xef22
#define MOCK_SCREEN_ACTION 0xef30
#define MOCK_SCREEN_ALL_ACTION 0xef32

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

static uint8_t workbuf[VB2_KERNEL_WORKBUF_RECOMMENDED_SIZE]
	__attribute__((aligned(VB2_WORKBUF_ALIGN)));
static struct vb2_context *ctx;
static struct vb2_shared_data *sd;
static struct vb2_gbb_header gbb;

static int mock_calls_until_shutdown;

static struct vb2_ui_context mock_ui_context;

static struct display_call mock_displayed[64];
static int mock_displayed_count;
static int mock_displayed_i;

static uint32_t mock_key[64];
static int mock_key_trusted[64];
static int mock_key_count;
static int mock_key_total;

static int mock_get_screen_info_called;

static vb2_error_t mock_vbtlk_retval;
static uint32_t mock_vbtlk_expected_flag;

static int mock_dev_boot_allowed;
static int mock_dev_boot_legacy_allowed;

static int mock_vbexlegacy_called;
static enum VbAltFwIndex_t mock_altfw_num_last;
static uint32_t mock_bootloader_count;

static uint32_t mock_time_ms;
static const uint32_t mock_time_start_ms = 31ULL * VB2_MSEC_PER_SEC;

/* Mock actions */
static uint32_t mock_action_called;
static uint32_t mock_action_countdown_limit;
static vb2_error_t mock_action_countdown(struct vb2_ui_context *ui)
{
	if (++mock_action_called >= mock_action_countdown_limit)
		return VB2_SUCCESS;
	return VB2_REQUEST_UI_CONTINUE;
}

static vb2_error_t mock_action_screen_change(struct vb2_ui_context *ui)
{
	return vb2_ui_screen_change(ui, MOCK_SCREEN_BASE);
}

static vb2_error_t mock_action_base(struct vb2_ui_context *ui)
{
	mock_action_called++;
	return VB2_SUCCESS;
}

static int mock_action_flags;
static vb2_error_t mock_action_flag0(struct vb2_ui_context *ui)
{
	if ((1 << 0) & mock_action_flags)
		return VB2_SUCCESS;
	return VB2_REQUEST_UI_CONTINUE;
}

static vb2_error_t mock_action_flag1(struct vb2_ui_context *ui)
{
	if ((1 << 1) & mock_action_flags)
		return VB2_SUCCESS;
	return VB2_REQUEST_UI_CONTINUE;
}

static vb2_error_t mock_action_flag2(struct vb2_ui_context *ui)
{
	if ((1 << 2) & mock_action_flags)
		return VB2_SUCCESS;
	return VB2_REQUEST_UI_CONTINUE;
}

static uint32_t mock_action_delay_ms;
static vb2_error_t mock_action_msleep(struct vb2_ui_context *ui)
{
	vb2ex_msleep(mock_action_delay_ms);
	return VB2_REQUEST_UI_CONTINUE;
}

/* Mock screens */
struct vb2_screen_info mock_screen_temp;
const struct vb2_screen_info mock_screen_blank = {
	.id = VB2_SCREEN_BLANK,
	.name = "mock_screen_blank",
};
const struct vb2_screen_info mock_screen_base = {
	.id = MOCK_SCREEN_BASE,
	.name = "mock_screen_base: menuless screen",
};
const struct vb2_menu_item mock_screen_menu_items[] = {
	{
		.text = "item 0",
		.target = MOCK_SCREEN_TARGET0,
	},
	{
		.text = "item 1",
		.target = MOCK_SCREEN_TARGET1,
	},
	{
		.text = "item 2",
		.target = MOCK_SCREEN_TARGET2,
	},
	{
		.text = "item 3",
		.action = mock_action_base,
	},
	{
		.text = "item 4 (no target)",
	},
};
const struct vb2_screen_info mock_screen_menu = {
	.id = MOCK_SCREEN_MENU,
	.name = "mock_screen_menu: screen with 5 items",
	.menu = {
		.num_items = ARRAY_SIZE(mock_screen_menu_items),
		.items = mock_screen_menu_items,
	},
};
const struct vb2_screen_info mock_screen_target0 = {
	.id = MOCK_SCREEN_TARGET0,
	.name = "mock_screen_target0",
};
const struct vb2_screen_info mock_screen_target1 = {
	.id = MOCK_SCREEN_TARGET1,
	.name = "mock_screen_target1",
};
const struct vb2_screen_info mock_screen_target2 = {
	.id = MOCK_SCREEN_TARGET2,
	.name = "mock_screen_target2",
};
const struct vb2_screen_info mock_screen_action = {
	.id = MOCK_SCREEN_ACTION,
	.name = "mock_screen_action",
	.action = mock_action_countdown,
};
const struct vb2_menu_item mock_screen_all_action_items[] = {
	{
		.text = "all_action_screen_item",
		.action = mock_action_flag1,
	},
};
const struct vb2_screen_info mock_screen_all_action = {
	.id = MOCK_SCREEN_ALL_ACTION,
	.name = "mock_screen_all_action",
	.action = mock_action_flag0,
	.menu = {
		.num_items = ARRAY_SIZE(mock_screen_all_action_items),
		.items = mock_screen_all_action_items,
	},
};

static void screen_state_eq(const struct vb2_screen_state *state,
			    enum vb2_screen screen,
			    uint32_t selected_item,
			    uint32_t hidden_item_mask)
{
	if (screen != MOCK_IGNORE) {
		if (state->screen == NULL)
			TEST_TRUE(0, "  state.screen does not exist");
		else
			TEST_EQ(state->screen->id, screen, "  state.screen");
	}
	if (selected_item != MOCK_IGNORE)
		TEST_EQ(state->selected_item,
			selected_item, "  state.selected_item");
	if (hidden_item_mask != MOCK_IGNORE)
		TEST_EQ(state->hidden_item_mask,
			hidden_item_mask, "  state.hidden_item_mask");
}

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


static void set_mock_vbtlk(vb2_error_t retval, uint32_t get_info_flags)
{
	mock_vbtlk_retval = retval;
	mock_vbtlk_expected_flag = get_info_flags;
}

static void displayed_eq(const char *text,
			 enum vb2_screen screen,
			 uint32_t locale_id,
			 uint32_t selected_item,
			 uint32_t hidden_item_mask,
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
	if (hidden_item_mask != MOCK_IGNORE) {
		sprintf(text_buf, "  %s hidden_item_mask of %s",
			text_info, text);
		TEST_EQ(mock_displayed[mock_displayed_i].hidden_item_mask,
			hidden_item_mask, text_buf);
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
		     __LINE__)

#define DISPLAYED_NO_EXTRA() displayed_no_extra(__LINE__)

/* Reset mock data (for use before each test) */
static void reset_common_data(void)
{
	TEST_SUCC(vb2api_init(workbuf, sizeof(workbuf), &ctx),
		  "vb2api_init failed");

	memset(&gbb, 0, sizeof(gbb));

	vb2_nv_init(ctx);

	sd = vb2_get_sd(ctx);

	/* For check_shutdown_request */
	mock_calls_until_shutdown = 10;

	/* Reset mock_screen_temp for test by test temporary screen_info */
	mock_screen_temp = (struct vb2_screen_info){
	      .id = MOCK_NO_SCREEN,
	      .name = "mock_screen_temp",
	};

	/* Mock ui_context based on mock screens */
	memset(&mock_ui_context, 0, sizeof(mock_ui_context));
	mock_ui_context.ctx = ctx;

	if (!mock_ui_context.state)
		mock_ui_context.state = malloc(sizeof(*mock_ui_context.state));
	memset(mock_ui_context.state, 0, sizeof(*mock_ui_context.state));
	mock_ui_context.state->screen = &mock_screen_temp;

	/* For vb2ex_display_ui */
	memset(mock_displayed, 0, sizeof(mock_displayed));
	mock_displayed_count = 0;
	mock_displayed_i = 0;

	/* For VbExKeyboardRead */
	memset(mock_key, 0, sizeof(mock_key));
	memset(mock_key_trusted, 0, sizeof(mock_key_trusted));
	mock_key_count = 0;
	mock_key_total = 0;

	/* For mock actions */
	mock_action_called = 0;
	mock_action_countdown_limit = 1;
	mock_action_flags = 0;
	mock_action_delay_ms = 0;

	/* For chagen_screen and vb2_get_screen_info */
	mock_get_screen_info_called = 0;

	/* For VbTryLoadKernel */
	mock_vbtlk_retval = VB2_ERROR_MOCK;
	mock_vbtlk_expected_flag = MOCK_IGNORE;

	/* For dev_boot* in 2misc.h */
	mock_dev_boot_allowed = 1;
	mock_dev_boot_legacy_allowed = 0;

	/* For VbExLegacy */
	mock_vbexlegacy_called = 0;
	mock_altfw_num_last = -100;
	mock_bootloader_count = 2;

	/* For vb2ex_mtime and vb2ex_msleep  */
	mock_time_ms = mock_time_start_ms;
}

/* Mock functions */
struct vb2_gbb_header *vb2_get_gbb(struct vb2_context *c)
{
	return &gbb;
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

const struct vb2_screen_info *vb2_get_screen_info(enum vb2_screen screen)
{
	mock_get_screen_info_called++;

	switch ((int)screen) {
	case VB2_SCREEN_BLANK:
		return &mock_screen_blank;
	case MOCK_SCREEN_BASE:
		return &mock_screen_base;
	case MOCK_SCREEN_MENU:
		return &mock_screen_menu;
	case MOCK_SCREEN_TARGET0:
		return &mock_screen_target0;
	case MOCK_SCREEN_TARGET1:
		return &mock_screen_target1;
	case MOCK_SCREEN_TARGET2:
		return &mock_screen_target2;
	case MOCK_SCREEN_ACTION:
		return &mock_screen_action;
	case MOCK_SCREEN_ALL_ACTION:
		return &mock_screen_all_action;
	case MOCK_NO_SCREEN:
		return NULL;
	default:
		mock_screen_temp.id = screen;
		return &mock_screen_temp;
	}
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

uint32_t VbExKeyboardRead(void)
{
	return VbExKeyboardReadWithFlags(NULL);
}

uint32_t VbExKeyboardReadWithFlags(uint32_t *key_flags)
{
	if (mock_key_count < mock_key_total) {
		if (key_flags != NULL) {
			if (mock_key_trusted[mock_key_count])
				*key_flags = VB_KEY_FLAG_TRUSTED_KEYBOARD;
			else
				*key_flags = 0;
		}
		return mock_key[mock_key_count++];
	}

	return 0;
}

vb2_error_t VbTryLoadKernel(struct vb2_context *c, uint32_t get_info_flags)
{
	TEST_EQ(mock_vbtlk_expected_flag, get_info_flags,
		"  unexpected get_info_flags");
	return mock_vbtlk_retval;
}

int vb2_dev_boot_allowed(struct vb2_context *c)
{
	return mock_dev_boot_allowed;
}

int vb2_dev_boot_legacy_allowed(struct vb2_context *c)
{
	return mock_dev_boot_legacy_allowed;
}

vb2_error_t VbExLegacy(enum VbAltFwIndex_t altfw_num)
{
	mock_vbexlegacy_called++;
	mock_altfw_num_last = altfw_num;

	if (altfw_num <= mock_bootloader_count)
		return VB2_SUCCESS;
	else
		return VB2_ERROR_UNKNOWN;
}

uint32_t vb2ex_get_bootloader_count(void)
{
	return mock_bootloader_count;
}

uint32_t vb2ex_mtime(void)
{
	return mock_time_ms;
}

void vb2ex_msleep(uint32_t msec)
{
	mock_time_ms += msec;
}

/* Tests */
static void menu_prev_tests(void)
{
	VB2_DEBUG("Testing menu_prev...\n");

	/* Valid action */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.key = VB_KEY_UP;
	TEST_EQ(vb2_ui_menu_prev(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"valid action");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 1,
			MOCK_IGNORE);

	/* Valid action with hidden mask */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.state->hidden_item_mask = 0x0a;  /* 0b01010 */
	mock_ui_context.key = VB_KEY_UP;
	TEST_EQ(vb2_ui_menu_prev(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"valid action with hidden mask");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 0,
			MOCK_IGNORE);

	/* Disabled mask does not affect menu_prev */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.state->disabled_item_mask = 0x0a;  /* 0b01010 */
	mock_ui_context.key = VB_KEY_UP;
	TEST_EQ(vb2_ui_menu_prev(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"valid action with disabled mask");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 1,
			MOCK_IGNORE);

	/* Invalid action (blocked) */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 0;
	mock_ui_context.key = VB_KEY_UP;
	TEST_EQ(vb2_ui_menu_prev(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"invalid action (blocked)");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 0,
			MOCK_IGNORE);

	/* Invalid action (blocked by mask) */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.state->hidden_item_mask = 0x0b;  /* 0b01011 */
	mock_ui_context.key = VB_KEY_UP;
	TEST_EQ(vb2_ui_menu_prev(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"invalid action (blocked by mask)");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 2,
			MOCK_IGNORE);

	/* Ignore volume-up when not DETACHABLE */
	if (!DETACHABLE) {
		reset_common_data();
		mock_ui_context.state->screen = &mock_screen_menu;
		mock_ui_context.state->selected_item = 2;
		mock_ui_context.key = VB_BUTTON_VOL_UP_SHORT_PRESS;
		TEST_EQ(vb2_ui_menu_prev(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE,
			"ignore volume-up when not DETACHABLE");
		screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 2,
				MOCK_IGNORE);
	}

	VB2_DEBUG("...done.\n");
}

static void menu_next_tests(void)
{
	VB2_DEBUG("Testing menu_next...\n");

	/* Valid action */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.key = VB_KEY_DOWN;
	TEST_EQ(vb2_ui_menu_next(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"valid action");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 3,
			MOCK_IGNORE);

	/* Valid action with hidden mask */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.state->hidden_item_mask = 0x0a;  /* 0b01010 */
	mock_ui_context.key = VB_KEY_DOWN;
	TEST_EQ(vb2_ui_menu_next(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"valid action with hidden mask");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 4,
			MOCK_IGNORE);

	/* Disabled mask does not affect menu_next */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.state->disabled_item_mask = 0x0a;  /* 0b01010 */
	mock_ui_context.key = VB_KEY_DOWN;
	TEST_EQ(vb2_ui_menu_next(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"valid action with disabled mask");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 3,
			MOCK_IGNORE);

	/* Invalid action (blocked) */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 4;
	mock_ui_context.key = VB_KEY_DOWN;
	TEST_EQ(vb2_ui_menu_next(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"invalid action (blocked)");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 4,
			MOCK_IGNORE);

	/* Invalid action (blocked by mask) */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.state->hidden_item_mask = 0x1a;  /* 0b11010 */
	mock_ui_context.key = VB_KEY_DOWN;
	TEST_EQ(vb2_ui_menu_next(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"invalid action (blocked by mask)");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 2,
			MOCK_IGNORE);

	/* Ignore volume-down when not DETACHABLE */
	if (!DETACHABLE) {
		reset_common_data();
		mock_ui_context.state->screen = &mock_screen_menu;
		mock_ui_context.state->selected_item = 2;
		mock_ui_context.key = VB_BUTTON_VOL_DOWN_SHORT_PRESS;
		TEST_EQ(vb2_ui_menu_next(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE,
			"ignore volume-down when not DETACHABLE");
		screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 2,
				MOCK_IGNORE);
	}

	VB2_DEBUG("...done.\n");
}

static void menu_select_tests(void)
{
	VB2_DEBUG("Testing menu_select...\n");

	/* select action with no item screen */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_base;
	mock_ui_context.key = VB_KEY_ENTER;
	TEST_EQ(vb2_ui_menu_select(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE,
		"vb2_ui_menu_select with no item screen");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_BASE, 0,
			MOCK_IGNORE);

	/* Try to select an item with a target (item 2) */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.key = VB_KEY_ENTER;
	TEST_EQ(vb2_ui_menu_select(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "select an item with a target");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_TARGET2, 0,
			MOCK_IGNORE);

	/* Try to select an item with an action (item 3) */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 3;
	mock_ui_context.key = VB_KEY_ENTER;
	TEST_EQ(vb2_ui_menu_select(&mock_ui_context),
		VB2_SUCCESS, "select an item with an action");
	TEST_EQ(mock_action_called, 1, "  action called once");

	/* Try to select an item with neither targets nor actions (item 4) */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 4;
	mock_ui_context.key = VB_KEY_ENTER;
	TEST_EQ(vb2_ui_menu_select(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE,
		"select an item with neither targets nor actions");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 4,
			MOCK_IGNORE);

	/* Cannot select a disabled item (item 3) */
	reset_common_data();
	mock_ui_context.state->screen = &mock_screen_menu;
	mock_ui_context.state->selected_item = 3;
	mock_ui_context.state->disabled_item_mask = 0x08;  /* 0b01000 */
	mock_ui_context.key = VB_KEY_ENTER;
	TEST_EQ(vb2_ui_menu_select(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "cannot select a disabled item");
	TEST_EQ(mock_action_called, 0, "  no action called");

	/* Ignore power button short press when not DETACHABLE */
	if (!DETACHABLE) {
		reset_common_data();
		mock_ui_context.state->screen = &mock_screen_menu;
		mock_ui_context.state->selected_item = 1;
		mock_ui_context.key = VB_BUTTON_POWER_SHORT_PRESS;
		TEST_EQ(vb2_ui_menu_select(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE,
			"ignore power button short press when not DETACHABLE");
		screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU, 1,
				MOCK_IGNORE);
	}

	VB2_DEBUG("...done.\n");
}

static void vb2_ui_developer_mode_boot_alternate_action_tests(void)
{
	VB2_DEBUG("Test developer mode boot alternate action...\n");

	/* Not allowed: not in dev mode */
	reset_common_data();
	mock_dev_boot_legacy_allowed = 1;
	TEST_EQ(vb2_ui_developer_mode_boot_alternate_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "not allowed: not in dev mode");
	TEST_EQ(mock_vbexlegacy_called, 0, "  VbExLegacy not called");

	/* Not allowed: dev boot not allowed */
	reset_common_data();
	ctx->flags |= VB2_CONTEXT_DEVELOPER_MODE;
	mock_dev_boot_allowed = 0;
	mock_dev_boot_legacy_allowed = 1;
	TEST_EQ(vb2_ui_developer_mode_boot_alternate_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "not allowed: dev boot not allowed");
	TEST_EQ(mock_vbexlegacy_called, 0, "  VbExLegacy not called");

	/* Not allowed: boot legacy not allowed */
	reset_common_data();
	ctx->flags |= VB2_CONTEXT_DEVELOPER_MODE;
	TEST_EQ(vb2_ui_developer_mode_boot_alternate_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE,
		"not allowed: boot legacy not allowed");
	TEST_EQ(mock_vbexlegacy_called, 0, "  VbExLegacy not called");

	/* Allowed */
	reset_common_data();
	ctx->flags |= VB2_CONTEXT_DEVELOPER_MODE;
	mock_dev_boot_legacy_allowed = 1;
	mock_ui_context.state->selected_item = 2;
	TEST_EQ(vb2_ui_developer_mode_boot_alternate_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "allowed");
	TEST_EQ(mock_vbexlegacy_called, 1, "  VbExLegacy called once");
	TEST_EQ(mock_altfw_num_last, 2, "  select bootloader #2");

	/* CTRL+L = default bootloader */
	reset_common_data();
	ctx->flags |= VB2_CONTEXT_DEVELOPER_MODE;
	mock_dev_boot_legacy_allowed = 1;
	mock_ui_context.key = VB_KEY_CTRL('L');
	mock_ui_context.state->selected_item = 4;  /* Ignored */
	TEST_EQ(vb2_ui_developer_mode_boot_alternate_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "allowed: ctrl+l");
	TEST_EQ(mock_vbexlegacy_called, 1, "  VbExLegacy called once");
	TEST_EQ(mock_altfw_num_last, 0, "  select bootloader #0");

	VB2_DEBUG("...done.\n");
}

static void manual_recovery_action_tests(void)
{
	VB2_DEBUG("Testing manual recovery action...\n");

	/* SUCCESS */
	reset_common_data();
	set_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(manual_recovery_action(&mock_ui_context),
		VB2_SUCCESS, "SUCCESS");
	TEST_EQ(mock_get_screen_info_called, 0, "  no change_screen");

	/* NO_DISK_FOUND */
	reset_common_data();
	set_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(manual_recovery_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "NO_DISK_FOUND");
	screen_state_eq(mock_ui_context.state, VB2_SCREEN_RECOVERY_SELECT,
			MOCK_IGNORE, MOCK_IGNORE);

	/* NO_DISK_FOUND -> INVALID_KERNEL -> SUCCESS */
	reset_common_data();
	set_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(manual_recovery_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "NO_DISK_FOUND");
	set_mock_vbtlk(VB2_ERROR_LK_INVALID_KERNEL_FOUND,
		       VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(manual_recovery_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "INVALID_KERNEL");
	set_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(manual_recovery_action(&mock_ui_context),
		VB2_SUCCESS, "SUCCESS");
	screen_state_eq(mock_ui_context.state, VB2_SCREEN_RECOVERY_INVALID,
			MOCK_IGNORE, MOCK_IGNORE);

	/* INVALID_KERNEL */
	reset_common_data();
	set_mock_vbtlk(VB2_ERROR_LK_INVALID_KERNEL_FOUND,
		       VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(manual_recovery_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "INVALID_KERNEL");
	screen_state_eq(mock_ui_context.state, VB2_SCREEN_RECOVERY_INVALID,
			MOCK_IGNORE, MOCK_IGNORE);

	/* INVALID_KERNEL -> NO_DISK_FOUND -> SUCCESS */
	reset_common_data();
	set_mock_vbtlk(VB2_ERROR_LK_INVALID_KERNEL_FOUND,
		       VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(manual_recovery_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "INVALID_KERNEL");
	set_mock_vbtlk(VB2_ERROR_LK_NO_DISK_FOUND, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(manual_recovery_action(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "NO_DISK_FOUND");
	set_mock_vbtlk(VB2_SUCCESS, VB_DISK_FLAG_REMOVABLE);
	TEST_EQ(manual_recovery_action(&mock_ui_context),
		VB2_SUCCESS, "SUCCESS");
	screen_state_eq(mock_ui_context.state, VB2_SCREEN_RECOVERY_SELECT,
			MOCK_IGNORE, MOCK_IGNORE);

	VB2_DEBUG("...done.\n");
}

static void ui_loop_tests(void)
{
	int i;
	const char *action_interfere_test_names[] = {
		"hook all actions: screen action return SUCCESS",
		"hook all actions: target action hooked return SUCCESS",
		"hook all actions: global action return SUCCESS",
	};

	VB2_DEBUG("Testing ui_loop...\n");

	/* Die if no root screen */
	reset_common_data();
	TEST_ABORT(ui_loop(ctx, MOCK_NO_SCREEN, NULL),
		   "die if no root screen");
	DISPLAYED_NO_EXTRA();

	/* Shutdown if requested */
	reset_common_data();
	TEST_EQ(ui_loop(ctx, MOCK_SCREEN_BASE, NULL),
		VB2_REQUEST_SHUTDOWN, "shutdown if requested");
	TEST_EQ(mock_calls_until_shutdown, 0, "  used up shutdown request");
	DISPLAYED_EQ("mock_screen_base", MOCK_SCREEN_BASE, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/* Screen action */
	reset_common_data();
	mock_calls_until_shutdown = -1;
	mock_action_countdown_limit = 10;
	TEST_EQ(ui_loop(ctx, MOCK_SCREEN_ACTION, NULL),
		VB2_SUCCESS, "screen action");
	TEST_EQ(mock_action_called, 10, "  action called");

	/* Global action */
	reset_common_data();
	mock_calls_until_shutdown = -1;
	mock_action_countdown_limit = 10;
	TEST_EQ(ui_loop(ctx, VB2_SCREEN_BLANK, mock_action_countdown),
		VB2_SUCCESS, "global action");
	TEST_EQ(mock_action_called, 10, "  action called");

	/* Global action can change screen */
	reset_common_data();
	TEST_EQ(ui_loop(ctx, VB2_SCREEN_BLANK, mock_action_screen_change),
		VB2_REQUEST_SHUTDOWN, "global action can change screen");
	DISPLAYED_PASS();
	DISPLAYED_EQ("change to mock_screen_base", MOCK_SCREEN_BASE,
		     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/*
	 * Hook all actions, and receive SUCCESS from actions one by one
	 * Action #0: screen action
	 * Action #1: item target action
	 * Action #2: global action
	 */
	for (i = 0; i <= 2; i++) {
		reset_common_data();
		add_mock_keypress(VB_KEY_ENTER);
		mock_calls_until_shutdown = -1;
		mock_action_flags |= (1 << i);
		TEST_EQ(ui_loop(ctx, MOCK_SCREEN_ALL_ACTION, mock_action_flag2),
			VB2_SUCCESS, action_interfere_test_names[i]);
	}

	/* KEY_UP, KEY_DOWN, and KEY_ENTER navigation */
	reset_common_data();
	add_mock_keypress(VB_KEY_UP);  /* (blocked) */
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);
	add_mock_keypress(VB_KEY_DOWN);  /* (blocked) */
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_UP);
	add_mock_keypress(VB_KEY_ENTER);
	TEST_EQ(ui_loop(ctx, MOCK_SCREEN_MENU, NULL),
		VB2_REQUEST_SHUTDOWN, "KEY_UP, KEY_DOWN, and KEY_ENTER");
	DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE, 0,
		     MOCK_IGNORE);
	DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE, 1,
		     MOCK_IGNORE);
	DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE, 2,
		     MOCK_IGNORE);
	DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE, 3,
		     MOCK_IGNORE);
	DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE, 4,
		     MOCK_IGNORE);
	DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE, 3,
		     MOCK_IGNORE);
	DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE, 2,
		     MOCK_IGNORE);
	DISPLAYED_EQ("mock_screen_target_2", MOCK_SCREEN_TARGET2, MOCK_IGNORE,
		     MOCK_IGNORE, MOCK_IGNORE);
	DISPLAYED_NO_EXTRA();

	/* For DETACHABLE */
	if (DETACHABLE) {
		reset_common_data();
		add_mock_keypress(VB_BUTTON_VOL_UP_SHORT_PRESS);
		add_mock_keypress(VB_BUTTON_VOL_DOWN_SHORT_PRESS);
		add_mock_keypress(VB_BUTTON_VOL_DOWN_SHORT_PRESS);
		add_mock_keypress(VB_BUTTON_VOL_DOWN_SHORT_PRESS);
		add_mock_keypress(VB_BUTTON_VOL_DOWN_SHORT_PRESS);
		add_mock_keypress(VB_BUTTON_VOL_DOWN_SHORT_PRESS);
		add_mock_keypress(VB_BUTTON_VOL_UP_SHORT_PRESS);
		add_mock_keypress(VB_BUTTON_VOL_UP_SHORT_PRESS);
		add_mock_keypress(VB_BUTTON_POWER_SHORT_PRESS);
		TEST_EQ(ui_loop(ctx, MOCK_SCREEN_MENU, NULL),
			VB2_REQUEST_SHUTDOWN, "DETACHABLE");
		DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE,
			     0, MOCK_IGNORE);
		DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE,
			     1, MOCK_IGNORE);
		DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE,
			     2, MOCK_IGNORE);
		DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE,
			     3, MOCK_IGNORE);
		DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE,
			     4, MOCK_IGNORE);
		DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE,
			     3, MOCK_IGNORE);
		DISPLAYED_EQ("mock_screen_menu", MOCK_SCREEN_MENU, MOCK_IGNORE,
			     2, MOCK_IGNORE);
		DISPLAYED_EQ("mock_screen_target_2", MOCK_SCREEN_TARGET2,
			     MOCK_IGNORE, MOCK_IGNORE, MOCK_IGNORE);
		DISPLAYED_NO_EXTRA();
	}

	VB2_DEBUG("...done.\n");
}

static void ui_loop_delay_tests(void)
{
	VB2_DEBUG("Testing ui_loop delay...\n");

	/* Sleep for 20 ms each iteration */
	reset_common_data();
	mock_calls_until_shutdown = 1;
	TEST_EQ(ui_loop(ctx, MOCK_SCREEN_BASE, mock_action_msleep),
		VB2_REQUEST_SHUTDOWN, "  sleep for 20 ms in each iteration");
	TEST_EQ(mock_time_ms - mock_time_start_ms, KEY_DELAY_MS,
		"  delay 20 ms in total");

	/* Complement to 20 ms */
	reset_common_data();
	mock_calls_until_shutdown = 1;
	mock_action_delay_ms = KEY_DELAY_MS / 2;
	TEST_EQ(ui_loop(ctx, MOCK_SCREEN_BASE, mock_action_msleep),
		VB2_REQUEST_SHUTDOWN, "  complement to 20 ms");
	TEST_EQ(mock_time_ms - mock_time_start_ms, KEY_DELAY_MS,
		"  delay 10 ms in total");

	/* No extra sleep if an iteration takes longer than KEY_DELAY_MS */
	reset_common_data();
	mock_calls_until_shutdown = 1;
	mock_action_delay_ms = 1234;
	TEST_EQ(ui_loop(ctx, MOCK_SCREEN_BASE, mock_action_msleep),
		VB2_REQUEST_SHUTDOWN, "  no extra sleep time");
	TEST_EQ(mock_time_ms - mock_time_start_ms, mock_action_delay_ms,
		"  no extra delay");

	/* Integer overflow */
	reset_common_data();
	mock_calls_until_shutdown = 1;
	mock_time_ms = UINT32_MAX;
	TEST_EQ(ui_loop(ctx, MOCK_SCREEN_BASE, mock_action_msleep),
		VB2_REQUEST_SHUTDOWN, "  integer overflow #1");
	TEST_EQ(mock_time_ms - UINT32_MAX, KEY_DELAY_MS,
		"  delay 20 ms in total");

	reset_common_data();
	mock_calls_until_shutdown = 1;
	mock_time_ms = UINT32_MAX;
	mock_action_delay_ms = KEY_DELAY_MS / 2;
	TEST_EQ(ui_loop(ctx, MOCK_SCREEN_BASE, mock_action_msleep),
		VB2_REQUEST_SHUTDOWN, "  integer overflow #2");
	TEST_EQ(mock_time_ms - UINT32_MAX, KEY_DELAY_MS,
		"  delay 10 ms in total");

	reset_common_data();
	mock_calls_until_shutdown = 1;
	mock_time_ms = UINT32_MAX;
	mock_action_delay_ms = 1234;
	TEST_EQ(ui_loop(ctx, MOCK_SCREEN_BASE, mock_action_msleep),
		VB2_REQUEST_SHUTDOWN, "  integer overflow #3");
	TEST_EQ(mock_time_ms - UINT32_MAX, mock_action_delay_ms,
		"  no extra delay");

	VB2_DEBUG("...done.\n");
}

int main(void)
{
	/* Input actions */
	menu_prev_tests();
	menu_next_tests();
	menu_select_tests();

	/* Screen actions */
	vb2_ui_developer_mode_boot_alternate_action_tests();

	/* Global actions */
	manual_recovery_action_tests();

	/* Core UI loop */
	ui_loop_tests();
	ui_loop_delay_tests();

	return gTestSuccess ? 0 : 255;
}
