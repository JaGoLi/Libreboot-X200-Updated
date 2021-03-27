/* Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * High-level firmware wrapper API - user interface for RW firmware
 */

#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2rsa.h"
#include "2secdata.h"
#include "2sysincludes.h"
#include "load_kernel_fw.h"
#include "tlcl.h"
#include "vb2_common.h"
#include "vboot_api.h"
#include "vboot_audio.h"
#include "vboot_kernel.h"
#include "vboot_struct.h"
#include "vboot_test.h"
#include "vboot_ui_legacy.h"
#include "vboot_ui_legacy_wilco.h"

static uint32_t disp_current_screen = VB_SCREEN_BLANK;

test_mockable
vb2_error_t VbDisplayScreen(struct vb2_context *ctx, uint32_t screen, int force,
			    const VbScreenData *data)
{
	uint32_t locale;

	/* If requested screen is the same as the current one, we're done. */
	if (disp_current_screen == screen && !force)
		return VB2_SUCCESS;

	/* Keep track of the currently displayed screen */
	disp_current_screen = screen;

	/* Read the locale last saved */
	locale = vb2_nv_get(ctx, VB2_NV_LOCALIZATION_INDEX);

	return VbExDisplayScreen(screen, locale, data);
}

static vb2_error_t VbTryUsb(struct vb2_context *ctx)
{
	int retval = VbTryLoadKernel(ctx, VB_DISK_FLAG_REMOVABLE);
	if (VB2_SUCCESS == retval) {
		VB2_DEBUG("developer UI - booting USB\n");
	} else {
		vb2_error_notify("Could not boot from USB\n",
				 "developer UI - no kernel found on USB\n",
				 VB_BEEP_FAILED);
	}
	return retval;
}

int VbUserConfirms(struct vb2_context *ctx, uint32_t confirm_flags)
{
	uint32_t key;
	uint32_t key_flags;
	uint32_t btn;
	int button_pressed = 0;
	int shutdown_requested = 0;

	VB2_DEBUG("Entering(%x)\n", confirm_flags);

	/* Await further instructions */
	do {
		key = VbExKeyboardReadWithFlags(&key_flags);
		shutdown_requested = vb2_want_shutdown(ctx, key);
		switch (key) {
		case VB_KEY_ENTER:
			/* If we are using a trusted keyboard or a trusted
			 * keyboard is not required then return yes, otherwise
			 * keep waiting (for instance if the user is using a
			 * USB keyboard).
			 */
			if (!(confirm_flags & VB_CONFIRM_MUST_TRUST_KEYBOARD) ||
			     (key_flags & VB_KEY_FLAG_TRUSTED_KEYBOARD)) {
				VB2_DEBUG("Yes (1)\n");
				return 1;
			}

			/*
			 * If physical presence is confirmed using the keyboard,
			 * beep and notify the user when the ENTER key comes
			 * from an untrusted keyboard.
			 *
			 * If physical presence is confirmed using a physical
			 * button, the existing message on the screen will
			 * instruct the user which button to push.  Silently
			 * ignore any ENTER presses.
			 */
			if (PHYSICAL_PRESENCE_KEYBOARD)
				vb2_error_notify("Please use internal keyboard "
					"to confirm\n",
					"VbUserConfirms() - "
					"Trusted keyboard is required\n",
					VB_BEEP_NOT_ALLOWED);

			break;
		case ' ':
			VB2_DEBUG("Space (%d)\n",
				  confirm_flags & VB_CONFIRM_SPACE_MEANS_NO);
			if (confirm_flags & VB_CONFIRM_SPACE_MEANS_NO)
				return 0;
			break;
		case VB_KEY_ESC:
			VB2_DEBUG("No (0)\n");
			return 0;
		default:
			/*
			 * If the physical presence button is separate from the
			 * keyboard, and is pressed, this is also a YES, but
			 * must wait for release.
			 */
			if (!PHYSICAL_PRESENCE_KEYBOARD) {
				btn = vb2ex_physical_presence_pressed();
				if (btn) {
					VB2_DEBUG("Presence button pressed, "
						  "awaiting release\n");
					button_pressed = 1;
				} else if (button_pressed) {
					VB2_DEBUG("Presence button released "
						  "(1)\n");
					return 1;
				}
			}
			VbCheckDisplayKey(ctx, key, disp_current_screen, NULL);
		}
		vb2ex_msleep(KEY_DELAY_MS);
	} while (!shutdown_requested);

	return -1;
}

/*
 * User interface for selecting alternative firmware
 *
 * This shows the user a list of bootloaders and allows selection of one of
 * them. We loop forever until something is chosen or Escape is pressed.
 */
static vb2_error_t vb2_altfw_ui(struct vb2_context *ctx)
{
	int active = 1;

	VbDisplayScreen(ctx, VB_SCREEN_ALT_FW_PICK, 0, NULL);

	/* We'll loop until the user decides what to do */
	do {
		uint32_t key = VbExKeyboardRead();

		if (vb2_want_shutdown(ctx, key)) {
			VB2_DEBUG("developer UI - shutdown requested!\n");
			return VB2_REQUEST_SHUTDOWN;
		}
		switch (key) {
		case 0:
			/* nothing pressed */
			break;
		case VB_KEY_ESC:
			/* Escape pressed - return to developer screen */
			VB2_DEBUG("developer UI - user pressed Esc; "
				  "exit to Developer screen\n");
			active = 0;
			break;
		/* We allow selection of the default '0' bootloader here */
		case '0'...'9':
			VB2_DEBUG("developer UI - user pressed key '%c';"
				  "Boot alternative firmware\n", key);
			/*
			 * This will not return if successful. Drop out to
			 * developer mode on failure.
			 */
			vb2_try_altfw(ctx, 1, key - '0');
			active = 0;
			break;
		default:
			VB2_DEBUG("developer UI - pressed key %#x\n", key);
			VbCheckDisplayKey(ctx, key, disp_current_screen, NULL);
			break;
		}
		vb2ex_msleep(KEY_DELAY_MS);
	} while (active);

	/* Back to developer screen */
	VbDisplayScreen(ctx, VB_SCREEN_DEVELOPER_WARNING, 0, NULL);

	return 0;
}

static vb2_error_t vb2_developer_ui(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	struct vb2_gbb_header *gbb = vb2_get_gbb(ctx);

	uint32_t disable_dev_boot = 0;
	uint32_t use_usb = 0;
	uint32_t use_legacy = 0;
	uint32_t ctrl_d_pressed = 0;

	VB2_DEBUG("Entering\n");

	/* Check if booting from external disk is allowed */
	uint32_t allow_usb = vb2_nv_get(ctx, VB2_NV_DEV_BOOT_EXTERNAL);
	uint32_t allow_legacy = vb2_nv_get(ctx, VB2_NV_DEV_BOOT_LEGACY);

	/* Check if the default boot target: internal/external disk or legacy */
	uint32_t default_boot = vb2_nv_get(ctx, VB2_NV_DEV_DEFAULT_BOOT);

	if (default_boot == VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL)
		use_usb = 1;
	if (default_boot == VB2_DEV_DEFAULT_BOOT_TARGET_LEGACY)
		use_legacy = 1;

	/* Handle GBB flag override */
	if (gbb->flags & VB2_GBB_FLAG_FORCE_DEV_BOOT_USB)
		allow_usb = 1;
	if (gbb->flags & VB2_GBB_FLAG_FORCE_DEV_BOOT_LEGACY)
		allow_legacy = 1;
	if (gbb->flags & VB2_GBB_FLAG_DEFAULT_DEV_BOOT_LEGACY) {
		use_legacy = 1;
		use_usb = 0;
	}

	/* Handle FWMP override */
	if (vb2_secdata_fwmp_get_flag(ctx, VB2_SECDATA_FWMP_DEV_ENABLE_EXTERNAL))
		allow_usb = 1;
	if (vb2_secdata_fwmp_get_flag(ctx, VB2_SECDATA_FWMP_DEV_ENABLE_LEGACY))
		allow_legacy = 1;
	if (vb2_secdata_fwmp_get_flag(ctx, VB2_SECDATA_FWMP_DEV_DISABLE_BOOT)) {
		if (gbb->flags & VB2_GBB_FLAG_FORCE_DEV_SWITCH_ON) {
			VB2_DEBUG("FWMP_DEV_DISABLE_BOOT rejected by "
				  "FORCE_DEV_SWITCH_ON\n");
		} else {
			disable_dev_boot = 1;
		}
	}

	/* If dev mode is disabled, only allow TONORM */
	while (disable_dev_boot) {
		VB2_DEBUG("dev_disable_boot is set\n");
		VbDisplayScreen(ctx,
				VB_SCREEN_DEVELOPER_TO_NORM, 0, NULL);
		VbExDisplayDebugInfo(dev_disable_msg, 0);

		/* Ignore space in VbUserConfirms()... */
		switch (VbUserConfirms(ctx, 0)) {
		case 1:
			VB2_DEBUG("leaving dev-mode\n");
			vb2_nv_set(ctx, VB2_NV_DISABLE_DEV_REQUEST, 1);
			VbDisplayScreen(ctx,
				VB_SCREEN_TO_NORM_CONFIRMED, 0, NULL);
			vb2ex_msleep(5 * VB2_MSEC_PER_SEC);
			return VB2_REQUEST_REBOOT;
		case -1:
			VB2_DEBUG("shutdown requested\n");
			return VB2_REQUEST_SHUTDOWN;
		default:
			/* Ignore user attempt to cancel */
			VB2_DEBUG("ignore cancel TONORM\n");
		}
	}

	if ((ctx->flags & VB2_CONTEXT_VENDOR_DATA_SETTABLE) &&
		VENDOR_DATA_LENGTH > 0) {
		vb2_error_t ret;
		VB2_DEBUG("developer UI - Vendor data not set\n");
		ret = vb2_vendor_data_ui(ctx);
		if (ret)
			return ret;
        }

        /* Show the dev mode warning screen */
        VbDisplayScreen(ctx, VB_SCREEN_DEVELOPER_WARNING, 0, NULL);

	/* Initialize audio/delay context */
	vb2_audio_start(ctx);

	/* We'll loop until we finish the delay or are interrupted */
	do {
		uint32_t key = VbExKeyboardRead();
		if (vb2_want_shutdown(ctx, key)) {
			VB2_DEBUG("developer UI - shutdown requested!\n");
			return VB2_REQUEST_SHUTDOWN;
		}

		switch (key) {
		case 0:
			/* nothing pressed */
			break;
		case VB_KEY_ENTER:
			/* Only disable virtual dev switch if allowed by GBB */
			if (!(gbb->flags & VB2_GBB_FLAG_ENTER_TRIGGERS_TONORM))
				break;
			VBOOT_FALLTHROUGH;
		case ' ':
			/* See if we should disable virtual dev-mode switch. */
			VB2_DEBUG("sd->flags=%#x\n", sd->flags);

			/* Validity check, should never fail. */
			VB2_ASSERT(sd->flags & VB2_SD_FLAG_DEV_MODE_ENABLED);

			/* Stop the countdown while we go ask... */
			if (gbb->flags & VB2_GBB_FLAG_FORCE_DEV_SWITCH_ON) {
				/*
				 * TONORM won't work (only for
				 * non-shipping devices).
				 */
				vb2_error_notify(
					"WARNING: TONORM prohibited by "
					"GBB FORCE_DEV_SWITCH_ON.\n",
					NULL, VB_BEEP_NOT_ALLOWED);
				break;
			}
			VbDisplayScreen(ctx, VB_SCREEN_DEVELOPER_TO_NORM,
					0, NULL);
			/* Ignore space in VbUserConfirms()... */
			switch (VbUserConfirms(ctx, 0)) {
			case 1:
				VB2_DEBUG("leaving dev-mode\n");
				vb2_nv_set(ctx, VB2_NV_DISABLE_DEV_REQUEST, 1);
				VbDisplayScreen(ctx,
					VB_SCREEN_TO_NORM_CONFIRMED, 0, NULL);
				vb2ex_msleep(5 * VB2_MSEC_PER_SEC);
				return VB2_REQUEST_REBOOT;
			case -1:
				VB2_DEBUG("shutdown requested\n");
				return VB2_REQUEST_SHUTDOWN;
			default:
				/* Stay in dev-mode */
				VB2_DEBUG("stay in dev-mode\n");
				VbDisplayScreen(ctx,
					VB_SCREEN_DEVELOPER_WARNING, 0, NULL);
				/* Start new countdown */
				vb2_audio_start(ctx);
			}
			break;
		case VB_KEY_CTRL('D'):
			/* Ctrl+D = dismiss warning; advance to timeout */
			VB2_DEBUG("developer UI - user pressed Ctrl+D; "
				  "skip delay\n");
			ctrl_d_pressed = 1;
			goto fallout;
		case VB_KEY_CTRL('L'):
			VB2_DEBUG("developer UI - user pressed Ctrl+L; "
				  "Try alt firmware\n");
			if (allow_legacy) {
				vb2_error_t ret;

				ret = vb2_altfw_ui(ctx);
				if (ret)
					return ret;
			} else {
				vb2_error_no_altfw();
			}
			break;
		case VB_KEY_CTRL_ENTER:
			/*
			 * The Ctrl-Enter is special for Lumpy test purpose;
			 * fall through to Ctrl+U handler.
			 */
		case VB_KEY_CTRL('U'):
			/* Ctrl+U = try USB boot, or beep if failure */
			VB2_DEBUG("developer UI - user pressed Ctrl+U; "
				  "try USB\n");
			if (!allow_usb) {
				vb2_error_notify(
					"WARNING: Booting from external media "
					"(USB/SD) has not been enabled. Refer "
					"to the developer-mode documentation "
					"for details.\n",
					"developer UI - "
					"USB booting is disabled\n",
					VB_BEEP_NOT_ALLOWED);
			} else {
				/*
				 * Clear the screen to show we get the Ctrl+U
				 * key press.
				 */
				VbDisplayScreen(ctx, VB_SCREEN_BLANK, 0, NULL);
				if (VB2_SUCCESS == VbTryUsb(ctx)) {
					return VB2_SUCCESS;
				} else {
					/* Show dev mode warning screen again */
					VbDisplayScreen(ctx,
						VB_SCREEN_DEVELOPER_WARNING,
						0, NULL);
				}
			}
			break;
		/* We allow selection of the default '0' bootloader here */
		case '0'...'9':
			VB2_DEBUG("developer UI - user pressed key '%c'; "
				  "Boot alternative firmware\n", key);
			vb2_try_altfw(ctx, allow_legacy, key - '0');
			break;
		default:
			VB2_DEBUG("developer UI - pressed key %#x\n", key);
			VbCheckDisplayKey(ctx, key, disp_current_screen, NULL);
			break;
		}

		vb2ex_msleep(KEY_DELAY_MS);
	} while(vb2_audio_looping());

 fallout:

	/* If defaulting to legacy boot, try that unless Ctrl+D was pressed */
	if (use_legacy && !ctrl_d_pressed) {
		VB2_DEBUG("developer UI - defaulting to legacy\n");
		vb2_try_altfw(ctx, allow_legacy, 0);
	}

	if ((use_usb && !ctrl_d_pressed) && allow_usb) {
		if (VB2_SUCCESS == VbTryUsb(ctx)) {
			return VB2_SUCCESS;
		}
	}

	/* Timeout or Ctrl+D; attempt loading from fixed disk */
	VB2_DEBUG("developer UI - trying fixed disk\n");
	return VbTryLoadKernel(ctx, VB_DISK_FLAG_FIXED);
}

vb2_error_t VbBootDeveloperLegacyClamshell(struct vb2_context *ctx)
{
	vb2_reset_power_button();
	vb2_error_t retval = vb2_developer_ui(ctx);
	VbDisplayScreen(ctx, VB_SCREEN_BLANK, 0, NULL);
	return retval;
}

vb2_error_t VbBootDiagnosticLegacyClamshell(struct vb2_context *ctx)
{
	vb2_reset_power_button();
	vb2_error_t retval = vb2_diagnostics_ui(ctx);
	VbDisplayScreen(ctx, VB_SCREEN_BLANK, 0, NULL);
	return retval;
}

static vb2_error_t recovery_ui(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	uint32_t retval;
	uint32_t key;
	const char release_button_msg[] =
		"Release the recovery button and try again\n";
	const char recovery_pressed_msg[] =
		"^D but recovery switch is pressed\n";

	VB2_DEBUG("recovery UI - start\n");

	if (!vb2_allow_recovery(ctx)) {
		VbDisplayScreen(ctx, VB_SCREEN_OS_BROKEN, 0, NULL);
		VB2_DEBUG("recovery UI - waiting for manual recovery\n");
		while (1) {
			key = VbExKeyboardRead();
			VbCheckDisplayKey(ctx, key, disp_current_screen, NULL);
			if (vb2_want_shutdown(ctx, key))
				return VB2_REQUEST_SHUTDOWN;
			else if ((retval =
				  vb2_check_diagnostic_key(ctx, key)) !=
				  VB2_SUCCESS)
				return retval;
			vb2ex_msleep(KEY_DELAY_MS);
		}
	}

	/* Loop and wait for a recovery image */
	VB2_DEBUG("recovery UI - waiting for a recovery image\n");
	while (1) {
		retval = VbTryLoadKernel(ctx, VB_DISK_FLAG_REMOVABLE);

		if (VB2_SUCCESS == retval)
			break; /* Found a recovery kernel */

		enum VbScreenType_t next_screen =
			retval == VB2_ERROR_LK_NO_DISK_FOUND ?
			VB_SCREEN_RECOVERY_INSERT : VB_SCREEN_RECOVERY_NO_GOOD;
		VbDisplayScreen(ctx, next_screen, 0, NULL);

		key = VbExKeyboardRead();
		/*
		 * We might want to enter dev-mode from the Insert
		 * screen if all of the following are true:
		 *   - user pressed Ctrl-D
		 *   - we can honor the virtual dev switch
		 *   - not already in dev mode
		 *   - user forced recovery mode
		 */
		if (key == VB_KEY_CTRL('D') &&
		    !(sd->flags & VB2_SD_FLAG_DEV_MODE_ENABLED) &&
		    (sd->flags & VB2_SD_FLAG_MANUAL_RECOVERY)) {
			if (!PHYSICAL_PRESENCE_KEYBOARD &&
			    vb2ex_physical_presence_pressed()) {
				/*
				 * Is the presence button stuck?  In any case
				 * we don't like this.  Beep and ignore.
				 */
				vb2_error_notify(release_button_msg,
						 recovery_pressed_msg,
						 VB_BEEP_NOT_ALLOWED);
				continue;
			}

			/* Ask the user to confirm entering dev-mode */
			VbDisplayScreen(ctx, VB_SCREEN_RECOVERY_TO_DEV,
					0, NULL);
			/* SPACE means no... */
			uint32_t vbc_flags = VB_CONFIRM_SPACE_MEANS_NO |
					     VB_CONFIRM_MUST_TRUST_KEYBOARD;
			switch (VbUserConfirms(ctx, vbc_flags)) {
			case 1:
				vb2_enable_developer_mode(ctx);
				return VB2_REQUEST_REBOOT_EC_TO_RO;
			case -1:
				VB2_DEBUG("Shutdown requested\n");
				return VB2_REQUEST_SHUTDOWN;
			default: /* zero, actually */
				VB2_DEBUG("Not enabling dev-mode\n");
				break;
			}
		} else if ((retval = vb2_check_diagnostic_key(ctx, key)) !=
			   VB2_SUCCESS) {
			return retval;
		} else {
			VbCheckDisplayKey(ctx, key, disp_current_screen, NULL);
		}
		if (vb2_want_shutdown(ctx, key))
			return VB2_REQUEST_SHUTDOWN;
		vb2ex_msleep(KEY_DELAY_MS);
	}

	return VB2_SUCCESS;
}

vb2_error_t VbBootRecoveryLegacyClamshell(struct vb2_context *ctx)
{
	vb2_error_t retval = recovery_ui(ctx);
	VbDisplayScreen(ctx, VB_SCREEN_BLANK, 0, NULL);
	return retval;
}
