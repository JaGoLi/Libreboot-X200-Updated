/* Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * High-level firmware wrapper API - entry points for kernel selection
 */

#include "2api.h"
#include "2common.h"
#include "2kernel.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2rsa.h"
#include "2secdata.h"
#include "2sysincludes.h"
#include "2ui.h"
#include "load_kernel_fw.h"
#include "vboot_api.h"
#include "vboot_kernel.h"
#include "vboot_struct.h"
#include "vboot_test.h"

/* Global variables */
static LoadKernelParams lkp;

#ifdef CHROMEOS_ENVIRONMENT
/* Global variable accessor for unit tests */
struct LoadKernelParams *VbApiKernelGetParams(void)
{
	return &lkp;
}
#endif

static vb2_error_t handle_battery_cutoff(struct vb2_context *ctx)
{
	/*
	 * Check if we need to cut-off battery. This should be done after EC
	 * FW and auxfw are updated, and before the kernel is started.  This
	 * is to make sure all firmware is up-to-date before shipping (which
	 * is the typical use-case for cutoff).
	 */
	if (vb2_nv_get(ctx, VB2_NV_BATTERY_CUTOFF_REQUEST)) {
		VB2_DEBUG("Request to cut-off battery\n");
		vb2_nv_set(ctx, VB2_NV_BATTERY_CUTOFF_REQUEST, 0);

		/* May lose power immediately, so commit our update now. */
		VB2_TRY(vb2ex_commit_data(ctx));

		vb2ex_ec_battery_cutoff();
		return VB2_REQUEST_SHUTDOWN;
	}

	return VB2_SUCCESS;
}

test_mockable
vb2_error_t VbTryLoadKernel(struct vb2_context *ctx, uint32_t get_info_flags)
{
	vb2_error_t rv = VB2_ERROR_LK_NO_DISK_FOUND;
	VbDiskInfo* disk_info = NULL;
	uint32_t disk_count = 0;
	uint32_t i;

	lkp.disk_handle = NULL;

	/* Find disks */
	if (VB2_SUCCESS != VbExDiskGetInfo(&disk_info, &disk_count,
					   get_info_flags))
		disk_count = 0;

	/* Loop over disks */
	for (i = 0; i < disk_count; i++) {
		VB2_DEBUG("trying disk %d\n", (int)i);
		/*
		 * Validity-check what we can. FWIW, VbTryLoadKernel() is always
		 * called with only a single bit set in get_info_flags.
		 *
		 * Ensure that we got a partition with only the flags we asked
		 * for.
		 */
		if (disk_info[i].bytes_per_lba < 512 ||
			(disk_info[i].bytes_per_lba &
				(disk_info[i].bytes_per_lba  - 1)) != 0 ||
					16 > disk_info[i].lba_count ||
					get_info_flags != (disk_info[i].flags &
					~VB_DISK_FLAG_EXTERNAL_GPT)) {
			VB2_DEBUG("  skipping: bytes_per_lba=%" PRIu64
				  " lba_count=%" PRIu64 " flags=%#x\n",
				  disk_info[i].bytes_per_lba,
				  disk_info[i].lba_count,
				  disk_info[i].flags);
			continue;
		}
		lkp.disk_handle = disk_info[i].handle;
		lkp.bytes_per_lba = disk_info[i].bytes_per_lba;
		lkp.gpt_lba_count = disk_info[i].lba_count;
		lkp.streaming_lba_count = disk_info[i].streaming_lba_count
						?: lkp.gpt_lba_count;
		lkp.boot_flags |= disk_info[i].flags & VB_DISK_FLAG_EXTERNAL_GPT
				? BOOT_FLAG_EXTERNAL_GPT : 0;

		vb2_error_t new_rv = LoadKernel(ctx, &lkp);
		VB2_DEBUG("LoadKernel() = %#x\n", new_rv);

		/* Stop now if we found a kernel. */
		if (VB2_SUCCESS == new_rv) {
			VbExDiskFreeInfo(disk_info, lkp.disk_handle);
			return VB2_SUCCESS;
		}

		/* Don't update error if we already have a more specific one. */
		if (VB2_ERROR_LK_INVALID_KERNEL_FOUND != rv)
			rv = new_rv;
	}

	/* If we drop out of the loop, we didn't find any usable kernel. */
	if (get_info_flags & VB_DISK_FLAG_FIXED) {
		switch (rv) {
		case VB2_ERROR_LK_INVALID_KERNEL_FOUND:
			vb2api_fail(ctx, VB2_RECOVERY_RW_INVALID_OS, rv);
			break;
		case VB2_ERROR_LK_NO_KERNEL_FOUND:
			vb2api_fail(ctx, VB2_RECOVERY_RW_NO_KERNEL, rv);
			break;
		case VB2_ERROR_LK_NO_DISK_FOUND:
			vb2api_fail(ctx, VB2_RECOVERY_RW_NO_DISK, rv);
			break;
		default:
			vb2api_fail(ctx, VB2_RECOVERY_LK_UNSPECIFIED, rv);
			break;
		}
	}

	/* If we didn't find any good kernels, don't return a disk handle. */
	VbExDiskFreeInfo(disk_info, NULL);

	return rv;
}

static vb2_error_t vb2_kernel_init_kparams(struct vb2_context *ctx,
					   VbSelectAndLoadKernelParams *kparams)
{
	/* Fill in params for calls to LoadKernel() */
	memset(&lkp, 0, sizeof(lkp));
	lkp.kernel_buffer = kparams->kernel_buffer;
	lkp.kernel_buffer_size = kparams->kernel_buffer_size;

	/* Clear output params in case we fail */
	kparams->disk_handle = NULL;
	kparams->partition_number = 0;
	kparams->bootloader_address = 0;
	kparams->bootloader_size = 0;
	kparams->flags = 0;
	memset(kparams->partition_guid, 0, sizeof(kparams->partition_guid));

	return VB2_SUCCESS;
}

static void vb2_kernel_fill_kparams(struct vb2_context *ctx,
				    VbSelectAndLoadKernelParams *kparams)
{
	/* Save disk parameters */
	kparams->disk_handle = lkp.disk_handle;
	kparams->partition_number = lkp.partition_number;
	kparams->bootloader_address = lkp.bootloader_address;
	kparams->bootloader_size = lkp.bootloader_size;
	kparams->flags = lkp.flags;
	kparams->kernel_buffer = lkp.kernel_buffer;
	kparams->kernel_buffer_size = lkp.kernel_buffer_size;
	memcpy(kparams->partition_guid, lkp.partition_guid,
	       sizeof(kparams->partition_guid));
}

vb2_error_t VbSelectAndLoadKernel(struct vb2_context *ctx,
				  VbSelectAndLoadKernelParams *kparams)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	vb2_gbb_flags_t gbb_flags = vb2api_gbb_get_flags(ctx);

	/* Init nvstorage space. TODO(kitching): Remove once we add assertions
	   to vb2_nv_get and vb2_nv_set. */
	vb2_nv_init(ctx);

	VB2_TRY(vb2_kernel_init_kparams(ctx, kparams));

	VB2_TRY(vb2api_kernel_phase1(ctx));

	VB2_DEBUG("GBB flags are %#x\n", gbb_flags);

	/*
	 * Do EC and auxfw software sync unless we're in recovery mode. This
	 * has UI but it's just a single non-interactive WAIT screen.
	 */
	if (!(ctx->flags & VB2_CONTEXT_RECOVERY_MODE)) {
		VB2_TRY(vb2api_ec_sync(ctx));
		VB2_TRY(vb2api_auxfw_sync(ctx));
		VB2_TRY(handle_battery_cutoff(ctx));
	}

	/*
	 * If in non-manual recovery mode, save the recovery reason as subcode.
	 * Otherwise, clear any leftover recovery requests or subcodes.
	 */
	vb2_clear_recovery(ctx);

	/* Select boot path */
	if (ctx->flags & VB2_CONTEXT_RECOVERY_MODE) {
		/* If we're in recovery mode just to do memory retraining, all
		   we need to do is reboot. */
		if (sd->recovery_reason == VB2_RECOVERY_TRAIN_AND_REBOOT) {
			VB2_DEBUG("Reboot after retraining in recovery\n");
			return VB2_REQUEST_REBOOT;
		}

		/*
		 * Need to commit nvdata changes immediately, since we will be
		 * entering either manual recovery UI or BROKEN screen shortly.
		 */
		vb2ex_commit_data(ctx);

		/*
		 * In EFS2, recovery mode can be entered even when battery is
		 * drained or damaged. EC-RO sets NO_BOOT flag in such case and
		 * uses PD power to boot AP.
		 *
		 * TODO: Inform user why recovery failed to start.
		 */
		if (ctx->flags & VB2_CONTEXT_NO_BOOT)
			VB2_DEBUG("NO_BOOT in RECOVERY mode\n");

		/* Recovery boot.  This has UI. */
		if (vb2_allow_recovery(ctx))
			VB2_TRY(vb2_manual_recovery_menu(ctx));
		else
			VB2_TRY(vb2_broken_recovery_menu(ctx));
	} else if (DIAGNOSTIC_UI && vb2api_diagnostic_ui_enabled(ctx) &&
		   vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST)) {
		/*
		 * Need to clear the request flag and commit nvdata changes
		 * immediately to avoid booting back into diagnostic tool when a
		 * forced system reset occurs.
		 */
		vb2_nv_set(ctx, VB2_NV_DIAG_REQUEST, 0);
		vb2ex_commit_data(ctx);

		/* Diagnostic boot.  This has UI. */
		VB2_TRY(vb2_diagnostic_menu(ctx));
		/*
		 * The diagnostic menu should either boot a rom, or
		 * return either of reboot or shutdown.
		 */
		return VB2_REQUEST_REBOOT;
	} else if (ctx->flags & VB2_CONTEXT_DEVELOPER_MODE) {
		/* Developer boot.  This has UI. */
		VB2_TRY(vb2_developer_menu(ctx));
	} else {
		/* Normal boot */
		VB2_TRY(vb2_normal_boot(ctx));
	}

	/*
	 * Stop all cases returning SUCCESS against NO_BOOT flag except when
	 * GBB flag disables software sync.
	 */
	if (!(gbb_flags & VB2_GBB_FLAG_DISABLE_EC_SOFTWARE_SYNC)
	    && (ctx->flags & VB2_CONTEXT_NO_BOOT)) {
		VB2_DEBUG("Blocking escape from NO_BOOT mode.\n");
		vb2api_fail(ctx, VB2_RECOVERY_ESCAPE_NO_BOOT, 0);
		return VB2_ERROR_ESCAPE_NO_BOOT;
	}

	vb2_kernel_fill_kparams(ctx, kparams);
	return VB2_SUCCESS;
}
