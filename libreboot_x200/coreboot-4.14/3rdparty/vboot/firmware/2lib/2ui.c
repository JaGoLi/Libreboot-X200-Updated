/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * User interfaces for developer and recovery mode menus.
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2return_codes.h"
#include "2ui.h"
#include "2ui_private.h"
#include "vboot_api.h"  /* For VB_SHUTDOWN_REQUEST_POWER_BUTTON */
#include "vboot_kernel.h"

/*****************************************************************************/
/* Utility functions */

/**
 * Check GBB flags against VbExIsShutdownRequested() shutdown request,
 * and check for VB_BUTTON_POWER_SHORT_PRESS key, to determine if a
 * shutdown is required.
 *
 * @param ui		UI context pointer
 * @return VB2_REQUEST_SHUTDOWN if shutdown needed, or VB2_SUCCESS
 */
vb2_error_t check_shutdown_request(struct vb2_ui_context *ui)
{
	struct vb2_gbb_header *gbb = vb2_get_gbb(ui->ctx);
	uint32_t shutdown_request = VbExIsShutdownRequested();

	/*
	 * Ignore power button push until after we have seen it released.
	 * This avoids shutting down immediately if the power button is still
	 * being held on startup. After we've recognized a valid power button
	 * push then don't report the event until after the button is released.
	 */
	if (shutdown_request & VB_SHUTDOWN_REQUEST_POWER_BUTTON) {
		shutdown_request &= ~VB_SHUTDOWN_REQUEST_POWER_BUTTON;
		if (ui->power_button == VB2_POWER_BUTTON_RELEASED)
			ui->power_button = VB2_POWER_BUTTON_PRESSED;
	} else {
		if (ui->power_button == VB2_POWER_BUTTON_PRESSED)
			shutdown_request |= VB_SHUTDOWN_REQUEST_POWER_BUTTON;
		ui->power_button = VB2_POWER_BUTTON_RELEASED;
	}

	if (ui->key == VB_BUTTON_POWER_SHORT_PRESS)
		shutdown_request |= VB_SHUTDOWN_REQUEST_POWER_BUTTON;

	/* If desired, ignore shutdown request due to lid closure. */
	if (gbb->flags & VB2_GBB_FLAG_DISABLE_LID_SHUTDOWN)
		shutdown_request &= ~VB_SHUTDOWN_REQUEST_LID_CLOSED;

	/*
	 * In detachables, disable shutdown due to power button.
	 * It is used for menu selection instead.
	 */
	if (DETACHABLE)
		shutdown_request &= ~VB_SHUTDOWN_REQUEST_POWER_BUTTON;

	if (shutdown_request)
		return VB2_REQUEST_SHUTDOWN;

	return VB2_SUCCESS;
}

/*****************************************************************************/
/* Error action functions */

vb2_error_t error_exit_action(struct vb2_ui_context *ui)
{
	/*
	 * If an error message is currently shown on the screen, any
	 * key press clears that error.  Unset the key so that it is
	 * not processed by other action functions.
	 */
	if (ui->key && ui->error_code) {
		ui->error_code = VB2_UI_ERROR_NONE;
		ui->key = 0;
	}
	return VB2_SUCCESS;
}

/*****************************************************************************/
/* Menu navigation functions */

const struct vb2_menu *get_menu(struct vb2_ui_context *ui)
{
	const struct vb2_menu *menu;
	static const struct vb2_menu empty_menu = {
		.num_items = 0,
		.items = NULL,
	};
	if (ui->state->screen->get_menu) {
		menu = ui->state->screen->get_menu(ui);
		return menu ? menu : &empty_menu;
	} else {
		return &ui->state->screen->menu;
	}
}

vb2_error_t menu_navigation_action(struct vb2_ui_context *ui)
{
	uint32_t key = ui->key;

	/* Map detachable button presses for simplicity. */
	if (DETACHABLE) {
		if (key == VB_BUTTON_VOL_UP_SHORT_PRESS)
			key = VB_KEY_UP;
		else if (key == VB_BUTTON_VOL_DOWN_SHORT_PRESS)
			key = VB_KEY_DOWN;
		else if (key == VB_BUTTON_POWER_SHORT_PRESS)
			key = VB_KEY_ENTER;
	}

	switch (key) {
	case VB_KEY_UP:
		return vb2_ui_menu_prev(ui);
	case VB_KEY_DOWN:
		return vb2_ui_menu_next(ui);
	case VB_KEY_ENTER:
		return vb2_ui_menu_select(ui);
	case VB_KEY_ESC:
		return vb2_ui_screen_back(ui);
	default:
		if (key != 0)
			VB2_DEBUG("Pressed key %#x, trusted? %d\n",
				  ui->key, ui->key_trusted);
	}

	return VB2_SUCCESS;
}

vb2_error_t vb2_ui_menu_prev(struct vb2_ui_context *ui)
{
	int item;

	if (!DETACHABLE && ui->key == VB_BUTTON_VOL_UP_SHORT_PRESS)
		return VB2_SUCCESS;

	item = ui->state->selected_item - 1;
	while (item >= 0 && VB2_GET_BIT(ui->state->hidden_item_mask, item))
		item--;
	/* Only update if item is valid */
	if (item >= 0)
		ui->state->selected_item = item;

	return VB2_SUCCESS;
}

vb2_error_t vb2_ui_menu_next(struct vb2_ui_context *ui)
{
	int item;
	const struct vb2_menu *menu;

	if (!DETACHABLE && ui->key == VB_BUTTON_VOL_DOWN_SHORT_PRESS)
		return VB2_SUCCESS;

	menu = get_menu(ui);
	item = ui->state->selected_item + 1;
	while (item < menu->num_items &&
	       VB2_GET_BIT(ui->state->hidden_item_mask, item))
		item++;
	/* Only update if item is valid */
	if (item < menu->num_items)
		ui->state->selected_item = item;

	return VB2_SUCCESS;
}

vb2_error_t vb2_ui_menu_select(struct vb2_ui_context *ui)
{
	const struct vb2_menu *menu;
	const struct vb2_menu_item *menu_item;

	if (!DETACHABLE && ui->key == VB_BUTTON_POWER_SHORT_PRESS)
		return VB2_SUCCESS;

	menu = get_menu(ui);
	if (menu->num_items == 0)
		return VB2_SUCCESS;

	menu_item = &menu->items[ui->state->selected_item];

	/* Cannot select a disabled menu item */
	if (VB2_GET_BIT(ui->state->disabled_item_mask,
			ui->state->selected_item)) {
		VB2_DEBUG("Menu item <%s> disabled; ignoring\n",
			  menu_item->text);
		return VB2_SUCCESS;
	}

	if (menu_item->action) {
		VB2_DEBUG("Menu item <%s> run action\n", menu_item->text);
		return menu_item->action(ui);
	} else if (menu_item->target) {
		VB2_DEBUG("Menu item <%s> to target screen %#x\n",
			  menu_item->text, menu_item->target);
		return vb2_ui_screen_change(ui, menu_item->target);
	}

	VB2_DEBUG("Menu item <%s> no action or target screen\n",
		  menu_item->text);
	return VB2_SUCCESS;
}

/*****************************************************************************/
/* Screen navigation functions */

vb2_error_t vb2_ui_screen_back(struct vb2_ui_context *ui)
{
	struct vb2_screen_state *tmp;

	if (ui->state && ui->state->prev) {
		tmp = ui->state->prev;
		free(ui->state);
		ui->state = tmp;
		if (ui->state->screen->reinit)
			VB2_TRY(ui->state->screen->reinit(ui));
	} else {
		VB2_DEBUG("ERROR: No previous screen; ignoring\n");
	}

	return VB2_REQUEST_UI_CONTINUE;
}

static vb2_error_t default_screen_init(struct vb2_ui_context *ui)
{
	const struct vb2_menu *menu = get_menu(ui);
	ui->state->selected_item = 0;
	if (menu->num_items > 1 && menu->items[0].is_language_select)
		ui->state->selected_item = 1;
	return VB2_SUCCESS;
}

vb2_error_t vb2_ui_screen_change(struct vb2_ui_context *ui, enum vb2_screen id)
{
	const struct vb2_screen_info *new_screen_info;
	struct vb2_screen_state *cur_state;
	int state_exists = 0;

	new_screen_info = vb2_get_screen_info(id);
	if (new_screen_info == NULL) {
		VB2_DEBUG("ERROR: Screen entry %#x not found; ignoring\n", id);
		return VB2_REQUEST_UI_CONTINUE;
	}

	/* Check to see if the screen state already exists in our stack. */
	cur_state = ui->state;
	while (cur_state != NULL) {
		if (cur_state->screen->id == id) {
			state_exists = 1;
			break;
		}
		cur_state = cur_state->prev;
	}

	if (state_exists) {
		/* Pop until the requested screen is at the top of stack. */
		while (ui->state->screen->id != id) {
			cur_state = ui->state;
			ui->state = cur_state->prev;
			free(cur_state);
		}
		if (ui->state->screen->reinit)
			VB2_TRY(ui->state->screen->reinit(ui));
	} else {
		/* Allocate the requested screen on top of the stack. */
		cur_state = malloc(sizeof(*ui->state));
		memset(cur_state, 0, sizeof(*ui->state));
		if (cur_state == NULL) {
			VB2_DEBUG("WARNING: malloc failed; ignoring\n");
			return VB2_REQUEST_UI_CONTINUE;
		}
		cur_state->prev = ui->state;
		cur_state->screen = new_screen_info;
		ui->state = cur_state;
		if (ui->state->screen->init)
			VB2_TRY(ui->state->screen->init(ui));
		else
			VB2_TRY(default_screen_init(ui));
	}

	return VB2_REQUEST_UI_CONTINUE;
}

/*****************************************************************************/
/* Core UI loop */

static vb2_error_t ui_loop_impl(
	struct vb2_context *ctx, enum vb2_screen root_screen_id,
	vb2_error_t (*global_action)(struct vb2_ui_context *ui))
{
	struct vb2_ui_context ui;
	struct vb2_screen_state prev_state;
	int prev_disable_timer;
	enum vb2_ui_error prev_error_code;
	const struct vb2_menu *menu;
	const struct vb2_screen_info *root_info;
	uint32_t key_flags;
	uint32_t start_time_ms, elapsed_ms;
	vb2_error_t rv;

	memset(&ui, 0, sizeof(ui));
	ui.ctx = ctx;
	root_info = vb2_get_screen_info(root_screen_id);
	if (root_info == NULL)
		VB2_DIE("Root screen not found.\n");
	ui.locale_id = vb2_nv_get(ctx, VB2_NV_LOCALIZATION_INDEX);

	rv = vb2_ui_screen_change(&ui, root_screen_id);
	if (rv && rv != VB2_REQUEST_UI_CONTINUE)
		return rv;

	memset(&prev_state, 0, sizeof(prev_state));
	prev_disable_timer = 0;
	prev_error_code = VB2_UI_ERROR_NONE;

	while (1) {
		start_time_ms = vb2ex_mtime();

		/* Draw if there are state changes. */
		if (memcmp(&prev_state, ui.state, sizeof(*ui.state)) ||
		    /* Redraw when timer is disabled. */
		    prev_disable_timer != ui.disable_timer ||
		    /* Redraw/beep on a transition. */
		    prev_error_code != ui.error_code ||
		    /* Beep. */
		    ui.error_beep != 0 ||
		    /* Redraw on a screen request to refresh. */
		    ui.force_display) {

			menu = get_menu(&ui);
			VB2_DEBUG("<%s> menu item <%s>\n",
				  ui.state->screen->name,
				  menu->num_items ?
				  menu->items[ui.state->selected_item].text :
				  "null");
			vb2ex_display_ui(ui.state->screen->id, ui.locale_id,
					 ui.state->selected_item,
					 ui.state->disabled_item_mask,
					 ui.state->hidden_item_mask,
					 ui.disable_timer,
					 ui.state->current_page,
					 ui.error_code);
			if (ui.error_beep ||
			    (ui.error_code &&
			     prev_error_code != ui.error_code)) {
				vb2ex_beep(250, 400);
				ui.error_beep = 0;
			}

			/* Reset refresh flag. */
			ui.force_display = 0;

			/* Update prev variables. */
			memcpy(&prev_state, ui.state, sizeof(*ui.state));
			prev_disable_timer = ui.disable_timer;
			prev_error_code = ui.error_code;
		}

		/* Grab new keyboard input. */
		ui.key = VbExKeyboardReadWithFlags(&key_flags);
		ui.key_trusted = !!(key_flags & VB_KEY_FLAG_TRUSTED_KEYBOARD);

		/* Check for shutdown request. */
		rv = check_shutdown_request(&ui);
		if (rv && rv != VB2_REQUEST_UI_CONTINUE) {
			VB2_DEBUG("Shutdown requested!\n");
			return rv;
		}

		/* Check if we need to exit an error box. */
		rv = error_exit_action(&ui);
		if (rv && rv != VB2_REQUEST_UI_CONTINUE)
			return rv;

		/* Run screen action. */
		if (ui.state->screen->action) {
			rv = ui.state->screen->action(&ui);
			if (rv && rv != VB2_REQUEST_UI_CONTINUE)
				return rv;
		}

		/* Run menu navigation action. */
		rv = menu_navigation_action(&ui);
		if (rv && rv != VB2_REQUEST_UI_CONTINUE)
			return rv;

		/* Run global action function if available. */
		if (global_action) {
			rv = global_action(&ui);
			if (rv && rv != VB2_REQUEST_UI_CONTINUE)
				return rv;
		}

		/* Delay. */
		elapsed_ms = vb2ex_mtime() - start_time_ms;
		if (elapsed_ms < KEY_DELAY_MS)
			vb2ex_msleep(KEY_DELAY_MS - elapsed_ms);
	}

	return VB2_SUCCESS;
}

vb2_error_t ui_loop(struct vb2_context *ctx, enum vb2_screen root_screen_id,
		    vb2_error_t (*global_action)(struct vb2_ui_context *ui))
{
	vb2_error_t rv = ui_loop_impl(ctx, root_screen_id, global_action);
	if (rv == VB2_REQUEST_UI_EXIT)
		return VB2_SUCCESS;
	return rv;
}

/*****************************************************************************/
/* Developer mode */

vb2_error_t vb2_developer_menu(struct vb2_context *ctx)
{
	enum vb2_screen root_screen_id = VB2_SCREEN_DEVELOPER_MODE;
	if (!vb2_dev_boot_allowed(ctx)) {
		VB2_DEBUG("WARNING: Dev boot not allowed; forcing to-norm\n");
		root_screen_id = VB2_SCREEN_DEVELOPER_TO_NORM;
	}
	return ui_loop(ctx, root_screen_id, developer_action);
}

vb2_error_t developer_action(struct vb2_ui_context *ui)
{
	/* Developer mode keyboard shortcuts */
	if (ui->key == '\t')
		return vb2_ui_screen_change(ui, VB2_SCREEN_DEBUG_INFO);

	/* Ignore other shortcuts */
	if (!vb2_dev_boot_allowed(ui->ctx))
		return VB2_REQUEST_UI_CONTINUE;

	if (ui->key == VB_KEY_CTRL('S'))
		return vb2_ui_screen_change(ui, VB2_SCREEN_DEVELOPER_TO_NORM);
	if (ui->key == VB_KEY_CTRL('U') ||
	    (DETACHABLE && ui->key == VB_BUTTON_VOL_UP_LONG_PRESS))
		return vb2_ui_developer_mode_boot_external_action(ui);
	if (ui->key == VB_KEY_CTRL('D') ||
	    (DETACHABLE && ui->key == VB_BUTTON_VOL_DOWN_LONG_PRESS))
		return vb2_ui_developer_mode_boot_internal_action(ui);
	if (ui->key == VB_KEY_CTRL('L'))  /* L for aLtfw (formerly Legacy) */
		return vb2_ui_developer_mode_boot_altfw_action(ui);

	return VB2_SUCCESS;
}

/*****************************************************************************/
/* Broken recovery */

vb2_error_t vb2_broken_recovery_menu(struct vb2_context *ctx)
{
	return ui_loop(ctx, VB2_SCREEN_RECOVERY_BROKEN, broken_recovery_action);
}

vb2_error_t broken_recovery_action(struct vb2_ui_context *ui)
{
	/* Broken recovery keyboard shortcuts */
	if (ui->key == '\t')
		return vb2_ui_screen_change(ui, VB2_SCREEN_DEBUG_INFO);

	return VB2_SUCCESS;
}

/*****************************************************************************/
/* Manual recovery */

vb2_error_t vb2_manual_recovery_menu(struct vb2_context *ctx)
{
	return ui_loop(ctx, VB2_SCREEN_RECOVERY_SELECT, manual_recovery_action);
}

vb2_error_t manual_recovery_action(struct vb2_ui_context *ui)
{
	/* See if we have a recovery kernel available yet. */
	vb2_error_t rv = VbTryLoadKernel(ui->ctx, VB_DISK_FLAG_REMOVABLE);
	if (rv == VB2_SUCCESS)
		return VB2_REQUEST_UI_EXIT;

	/* If disk validity state changed, switch to appropriate screen. */
	if (ui->recovery_rv != rv) {
		VB2_DEBUG("Recovery VbTryLoadKernel %#x --> %#x\n",
			  ui->recovery_rv, rv);
		ui->recovery_rv = rv;
		return vb2_ui_screen_change(ui,
					    rv == VB2_ERROR_LK_NO_DISK_FOUND ?
					    VB2_SCREEN_RECOVERY_SELECT :
					    VB2_SCREEN_RECOVERY_INVALID);
	}

	/* Manual recovery keyboard shortcuts */
	if (ui->key == VB_KEY_CTRL('D') ||
	    (DETACHABLE && ui->key == VB_BUTTON_VOL_UP_DOWN_COMBO_PRESS))
		return vb2_ui_screen_change(ui, VB2_SCREEN_RECOVERY_TO_DEV);

	if (ui->key == '\t')
		return vb2_ui_screen_change(ui, VB2_SCREEN_DEBUG_INFO);

	return VB2_SUCCESS;
}

/*****************************************************************************/
/* Diagnostics */

vb2_error_t vb2_diagnostic_menu(struct vb2_context *ctx)
{
	return ui_loop(ctx, VB2_SCREEN_DIAGNOSTICS, NULL);
}
