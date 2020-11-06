/* Copyright 2018 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Common code used by both legacy_clamshell_ui and legacy_menu_ui.
 */

#ifndef VBOOT_REFERENCE_VBOOT_UI_COMMON_H_
#define VBOOT_REFERENCE_VBOOT_UI_COMMON_H_

#define KEY_DELAY_MS	20	/* Delay between key scans in UI loops */

enum vb2_beep_type {
	VB_BEEP_FAILED,		/* Permitted but the operation failed */
	VB_BEEP_NOT_ALLOWED,	/* Operation disabled by user setting */
};

/**
 * Reinitialize global state. This should only need to be called
 * by vboot_ui::vb2_init_ui() for init tests.
 */
void vb2_reset_power_button(void);

/**
 * Emit beeps to indicate an error
 */
void vb2_error_beep(enum vb2_beep_type beep);

/**
 * Prints a message to screen, logs a possibly different message to log,
 * and beeps to notify user.
 *
 * @print_msg	Display message. NULL message will be ignored.
 * @log_msg	Log message. If NULL, uses @print_msg (if that's not NULL).
 * @beep	Type of beep sound.
 */
void vb2_error_notify(const char *print_msg,
		      const char *log_msg,
		      enum vb2_beep_type beep);

/** Display an error and beep to indicate that altfw is not available */
void vb2_error_no_altfw(void);

/**
 * Jump to a bootloader if possible
 *
 * This checks if the operation is permitted. If it is, then it jumps to the
 * selected bootloader and execution continues there, never returning.
 *
 * Will beep and return if one of the following is true:
 *   - operation is not permitted (allowed == 0)
 *   - vboot data fails to commit
 *   - secdata_kernel fails to lock
 *   - bootloader cannot be found
 *   - bootloader fails to start
 *
 * @param ctx		Context pointer
 * @param allowed	1 if allowed, 0 if not allowed
 * @param altfw_num	Number of bootloader to start (0=any, 1=first, etc.)
 */
void vb2_try_altfw(struct vb2_context *ctx, int allowed,
		   enum VbAltFwIndex_t altfw_num);

/**
 * Checks GBB flags against VbExIsShutdownRequested() shutdown request to
 * determine if a shutdown is required.
 *
 * Returns zero or more of the following flags (if any are set then typically
 * shutdown is required):
 * VB_SHUTDOWN_REQUEST_LID_CLOSED
 * VB_SHUTDOWN_REQUEST_POWER_BUTTON
 */
int vb2_want_shutdown(struct vb2_context *ctx, uint32_t key);

#endif  /* VBOOT_REFERENCE_VBOOT_UI_COMMON_H_ */
