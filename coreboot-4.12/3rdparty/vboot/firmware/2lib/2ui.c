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
#include "2secdata.h"
#include "2ui.h"
#include "vboot_kernel.h"

/*****************************************************************************/
/* Entry points */

vb2_error_t vb2_developer_menu(struct vb2_context *ctx)
{
	enum vb2_dev_default_boot default_boot;

	/* TODO(roccochen): Init, wait for user, and boot. */
	vb2ex_display_ui(VB2_SCREEN_BLANK, 0, 0, 0);

	/* If dev mode was disabled, loop forever. */
	if (!vb2_dev_boot_allowed(ctx))
		while (1);

	/* Boot from the default option. */
	default_boot = vb2_get_dev_boot_target(ctx);

	/* Boot legacy does not return on success */
	if (default_boot == VB2_DEV_DEFAULT_BOOT_LEGACY &&
	    vb2_dev_boot_legacy_allowed(ctx) &&
	    VbExLegacy(VB_ALTFW_DEFAULT) == VB2_SUCCESS)
		return VB2_SUCCESS;

	if (default_boot == VB2_DEV_DEFAULT_BOOT_USB &&
	    vb2_dev_boot_usb_allowed(ctx) &&
	    VbTryLoadKernel(ctx, VB_DISK_FLAG_REMOVABLE) == VB2_SUCCESS)
		return VB2_SUCCESS;

	return VbTryLoadKernel(ctx, VB_DISK_FLAG_FIXED);
}

vb2_error_t vb2_broken_recovery_menu(struct vb2_context *ctx)
{
	/* TODO(roccochen): Init and wait for user to reset or shutdown. */
	vb2ex_display_ui(VB2_SCREEN_BLANK, 0, 0, 0);

	while (1);

	return VB2_SUCCESS;
}

vb2_error_t vb2_manual_recovery_menu(struct vb2_context *ctx)
{
	/* TODO(roccochen): Init and wait for user. */
	vb2ex_display_ui(VB2_SCREEN_BLANK, 0 ,0, 0);

	while (1);

	return VB2_SUCCESS;
}
