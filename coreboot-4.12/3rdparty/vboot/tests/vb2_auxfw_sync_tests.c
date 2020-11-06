/* Copyright 2019 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Tests for auxfw synchronization.
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2sysincludes.h"
#include "host_common.h"
#include "load_kernel_fw.h"
#include "test_common.h"
#include "vboot_audio.h"
#include "vboot_display.h"
#include "vboot_kernel.h"
#include "vboot_struct.h"

/* Mock data */
static struct vb2_context *ctx;
static uint8_t workbuf[VB2_KERNEL_WORKBUF_RECOMMENDED_SIZE]
	__attribute__((aligned(VB2_WORKBUF_ALIGN)));
static struct vb2_shared_data *sd;
static struct vb2_gbb_header gbb;

static vb2_error_t auxfw_retval;
static int auxfw_update_req;
static enum vb2_auxfw_update_severity auxfw_mock_severity;
static enum vb2_auxfw_update_severity auxfw_update_severity;
static int auxfw_mock_display_available;
static int auxfw_protected;
static vb2_error_t auxfw_done_retval;

/* Reset mock data (for use before each test) */
static void ResetMocks(void)
{
	TEST_SUCC(vb2api_init(workbuf, sizeof(workbuf), &ctx),
		  "vb2api_init failed");

	ctx->flags = VB2_CONTEXT_EC_SYNC_SUPPORTED;
	vb2_nv_init(ctx);

	sd = vb2_get_sd(ctx);

	memset(&gbb, 0, sizeof(gbb));

	auxfw_retval = VB2_SUCCESS;
	auxfw_mock_severity = VB_AUX_FW_NO_UPDATE;
	auxfw_update_severity = VB_AUX_FW_NO_UPDATE;
	auxfw_mock_display_available = 1;
	auxfw_update_req = 0;
	auxfw_protected = 0;
	auxfw_done_retval = VB2_SUCCESS;
}

/* Mock functions */
struct vb2_gbb_header *vb2_get_gbb(struct vb2_context *c)
{
	return &gbb;
}

vb2_error_t vb2ex_auxfw_check(enum vb2_auxfw_update_severity *severity)
{
	*severity = auxfw_mock_severity;
	auxfw_update_severity = auxfw_mock_severity;
	if (*severity == VB_AUX_FW_SLOW_UPDATE)
		if (!auxfw_mock_display_available)
			return VB2_REQUEST_REBOOT;
	return VB2_SUCCESS;
}

vb2_error_t vb2ex_auxfw_update(void)
{
	if (auxfw_update_severity != VB_AUX_FW_NO_DEVICE &&
	    auxfw_update_severity != VB_AUX_FW_NO_UPDATE)
		auxfw_update_req = 1;
	return auxfw_retval;
}

vb2_error_t vb2ex_auxfw_finalize(struct vb2_context *c)
{
	auxfw_protected = auxfw_update_severity != VB_AUX_FW_NO_DEVICE;
	return auxfw_done_retval;
}

static void test_auxsync(vb2_error_t retval, int recovery_reason,
			 const char *desc)
{
	TEST_EQ(vb2api_auxfw_sync(ctx), retval, desc);
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST),
		recovery_reason, "  recovery reason");
}

/* Tests */

static void VbSoftwareSyncTest(void)
{
	ResetMocks();
	gbb.flags |= VB2_GBB_FLAG_DISABLE_EC_SOFTWARE_SYNC;
	auxfw_mock_severity = VB_AUX_FW_FAST_UPDATE;
	test_auxsync(VB2_REQUEST_REBOOT_EC_TO_RO, 0,
		     "VB2_GBB_FLAG_DISABLE_EC_SOFTWARE_SYNC"
		     " does not disable auxiliary FW update request");
	TEST_EQ(auxfw_update_req, 1, "  aux fw update requested");
	TEST_EQ(auxfw_protected, 0, "  aux fw protected");

	ResetMocks();
	gbb.flags |= VB2_GBB_FLAG_DISABLE_AUXFW_SOFTWARE_SYNC;
	auxfw_mock_severity = VB_AUX_FW_FAST_UPDATE;
	test_auxsync(VB2_SUCCESS, 0,
		     "VB2_GBB_FLAG_DISABLE_AUXFW_SOFTWARE_SYNC"
		     " disables auxiliary FW update request");
	TEST_EQ(auxfw_update_req, 0, "  aux fw update disabled");
	TEST_EQ(auxfw_protected, 1, "  aux fw protected");

	ResetMocks();
	auxfw_mock_severity = VB_AUX_FW_NO_DEVICE;
	test_auxsync(VB2_SUCCESS, 0,
		     "No auxiliary FW update needed");
	TEST_EQ(auxfw_update_req, 0, "  no aux fw update requested");
	TEST_EQ(auxfw_protected, 0, "  no aux fw protected");

	ResetMocks();
	auxfw_mock_severity = VB_AUX_FW_NO_UPDATE;
	test_auxsync(VB2_SUCCESS, 0,
		"No auxiliary FW update needed");
	TEST_EQ(auxfw_update_req, 0, "  no aux fw update requested");
	TEST_EQ(auxfw_protected, 1, "  aux fw protected");

	ResetMocks();
	auxfw_mock_severity = VB_AUX_FW_FAST_UPDATE;
	test_auxsync(VB2_REQUEST_REBOOT_EC_TO_RO, 0,
		     "Fast auxiliary FW update needed");
	TEST_EQ(auxfw_update_req, 1, "  aux fw update requested");
	TEST_EQ(auxfw_protected, 0, "  aux fw protected");

	ResetMocks();
	auxfw_mock_severity = VB_AUX_FW_SLOW_UPDATE;
	auxfw_mock_display_available = 0;
	test_auxsync(VB2_REQUEST_REBOOT, 0,
		     "Slow auxiliary FW update needed - reboot for display");

	ResetMocks();
	auxfw_mock_severity = VB_AUX_FW_SLOW_UPDATE;
	test_auxsync(VB2_REQUEST_REBOOT_EC_TO_RO, 0,
		     "Slow auxiliary FW update needed");
	TEST_EQ(auxfw_update_req, 1, "  aux fw update requested");
	TEST_EQ(auxfw_protected, 0, "  aux fw protected");

	ResetMocks();
	auxfw_mock_severity = VB_AUX_FW_FAST_UPDATE;
	auxfw_retval = VB2_ERROR_UNKNOWN;
	test_auxsync(VB2_ERROR_UNKNOWN, VB2_RECOVERY_AUX_FW_UPDATE,
		     "Error updating AUX firmware");
}

int main(void)
{
	VbSoftwareSyncTest();

	return gTestSuccess ? 0 : 255;
}
