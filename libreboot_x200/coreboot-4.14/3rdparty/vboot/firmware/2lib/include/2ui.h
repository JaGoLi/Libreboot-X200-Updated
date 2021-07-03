/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * User interfaces for developer and recovery mode menus.
 */

#ifndef VBOOT_REFERENCE_2UI_H_
#define VBOOT_REFERENCE_2UI_H_

#include <2api.h>
#include <2sysincludes.h>

/*****************************************************************************/
/* Data structures */

struct vb2_ui_context;  /* Forward declaration */

struct vb2_menu_item {
	/* Text description */
	const char *text;
	/* Target screen */
	enum vb2_screen target;
	/* Action function takes precedence over target screen if non-NULL. */
	vb2_error_t (*action)(struct vb2_ui_context *ui);
	/* Whether the item is language selection */
	int is_language_select;
};

struct vb2_menu {
	/* Number of menu items */
	uint16_t num_items;
	/* List of menu items */
	const struct vb2_menu_item *items;
};

struct vb2_screen_info {
	/* Screen id */
	enum vb2_screen id;
	/* Screen name for printing to console only */
	const char *name;
	/*
	 * Init function runs once when changing to the screen which is not in
	 * the history stack.
	 */
	vb2_error_t (*init)(struct vb2_ui_context *ui);
	/*
	 * Re-init function runs once when changing to the screen which is
	 * already in the history stack, for example, when going back to the
	 * screen. Exactly one of init() and reinit() will be called.
	 */
	vb2_error_t (*reinit)(struct vb2_ui_context *ui);
	/* Action function runs repeatedly while on the screen. */
	vb2_error_t (*action)(struct vb2_ui_context *ui);
	/* Menu items. */
	struct vb2_menu menu;
	/*
	 * Custom function for getting menu items. If non-null, field 'menu'
	 * will be ignored.
	 */
	const struct vb2_menu *(*get_menu)(struct vb2_ui_context *ui);
	/*
	 * Indices of menu items;
	 * used by log_page_* functions in 2ui_screens.c.
	 */
	uint32_t page_up_item;
	uint32_t page_down_item;
	uint32_t back_item;
	uint32_t cancel_item;
};

struct vb2_screen_state {
	const struct vb2_screen_info *screen;
	uint32_t selected_item;
	uint32_t disabled_item_mask;
	uint32_t hidden_item_mask;

	/* For log screen. */
	uint32_t page_count;
	uint32_t current_page;

	/* For memory check screen. */
	int test_finished;  /* Do not update screen if the content is done */

	struct vb2_screen_state *prev;
};

enum vb2_power_button {
	VB2_POWER_BUTTON_HELD_SINCE_BOOT = 0,
	VB2_POWER_BUTTON_RELEASED,
	VB2_POWER_BUTTON_PRESSED,  /* Must have been previously released */
};

struct vb2_ui_context {
	struct vb2_context *ctx;
	struct vb2_screen_state *state;
	uint32_t locale_id;
	uint32_t key;
	int key_trusted;

	/* For check_shutdown_request. */
	enum vb2_power_button power_button;

	/* For developer mode. */
	int disable_timer;
	uint32_t start_time_ms;
	int beep_count;

	/* For manual recovery. */
	vb2_error_t recovery_rv;

	/* For to_dev transition flow. */
	int physical_presence_button_pressed;

	/* For language selection screen. */
	struct vb2_menu language_menu;

	/* For bootloader selection screen. */
	struct vb2_menu bootloader_menu;

	/* For error beep sound. */
	int error_beep;

	/* For displaying error messages. */
	enum vb2_ui_error error_code;

	/* Force calling vb2ex_display_ui for refreshing the screen. This flag
	   will be reset after done. */
	int force_display;
};

vb2_error_t vb2_ui_developer_mode_boot_internal_action(
	struct vb2_ui_context *ui);
vb2_error_t vb2_ui_developer_mode_boot_external_action(
	struct vb2_ui_context *ui);
vb2_error_t vb2_ui_developer_mode_boot_altfw_action(
	struct vb2_ui_context *ui);

/**
 * Get info struct of a screen.
 *
 * @param id		Screen from enum vb2_screen
 *
 * @return screen info struct on success, NULL on error.
 */
const struct vb2_screen_info *vb2_get_screen_info(enum vb2_screen id);

/*****************************************************************************/
/* Menu navigation functions */

/**
 * Move selection to the previous menu item.
 *
 * Update selected_item, taking into account hidden indices (from
 * hidden_item_mask).  The selection does not wrap, meaning that we block
 * on 0 when we hit the start of the menu.
 *
 * @param ui		UI context pointer
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_ui_menu_prev(struct vb2_ui_context *ui);

/**
 * Move selection to the next menu item.
 *
 * Update selected_item, taking into account hidden indices (from
 * hidden_item_mask).  The selection does not wrap, meaning that we block
 * on the max index when we hit the end of the menu.
 *
 * @param ui		UI context pointer
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_ui_menu_next(struct vb2_ui_context *ui);

/**
 * Select the current menu item.
 *
 * The caller should take care of returning after this function, and should not
 * continue executing under the assumption that the screen has *not* changed.
 *
 * If the current menu item has an action associated with it, run the action.
 * Otherwise, navigate to the target screen.  If neither of these are set, then
 * selecting the menu item is a no-op.
 *
 * @param ui		UI context pointer
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_ui_menu_select(struct vb2_ui_context *ui);

/*****************************************************************************/
/* Screen navigation functions */
/**
 * After these functions are called, no assumptions may be made about which
 * screen is currently displayed, and thus execution should return to ui_loop.
 * VB2_REQUEST_UI_CONTINUE is returned rather than VB2_SUCCESS, so VB2_TRY can
 * be used to wrapped to these functions and the callers of these functions.
 */
/**
 * Return back to the previous screen.
 *
 * The caller should take care of returning after this function, and should not
 * continue executing under the assumption that the screen has *not* changed.
 *
 * If the current screen is already the root screen, the request is ignored.
 *
 * TODO(b/157625765): Consider falling into recovery mode (BROKEN screen) when
 * the current screen is already the root screen.
 *
 * @param ui		UI context pointer
 * @return VB2_REQUEST_UI_CONTINUE, or error code on error.
 */
vb2_error_t vb2_ui_screen_back(struct vb2_ui_context *ui);

/**
 * Change to the given screen.
 *
 * The caller should take care of returning after this function, and should not
 * continue executing under the assumption that the screen has *not* changed.
 *
 * If the screen is not found, the request is ignored.
 *
 * TODO(b/157625765): Consider falling into recovery mode (BROKEN screen) when
 * the target screen is not found.
 *
 * @param ui		UI context pointer
 * @param id		Screen from enum vb2_screen
 * @return VB2_REQUEST_UI_CONTINUE, or error code on error.
 */
vb2_error_t vb2_ui_screen_change(struct vb2_ui_context *ui, enum vb2_screen id);

/*****************************************************************************/
/* UI loops */

/**
 * UI for a developer-mode boot.
 *
 * Enter the developer menu, which provides options to switch out of developer
 * mode, boot from external media, use legacy bootloader, or boot Chrome OS from
 * disk.
 *
 * If a timeout occurs, take the default boot action.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or non-zero error code.
 */
vb2_error_t vb2_developer_menu(struct vb2_context *ctx);

/**
 * UI for a non-manual recovery ("BROKEN").
 *
 * Enter the recovery menu, which shows that an unrecoverable error was
 * encountered last boot. Wait for the user to physically reset or shut down.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or non-zero error code.
 */
vb2_error_t vb2_broken_recovery_menu(struct vb2_context *ctx);

/**
 * UI for a manual recovery-mode boot.
 *
 * Enter the recovery menu, which prompts the user to insert recovery media,
 * navigate the step-by-step recovery, or enter developer mode if allowed.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or non-zero error code.
 */
vb2_error_t vb2_manual_recovery_menu(struct vb2_context *ctx);

/**
 * UI for a diagnostic tools boot.
 *
 * Enter the diagnostic tools menu, which provides debug information and
 * diagnostic tests of various hardware components.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or non-zero error code.
 */
vb2_error_t vb2_diagnostic_menu(struct vb2_context *ctx);

#endif  /* VBOOT_REFERENCE_2UI_H_ */
