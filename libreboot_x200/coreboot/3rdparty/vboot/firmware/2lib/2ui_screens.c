/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Firmware screen definitions.
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2ui.h"
#include "2ui_private.h"
#include "vboot_api.h"
#include "vboot_kernel.h"

#define MENU_ITEMS(a) ((struct vb2_menu){ \
	.num_items = ARRAY_SIZE(a), \
	.items = a, \
})

#define LANGUAGE_SELECT_ITEM ((struct vb2_menu_item){ \
	.text = "Language selection", \
	.target = VB2_SCREEN_LANGUAGE_SELECT, \
	.is_language_select = 1, \
})

#define NEXT_ITEM(target_screen) ((struct vb2_menu_item){ \
	.text = "Next", \
	.target = (target_screen), \
})

#define BACK_ITEM ((struct vb2_menu_item){ \
	.text = "Back", \
	.action = vb2_ui_screen_back, \
})

#define ADVANCED_OPTIONS_ITEM ((struct vb2_menu_item){ \
	.text = "Advanced options", \
	.target = VB2_SCREEN_ADVANCED_OPTIONS, \
})

/* Action that will power off the device. */
static vb2_error_t power_off_action(struct vb2_ui_context *ui)
{
	return VB2_REQUEST_SHUTDOWN;
}

#define POWER_OFF_ITEM ((struct vb2_menu_item){ \
	.text = "Power off", \
	.action = power_off_action, \
})

/******************************************************************************/
/*
 * Functions used for log screens
 *
 * Expects that the page_count is valid and page_up_item and page_down_item are
 * assigned to correct menu item indices in all three functions, the
 * current_page is valid in prev and next actions, and the back_item is assigned
 * to a correct menu item index.
 */

static vb2_error_t log_page_init(struct vb2_ui_context *ui)
{
	const struct vb2_screen_info *screen = ui->state->screen;

	ui->state->current_page = 0;

	if (ui->state->page_count == 1) {
		VB2_SET_BIT(ui->state->disabled_item_mask,
			    screen->page_up_item);
		VB2_SET_BIT(ui->state->disabled_item_mask,
			    screen->page_down_item);
		ui->state->selected_item = screen->back_item;
	} else {
		VB2_SET_BIT(ui->state->disabled_item_mask,
			    screen->page_up_item);
		ui->state->selected_item = screen->page_down_item;
	}

	return VB2_REQUEST_UI_CONTINUE;
}

static vb2_error_t log_page_prev_action(struct vb2_ui_context *ui)
{
	const struct vb2_screen_info *screen = ui->state->screen;

	/* Validity check. */
	if (ui->state->current_page == 0)
		return VB2_REQUEST_UI_CONTINUE;

	ui->state->current_page--;

	/* Clear bits of page down. */
	if (ui->state->current_page != ui->state->page_count - 1)
		VB2_CLR_BIT(ui->state->disabled_item_mask,
			    screen->page_down_item);

	/* Disable page up at the first page. */
	if (ui->state->current_page == 0)
		VB2_SET_BIT(ui->state->disabled_item_mask,
			    screen->page_up_item);

	return VB2_REQUEST_UI_CONTINUE;
}

static vb2_error_t log_page_next_action(struct vb2_ui_context *ui)
{
	const struct vb2_screen_info *screen = ui->state->screen;

	/* Validity check. */
	if (ui->state->current_page == ui->state->page_count - 1)
		return VB2_REQUEST_UI_CONTINUE;

	ui->state->current_page++;

	/* Clear bits of page up. */
	if (ui->state->current_page != 0)
		VB2_CLR_BIT(ui->state->disabled_item_mask,
			    screen->page_up_item);

	/* Disable page down at the last page. */
	if (ui->state->current_page == ui->state->page_count - 1)
		VB2_SET_BIT(ui->state->disabled_item_mask,
			    screen->page_down_item);

	return VB2_REQUEST_UI_CONTINUE;
}

#define PAGE_UP_ITEM ((struct vb2_menu_item){ \
	.text = "Page up", \
	.action = log_page_prev_action, \
})

#define PAGE_DOWN_ITEM ((struct vb2_menu_item){ \
	.text = "Page down", \
	.action = log_page_next_action, \
})

/******************************************************************************/
/* VB2_SCREEN_BLANK */

static const struct vb2_screen_info blank_screen = {
	.id = VB2_SCREEN_BLANK,
	.name = "Blank",
};

/******************************************************************************/
/* VB2_SCREEN_LANGUAGE_SELECT */

static vb2_error_t language_select_action(struct vb2_ui_context *ui)
{
	vb2_error_t rv;
	ui->locale_id = ui->state->selected_item;
	VB2_DEBUG("Locale changed to %u\n", ui->locale_id);

	/* Write locale id back to nvdata. */
	vb2_nv_set(ui->ctx, VB2_NV_LOCALIZATION_INDEX, ui->locale_id);

	/* Commit nvdata changes immediately, in case of three-finger salute
	   reboot.  Ignore commit errors in recovery mode. */
	rv = vb2ex_commit_data(ui->ctx);
	if (rv && !(ui->ctx->flags & VB2_CONTEXT_RECOVERY_MODE))
		return rv;

	return vb2_ui_screen_back(ui);
}

const struct vb2_menu *get_language_menu(struct vb2_ui_context *ui)
{
	int i;
	uint32_t num_locales;
	struct vb2_menu_item *items;

	if (ui->language_menu.num_items > 0)
		return &ui->language_menu;

	num_locales = vb2ex_get_locale_count();
	if (num_locales == 0) {
		VB2_DEBUG("WARNING: No locales available; assuming 1 locale\n");
		num_locales = 1;
	}

	items = malloc(num_locales * sizeof(struct vb2_menu_item));
	if (!items) {
		VB2_DEBUG("ERROR: malloc failed for language items\n");
		return NULL;
	}

	for (i = 0; i < num_locales; i++) {
		items[i].text = "Some language";
		items[i].action = language_select_action;
	}

	ui->language_menu.num_items = num_locales;
	ui->language_menu.items = items;
	return &ui->language_menu;
}

static vb2_error_t language_select_init(struct vb2_ui_context *ui)
{
	const struct vb2_menu *menu = get_menu(ui);
	if (menu->num_items == 0) {
		VB2_DEBUG("ERROR: No menu items found; "
			  "rejecting entering language selection screen\n");
		return vb2_ui_screen_back(ui);
	}
	if (ui->locale_id < menu->num_items) {
		ui->state->selected_item = ui->locale_id;
	} else {
		VB2_DEBUG("WARNING: Current locale not found in menu items; "
			  "initializing selected_item to 0\n");
		ui->state->selected_item = 0;
	}
	return VB2_REQUEST_UI_CONTINUE;
}

static const struct vb2_screen_info language_select_screen = {
	.id = VB2_SCREEN_LANGUAGE_SELECT,
	.name = "Language selection screen",
	.init = language_select_init,
	.get_menu = get_language_menu,
};

/******************************************************************************/
/* VB2_SCREEN_RECOVERY_BROKEN */

static const struct vb2_menu_item recovery_broken_items[] = {
	LANGUAGE_SELECT_ITEM,
	ADVANCED_OPTIONS_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info recovery_broken_screen = {
	.id = VB2_SCREEN_RECOVERY_BROKEN,
	.name = "Recover broken device",
	.menu = MENU_ITEMS(recovery_broken_items),
};

/******************************************************************************/
/* VB2_SCREEN_ADVANCED_OPTIONS */

#define ADVANCED_OPTIONS_ITEM_DEVELOPER_MODE 1
#define ADVANCED_OPTIONS_ITEM_DEBUG_INFO 2

vb2_error_t advanced_options_init(struct vb2_ui_context *ui)
{
	ui->state->selected_item = ADVANCED_OPTIONS_ITEM_DEVELOPER_MODE;
	if (vb2_get_sd(ui->ctx)->flags & VB2_SD_FLAG_DEV_MODE_ENABLED ||
	    !vb2_allow_recovery(ui->ctx)) {
		VB2_SET_BIT(ui->state->hidden_item_mask,
			    ADVANCED_OPTIONS_ITEM_DEVELOPER_MODE);
		ui->state->selected_item = ADVANCED_OPTIONS_ITEM_DEBUG_INFO;
	}

	return VB2_REQUEST_UI_CONTINUE;
}

static const struct vb2_menu_item advanced_options_items[] = {
	LANGUAGE_SELECT_ITEM,
	[ADVANCED_OPTIONS_ITEM_DEVELOPER_MODE] = {
		.text = "Enable developer mode",
		.target = VB2_SCREEN_RECOVERY_TO_DEV,
	},
	[ADVANCED_OPTIONS_ITEM_DEBUG_INFO] = {
		.text = "Debug info",
		.target = VB2_SCREEN_DEBUG_INFO,
	},
	{
		.text = "Firmware log",
		.target = VB2_SCREEN_FIRMWARE_LOG,
	},
	BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info advanced_options_screen = {
	.id = VB2_SCREEN_ADVANCED_OPTIONS,
	.name = "Advanced options",
	.init = advanced_options_init,
	.menu = MENU_ITEMS(advanced_options_items),
};

/******************************************************************************/
/* VB2_SCREEN_DEBUG_INFO */

#define DEBUG_INFO_ITEM_PAGE_UP 1
#define DEBUG_INFO_ITEM_PAGE_DOWN 2
#define DEBUG_INFO_ITEM_BACK 3

static vb2_error_t debug_info_init(struct vb2_ui_context *ui)
{
	const char *log_string = vb2ex_get_debug_info(ui->ctx);
	if (!log_string) {
		VB2_DEBUG("ERROR: Failed to retrieve debug info\n");
		ui->error_code = VB2_UI_ERROR_DEBUG_LOG;
		return vb2_ui_screen_back(ui);
	}
	ui->state->page_count = vb2ex_prepare_log_screen(
		ui->state->screen->id, ui->locale_id, log_string);
	if (ui->state->page_count == 0) {
		VB2_DEBUG("ERROR: Failed to prepare debug info screen\n");
		ui->error_code = VB2_UI_ERROR_DEBUG_LOG;
		return vb2_ui_screen_back(ui);
	}

	return log_page_init(ui);
}

static vb2_error_t debug_info_reinit(struct vb2_ui_context *ui)
{
	const char *log_string = vb2ex_get_debug_info(ui->ctx);
	if (!log_string) {
		VB2_DEBUG("ERROR: Failed to retrieve debug info\n");
		ui->error_code = VB2_UI_ERROR_DEBUG_LOG;
		return vb2_ui_screen_back(ui);
	}
	ui->state->page_count = vb2ex_prepare_log_screen(
		ui->state->screen->id, ui->locale_id, log_string);
	if (ui->state->page_count == 0) {
		VB2_DEBUG("ERROR: Failed to prepare debug info screen\n");
		ui->error_code = VB2_UI_ERROR_DEBUG_LOG;
		return vb2_ui_screen_back(ui);
	}

	return VB2_REQUEST_UI_CONTINUE;
}

static const struct vb2_menu_item debug_info_items[] = {
	LANGUAGE_SELECT_ITEM,
	[DEBUG_INFO_ITEM_PAGE_UP] = PAGE_UP_ITEM,
	[DEBUG_INFO_ITEM_PAGE_DOWN] = PAGE_DOWN_ITEM,
	[DEBUG_INFO_ITEM_BACK] = BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info debug_info_screen = {
	.id = VB2_SCREEN_DEBUG_INFO,
	.name = "Debug info",
	.init = debug_info_init,
	.reinit = debug_info_reinit,
	.menu = MENU_ITEMS(debug_info_items),
	.page_up_item = DEBUG_INFO_ITEM_PAGE_UP,
	.page_down_item = DEBUG_INFO_ITEM_PAGE_DOWN,
	.back_item = DEBUG_INFO_ITEM_BACK,
};

/******************************************************************************/
/* VB2_SCREEN_FIRMWARE_LOG */

#define FIRMWARE_LOG_ITEM_PAGE_UP 1
#define FIRMWARE_LOG_ITEM_PAGE_DOWN 2
#define FIRMWARE_LOG_ITEM_BACK 3

static vb2_error_t firmware_log_init(struct vb2_ui_context *ui)
{
	const char *log_string = vb2ex_get_firmware_log(1);
	if (!log_string) {
		VB2_DEBUG("ERROR: Failed to retrieve firmware log\n");
		ui->error_code = VB2_UI_ERROR_FIRMWARE_LOG;
		return vb2_ui_screen_back(ui);
	}
	ui->state->page_count = vb2ex_prepare_log_screen(
		ui->state->screen->id, ui->locale_id, log_string);
	if (ui->state->page_count == 0) {
		VB2_DEBUG("ERROR: Failed to prepare firmware log screen\n");
		ui->error_code = VB2_UI_ERROR_FIRMWARE_LOG;
		return vb2_ui_screen_back(ui);
	}

	return log_page_init(ui);
}

static vb2_error_t firmware_log_reinit(struct vb2_ui_context *ui)
{
	const char *log_string = vb2ex_get_firmware_log(0);
	if (!log_string) {
		VB2_DEBUG("ERROR: Failed to retrieve firmware log\n");
		ui->error_code = VB2_UI_ERROR_FIRMWARE_LOG;
		return vb2_ui_screen_back(ui);
	}
	ui->state->page_count = vb2ex_prepare_log_screen(
		ui->state->screen->id, ui->locale_id, log_string);
	if (ui->state->page_count == 0) {
		VB2_DEBUG("ERROR: Failed to prepare firmware log screen\n");
		ui->error_code = VB2_UI_ERROR_FIRMWARE_LOG;
		return vb2_ui_screen_back(ui);
	}

	return VB2_REQUEST_UI_CONTINUE;
}

static const struct vb2_menu_item firmware_log_items[] = {
	LANGUAGE_SELECT_ITEM,
	[FIRMWARE_LOG_ITEM_PAGE_UP] = PAGE_UP_ITEM,
	[FIRMWARE_LOG_ITEM_PAGE_DOWN] = PAGE_DOWN_ITEM,
	[FIRMWARE_LOG_ITEM_BACK] = BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info firmware_log_screen = {
	.id = VB2_SCREEN_FIRMWARE_LOG,
	.name = "Firmware log",
	.init = firmware_log_init,
	.reinit = firmware_log_reinit,
	.menu = MENU_ITEMS(firmware_log_items),
	.page_up_item = FIRMWARE_LOG_ITEM_PAGE_UP,
	.page_down_item = FIRMWARE_LOG_ITEM_PAGE_DOWN,
	.back_item = FIRMWARE_LOG_ITEM_BACK,
};

/******************************************************************************/
/* VB2_SCREEN_RECOVERY_SELECT */

#define RECOVERY_SELECT_ITEM_PHONE 1
#define RECOVERY_SELECT_ITEM_EXTERNAL_DISK 2
#define RECOVERY_SELECT_ITEM_DIAGNOSTICS 3

/* Set VB2_NV_DIAG_REQUEST and reboot. */
static vb2_error_t launch_diagnostics_action(struct vb2_ui_context *ui)
{
	vb2_nv_set(ui->ctx, VB2_NV_DIAG_REQUEST, 1);
	VB2_DEBUG("Diagnostics requested, rebooting\n");
	return VB2_REQUEST_REBOOT;
}

vb2_error_t recovery_select_init(struct vb2_ui_context *ui)
{
	ui->state->selected_item = RECOVERY_SELECT_ITEM_PHONE;
	if (!vb2api_phone_recovery_ui_enabled(ui->ctx)) {
		VB2_DEBUG("WARNING: Phone recovery not available\n");
		VB2_SET_BIT(ui->state->hidden_item_mask,
			    RECOVERY_SELECT_ITEM_PHONE);
		ui->state->selected_item = RECOVERY_SELECT_ITEM_EXTERNAL_DISK;
	}

        if (!DIAGNOSTIC_UI || !vb2api_diagnostic_ui_enabled(ui->ctx))
		VB2_SET_BIT(ui->state->hidden_item_mask,
			    RECOVERY_SELECT_ITEM_DIAGNOSTICS);

	return VB2_REQUEST_UI_CONTINUE;
}

static const struct vb2_menu_item recovery_select_items[] = {
	LANGUAGE_SELECT_ITEM,
	[RECOVERY_SELECT_ITEM_PHONE] = {
		.text = "Recovery using phone",
		.target = VB2_SCREEN_RECOVERY_PHONE_STEP1,
	},
	[RECOVERY_SELECT_ITEM_EXTERNAL_DISK] = {
		.text = "Recovery using external disk",
		.target = VB2_SCREEN_RECOVERY_DISK_STEP1,
	},
	[RECOVERY_SELECT_ITEM_DIAGNOSTICS] = {
		.text = "Launch diagnostics",
		.action = launch_diagnostics_action,
	},
	ADVANCED_OPTIONS_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info recovery_select_screen = {
	.id = VB2_SCREEN_RECOVERY_SELECT,
	.name = "Recovery method selection",
	.init = recovery_select_init,
	.menu = MENU_ITEMS(recovery_select_items),
};

/******************************************************************************/
/* VB2_SCREEN_RECOVERY_INVALID */

static const struct vb2_menu_item recovery_invalid_items[] = {
	LANGUAGE_SELECT_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info recovery_invalid_screen = {
	.id = VB2_SCREEN_RECOVERY_INVALID,
	.name = "Invalid recovery inserted",
	.menu = MENU_ITEMS(recovery_invalid_items),
};

/******************************************************************************/
/* VB2_SCREEN_RECOVERY_TO_DEV */

#define RECOVERY_TO_DEV_ITEM_CONFIRM 1
#define RECOVERY_TO_DEV_ITEM_CANCEL 2

vb2_error_t recovery_to_dev_init(struct vb2_ui_context *ui)
{
	if (vb2_get_sd(ui->ctx)->flags & VB2_SD_FLAG_DEV_MODE_ENABLED) {
		/* We're in dev mode, so let user know they can't transition */
		ui->error_code = VB2_UI_ERROR_DEV_MODE_ALREADY_ENABLED;
		return vb2_ui_screen_back(ui);
	}

	if (!PHYSICAL_PRESENCE_KEYBOARD && vb2ex_physical_presence_pressed()) {
		VB2_DEBUG("Presence button stuck?\n");
		return vb2_ui_screen_back(ui);
	}

	ui->state->selected_item = RECOVERY_TO_DEV_ITEM_CONFIRM;

	/* Disable "Confirm" button for other physical presence types. */
	if (!PHYSICAL_PRESENCE_KEYBOARD) {
		VB2_SET_BIT(ui->state->hidden_item_mask,
			    RECOVERY_TO_DEV_ITEM_CONFIRM);
		ui->state->selected_item = RECOVERY_TO_DEV_ITEM_CANCEL;
	}

	ui->physical_presence_button_pressed = 0;

	return VB2_REQUEST_UI_CONTINUE;
}

static vb2_error_t recovery_to_dev_finalize(struct vb2_ui_context *ui)
{
	VB2_DEBUG("Physical presence confirmed!\n");

	/* Validity check, should never happen. */
	if (ui->state->screen->id != VB2_SCREEN_RECOVERY_TO_DEV ||
	    (vb2_get_sd(ui->ctx)->flags & VB2_SD_FLAG_DEV_MODE_ENABLED) ||
	    !vb2_allow_recovery(ui->ctx)) {
		VB2_DEBUG("ERROR: Dev transition validity check failed\n");
		return VB2_REQUEST_UI_CONTINUE;
	}

	VB2_DEBUG("Enabling dev mode and rebooting...\n");
	vb2_enable_developer_mode(ui->ctx);
	return VB2_REQUEST_REBOOT_EC_TO_RO;
}

vb2_error_t recovery_to_dev_confirm_action(struct vb2_ui_context *ui)
{
	if (!ui->key_trusted) {
		VB2_DEBUG("Reject untrusted %s confirmation\n",
			  ui->key == VB_KEY_ENTER ? "ENTER" : "POWER");
		/*
		 * If physical presence is confirmed using the keyboard,
		 * beep and notify the user when the ENTER key comes
		 * from an untrusted keyboard.
		 */
		if (PHYSICAL_PRESENCE_KEYBOARD && ui->key == VB_KEY_ENTER)
			ui->error_code = VB2_UI_ERROR_UNTRUSTED_CONFIRMATION;
		return VB2_REQUEST_UI_CONTINUE;
	}
	return recovery_to_dev_finalize(ui);
}

vb2_error_t recovery_to_dev_action(struct vb2_ui_context *ui)
{
	int pressed;

	if (ui->key == ' ') {
		VB2_DEBUG("SPACE means cancel dev mode transition\n");
		return vb2_ui_screen_back(ui);
	}

	/* Keyboard physical presence case covered by "Confirm" action. */
	if (PHYSICAL_PRESENCE_KEYBOARD)
		return VB2_REQUEST_UI_CONTINUE;

	pressed = vb2ex_physical_presence_pressed();
	if (pressed) {
		VB2_DEBUG("Physical presence button pressed, "
			  "awaiting release\n");
		ui->physical_presence_button_pressed = 1;
		return VB2_REQUEST_UI_CONTINUE;
	}
	if (!ui->physical_presence_button_pressed)
		return VB2_REQUEST_UI_CONTINUE;
	VB2_DEBUG("Physical presence button released\n");

	return recovery_to_dev_finalize(ui);
}

static const struct vb2_menu_item recovery_to_dev_items[] = {
	LANGUAGE_SELECT_ITEM,
	[RECOVERY_TO_DEV_ITEM_CONFIRM] = {
		.text = "Confirm",
		.action = recovery_to_dev_confirm_action,
	},
	[RECOVERY_TO_DEV_ITEM_CANCEL] = {
		.text = "Cancel",
		.action = vb2_ui_screen_back,
	},
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info recovery_to_dev_screen = {
	.id = VB2_SCREEN_RECOVERY_TO_DEV,
	.name = "Transition to developer mode",
	.init = recovery_to_dev_init,
	.action = recovery_to_dev_action,
	.menu = MENU_ITEMS(recovery_to_dev_items),
};

/******************************************************************************/
/* VB2_SCREEN_RECOVERY_PHONE_STEP1 */

static const struct vb2_menu_item recovery_phone_step1_items[] = {
	LANGUAGE_SELECT_ITEM,
	NEXT_ITEM(VB2_SCREEN_RECOVERY_PHONE_STEP2),
	BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info recovery_phone_step1_screen = {
	.id = VB2_SCREEN_RECOVERY_PHONE_STEP1,
	.name = "Phone recovery step 1",
	.menu = MENU_ITEMS(recovery_phone_step1_items),
};

/******************************************************************************/
/* VB2_SCREEN_RECOVERY_PHONE_STEP2 */

static const struct vb2_menu_item recovery_phone_step2_items[] = {
	LANGUAGE_SELECT_ITEM,
	BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info recovery_phone_step2_screen = {
	.id = VB2_SCREEN_RECOVERY_PHONE_STEP2,
	.name = "Phone recovery step 2",
	.menu = MENU_ITEMS(recovery_phone_step2_items),
};

/******************************************************************************/
/* VB2_SCREEN_RECOVERY_DISK_STEP1 */

static const struct vb2_menu_item recovery_disk_step1_items[] = {
	LANGUAGE_SELECT_ITEM,
	NEXT_ITEM(VB2_SCREEN_RECOVERY_DISK_STEP2),
	BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info recovery_disk_step1_screen = {
	.id = VB2_SCREEN_RECOVERY_DISK_STEP1,
	.name = "Disk recovery step 1",
	.menu = MENU_ITEMS(recovery_disk_step1_items),
};

/******************************************************************************/
/* VB2_SCREEN_RECOVERY_DISK_STEP2 */

static const struct vb2_menu_item recovery_disk_step2_items[] = {
	LANGUAGE_SELECT_ITEM,
	NEXT_ITEM(VB2_SCREEN_RECOVERY_DISK_STEP3),
	BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info recovery_disk_step2_screen = {
	.id = VB2_SCREEN_RECOVERY_DISK_STEP2,
	.name = "Disk recovery step 2",
	.menu = MENU_ITEMS(recovery_disk_step2_items),
};

/******************************************************************************/
/* VB2_SCREEN_RECOVERY_DISK_STEP3 */

static const struct vb2_menu_item recovery_disk_step3_items[] = {
	LANGUAGE_SELECT_ITEM,
	BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info recovery_disk_step3_screen = {
	.id = VB2_SCREEN_RECOVERY_DISK_STEP3,
	.name = "Disk recovery step 3",
	.menu = MENU_ITEMS(recovery_disk_step3_items),
};

/******************************************************************************/
/* VB2_SCREEN_DEVELOPER_MODE */

#define DEVELOPER_MODE_ITEM_RETURN_TO_SECURE 1
#define DEVELOPER_MODE_ITEM_BOOT_INTERNAL 2
#define DEVELOPER_MODE_ITEM_BOOT_EXTERNAL 3
#define DEVELOPER_MODE_ITEM_SELECT_BOOTLOADER 4

vb2_error_t developer_mode_init(struct vb2_ui_context *ui)
{
	enum vb2_dev_default_boot_target default_boot =
		vb2api_get_dev_default_boot_target(ui->ctx);

	/* TODO(b/159579189): Split this case into a separate root screen */
	if (!vb2_dev_boot_allowed(ui->ctx))
		vb2_ui_screen_change(ui, VB2_SCREEN_DEVELOPER_TO_NORM);

	/* Don't show "Return to secure mode" button if GBB forces dev mode. */
	if (vb2_get_gbb(ui->ctx)->flags & VB2_GBB_FLAG_FORCE_DEV_SWITCH_ON)
		VB2_SET_BIT(ui->state->hidden_item_mask,
			    DEVELOPER_MODE_ITEM_RETURN_TO_SECURE);

	/* Don't show "Boot from external disk" button if not allowed. */
	if (!vb2_dev_boot_external_allowed(ui->ctx))
		VB2_SET_BIT(ui->state->hidden_item_mask,
			    DEVELOPER_MODE_ITEM_BOOT_EXTERNAL);

	/* Don't show "Select alternate bootloader" button if not allowed. */
	if (!vb2_dev_boot_legacy_allowed(ui->ctx))
		VB2_SET_BIT(ui->state->hidden_item_mask,
			    DEVELOPER_MODE_ITEM_SELECT_BOOTLOADER);

	/* Choose the default selection. */
	switch (default_boot) {
	case VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL:
		ui->state->selected_item = DEVELOPER_MODE_ITEM_BOOT_EXTERNAL;
		break;
	case VB2_DEV_DEFAULT_BOOT_TARGET_LEGACY:
		ui->state->selected_item =
			DEVELOPER_MODE_ITEM_SELECT_BOOTLOADER;
		break;
	default:
		ui->state->selected_item = DEVELOPER_MODE_ITEM_BOOT_INTERNAL;
		break;
	}

	ui->start_time_ms = vb2ex_mtime();

	return VB2_REQUEST_UI_CONTINUE;
}

vb2_error_t vb2_ui_developer_mode_boot_internal_action(
	struct vb2_ui_context *ui)
{
	if (!(ui->ctx->flags & VB2_CONTEXT_DEVELOPER_MODE) ||
	    !vb2_dev_boot_allowed(ui->ctx)) {
		VB2_DEBUG("ERROR: Dev mode internal boot not allowed\n");
		return VB2_REQUEST_UI_CONTINUE;
	}

	VB2_TRY(VbTryLoadKernel(ui->ctx, VB_DISK_FLAG_FIXED));
	return VB2_SUCCESS;
}

vb2_error_t vb2_ui_developer_mode_boot_external_action(
	struct vb2_ui_context *ui)
{
	vb2_error_t rv;

	/* Validity check, should never happen. */
	if (!(ui->ctx->flags & VB2_CONTEXT_DEVELOPER_MODE) ||
	    !vb2_dev_boot_allowed(ui->ctx) ||
	    !vb2_dev_boot_external_allowed(ui->ctx)) {
		VB2_DEBUG("ERROR: Dev mode external boot not allowed\n");
		ui->error_beep = 1;
		ui->error_code = VB2_UI_ERROR_EXTERNAL_BOOT_NOT_ENABLED;
		return VB2_REQUEST_UI_CONTINUE;
	}

	rv = VbTryLoadKernel(ui->ctx, VB_DISK_FLAG_REMOVABLE);
	if (rv == VB2_SUCCESS) {
		return VB2_SUCCESS;
	} else if (rv == VB2_ERROR_LK_NO_DISK_FOUND) {
		if (ui->state->screen->id !=
		    VB2_SCREEN_DEVELOPER_BOOT_EXTERNAL) {
			VB2_DEBUG("No external disk found\n");
			ui->error_beep = 1;
		}
		return vb2_ui_screen_change(
			ui, VB2_SCREEN_DEVELOPER_BOOT_EXTERNAL);
	} else {
		if (ui->state->screen->id !=
		    VB2_SCREEN_DEVELOPER_INVALID_DISK) {
			VB2_DEBUG("Invalid external disk: %#x\n", rv);
			ui->error_beep = 1;
		}
		return vb2_ui_screen_change(
			ui, VB2_SCREEN_DEVELOPER_INVALID_DISK);
	}
}

vb2_error_t developer_mode_action(struct vb2_ui_context *ui)
{
	const int use_short = vb2api_use_short_dev_screen_delay(ui->ctx);
	uint64_t elapsed_ms;

	/* TODO(b/159579189): Split this case into a separate root screen */
	if (!vb2_dev_boot_allowed(ui->ctx))
		vb2_ui_screen_change(ui, VB2_SCREEN_DEVELOPER_TO_NORM);

	/* Once any user interaction occurs, stop the timer. */
	if (ui->key)
		ui->disable_timer = 1;
	if (ui->disable_timer)
		return VB2_REQUEST_UI_CONTINUE;

	elapsed_ms = vb2ex_mtime() - ui->start_time_ms;

	/* If we're using short delay, wait 2 seconds and don't beep. */
	if (use_short && elapsed_ms > DEV_DELAY_SHORT_MS) {
		VB2_DEBUG("Booting default target after 2s\n");
		ui->disable_timer = 1;
		return vb2_ui_menu_select(ui);
	}

	/* Otherwise, beep at 20 and 20.5 seconds. */
	if ((ui->beep_count == 0 && elapsed_ms > DEV_DELAY_BEEP1_MS) ||
	    (ui->beep_count == 1 && elapsed_ms > DEV_DELAY_BEEP2_MS)) {
		vb2ex_beep(250, 400);
		ui->beep_count++;
	}

	/* Stop after 30 seconds. */
	if (elapsed_ms > DEV_DELAY_NORMAL_MS) {
		VB2_DEBUG("Booting default target after 30s\n");
		ui->disable_timer = 1;
		return vb2_ui_menu_select(ui);
	}

	return VB2_REQUEST_UI_CONTINUE;
}

static const struct vb2_menu_item developer_mode_items[] = {
	LANGUAGE_SELECT_ITEM,
	[DEVELOPER_MODE_ITEM_RETURN_TO_SECURE] = {
		.text = "Return to secure mode",
		.target = VB2_SCREEN_DEVELOPER_TO_NORM,
	},
	[DEVELOPER_MODE_ITEM_BOOT_INTERNAL] = {
		.text = "Boot from internal disk",
		.action = vb2_ui_developer_mode_boot_internal_action,
	},
	[DEVELOPER_MODE_ITEM_BOOT_EXTERNAL] = {
		.text = "Boot from external disk",
		.action = vb2_ui_developer_mode_boot_external_action,
	},
	[DEVELOPER_MODE_ITEM_SELECT_BOOTLOADER] = {
		.text = "Select alternate bootloader",
		.target = VB2_SCREEN_DEVELOPER_SELECT_BOOTLOADER,
	},
	ADVANCED_OPTIONS_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info developer_mode_screen = {
	.id = VB2_SCREEN_DEVELOPER_MODE,
	.name = "Developer mode",
	.init = developer_mode_init,
	.action = developer_mode_action,
	.menu = MENU_ITEMS(developer_mode_items),
};

/******************************************************************************/
/* VB2_SCREEN_DEVELOPER_TO_NORM */

#define DEVELOPER_TO_NORM_ITEM_CONFIRM 1

static vb2_error_t developer_to_norm_init(struct vb2_ui_context *ui)
{
	/* Don't allow to-norm if GBB forces dev mode */
	if (vb2_get_gbb(ui->ctx)->flags & VB2_GBB_FLAG_FORCE_DEV_SWITCH_ON) {
		VB2_DEBUG("ERROR: to-norm not allowed\n");
		ui->error_code = VB2_UI_ERROR_TO_NORM_NOT_ALLOWED;
		return vb2_ui_screen_back(ui);
	}
	ui->state->selected_item = DEVELOPER_TO_NORM_ITEM_CONFIRM;
	return VB2_REQUEST_UI_CONTINUE;
}

vb2_error_t developer_to_norm_action(struct vb2_ui_context *ui)
{
	if (vb2_get_gbb(ui->ctx)->flags & VB2_GBB_FLAG_FORCE_DEV_SWITCH_ON) {
		VB2_DEBUG("ERROR: dev mode forced by GBB flag\n");
		return VB2_REQUEST_UI_CONTINUE;
	}

	VB2_DEBUG("Leaving dev mode\n");
	vb2_nv_set(ui->ctx, VB2_NV_DISABLE_DEV_REQUEST, 1);
	return VB2_REQUEST_REBOOT;
}

static const struct vb2_menu_item developer_to_norm_items[] = {
	LANGUAGE_SELECT_ITEM,
	{
		.text = "Confirm",
		.action = developer_to_norm_action,
	},
	{
		.text = "Cancel",
		.action = vb2_ui_screen_back,
	},
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info developer_to_norm_screen = {
	.id = VB2_SCREEN_DEVELOPER_TO_NORM,
	.name = "Transition to normal mode",
	.init = developer_to_norm_init,
	.menu = MENU_ITEMS(developer_to_norm_items),
};

/******************************************************************************/
/* VB2_SCREEN_DEVELOPER_BOOT_EXTERNAL */

static const struct vb2_menu_item developer_boot_external_items[] = {
	LANGUAGE_SELECT_ITEM,
	BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info developer_boot_external_screen = {
	.id = VB2_SCREEN_DEVELOPER_BOOT_EXTERNAL,
	.name = "Developer boot from external disk",
	.action = vb2_ui_developer_mode_boot_external_action,
	.menu = MENU_ITEMS(developer_boot_external_items),
};

/******************************************************************************/
/* VB2_SCREEN_DEVELOPER_INVALID_DISK */

static const struct vb2_menu_item developer_invalid_disk_items[] = {
	LANGUAGE_SELECT_ITEM,
	BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info developer_invalid_disk_screen = {
	.id = VB2_SCREEN_DEVELOPER_INVALID_DISK,
	.name = "Invalid external disk in dev mode",
	.action = vb2_ui_developer_mode_boot_external_action,
	.menu = MENU_ITEMS(developer_invalid_disk_items),
};

/******************************************************************************/
/* VB2_SCREEN_DEVELOPER_SELECT_BOOTLOADER */

static const struct vb2_menu_item developer_select_bootloader_items_before[] = {
	LANGUAGE_SELECT_ITEM,
};

static const struct vb2_menu_item developer_select_bootloader_items_after[] = {
	BACK_ITEM,
	POWER_OFF_ITEM,
};

static vb2_error_t developer_select_bootloader_init(struct vb2_ui_context *ui)
{
	if (get_menu(ui)->num_items == 0) {
		ui->error_code = VB2_UI_ERROR_NO_BOOTLOADER;
		return vb2_ui_screen_back(ui);
	}
	/* Select the first bootloader. */
	ui->state->selected_item =
		ARRAY_SIZE(developer_select_bootloader_items_before);
	return VB2_REQUEST_UI_CONTINUE;
}

vb2_error_t vb2_ui_developer_mode_boot_alternate_action(
	struct vb2_ui_context *ui)
{
	uint32_t altfw_num;
	const size_t menu_before_len =
		ARRAY_SIZE(developer_select_bootloader_items_before);

	if (!(ui->ctx->flags & VB2_CONTEXT_DEVELOPER_MODE) ||
	    !vb2_dev_boot_allowed(ui->ctx) ||
	    !vb2_dev_boot_legacy_allowed(ui->ctx)) {
		VB2_DEBUG("ERROR: Dev mode alternate bootloader not allowed\n");
		ui->error_code = VB2_UI_ERROR_ALTERNATE_BOOT_DISABLED;
		return VB2_REQUEST_UI_CONTINUE;
	}

	if (vb2ex_get_bootloader_count() == 0) {
		VB2_DEBUG("ERROR: No alternate bootloader was found\n");
		ui->error_code = VB2_UI_ERROR_NO_BOOTLOADER;
		return VB2_REQUEST_UI_CONTINUE;
	}

	if (ui->key == VB_KEY_CTRL('L')) {
		altfw_num = 0;
		VB2_DEBUG("Try booting from default bootloader\n");
	} else {
		altfw_num = ui->state->selected_item - menu_before_len + 1;
		VB2_DEBUG("Try booting from bootloader #%u\n", altfw_num);
	}

	/* VbExLegacy will not return if successful */
	VbExLegacy(altfw_num);

	VB2_DEBUG("ERROR: Alternate bootloader failed\n");
	ui->error_code = VB2_UI_ERROR_ALTERNATE_BOOT_FAILED;
	return VB2_REQUEST_UI_CONTINUE;
}

static const struct vb2_menu *get_bootloader_menu(struct vb2_ui_context *ui)
{
	int i;
	uint32_t num_bootloaders, num_items;
	struct vb2_menu_item *items;
	const size_t menu_before_len =
		ARRAY_SIZE(developer_select_bootloader_items_before);
	const size_t menu_after_len =
		ARRAY_SIZE(developer_select_bootloader_items_after);

	if (ui->bootloader_menu.num_items > 0)
		return &ui->bootloader_menu;

	num_bootloaders = vb2ex_get_bootloader_count();
	if (num_bootloaders == 0) {
		VB2_DEBUG("ERROR: No bootloader was found\n");
		return NULL;
	}
	VB2_DEBUG("num_bootloaders: %u\n", num_bootloaders);
	num_items = num_bootloaders + menu_before_len + menu_after_len;
	items = malloc(num_items * sizeof(struct vb2_menu_item));
	if (!items) {
		VB2_DEBUG("ERROR: malloc failed for bootloader items\n");
		return NULL;
	}

	/* Copy prefix items to the begin. */
	memcpy(&items[0],
	       developer_select_bootloader_items_before,
	       menu_before_len * sizeof(struct vb2_menu_item));

	/* Copy bootloaders. */
	for (i = 0; i < num_bootloaders; i++) {
		items[i + menu_before_len].text = "Some bootloader";
		items[i + menu_before_len].action =
			vb2_ui_developer_mode_boot_alternate_action;
	}

	/* Copy postfix items to the end. */
	memcpy(&items[num_items - menu_after_len],
	       developer_select_bootloader_items_after,
	       menu_after_len * sizeof(struct vb2_menu_item));

	ui->bootloader_menu.num_items = num_items;
	ui->bootloader_menu.items = items;

	return &ui->bootloader_menu;
}

static const struct vb2_screen_info developer_select_bootloader_screen = {
	.id = VB2_SCREEN_DEVELOPER_SELECT_BOOTLOADER,
	.name = "Select alternate bootloader",
	.init = developer_select_bootloader_init,
	.get_menu = get_bootloader_menu,
};

/******************************************************************************/
/* VB2_SCREEN_DIAGNOSTICS */

static const struct vb2_menu_item diagnostics_items[] = {
	LANGUAGE_SELECT_ITEM,
	{
		.text = "Storage",
		.target = VB2_SCREEN_DIAGNOSTICS_STORAGE,
	},
	{
		.text = "Quick memory check",
		.target = VB2_SCREEN_DIAGNOSTICS_MEMORY_QUICK,
	},
	{
		.text = "Full memory check",
		.target = VB2_SCREEN_DIAGNOSTICS_MEMORY_FULL,
	},
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info diagnostics_screen = {
	.id = VB2_SCREEN_DIAGNOSTICS,
	.name = "Diagnostic tools",
	.menu = MENU_ITEMS(diagnostics_items),
};

/******************************************************************************/
/* VB2_SCREEN_DIAGNOSTICS_STORAGE */

#define DIAGNOSTICS_STORAGE_ITEM_PAGE_UP 0
#define DIAGNOSTICS_STORAGE_ITEM_PAGE_DOWN 1
#define DIAGNOSTICS_STORAGE_ITEM_BACK 2

static vb2_error_t diagnostics_storage_init(struct vb2_ui_context *ui)
{
	const char *log_string = vb2ex_get_diagnostic_storage();
	if (!log_string) {
		VB2_DEBUG("ERROR: Failed to retrieve storage log message\n");
		ui->error_code = VB2_UI_ERROR_DIAGNOSTICS;
		return vb2_ui_screen_back(ui);
	}

	ui->state->page_count = vb2ex_prepare_log_screen(
		ui->state->screen->id, ui->locale_id, log_string);
	if (ui->state->page_count == 0) {
		VB2_DEBUG("ERROR: Failed to prepare storage log screen\n");
		ui->error_code = VB2_UI_ERROR_DIAGNOSTICS;
		return vb2_ui_screen_back(ui);
	}
	return log_page_init(ui);
}

static const struct vb2_menu_item diagnostics_storage_items[] = {
	[DIAGNOSTICS_STORAGE_ITEM_PAGE_UP] = PAGE_UP_ITEM,
	[DIAGNOSTICS_STORAGE_ITEM_PAGE_DOWN] = PAGE_DOWN_ITEM,
	[DIAGNOSTICS_STORAGE_ITEM_BACK] = BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info diagnostics_storage_screen = {
	.id = VB2_SCREEN_DIAGNOSTICS_STORAGE,
	.name = "Storage",
	.init = diagnostics_storage_init,
	.menu = MENU_ITEMS(diagnostics_storage_items),
	.page_up_item = DIAGNOSTICS_STORAGE_ITEM_PAGE_UP,
	.page_down_item = DIAGNOSTICS_STORAGE_ITEM_PAGE_DOWN,
	.back_item = DIAGNOSTICS_STORAGE_ITEM_BACK,
};

/******************************************************************************/
/* VB2_SCREEN_DIAGNOSTICS_MEMORY_QUICK
   VB2_SCREEN_DIAGNOSTICS_MEMORY_FULL */

#define DIAGNOSTICS_MEMORY_ITEM_PAGE_UP 0
#define DIAGNOSTICS_MEMORY_ITEM_PAGE_DOWN 1
#define DIAGNOSTICS_MEMORY_ITEM_CANCEL 2
#define DIAGNOSTICS_MEMORY_ITEM_BACK 3

typedef vb2_error_t (*memory_test_op_t)(int reset, const char **out);
static vb2_error_t diagnostics_memory_update_screen(struct vb2_ui_context *ui,
						    memory_test_op_t op,
						    int reset)
{
	const char *log_string = NULL;

	/* Early return if the memory test is done. */
	if (ui->state->test_finished)
		return VB2_REQUEST_UI_CONTINUE;

	vb2_error_t rv = op(reset, &log_string);

	/* The test is still running but the output buffer was unchanged. */
	if (rv == VB2_ERROR_EX_DIAG_TEST_RUNNING)
		return VB2_REQUEST_UI_CONTINUE;

	if ((rv && rv != VB2_ERROR_EX_DIAG_TEST_UPDATED) || !log_string) {
		VB2_DEBUG("ERROR: Failed to retrieve memory test status\n");
		ui->error_code = VB2_UI_ERROR_DIAGNOSTICS;
		return vb2_ui_screen_back(ui);
	}

	ui->state->page_count = vb2ex_prepare_log_screen(
		ui->state->screen->id, ui->locale_id, log_string);
	if (ui->state->page_count == 0) {
		VB2_DEBUG("ERROR: Failed to prepare memory log screen, error: "
			  "%#x\n", rv);
		ui->error_code = VB2_UI_ERROR_DIAGNOSTICS;
		return vb2_ui_screen_back(ui);
	}
	if (ui->state->current_page >= ui->state->page_count)
		ui->state->current_page = ui->state->page_count - 1;

	ui->force_display = 1;

	/* Show cancel button when the test is running, otherwise show the back
	 * button. VB2_SUCCESS indicates the test is finished. */
	VB2_CLR_BIT(ui->state->hidden_item_mask,
		    DIAGNOSTICS_MEMORY_ITEM_CANCEL);
	VB2_CLR_BIT(ui->state->hidden_item_mask, DIAGNOSTICS_MEMORY_ITEM_BACK);
	if (rv == VB2_ERROR_EX_DIAG_TEST_UPDATED) {
		VB2_SET_BIT(ui->state->hidden_item_mask,
			    DIAGNOSTICS_MEMORY_ITEM_BACK);
		if (ui->state->selected_item == DIAGNOSTICS_MEMORY_ITEM_BACK)
			ui->state->selected_item =
				DIAGNOSTICS_MEMORY_ITEM_CANCEL;
	} else {
		VB2_SET_BIT(ui->state->hidden_item_mask,
			    DIAGNOSTICS_MEMORY_ITEM_CANCEL);
		if (ui->state->selected_item == DIAGNOSTICS_MEMORY_ITEM_CANCEL)
			ui->state->selected_item = DIAGNOSTICS_MEMORY_ITEM_BACK;
		ui->state->test_finished = 1;
	}

	return VB2_REQUEST_UI_CONTINUE;
}

static vb2_error_t diagnostics_memory_init_quick(struct vb2_ui_context *ui)
{
	return diagnostics_memory_update_screen(
		ui, &vb2ex_diag_memory_quick_test, 1);
}

static vb2_error_t diagnostics_memory_init_full(struct vb2_ui_context *ui)
{
	return diagnostics_memory_update_screen(
		ui, &vb2ex_diag_memory_full_test, 1);
}

static vb2_error_t diagnostics_memory_update_quick(struct vb2_ui_context *ui)
{
	return diagnostics_memory_update_screen(
		ui, &vb2ex_diag_memory_quick_test, 0);
}

static vb2_error_t diagnostics_memory_update_full(struct vb2_ui_context *ui)
{
	return diagnostics_memory_update_screen(
		ui, &vb2ex_diag_memory_full_test, 0);
}

static const struct vb2_menu_item diagnostics_memory_items[] = {
	[DIAGNOSTICS_MEMORY_ITEM_PAGE_UP] = PAGE_UP_ITEM,
	[DIAGNOSTICS_MEMORY_ITEM_PAGE_DOWN] = PAGE_DOWN_ITEM,
	[DIAGNOSTICS_MEMORY_ITEM_CANCEL] = {
		.text = "Cancel and go back",
		.action = vb2_ui_screen_back,
	},
	[DIAGNOSTICS_MEMORY_ITEM_BACK] = BACK_ITEM,
	POWER_OFF_ITEM,
};

static const struct vb2_screen_info diagnostics_memory_quick_screen = {
	.id = VB2_SCREEN_DIAGNOSTICS_MEMORY_QUICK,
	.name = "Quick memory check",
	.init = diagnostics_memory_init_quick,
	.action = diagnostics_memory_update_quick,
	.menu = MENU_ITEMS(diagnostics_memory_items),
};

static const struct vb2_screen_info diagnostics_memory_full_screen = {
	.id = VB2_SCREEN_DIAGNOSTICS_MEMORY_FULL,
	.name = "Full memory check",
	.init = diagnostics_memory_init_full,
	.action = diagnostics_memory_update_full,
	.menu = MENU_ITEMS(diagnostics_memory_items),
};

/******************************************************************************/
/*
 * TODO(chromium:1035800): Refactor UI code across vboot and depthcharge.
 * Currently vboot and depthcharge maintain their own copies of menus/screens.
 * vboot detects keyboard input and controls the navigation among different menu
 * items and screens, while depthcharge performs the actual rendering of each
 * screen, based on the menu information passed from vboot.
 */
static const struct vb2_screen_info *screens[] = {
	&blank_screen,
	&language_select_screen,
	&recovery_broken_screen,
	&advanced_options_screen,
	&debug_info_screen,
	&firmware_log_screen,
	&recovery_select_screen,
	&recovery_invalid_screen,
	&recovery_to_dev_screen,
	&recovery_phone_step1_screen,
	&recovery_phone_step2_screen,
	&recovery_disk_step1_screen,
	&recovery_disk_step2_screen,
	&recovery_disk_step3_screen,
	&developer_mode_screen,
	&developer_to_norm_screen,
	&developer_boot_external_screen,
	&developer_invalid_disk_screen,
	&developer_select_bootloader_screen,
	&diagnostics_screen,
	&diagnostics_storage_screen,
	&diagnostics_memory_quick_screen,
	&diagnostics_memory_full_screen,
};

const struct vb2_screen_info *vb2_get_screen_info(enum vb2_screen id)
{
	int i;
	for (i = 0; i < ARRAY_SIZE(screens); i++) {
		if (screens[i]->id == id)
			return screens[i];
	}
	return NULL;
}
