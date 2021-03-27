/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Tests for UI utility functions.
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2ui.h"
#include "2ui_private.h"
#include "test_common.h"
#include "vboot_api.h"

/* Fixed value for ignoring some checks. */
#define MOCK_IGNORE 0xffffu

/* Mock screen index for testing screen utility functions. */
#define MOCK_NO_SCREEN 0xef00
#define MOCK_SCREEN_BASE 0xef10
#define MOCK_SCREEN_MENU 0xef11
#define MOCK_SCREEN_ROOT 0xefff

/* Mock data */
static uint8_t workbuf[VB2_KERNEL_WORKBUF_RECOMMENDED_SIZE]
	__attribute__((aligned(VB2_WORKBUF_ALIGN)));
static struct vb2_context *ctx;
static struct vb2_gbb_header gbb;

static uint32_t mock_locale_count;
static int mock_shutdown_request;

static struct vb2_ui_context mock_ui_context;

/* Mock actions */
static uint32_t mock_action_called;
static vb2_error_t mock_action_base(struct vb2_ui_context *ui)
{
	mock_action_called++;
	return VB2_SUCCESS;
}

/* Mock screens */
struct vb2_screen_info mock_screen_blank = {
	.id = VB2_SCREEN_BLANK,
	.name = "mock_screen_blank",
};
struct vb2_screen_info mock_screen_base = {
	.id = MOCK_SCREEN_BASE,
	.name = "mock_screen_base: menuless screen",
};
struct vb2_menu_item mock_screen_menu_items[] = {
	{
		.text = "option 0: language selection",
		.is_language_select = 1,
	},
	{
		.text = "option 1",
	},
	{
		.text = "option 2",
	},
	{
		.text = "option 3",
	},
	{
		.text = "option 4",
	},
};
struct vb2_screen_info mock_screen_menu = {
	.id = MOCK_SCREEN_MENU,
	.name = "mock_screen_menu: screen with 5 options",
	.menu = {
		.num_items = ARRAY_SIZE(mock_screen_menu_items),
		.items = mock_screen_menu_items,
	},
};
struct vb2_screen_info mock_screen_root = {
	.id = MOCK_SCREEN_ROOT,
	.name = "mock_screen_root",
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

/* Reset mock data (for use before each test) */
static void reset_common_data(void)
{
	TEST_SUCC(vb2api_init(workbuf, sizeof(workbuf), &ctx),
		  "vb2api_init failed");

	memset(&gbb, 0, sizeof(gbb));

	vb2_nv_init(ctx);

	/* For vb2ex_get_locale_count */
	mock_locale_count = 1;

	/* For check_shutdown_request */
	mock_shutdown_request = MOCK_IGNORE;

	/* Mock ui_context based on mock screens */
	memset(&mock_ui_context, 0, sizeof(mock_ui_context));
	mock_ui_context.power_button = VB2_POWER_BUTTON_HELD_SINCE_BOOT;

	/* For mock actions */
	mock_action_called = 0;

	/* Reset init and action functions */
	mock_screen_blank.init = NULL;
	mock_screen_blank.action = NULL;
	mock_screen_base.init = NULL;
	mock_screen_base.action = NULL;
	mock_screen_menu.init = NULL;
	mock_screen_menu.action = NULL;
	mock_screen_root.init = NULL;
	mock_screen_root.action = NULL;
}

/* Mock functions */
struct vb2_gbb_header *vb2_get_gbb(struct vb2_context *c)
{
	return &gbb;
}

uint32_t vb2ex_get_locale_count(void)
{
	return mock_locale_count;
}

uint32_t VbExIsShutdownRequested(void)
{
	if (mock_shutdown_request != MOCK_IGNORE)
		return mock_shutdown_request;

	return 0;
}

const struct vb2_screen_info *vb2_get_screen_info(enum vb2_screen screen)
{
	switch ((int)screen) {
	case VB2_SCREEN_BLANK:
		return &mock_screen_blank;
	case MOCK_SCREEN_BASE:
		return &mock_screen_base;
	case MOCK_SCREEN_MENU:
		return &mock_screen_menu;
	case MOCK_SCREEN_ROOT:
		return &mock_screen_root;
	default:
		return NULL;
	}
}

/* Tests */
static void check_shutdown_request_tests(void)
{
	VB2_DEBUG("Testing check_shutdown_request...\n");

	/* Release, press, hold, and release */
	if (!DETACHABLE) {
		reset_common_data();
		mock_shutdown_request = 0;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE,
			"release, press, hold, and release");
		mock_shutdown_request = VB_SHUTDOWN_REQUEST_POWER_BUTTON;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE, "  press");
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE, "  hold");
		mock_shutdown_request = 0;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_SHUTDOWN, "  release");
	}

	/* Press is ignored because we may held since boot */
	if (!DETACHABLE) {
		reset_common_data();
		mock_shutdown_request = VB_SHUTDOWN_REQUEST_POWER_BUTTON;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE, "press is ignored");
	}

	/* Power button short press from key */
	if (!DETACHABLE) {
		reset_common_data();
		mock_shutdown_request = 0;
		mock_ui_context.key = VB_BUTTON_POWER_SHORT_PRESS;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_SHUTDOWN, "power button short press");
	}

	/* Lid closure = shutdown request anyway */
	reset_common_data();
	mock_shutdown_request = VB_SHUTDOWN_REQUEST_LID_CLOSED;
	TEST_EQ(check_shutdown_request(&mock_ui_context),
		VB2_REQUEST_SHUTDOWN, "lid closure");
	mock_ui_context.key = 'A';
	TEST_EQ(check_shutdown_request(&mock_ui_context),
		VB2_REQUEST_SHUTDOWN, "  lidsw + random key");

	/* Lid ignored by GBB flags */
	reset_common_data();
	gbb.flags |= VB2_GBB_FLAG_DISABLE_LID_SHUTDOWN;
	mock_shutdown_request = VB_SHUTDOWN_REQUEST_LID_CLOSED;
	TEST_EQ(check_shutdown_request(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE, "lid ignored");
	if (!DETACHABLE) {  /* Power button works for non DETACHABLE */
		mock_shutdown_request = VB_SHUTDOWN_REQUEST_LID_CLOSED |
					VB_SHUTDOWN_REQUEST_POWER_BUTTON;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE, "  lidsw + pwdsw");
		mock_shutdown_request = 0;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_SHUTDOWN, "  pwdsw release");
	}

	/* Lid ignored; power button short pressed */
	if (!DETACHABLE) {
		reset_common_data();
		gbb.flags |= VB2_GBB_FLAG_DISABLE_LID_SHUTDOWN;
		mock_shutdown_request = VB_SHUTDOWN_REQUEST_LID_CLOSED;
		mock_ui_context.key = VB_BUTTON_POWER_SHORT_PRESS;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_SHUTDOWN,
			"lid ignored; power button short pressed");
	}

	/* DETACHABLE ignore power button */
	if (DETACHABLE) {
		/* Flag pwdsw */
		reset_common_data();
		mock_shutdown_request = VB_SHUTDOWN_REQUEST_POWER_BUTTON;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE, "DETACHABLE: ignore pwdsw");
		mock_shutdown_request = 0;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE, "  ignore on release");

		/* Power button short press */
		reset_common_data();
		mock_shutdown_request = 0;
		mock_ui_context.key = VB_BUTTON_POWER_SHORT_PRESS;
		TEST_EQ(check_shutdown_request(&mock_ui_context),
			VB2_REQUEST_UI_CONTINUE,
			"DETACHABLE: ignore power button short press");
	}

	VB2_DEBUG("...done.\n");
}

static void screen_stack_tests(void)
{
	VB2_DEBUG("Testing screen stack functionality...\n");

	/* Change to screen which does not exist */
	reset_common_data();
	TEST_EQ(vb2_ui_screen_change(&mock_ui_context, MOCK_NO_SCREEN),
		VB2_REQUEST_UI_CONTINUE,
		"change to screen which does not exist");
	TEST_PTR_EQ(mock_ui_context.state, NULL, "  stack is empty");

	/* Screen back with empty stack */
	reset_common_data();
	TEST_EQ(vb2_ui_screen_back(&mock_ui_context),
		VB2_REQUEST_UI_CONTINUE,
		"screen back with empty stack");
	TEST_PTR_EQ(mock_ui_context.state, NULL, "  stack is empty");

	/* Back to previous screen, restoring the state */
	reset_common_data();
	mock_screen_base.init = mock_action_base;
	vb2_ui_screen_change(&mock_ui_context, MOCK_SCREEN_ROOT);
	vb2_ui_screen_change(&mock_ui_context, MOCK_SCREEN_BASE);
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.state->hidden_item_mask = 0x10;
	vb2_ui_screen_change(&mock_ui_context, MOCK_SCREEN_MENU);
	TEST_EQ(vb2_ui_screen_back(&mock_ui_context), VB2_REQUEST_UI_CONTINUE,
		"back to previous screen");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_BASE, 2, 0x10);
	TEST_EQ(mock_action_called, 1, "  action called once");

	/* Change to target screen already in stack, restoring the state */
	reset_common_data();
	mock_screen_base.init = mock_action_base;
	vb2_ui_screen_change(&mock_ui_context, MOCK_SCREEN_ROOT);
	vb2_ui_screen_change(&mock_ui_context, MOCK_SCREEN_BASE);
	mock_ui_context.state->selected_item = 2;
	mock_ui_context.state->hidden_item_mask = 0x10;
	vb2_ui_screen_change(&mock_ui_context, MOCK_SCREEN_MENU);
	TEST_EQ(vb2_ui_screen_change(&mock_ui_context, MOCK_SCREEN_BASE),
		VB2_REQUEST_UI_CONTINUE, "change to target in stack");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_BASE, 2, 0x10);
	TEST_EQ(mock_action_called, 1, "  action called once");

	/* Change to screen without init; using default init() */
	reset_common_data();
	TEST_EQ(vb2_ui_screen_change(&mock_ui_context, MOCK_SCREEN_MENU),
		VB2_REQUEST_UI_CONTINUE,
		"change to screen with language selection");
	screen_state_eq(mock_ui_context.state, MOCK_SCREEN_MENU,
			1,	/* Since index 0 is the language selection */
			0);

	VB2_DEBUG("...done.\n");
}

static void get_language_menu_tests(void)
{
	const struct vb2_menu *menu;
	const struct vb2_menu_item *items;
	VB2_DEBUG("Testing get_language_menu...\n");

	/* Only allocate menu items once */
	reset_common_data();
	mock_locale_count = 7;
	menu = get_language_menu(&mock_ui_context);
	TEST_PTR_NEQ(menu, NULL, "get language menu");
	TEST_EQ(menu->num_items, 7, "  correct locale count");
	TEST_PTR_NEQ(menu->items, NULL, "  items not null");
	items = menu->items;

	menu = get_language_menu(&mock_ui_context);
	TEST_PTR_NEQ(menu, NULL, "get language menu again");
	TEST_EQ(menu->num_items, 7, "  correct locale count again");
	TEST_PTR_EQ(menu->items, items, "  same pointer of items");

	/* Locale count = 0 */
	reset_common_data();
	mock_locale_count = 0;
	menu = get_language_menu(&mock_ui_context);
	TEST_PTR_NEQ(menu, NULL, "menu not null");
	TEST_EQ(menu->num_items, 1, "  locale count 1");

	VB2_DEBUG("...done.\n");
}

int main(void)
{
	check_shutdown_request_tests();
	screen_stack_tests();
	get_language_menu_tests();

	return gTestSuccess ? 0 : 255;
}
