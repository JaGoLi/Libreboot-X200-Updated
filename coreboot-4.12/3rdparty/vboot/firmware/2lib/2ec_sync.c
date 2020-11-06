/* Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * EC software sync routines for vboot
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2secdata.h"
#include "2sysincludes.h"
#include "vboot_api.h"
#include "vboot_display.h"
#include "vboot_kernel.h"
#include "vboot_test.h"

#define SYNC_FLAG(select)					\
	((select) == VB_SELECT_FIRMWARE_READONLY ?		\
	 VB2_SD_FLAG_ECSYNC_EC_RO : VB2_SD_FLAG_ECSYNC_EC_RW)

/**
 * Set the RECOVERY_REQUEST flag in NV space
 */
static void request_recovery(struct vb2_context *ctx, uint32_t recovery_request)
{
	VB2_DEBUG("request_recovery(%u)\n", recovery_request);

	vb2_nv_set(ctx, VB2_NV_RECOVERY_REQUEST, recovery_request);
}

/**
 * Whether a reboot is requested.
 *
 * When this function returns 1, rv isn't considered an error and hence
 * recovery mode shouldn't be triggered.  This includes the following
 * situations:
 *
 * VBERROR_REBOOT_REQUIRED: When we need to display firmware sync screen, but
 * the display hasn't been initialized, a reboot will be required.
 *
 * VBERROR_EC_REBOOT_TO_RO_REQUIRED: The EC may know it needs a reboot.  It may
 * need to reboot to unprotect the region before updating, or may need to reboot
 * after updating.  When EC update fails, it also needs to reboot.
 */
static inline int reboot_requested(vb2_error_t rv)
{
	return rv == VB2_REQUEST_REBOOT || rv == VB2_REQUEST_REBOOT_EC_TO_RO;
}

/**
 * Wrapper around vb2ex_ec_protect() which sets recovery reason on error.
 */
static vb2_error_t protect_ec(struct vb2_context *ctx,
			      enum vb2_firmware_selection select)
{
	vb2_error_t rv = vb2ex_ec_protect(select);

	if (reboot_requested(rv)) {
		VB2_DEBUG("vb2ex_ec_protect() needs reboot: %#x\n", rv);
	} else if (rv != VB2_SUCCESS) {
		VB2_DEBUG("vb2ex_ec_protect() returned %#x\n", rv);
		request_recovery(ctx, VB2_RECOVERY_EC_PROTECT);
	}
	return rv;
}

/**
 * Print a hash to debug output
 *
 * @param hash		Pointer to the hash
 * @param hash_size	Size of the hash in bytes
 * @param desc		Description of what's being hashed
 */
static void print_hash(const uint8_t *hash, uint32_t hash_size)
{
	int i;
	for (i = 0; i < hash_size; i++)
		VB2_DEBUG_RAW("%02x", hash[i]);
	VB2_DEBUG_RAW("\n");
}

static const char *image_name_to_string(enum vb2_firmware_selection select)
{
	switch (select) {
	case VB_SELECT_FIRMWARE_READONLY:
		return "RO";
	case VB_SELECT_FIRMWARE_EC_ACTIVE:
		return "RW(active)";
	case VB_SELECT_FIRMWARE_EC_UPDATE:
		return "RW(update)";
	default:
		return "UNKNOWN";
	}
}

/**
 * Check if the hash of the EC code matches the expected hash.
 *
 * @param ctx		Vboot2 context
 * @param select	Which firmware image to check
 * @return VB2_SUCCESS, or non-zero error code.
 */
static vb2_error_t check_ec_hash(struct vb2_context *ctx,
				 enum vb2_firmware_selection select)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	const uint8_t *hexp = NULL;
	const uint8_t *hmir = NULL;
	const uint8_t *heff = NULL;
	int hexp_len, heff_len;
	const int hmir_len = VB2_SHA256_DIGEST_SIZE;
	vb2_error_t rv;

	/*
	 * Get expected EC hash and length.
	 */
	rv = vb2ex_ec_get_expected_image_hash(select, &hexp, &hexp_len);
	if (rv) {
		VB2_DEBUG("vb2ex_ec_get_expected_image_hash() returned %#x\n",
			  rv);
		request_recovery(ctx, VB2_RECOVERY_EC_EXPECTED_HASH);
		return VB2_ERROR_EC_HASH_EXPECTED;
	}
	VB2_DEBUG("Hexp %10s: ", image_name_to_string(select));
	print_hash(hexp, hexp_len);

	/*
	 * Get mirrored EC hash. This returns NULL on old systems. On new
	 * systems without EFS2, Hmir will be updated but unused.
	 *
	 * If it's called from update_ec, Hmir and Hexp are already synced.
	 */
	hmir = vb2_secdata_kernel_get_ec_hash(ctx);
	if (hmir && select == VB_SELECT_FIRMWARE_EC_ACTIVE) {
		VB2_DEBUG("     %10s: ", "Hmir");
		print_hash(hmir, hmir_len);
		if (hmir_len != hexp_len) {
			VB2_DEBUG("Hmir size (%d) != Hexp size (%d)\n",
				  hmir_len, hexp_len);
			request_recovery(ctx, VB2_RECOVERY_EC_HASH_SIZE);
			return VB2_ERROR_EC_HASH_SIZE;
		}
		if (vb2_safe_memcmp(hmir, hexp, hexp_len)) {
			VB2_DEBUG("Hmir != Hexp. Update Hmir.\n");
			vb2_secdata_kernel_set_ec_hash(ctx, hexp);
			sd->flags |= VB2_SD_FLAG_ECSYNC_HMIR_UPDATED;
		}
	}

	/*
	 * Get effective EC hash and length.
	 */
	rv = vb2ex_ec_hash_image(select, &heff, &heff_len);
	if (rv) {
		VB2_DEBUG("vb2ex_ec_hash_image() returned %#x\n", rv);
		request_recovery(ctx, VB2_RECOVERY_EC_HASH_FAILED);
		return VB2_ERROR_EC_HASH_IMAGE;
	}
	VB2_DEBUG("Heff %10s: ", image_name_to_string(select));
	print_hash(heff, heff_len);

	/* Lengths should match. */
	if (heff_len != hexp_len) {
		VB2_DEBUG("EC uses %d-byte hash but AP-RW contains %d bytes\n",
			  heff_len, hexp_len);
		request_recovery(ctx, VB2_RECOVERY_EC_HASH_SIZE);
		return VB2_ERROR_EC_HASH_SIZE;
	}

	if (vb2_safe_memcmp(heff, hexp, hexp_len)) {
		VB2_DEBUG("Heff != Hexp. Schedule update\n");
		sd->flags |= SYNC_FLAG(select);
	}

	return VB2_SUCCESS;
}

/**
 * Update the specified EC and verify the update succeeded
 *
 * @param ctx		Vboot2 context
 * @param select	Which firmware image to check
 * @return VB2_SUCCESS, or non-zero error code.
 */
static vb2_error_t update_ec(struct vb2_context *ctx,
			     enum vb2_firmware_selection select)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	vb2_error_t rv;

	VB2_DEBUG("Updating %s...\n", image_name_to_string(select));

	rv = vb2ex_ec_update_image(select);
	if (rv != VB2_SUCCESS) {
		VB2_DEBUG("vb2ex_ec_update_image() returned %#x\n", rv);
		if (!reboot_requested(rv))
			request_recovery(ctx, VB2_RECOVERY_EC_UPDATE);
		return rv;
	}

	/* Verify the EC was updated properly */
	sd->flags &= ~SYNC_FLAG(select);
	if (check_ec_hash(ctx, select) != VB2_SUCCESS)
		return VB2_REQUEST_REBOOT_EC_TO_RO;
	if (sd->flags & SYNC_FLAG(select)) {
		VB2_DEBUG("Failed to update\n");
		request_recovery(ctx, VB2_RECOVERY_EC_UPDATE);
		return VB2_REQUEST_REBOOT_EC_TO_RO;
	}

	VB2_DEBUG("Updated %s successfully\n", image_name_to_string(select));

	return VB2_SUCCESS;
}

/**
 * Set VB2_SD_FLAG_ECSYNC_EC_IN_RW flag for the EC
 *
 * @param ctx		Vboot2 context
 * @return VB2_SUCCESS, or non-zero if error.
 */
static vb2_error_t check_ec_active(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	int in_rw = 0;
	/*
	 * We don't use vb2ex_ec_trusted, which checks EC_IN_RW. It is
	 * controlled by cr50 but on some platforms, cr50 can't know when a EC
	 * resets. So, we trust what EC-RW says. If it lies it's in RO, we'll
	 * flash RW while it's in RW.
	 */
	vb2_error_t rv = vb2ex_ec_running_rw(&in_rw);
	/* If we couldn't determine where the EC was, reboot to recovery. */
	if (rv != VB2_SUCCESS) {
		VB2_DEBUG("vb2ex_ec_running_rw() returned %#x\n", rv);
		request_recovery(ctx, VB2_RECOVERY_EC_UNKNOWN_IMAGE);
		return VB2_REQUEST_REBOOT_EC_TO_RO;
	}

	if (in_rw)
		sd->flags |= VB2_SD_FLAG_ECSYNC_EC_IN_RW;

	return VB2_SUCCESS;
}

#define RO_RETRIES 2  /* Maximum times to retry flashing RO */

/**
 * Sync, jump, and protect EC device
 *
 * @param ctx		Vboot2 context
 * @return VB2_SUCCESS, or non-zero if error.
 */
static vb2_error_t sync_ec(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	vb2_error_t rv;

	const enum vb2_firmware_selection select_rw = EC_EFS ?
		VB_SELECT_FIRMWARE_EC_UPDATE :
		VB_SELECT_FIRMWARE_EC_ACTIVE;
	VB2_DEBUG("select_rw=%s\n", image_name_to_string(select_rw));

	/* Update the RW Image */
	if (sd->flags & SYNC_FLAG(select_rw)) {
		rv = update_ec(ctx, select_rw);
		if (reboot_requested(rv))
			return rv;
		else if (rv)
			return VB2_REQUEST_REBOOT_EC_TO_RO;
		/* Updated successfully. Cold reboot to switch to the new RW. */
		if (ctx->flags & VB2_CONTEXT_NO_BOOT) {
			VB2_DEBUG("Rebooting to jump to new EC-RW\n");
			return VB2_REQUEST_REBOOT_EC_TO_RO;
		} else if (EC_EFS) {
			VB2_DEBUG("Rebooting to switch to new EC-RW\n");
			return VB2_REQUEST_REBOOT_EC_SWITCH_RW;
		}
	}

	if (sd->flags & VB2_SD_FLAG_ECSYNC_HMIR_UPDATED) {
		/*
		 * After Hmir is updated, EFS needs to be retried since the
		 * verification result is revoked.
		 */
		VB2_DEBUG("Reset EC after Hmir update\n");
		return VB2_REQUEST_REBOOT_EC_TO_RO;
	}

	/* Tell EC to jump to RW. It should already be in RW for EFS2. */
	if (!(sd->flags & VB2_SD_FLAG_ECSYNC_EC_IN_RW)) {
		VB2_DEBUG("jumping to EC-RW\n");
		rv = vb2ex_ec_jump_to_rw();
		if (rv != VB2_SUCCESS) {
			VB2_DEBUG("vb2ex_ec_jump_to_rw() returned %x\n", rv);

			/*
			 * If a previous AP boot has called
			 * vb2ex_ec_disable_jump(), we need to reboot the EC to
			 * unlock the ability to jump to the RW firmware.
			 *
			 * All other errors trigger recovery mode.
			 */
			if (rv != VB2_REQUEST_REBOOT_EC_TO_RO)
				request_recovery(ctx, VB2_RECOVERY_EC_JUMP_RW);

			return VB2_REQUEST_REBOOT_EC_TO_RO;
		}
	}

	/* Might need to update EC-RO */
	if (sd->flags & VB2_SD_FLAG_ECSYNC_EC_RO) {
		VB2_DEBUG("RO Software Sync\n");

		/* Reset RO Software Sync NV flag */
		vb2_nv_set(ctx, VB2_NV_TRY_RO_SYNC, 0);

		/*
		 * Get the current recovery request (if any).  This gets
		 * overwritten by a failed try.  If a later try succeeds, we'll
		 * need to restore this request (or the lack of a request), or
		 * else we'll end up in recovery mode even though RO software
		 * sync did eventually succeed.
		 */
		uint32_t recovery_request =
			vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST);

		/* Update the RO Image. */
		int num_tries;
		for (num_tries = 0; num_tries < RO_RETRIES; num_tries++) {
			rv = update_ec(ctx, VB_SELECT_FIRMWARE_READONLY);
			if (rv == VB2_SUCCESS)
				break;
			if (reboot_requested(rv))
				return rv;
		}
		if (num_tries == RO_RETRIES) {
			/* Ran out of tries */
			return VB2_REQUEST_REBOOT_EC_TO_RO;
		} else if (num_tries) {
			/*
			 * Update succeeded after a failure, so we've polluted
			 * the recovery request.  Restore it.
			 */
			request_recovery(ctx, recovery_request);
		}
	}

	/* Protect RO flash */
	rv = protect_ec(ctx, VB_SELECT_FIRMWARE_READONLY);
	if (rv != VB2_SUCCESS)
		return rv;

	/* Protect RW flash */
	rv = protect_ec(ctx, select_rw);
	if (rv != VB2_SUCCESS)
		return rv;

	/* Disable further sysjumps */
	rv = vb2ex_ec_disable_jump();
	if (rv != VB2_SUCCESS) {
		VB2_DEBUG("vb2ex_ec_disable_jump() returned %#x\n", rv);
		request_recovery(ctx, VB2_RECOVERY_EC_SOFTWARE_SYNC);
		return VB2_REQUEST_REBOOT_EC_TO_RO;
	}

	return rv;
}

/**
 * EC sync, phase 1
 *
 * This checks whether the EC is running the correct image to do EC sync, and
 * whether any updates are necessary.
 *
 * @param ctx		Vboot2 context
 * @return VB2_SUCCESS, VB2_REQUEST_REBOOT_EC_TO_RO if the EC must reboot back
 * to its RO code to continue EC sync, or other non-zero error code.
 */
static vb2_error_t ec_sync_phase1(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	struct vb2_gbb_header *gbb = vb2_get_gbb(ctx);

	/* Reasons not to do sync at all */
	if (!(ctx->flags & VB2_CONTEXT_EC_SYNC_SUPPORTED))
		return VB2_SUCCESS;
	if (gbb->flags & VB2_GBB_FLAG_DISABLE_EC_SOFTWARE_SYNC)
		return VB2_SUCCESS;

	/* Set VB2_SD_FLAG_ECSYNC_EC_IN_RW flag */
	if (check_ec_active(ctx))
		return VB2_REQUEST_REBOOT_EC_TO_RO;

	/* Check if we need to update RW. Failures trigger recovery mode. */
	if (check_ec_hash(ctx, VB_SELECT_FIRMWARE_EC_ACTIVE))
		return VB2_REQUEST_REBOOT_EC_TO_RO;

	/* See if we need to update EC-RO. */
	if (vb2_nv_get(ctx, VB2_NV_TRY_RO_SYNC) &&
	    check_ec_hash(ctx, VB_SELECT_FIRMWARE_READONLY)) {
		return VB2_REQUEST_REBOOT_EC_TO_RO;
	}

	/*
	 * If we're in RW, we need to reboot back to RO because RW can't be
	 * updated while we're running it.
	 *
	 * If EC supports RW-A/B slots, we can proceed but we need
	 * to jump to the new RW version later.
	 */
	if ((sd->flags & SYNC_FLAG(VB_SELECT_FIRMWARE_EC_ACTIVE)) &&
	    (sd->flags & VB2_SD_FLAG_ECSYNC_EC_IN_RW) && !EC_EFS) {
		return VB2_REQUEST_REBOOT_EC_TO_RO;
	}

	return VB2_SUCCESS;
}

/**
 * determine if we can update the EC
 *
 * @param ctx		Vboot2 context
 * @return boolean (true iff we can update the EC)
 */

static int ec_sync_allowed(struct vb2_context *ctx)
{
	struct vb2_gbb_header *gbb = vb2_get_gbb(ctx);

	/* Reasons not to do sync at all */
	if (!(ctx->flags & VB2_CONTEXT_EC_SYNC_SUPPORTED))
		return 0;
	if (gbb->flags & VB2_GBB_FLAG_DISABLE_EC_SOFTWARE_SYNC)
		return 0;
	if (ctx->flags & VB2_CONTEXT_RECOVERY_MODE)
		return 0;
	return 1;
}

/**
 * EC sync, phase 2
 *
 * This updates the EC if necessary, makes sure it has protected its image(s),
 * and makes sure it has jumped to the correct image.
 *
 * @param ctx		Vboot2 context
 * @return VB2_SUCCESS, VB2_REQUEST_REBOOT_EC_TO_RO if the EC must
 * reboot back to its RO code to continue EC sync, or other non-zero error
 * code.
 */
static vb2_error_t ec_sync_phase2(struct vb2_context *ctx)
{
	if (!ec_sync_allowed(ctx))
		return VB2_SUCCESS;

	/* Handle updates and jumps for EC */
	return sync_ec(ctx);
}

vb2_error_t vb2api_ec_sync(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);

	/*
	 * If the status indicates that the EC has already gone through
	 * software sync this boot, then don't do it again.
	 */
	if (sd->status & VB2_SD_STATUS_EC_SYNC_COMPLETE) {
		VB2_DEBUG("EC software sync already performed this boot, skipping\n");
		return VB2_SUCCESS;
	}

	/*
	 * If the device is in recovery mode, then EC sync should
	 * not be performed.
	 */
	if (ctx->flags & VB2_CONTEXT_RECOVERY_MODE) {
		VB2_DEBUG("In recovery mode, skipping EC sync\n");
		return VB2_SUCCESS;
	}

	/* Phase 1; this determines if we need an update */
	VB2_TRY(ec_sync_phase1(ctx));

	/* Phase 2; Applies update and/or jumps to the correct EC image */
	VB2_TRY(ec_sync_phase2(ctx));

	/* Phase 3; Let the platform know that EC software sync is now done */
	VB2_TRY(vb2ex_ec_vboot_done(ctx));

	/* Establish that EC software sync is complete and successful */
	sd->status |= VB2_SD_STATUS_EC_SYNC_COMPLETE;

	return VB2_SUCCESS;
}
