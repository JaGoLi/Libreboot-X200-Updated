/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Wilco-specific feature support for vboot_ui
 */

#ifndef VBOOT_REFERENCE_VBOOT_UI_WILCO_H_
#define VBOOT_REFERENCE_VBOOT_UI_WILCO_H_

#define CURSOR_BLINK_MS 400	/* Speed that the vendor data cursor blinks */

/*
 * User interface for setting the vendor data in VPD
 */
vb2_error_t vb2_vendor_data_ui(struct vb2_context *ctx);

/*
 * Determine whether the user has pressed the keys to enter diagnostics mode
 */
vb2_error_t vb2_check_diagnostic_key(struct vb2_context *ctx, uint32_t key);

/*
 * User interface for confirming launch of diagnostics rom
 *
 * This asks the user to confirm the launch of the diagnostics rom. The user
 * can press the power button to confirm or press escape. There is a 30-second
 * timeout which acts the same as escape.
 */
vb2_error_t vb2_diagnostics_ui(struct vb2_context *ctx);

#endif  /* VBOOT_REFERENCE_VBOOT_UI_WILCO_H_ */
