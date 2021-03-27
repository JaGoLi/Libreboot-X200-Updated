/* Copyright 2019 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Auxiliary firmware (auxfw) sync routines for vboot.
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"

/**
 * Determine if we are allowed to update auxfw.
 *
 * @param ctx		Vboot2 context
 * @return boolean (true iff we can update auxfw)
 */
static int auxfw_sync_allowed(struct vb2_context *ctx)
{
	struct vb2_gbb_header *gbb = vb2_get_gbb(ctx);

	/* Reasons not to do sync at all */
	if (gbb->flags & VB2_GBB_FLAG_DISABLE_AUXFW_SOFTWARE_SYNC)
		return 0;
	if (ctx->flags & VB2_CONTEXT_RECOVERY_MODE)
		return 0;
	return 1;
}

/**
 * Update the specified auxfw and verify the update succeeded.
 *
 * @param ctx		Vboot2 context
 * @return VB2_SUCCESS, or non-zero error code.
 */
static vb2_error_t update_auxfw(struct vb2_context *ctx)
{
	vb2_error_t rv;

	VB2_DEBUG("Updating auxfw\n");

	/*
	 * The underlying platform is expected to know how and where to find the
	 * firmware image for all auxfw devices.
	 */
	rv = vb2ex_auxfw_update();
	if (rv != VB2_SUCCESS) {
		VB2_DEBUG("vb2ex_auxfw_update() returned %d\n", rv);

		/*
		 * The device may need a reboot.  It may need to unprotect the
		 * region before updating, or may need to reboot after updating.
		 * Either way, it's not an error requiring recovery mode.
		 *
		 * If we fail for any other reason, trigger recovery mode.
		 */
		if (rv != VB2_REQUEST_REBOOT_EC_TO_RO)
			vb2api_fail(ctx, VB2_RECOVERY_AUXFW_UPDATE, rv);
	}

	return rv;
}

/**
 * Decides if auxfw sync is allowed to be performed.
 *
 * If sync is allowed, invokes the external callback,
 * vb2ex_auxfw_check() to allow the client to decide on the auxfw
 * update severity.
 *
 * @param ctx		Vboot2 context
 * @return VB2_SUCCESS, or non-zero error code.
 */
static vb2_error_t auxfw_sync_check_update(struct vb2_context *ctx,
					   enum vb2_auxfw_update_severity *severity)
{
	if (!auxfw_sync_allowed(ctx)) {
		*severity = VB2_AUXFW_NO_UPDATE;
		return VB2_SUCCESS;
	}

	return vb2ex_auxfw_check(severity);
}

vb2_error_t vb2api_auxfw_sync(struct vb2_context *ctx)
{
	enum vb2_auxfw_update_severity fw_update = VB2_AUXFW_NO_UPDATE;

	/* Check for update severity */
	VB2_TRY(auxfw_sync_check_update(ctx, &fw_update));

	if (fw_update > VB2_AUXFW_NO_UPDATE) {
		VB2_TRY(update_auxfw(ctx));
		/*
		 * auxfw update is applied successfully. Request EC reboot to
		 * RO, so that the chips that had FW update get reset to a
		 * clean state.
		 */
		return VB2_REQUEST_REBOOT_EC_TO_RO;
	}

	return vb2ex_auxfw_finalize(ctx);
}
