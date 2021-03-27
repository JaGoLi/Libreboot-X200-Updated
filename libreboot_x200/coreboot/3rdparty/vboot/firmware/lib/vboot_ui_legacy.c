/* Copyright 2018 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * High-level firmware wrapper API - user interface for RW firmware
 */

#include "2api.h"
#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2sysincludes.h"
#include "vboot_api.h"
#include "vboot_kernel.h"
#include "vboot_test.h"
#include "vboot_ui_legacy.h"

const char dev_disable_msg[] =
	"Developer mode is disabled on this device by system policy.\n"
	"For more information, see http://dev.chromium.org/chromium-os/fwmp\n"
	"\n";

static void Uint8ToString(char *buf, uint8_t val)
{
	const char *trans = "0123456789abcdef";
	*buf++ = trans[val >> 4];
	*buf = trans[val & 0xF];
}

static void FillInSha1Sum(char *outbuf, struct vb2_packed_key *key)
{
	uint8_t *buf = ((uint8_t *)key) + key->key_offset;
	uint64_t buflen = key->key_size;
	uint8_t digest[VB2_SHA1_DIGEST_SIZE];
	int i;

	vb2_digest_buffer(buf, buflen, VB2_HASH_SHA1, digest, sizeof(digest));
	for (i = 0; i < sizeof(digest); i++) {
		Uint8ToString(outbuf, digest[i]);
		outbuf += 2;
	}
	*outbuf = '\0';
}

#define DEBUG_INFO_SIZE 1024
#define DEBUG_INFO_APPEND(format, args...) do { \
	if (used < DEBUG_INFO_SIZE) \
		used += snprintf(buf + used, DEBUG_INFO_SIZE - used, format, \
				 ## args); \
} while (0)

vb2_error_t VbDisplayDebugInfo(struct vb2_context *ctx)
{
	struct vb2_shared_data *sd = vb2_get_sd(ctx);
	struct vb2_gbb_header *gbb = vb2_get_gbb(ctx);
	struct vb2_workbuf wb;
	char buf[DEBUG_INFO_SIZE] = "";
	char sha1sum[VB2_SHA1_DIGEST_SIZE * 2 + 1];
	int32_t used = 0;
	vb2_error_t ret;
	uint32_t i;

	vb2_workbuf_from_ctx(ctx, &wb);

	/* Add hardware ID */
	{
		char hwid[VB2_GBB_HWID_MAX_SIZE];
		uint32_t size = sizeof(hwid);
		ret = vb2api_gbb_read_hwid(ctx, hwid, &size);
		if (ret)
			strcpy(hwid, "{INVALID}");
		DEBUG_INFO_APPEND("HWID: %s", hwid);
	}

	/* Add recovery reason and subcode */
	i = vb2_nv_get(ctx, VB2_NV_RECOVERY_SUBCODE);
	DEBUG_INFO_APPEND("\nrecovery_reason: %#.2x / %#.2x  %s",
			  sd->recovery_reason, i,
			  vb2_get_recovery_reason_string(sd->recovery_reason));

	/* Add vb2_context and vb2_shared_data flags */
	DEBUG_INFO_APPEND("\ncontext.flags: %#.16" PRIx64, ctx->flags);
	DEBUG_INFO_APPEND("\nshared_data.flags: %#.8x", sd->flags);
	DEBUG_INFO_APPEND("\nshared_data.status: %#.8x", sd->status);

	/* Add raw contents of nvdata */
	DEBUG_INFO_APPEND("\nnvdata:");
	if (vb2_nv_get_size(ctx) > 16)  /* Multi-line starts on next line */
		DEBUG_INFO_APPEND("\n  ");
	for (i = 0; i < vb2_nv_get_size(ctx); i++) {
		/* Split into 16-byte blocks */
		if (i > 0 && i % 16 == 0)
			DEBUG_INFO_APPEND("\n  ");
		DEBUG_INFO_APPEND(" %02x", ctx->nvdata[i]);
	}

	/* Add dev_boot_usb flag */
	i = vb2_nv_get(ctx, VB2_NV_DEV_BOOT_EXTERNAL);
	DEBUG_INFO_APPEND("\ndev_boot_usb: %d", i);

	/* Add dev_boot_legacy flag */
	i = vb2_nv_get(ctx, VB2_NV_DEV_BOOT_LEGACY);
	DEBUG_INFO_APPEND("\ndev_boot_legacy: %d", i);

	/* Add dev_default_boot flag */
	i = vb2_nv_get(ctx, VB2_NV_DEV_DEFAULT_BOOT);
	DEBUG_INFO_APPEND("\ndev_default_boot: %d", i);

	/* Add dev_boot_signed_only flag */
	i = vb2_nv_get(ctx, VB2_NV_DEV_BOOT_SIGNED_ONLY);
	DEBUG_INFO_APPEND("\ndev_boot_signed_only: %d", i);

	/* Add TPM versions */
	DEBUG_INFO_APPEND("\nTPM: fwver=%#.8x kernver=%#.8x",
			  sd->fw_version_secdata, sd->kernel_version_secdata);

	/* Add GBB flags */
	DEBUG_INFO_APPEND("\ngbb.flags: %#.8x", gbb->flags);

	/* Add sha1sum for Root & Recovery keys */
	{
		struct vb2_packed_key *key;
		struct vb2_workbuf wblocal = wb;
		ret = vb2_gbb_read_root_key(ctx, &key, NULL, &wblocal);
		if (!ret) {
			FillInSha1Sum(sha1sum, key);
			DEBUG_INFO_APPEND("\ngbb.rootkey: %s", sha1sum);
		}
	}

	{
		struct vb2_packed_key *key;
		struct vb2_workbuf wblocal = wb;
		ret = vb2_gbb_read_recovery_key(ctx, &key, NULL, &wblocal);
		if (!ret) {
			FillInSha1Sum(sha1sum, key);
			DEBUG_INFO_APPEND("\ngbb.recovery_key: %s", sha1sum);
		}
	}

	/* If we're in dev-mode, show the kernel subkey that we expect, too. */
	if (!(ctx->flags & VB2_CONTEXT_RECOVERY_MODE) &&
	    sd->kernel_key_offset) {
		struct vb2_packed_key *key =
			vb2_member_of(sd, sd->kernel_key_offset);
		FillInSha1Sum(sha1sum, key);
		DEBUG_INFO_APPEND("\nkernel_subkey: %s", sha1sum);
	}

	/* Make sure we finish with a newline */
	DEBUG_INFO_APPEND("\n");

	/* TODO: add more interesting data:
	 * - Information on current disks */

	buf[DEBUG_INFO_SIZE - 1] = '\0';
	VB2_DEBUG("[TAB] Debug Info:\n%s", buf);
	return VbExDisplayDebugInfo(buf, 1);
}

vb2_error_t VbCheckDisplayKey(struct vb2_context *ctx, uint32_t key,
			      uint32_t screen, const VbScreenData *data)
{
	uint32_t loc = 0;
	uint32_t count = 0;

	switch (key) {
	case '\t':
		/* Tab = display debug info */
		return VbDisplayDebugInfo(ctx);
	case VB_KEY_ESC:
		/* Force redraw current screen (to clear Tab debug output) */
		return VbDisplayScreen(ctx, screen, 1, data);
	case VB_KEY_LEFT:
	case VB_KEY_RIGHT:
	case VB_KEY_UP:
	case VB_KEY_DOWN:
		/* Arrow keys = change localization */
		loc = vb2_nv_get(ctx, VB2_NV_LOCALIZATION_INDEX);
		count = vb2ex_get_locale_count();
		if (count == 0)
			loc = 0;  /* No localization count (bad GBB?) */
		else if (VB_KEY_RIGHT == key || VB_KEY_UP == key)
			loc = (loc < count - 1 ? loc + 1 : 0);
		else
			loc = (loc > 0 ? loc - 1 : count - 1);
		VB2_DEBUG("VbCheckDisplayKey() - change localization to %d\n",
			  (int)loc);
		vb2_nv_set(ctx, VB2_NV_LOCALIZATION_INDEX, loc);
		vb2_nv_set(ctx, VB2_NV_BACKUP_NVRAM_REQUEST, 1);

		/*
		 * Non-manual recovery mode is meant to be left via three-finger
		 * salute (into manual recovery mode). Need to commit nvdata
		 * changes immediately.  Ignore commit errors in recovery mode.
		 */
		if ((ctx->flags & VB2_CONTEXT_RECOVERY_MODE) &&
		    !vb2_allow_recovery(ctx))
			 vb2ex_commit_data(ctx);

		/* Force redraw of current screen */
		return VbDisplayScreen(ctx, screen, 1, data);
	}

	return VB2_SUCCESS;
}

static enum {
	POWER_BUTTON_HELD_SINCE_BOOT = 0,
	POWER_BUTTON_RELEASED,
	POWER_BUTTON_PRESSED,  /* Must have been previously released */
} power_button_state;

void vb2_reset_power_button(void) {
	power_button_state = POWER_BUTTON_HELD_SINCE_BOOT;
}

void vb2_error_beep(enum vb2_beep_type beep)
{
	switch (beep) {
	case VB_BEEP_FAILED:
		vb2ex_beep(250, 200);
		break;
	default:
	case VB_BEEP_NOT_ALLOWED:
		vb2ex_beep(120, 400);
		vb2ex_msleep(120);
		vb2ex_beep(120, 400);
		break;
	}
}

void vb2_error_notify(const char *print_msg,
		      const char *log_msg,
		      enum vb2_beep_type beep)
{
	if (print_msg)
		VbExDisplayDebugInfo(print_msg, 0);
	if (!log_msg)
		log_msg = print_msg;
	if (log_msg)
		VB2_DEBUG(log_msg);
	vb2_error_beep(beep);
}

void vb2_error_no_altfw(void)
{
	VB2_DEBUG("Legacy boot is disabled\n");
	VbExDisplayDebugInfo("WARNING: Booting legacy BIOS has not been "
			     "enabled. Refer to the developer-mode "
			     "documentation for details.\n", 0);
	vb2_error_beep(VB_BEEP_NOT_ALLOWED);
}

void vb2_try_altfw(struct vb2_context *ctx, int allowed,
		   enum VbAltFwIndex_t altfw_num)
{
	if (!allowed) {
		vb2_error_no_altfw();
		return;
	}

	if (vb2ex_commit_data(ctx)) {
		vb2_error_notify("Error committing data on legacy boot.\n",
				 NULL, VB_BEEP_FAILED);
		return;
	}

	/* Will not return if successful */
	VbExLegacy(altfw_num);

	vb2_error_notify("Legacy boot failed. Missing BIOS?\n", NULL,
			 VB_BEEP_FAILED);
}

int vb2_want_shutdown(struct vb2_context *ctx, uint32_t key)
{
	struct vb2_gbb_header *gbb = vb2_get_gbb(ctx);
	uint32_t shutdown_request = VbExIsShutdownRequested();

	/*
	 * Ignore power button push until after we have seen it released.
	 * This avoids shutting down immediately if the power button is still
	 * being held on startup. After we've recognized a valid power button
	 * push then don't report the event until after the button is released.
	 */
	if (shutdown_request & VB_SHUTDOWN_REQUEST_POWER_BUTTON) {
		shutdown_request &= ~VB_SHUTDOWN_REQUEST_POWER_BUTTON;
		if (power_button_state == POWER_BUTTON_RELEASED)
			power_button_state = POWER_BUTTON_PRESSED;
	} else {
		if (power_button_state == POWER_BUTTON_PRESSED)
			shutdown_request |= VB_SHUTDOWN_REQUEST_POWER_BUTTON;
		power_button_state = POWER_BUTTON_RELEASED;
	}

	if (key == VB_BUTTON_POWER_SHORT_PRESS)
		shutdown_request |= VB_SHUTDOWN_REQUEST_POWER_BUTTON;

	/* If desired, ignore shutdown request due to lid closure. */
	if (gbb->flags & VB2_GBB_FLAG_DISABLE_LID_SHUTDOWN)
		shutdown_request &= ~VB_SHUTDOWN_REQUEST_LID_CLOSED;

	return shutdown_request;
}
