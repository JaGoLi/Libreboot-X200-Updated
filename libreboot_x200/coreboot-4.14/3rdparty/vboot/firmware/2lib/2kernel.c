/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Kernel selection, loading, verification, and booting.
 */

#include "2common.h"
#include "2kernel.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2rsa.h"
#include "2secdata.h"
#include "vboot_kernel.h"

/**
 * Reset any NVRAM requests.
 *
 * @param ctx		Vboot context
 * @return 1 if a reboot is required, 0 otherwise.
 */
static int vb2_reset_nv_requests(struct vb2_context *ctx)
{
	int need_reboot = 0;

	if (vb2_nv_get(ctx, VB2_NV_DISPLAY_REQUEST)) {
		VB2_DEBUG("Unset display request (undo display init)\n");
		vb2_nv_set(ctx, VB2_NV_DISPLAY_REQUEST, 0);
		need_reboot = 1;
	}

	if (vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST)) {
		VB2_DEBUG("Unset diagnostic request (undo display init)\n");
		vb2_nv_set(ctx, VB2_NV_DIAG_REQUEST, 0);
		need_reboot = 1;
	}

	return need_reboot;
}

vb2_error_t vb2_normal_boot(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	uint32_t max_rollforward = vb2_nv_get(ctx,
					      VB2_NV_KERNEL_MAX_ROLLFORWARD);

	/* Boot from fixed disk only */
	VB2_DEBUG("Entering\n");

	if (vb2_reset_nv_requests(ctx)) {
		VB2_DEBUG("Normal mode: reboot to reset NVRAM requests\n");
		return VB2_REQUEST_REBOOT;
	}

	vb2_error_t rv = VbTryLoadKernel(ctx, VB_DISK_FLAG_FIXED);

	VB2_DEBUG("Checking if TPM kernel version needs advancing\n");

	/*
	 * Special case for when we're trying a slot with new firmware.
	 * Firmware updates also usually change the kernel key, which means
	 * that the new firmware can only boot a new kernel, and the old
	 * firmware in the previous slot can only boot the previous kernel.
	 *
	 * Don't roll-forward the kernel version, because we don't yet know if
	 * the new kernel will successfully boot.
	 */
	if (vb2_nv_get(ctx, VB2_NV_FW_RESULT) == VB2_FW_RESULT_TRYING) {
		VB2_DEBUG("Trying new FW; skip kernel version roll-forward.\n");
		return rv;
	}

	/*
	 * Limit kernel version rollforward if needed.  Can't limit kernel
	 * version to less than the version currently in the TPM.  That is,
	 * we're limiting rollforward, not allowing rollback.
	 */
	if (max_rollforward < sd->kernel_version_secdata)
		max_rollforward = sd->kernel_version_secdata;

	if (sd->kernel_version > max_rollforward) {
		VB2_DEBUG("Limiting TPM kernel version roll-forward "
			  "to %#x < %#x\n",
			  max_rollforward, sd->kernel_version);

		sd->kernel_version = max_rollforward;
	}

	if (sd->kernel_version > sd->kernel_version_secdata) {
		vb2_secdata_kernel_set(ctx, VB2_SECDATA_KERNEL_VERSIONS,
				       sd->kernel_version);
	}

	return rv;
}

int vb2api_is_developer_signed(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);

	if (!sd->kernel_key_offset || !sd->kernel_key_size) {
		VB2_DEBUG("ERROR: Cannot call this before kernel_phase1!\n");
		return 0;
	}

	struct vb2_public_key key;
	if (vb2_unpack_key(&key, vb2_member_of(sd, sd->kernel_key_offset)))
		return 0;

	/* This is a debugging aid, not a security-relevant feature. There's no
	   reason to hardcode the whole key or waste time computing a hash. Just
	   spot check the starting bytes of the pseudorandom part of the key. */
	uint32_t devkey_n0inv = ctx->flags & VB2_CONTEXT_RECOVERY_MODE ?
		0x18cebcf5 :	/*  recovery_key.vbpubk @0x24 */
		0xe0cd87d9;	/* kernel_subkey.vbpubk @0x24 */

	if (key.n0inv == devkey_n0inv)
		return 1;

	return 0;
}

vb2_error_t vb2api_kernel_phase1(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	struct vb2_workbuf wb;
	struct vb2_packed_key *packed_key;
	uint32_t flags;
	vb2_error_t rv;

	vb2_workbuf_from_ctx(ctx, &wb);

	/*
	 * Init secdata_fwmp spaces. No need to init secdata_firmware or
	 * secdata_kernel, since they were already read during firmware
	 * verification.  Ignore errors in recovery mode.
	 */
	rv = vb2_secdata_fwmp_init(ctx);
	if (rv && !(ctx->flags & VB2_CONTEXT_RECOVERY_MODE)) {
		VB2_DEBUG("TPM: init secdata_fwmp returned %#x\n", rv);
		vb2api_fail(ctx, VB2_RECOVERY_SECDATA_FWMP_INIT, rv);
		return rv;
	}

	/* Initialize experimental feature flags while in normal RW path. */
	if (!(ctx->flags & VB2_CONTEXT_RECOVERY_MODE)) {
		flags = vb2_secdata_kernel_get(ctx, VB2_SECDATA_KERNEL_FLAGS);
		flags &= ~VB2_SECDATA_KERNEL_FLAG_PHONE_RECOVERY_DISABLED;
		flags |= VB2_SECDATA_KERNEL_FLAG_PHONE_RECOVERY_UI_DISABLED;
		flags &= ~VB2_SECDATA_KERNEL_FLAG_DIAGNOSTIC_UI_DISABLED;
		flags |= VB2_SECDATA_KERNEL_FLAG_HWCRYPTO_ALLOWED;
		vb2_secdata_kernel_set(ctx, VB2_SECDATA_KERNEL_FLAGS, flags);
	}

	/* Read kernel version from secdata. */
	sd->kernel_version_secdata =
		vb2_secdata_kernel_get(ctx, VB2_SECDATA_KERNEL_VERSIONS);
	sd->kernel_version = sd->kernel_version_secdata;

	/* Find the key to use to verify the kernel keyblock */
	if ((ctx->flags & VB2_CONTEXT_RECOVERY_MODE)) {
		/* Load recovery key from GBB. */
		rv = vb2_gbb_read_recovery_key(ctx, &packed_key, NULL, &wb);
		if (rv) {
			if (vb2_allow_recovery(ctx))
				VB2_DIE("GBB read recovery key failed.\n");
			else
				/*
				 * If we're headed for the BROKEN screen,
				 * we won't need the recovery key.  Just
				 * short-circuit with success.
				 */
				return VB2_SUCCESS;
		}
	} else {
		/* Kernel subkey from firmware preamble */
		struct vb2_fw_preamble *pre;

		/* Make sure we have a firmware preamble loaded */
		if (!sd->preamble_size)
			return VB2_ERROR_API_KPHASE1_PREAMBLE;

		pre = (struct vb2_fw_preamble *)
			vb2_member_of(sd, sd->preamble_offset);
		packed_key = &pre->kernel_subkey;
	}

	sd->kernel_key_offset = vb2_offset_of(sd, packed_key);
	sd->kernel_key_size = packed_key->key_offset + packed_key->key_size;

	vb2_set_workbuf_used(ctx, vb2_offset_of(sd, wb.buf));

	if (vb2api_is_developer_signed(ctx))
		VB2_DEBUG("This is developer-signed firmware.\n");

	return VB2_SUCCESS;
}
