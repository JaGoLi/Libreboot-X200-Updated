/* Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Tests for vboot_api_kernel, part 4 - select and load kernel
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2secdata.h"
#include "2sysincludes.h"
#include "2ui.h"
#include "host_common.h"
#include "load_kernel_fw.h"
#include "test_common.h"
#include "tlcl.h"
#include "tss_constants.h"
#include "vboot_kernel.h"
#include "vboot_struct.h"
#include "vboot_test.h"

/* Mock data */

static uint8_t workbuf[VB2_KERNEL_WORKBUF_RECOMMENDED_SIZE]
	__attribute__((aligned(VB2_WORKBUF_ALIGN)));
static struct vb2_context *ctx;
static struct vb2_shared_data *sd;
static VbSelectAndLoadKernelParams kparams;
static struct vb2_gbb_header gbb;

static uint32_t kernel_version;
static uint32_t new_version;
static vb2_error_t vbboot_retval;
static int commit_data_called;
static vb2_error_t secdata_kernel_init_retval;
static vb2_error_t secdata_fwmp_init_retval;
static vb2_error_t kernel_phase1_retval;
static uint32_t current_recovery_reason;
static uint32_t expected_recovery_reason;

static int mock_diagnostic_ui_enabled;

static void reset_common_data(void)
{
	memset(&kparams, 0, sizeof(kparams));

	memset(&gbb, 0, sizeof(gbb));
	gbb.major_version = VB2_GBB_MAJOR_VER;
	gbb.minor_version = VB2_GBB_MINOR_VER;
	gbb.flags = 0;

	TEST_SUCC(vb2api_init(workbuf, sizeof(workbuf), &ctx),
		  "vb2api_init failed");
	sd = vb2_get_sd(ctx);
	sd->flags |= VB2_SD_FLAG_DISPLAY_AVAILABLE;
	ctx->flags |= VB2_CONTEXT_NO_SECDATA_FWMP;
	sd->preamble_size = 1;

	vb2_nv_init(ctx);
	vb2_nv_set(ctx, VB2_NV_KERNEL_MAX_ROLLFORWARD, 0xffffffff);
	commit_data_called = 0;

	kernel_version = new_version = 0x10002;
	vbboot_retval = VB2_SUCCESS;
	secdata_kernel_init_retval = VB2_SUCCESS;
	secdata_fwmp_init_retval = VB2_SUCCESS;
	kernel_phase1_retval = VB2_SUCCESS;
	current_recovery_reason = 0;
	expected_recovery_reason = 0;

	mock_diagnostic_ui_enabled = 0;

	sd->status |= VB2_SD_STATUS_SECDATA_KERNEL_INIT;
	sd->status |= VB2_SD_STATUS_SECDATA_FWMP_INIT;
}

static void test_slk(vb2_error_t retval, int recovery_reason, const char *desc)
{
	if (sd->recovery_reason)
		ctx->flags |= VB2_CONTEXT_RECOVERY_MODE;

	expected_recovery_reason = recovery_reason;
	TEST_EQ(VbSelectAndLoadKernel(ctx, &kparams), retval, desc);
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST),
		recovery_reason, "  recovery reason");
}

/* Mock functions */

struct vb2_gbb_header *vb2_get_gbb(struct vb2_context *c)
{
	return &gbb;
}

vb2_error_t vb2api_kernel_phase1(struct vb2_context *c)
{
	sd->kernel_version_secdata = kernel_version;
	sd->kernel_version = kernel_version;
	return kernel_phase1_retval;
}

vb2_error_t vb2ex_commit_data(struct vb2_context *c)
{
	current_recovery_reason = vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST);
	commit_data_called = 1;
	return VB2_SUCCESS;
}

vb2_error_t vb2_secdata_fwmp_init(struct vb2_context *c)
{
	return secdata_fwmp_init_retval;
}

void vb2_secdata_kernel_set(struct vb2_context *c,
			    enum vb2_secdata_kernel_param param,
			    uint32_t value)
{
	kernel_version = value;
}

vb2_error_t VbTryLoadKernel(struct vb2_context *c, uint32_t get_info_flags)
{
	sd->kernel_version = new_version;

	if (vbboot_retval == -1)
		return VB2_ERROR_MOCK;

	return vbboot_retval;
}

static vb2_error_t boot_dev(struct vb2_context *c)
{
	if (vbboot_retval == -2)
		return VB2_ERROR_MOCK;

	return vbboot_retval;
}

vb2_error_t vb2_developer_menu(struct vb2_context *c)
{
	return boot_dev(c);
}

static void rec_check(struct vb2_context *c)
{
	TEST_EQ(current_recovery_reason, expected_recovery_reason,
		"  recovery reason");
	TEST_TRUE(commit_data_called, "  commit data");
}

vb2_error_t vb2_manual_recovery_menu(struct vb2_context *c)
{
	rec_check(c);
	if (vbboot_retval == -3)
		return VB2_ERROR_MOCK;
	return vbboot_retval;
}

vb2_error_t vb2_broken_recovery_menu(struct vb2_context *c)
{
	rec_check(c);
	if (vbboot_retval == -4)
		return VB2_ERROR_MOCK;
	return vbboot_retval;
}

vb2_error_t vb2_diagnostic_menu(struct vb2_context *c)
{
	if (vbboot_retval == -5)
		return VB2_ERROR_MOCK;

	return vbboot_retval;
}

int vb2api_diagnostic_ui_enabled(struct vb2_context *c)
{
	return mock_diagnostic_ui_enabled;
}

vb2_error_t vb2ex_tpm_set_mode(enum vb2_tpm_mode mode_val)
{
	return VB2_SUCCESS;
}

/* Tests */

static void select_and_load_kernel_tests(void)
{
	/* Normal boot */
	reset_common_data();
	test_slk(0, 0, "Normal");
	TEST_EQ(kernel_version, 0x10002, "  version");
	TEST_NEQ(sd->status & VB2_SD_STATUS_EC_SYNC_COMPLETE, 0,
		 "  EC sync complete");
	TEST_FALSE(commit_data_called, "  no commit data");

	/* Check EC sync toggling */
	reset_common_data();
	ctx->flags |= VB2_CONTEXT_EC_SYNC_SUPPORTED;
	gbb.flags |= VB2_GBB_FLAG_DISABLE_EC_SOFTWARE_SYNC;
	test_slk(0, 0, "EC sync disabled by GBB");
	TEST_NEQ(sd->status & VB2_SD_STATUS_EC_SYNC_COMPLETE, 0,
		 "  EC sync complete");

	reset_common_data();
	ctx->flags |= VB2_CONTEXT_EC_SYNC_SUPPORTED;
	test_slk(0, 0, "Normal with EC sync");
	TEST_NEQ(sd->status & VB2_SD_STATUS_EC_SYNC_COMPLETE, 0,
		 "  EC sync complete");

	reset_common_data();
	new_version = 0x20003;
	test_slk(0, 0, "Roll forward");
	TEST_EQ(kernel_version, 0x20003, "  version");

	reset_common_data();
	vb2_nv_set(ctx, VB2_NV_FW_RESULT, VB2_FW_RESULT_TRYING);
	new_version = 0x20003;
	test_slk(0, 0, "Don't roll forward kernel when trying new FW");
	TEST_EQ(kernel_version, 0x10002, "  version");

	reset_common_data();
	vb2_nv_set(ctx, VB2_NV_KERNEL_MAX_ROLLFORWARD, 0x30005);
	new_version = 0x40006;
	test_slk(0, 0, "Limit max roll forward");
	TEST_EQ(kernel_version, 0x30005, "  version");

	reset_common_data();
	vb2_nv_set(ctx, VB2_NV_KERNEL_MAX_ROLLFORWARD, 0x10001);
	new_version = 0x40006;
	test_slk(0, 0, "Max roll forward can't rollback");
	TEST_EQ(kernel_version, 0x10002, "  version");

	/* Boot normal */
	reset_common_data();
	vbboot_retval = -1;
	test_slk(VB2_ERROR_MOCK, 0, "Normal boot bad");

	/* Check that NV_DIAG_REQUEST triggers diagnostic UI */
	if (DIAGNOSTIC_UI) {
		reset_common_data();
		mock_diagnostic_ui_enabled = 1;
		vb2_nv_set(ctx, VB2_NV_DIAG_REQUEST, 1);
		vbboot_retval = -5;
		test_slk(VB2_ERROR_MOCK, 0,
			 "Normal boot with diag enabled");
		TEST_EQ(vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST), 0,
			"  diag not requested");

		reset_common_data();
		vb2_nv_set(ctx, VB2_NV_DIAG_REQUEST, 1);
		test_slk(VB2_REQUEST_REBOOT, 0,
			 "Normal boot with diag disabled (reboot to "
			 "unset)");
	}

	/* Boot normal - phase1 failure */
	reset_common_data();
	kernel_phase1_retval = VB2_ERROR_MOCK;
	test_slk(VB2_ERROR_MOCK, 0, "Normal phase1 failure");

	/* Recovery - VB2_ERROR_ESCAPE_NO_BOOT */
	reset_common_data();
	ctx->flags |= VB2_CONTEXT_NO_BOOT;
	test_slk(VB2_ERROR_ESCAPE_NO_BOOT,
		 VB2_RECOVERY_ESCAPE_NO_BOOT, "Recovery for NO_BOOT escape");

	/* Boot normal - VB2_ERROR_ESCAPE_NO_BOOT */
	reset_common_data();
	ctx->flags |= VB2_CONTEXT_NO_BOOT;
	gbb.flags |= VB2_GBB_FLAG_DISABLE_EC_SOFTWARE_SYNC;
	test_slk(VB2_SUCCESS, 0, "DISABLE_EC_SOFTWARE_SYNC ignores NO_BOOT");

	/* Boot dev */
	reset_common_data();
	ctx->flags |= VB2_CONTEXT_DEVELOPER_MODE;
	vbboot_retval = -2;
	test_slk(VB2_ERROR_MOCK, 0, "Dev boot bad");
	TEST_FALSE(commit_data_called, "  no commit data");

	reset_common_data();
	ctx->flags |= VB2_CONTEXT_DEVELOPER_MODE;
	new_version = 0x20003;
	test_slk(0, 0, "Dev doesn't roll forward");
	TEST_EQ(kernel_version, 0x10002, "  version");

	/* Boot dev - phase1 failure */
	reset_common_data();
	ctx->flags |= VB2_CONTEXT_DEVELOPER_MODE;
	kernel_phase1_retval = VB2_ERROR_MOCK;
	test_slk(VB2_ERROR_MOCK, 0, "Dev phase1 failure");

	/* Boot recovery */
	reset_common_data();
	sd->recovery_reason = 123;
	vbboot_retval = -4;
	test_slk(VB2_ERROR_MOCK, 0, "Recovery boot bad");
	TEST_TRUE(commit_data_called, "  commit data");

	reset_common_data();
	sd->recovery_reason = 123;
	new_version = 0x20003;
	test_slk(0, 0, "Recovery doesn't roll forward");
	TEST_EQ(kernel_version, 0x10002, "  version");
	TEST_TRUE(commit_data_called, "  commit data");

	/* Boot recovery - phase1 failure */
	reset_common_data();
	sd->recovery_reason = 123;
	kernel_phase1_retval = VB2_ERROR_MOCK;
	test_slk(VB2_ERROR_MOCK, 0, "Recovery phase1 failure");
	TEST_FALSE(commit_data_called, "  no commit data");

	/* Boot recovery - memory retraining */
	reset_common_data();
	sd->recovery_reason = VB2_RECOVERY_TRAIN_AND_REBOOT;
	test_slk(VB2_REQUEST_REBOOT, 0, "Recovery train and reboot");
	TEST_FALSE(commit_data_called, "  no commit data");

	/* Boot BROKEN recovery */
	reset_common_data();
	sd->recovery_reason = 123;
	vb2_nv_set(ctx, VB2_NV_RECOVERY_SUBCODE, 13);
	test_slk(0, 0, "BROKEN recovery");
	TEST_TRUE(commit_data_called, "  commit data");

	/* Boot manual recovery */
	reset_common_data();
	sd->recovery_reason = VB2_RECOVERY_RO_MANUAL;
	vb2_nv_set(ctx, VB2_NV_RECOVERY_SUBCODE, 13);
	sd->flags |= VB2_SD_FLAG_MANUAL_RECOVERY;
	test_slk(0, 0, "Manual recovery");
	TEST_TRUE(commit_data_called, "  commit data");
}

int main(void)
{
	select_and_load_kernel_tests();

	return gTestSuccess ? 0 : 255;
}
