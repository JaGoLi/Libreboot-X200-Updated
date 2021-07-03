/* Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Misc functions which need access to vb2_context but are not public APIs
 */

#ifndef VBOOT_REFERENCE_2MISC_H_
#define VBOOT_REFERENCE_2MISC_H_

#include "2api.h"
#include "2struct.h"

struct vb2_gbb_header;
struct vb2_workbuf;

#define vb2_container_of(ptr, type, member) ({                     \
	const typeof(((type *)0)->member) *__mptr = (ptr);         \
	(type *)((uint8_t *)__mptr - offsetof(type, member) );})   \

/**
 * Get the shared data pointer from the vboot context
 *
 * @param ctx		Vboot context
 * @return The shared data pointer.
 */
static inline struct vb2_shared_data *vb2_get_sd(struct vb2_context *ctx)
{
	return vb2_container_of(ctx, struct vb2_shared_data, ctx);
}

/**
 * Get the GBB header pointer from a vboot context's shared data
 *
 * @param ctx		Vboot context
 * @return The GBB header pointer.
 */
struct vb2_gbb_header *vb2_get_gbb(struct vb2_context *ctx);

/**
 * Validate gbb signature (the magic number)
 *
 * @param sig		Pointer to the signature bytes to validate
 * @return VB2_SUCCESS if valid or non-zero if error.
 */
vb2_error_t vb2_validate_gbb_signature(uint8_t *sig);

/**
 * Initialize a work buffer from the vboot context.
 *
 * This sets the work buffer to the unused portion of the context work buffer.
 *
 * @param ctx		Vboot context
 * @param wb		Work buffer to initialize
 */
void vb2_workbuf_from_ctx(struct vb2_context *ctx, struct vb2_workbuf *wb);

/**
 * Set the amount of work buffer used in the vboot context.
 *
 * This will round up to VB2_WORKBUF_ALIGN, so that the next allocation will
 * be aligned as expected.
 *
 * @param ctx		Vboot context
 * @param used		Number of bytes used
 */
void vb2_set_workbuf_used(struct vb2_context *ctx, uint32_t used);

/**
 * Read the GBB header.
 *
 * @param ctx		Vboot context
 * @param gbb		Destination for header
 * @return VB2_SUCCESS, or non-zero if error.
 */
vb2_error_t vb2_read_gbb_header(struct vb2_context *ctx,
				struct vb2_gbb_header *gbb);

/**
 * Check for recovery reasons we can determine early in the boot process.
 *
 * On exit, check ctx->flags for VB2_CONTEXT_RECOVERY_MODE; if present, jump to
 * the recovery path instead of continuing with normal boot.  This is the only
 * direct path to recovery mode.  All other errors later in the boot process
 * should induce a reboot instead of jumping to recovery, so that recovery mode
 * starts from a consistent firmware state.
 *
 * @param ctx		Vboot context
 */
void vb2_check_recovery(struct vb2_context *ctx);

/**
 * Parse the GBB header.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_fw_init_gbb(struct vb2_context *ctx);

/**
 * Check developer switch position.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_check_dev_switch(struct vb2_context *ctx);

/**
 * Check if we need to clear the TPM owner.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_check_tpm_clear(struct vb2_context *ctx);

/**
 * Decide which firmware slot to try this boot.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_select_fw_slot(struct vb2_context *ctx);

/**
 * Verify the firmware keyblock using the root key.
 *
 * After this call, the data key is stored in the work buffer.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_load_fw_keyblock(struct vb2_context *ctx);

/**
 * Verify the firmware preamble using the data subkey from the keyblock.
 *
 * After this call, the preamble is stored in the work buffer.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_load_fw_preamble(struct vb2_context *ctx);

/**
 * Verify the kernel keyblock using the previously-loaded kernel key.
 *
 * After this call, the data key is stored in the work buffer.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_load_kernel_keyblock(struct vb2_context *ctx);

/**
 * Verify the kernel preamble using the data subkey from the keyblock.
 *
 * After this call, the preamble is stored in the work buffer.
 *
 * @param ctx		Vboot context
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_load_kernel_preamble(struct vb2_context *ctx);

/**
 * Utility function to enable developer mode.
 *
 * Enables the developer flag in vb2_context firmware secdata.  Note that
 * modified secdata must be saved for change to apply on reboot.
 *
 * NOTE: Doesn't update the LAST_BOOT_DEVELOPER secdata flag.  That should be
 * done on the next boot.
 *
 * @param ctx		Vboot context
 */
void vb2_enable_developer_mode(struct vb2_context *ctx);

/**
 * Check whether recovery is allowed or not.
 *
 * The only way to pass this check and proceed to the recovery process is to
 * physically request a recovery (a.k.a. manual recovery).  All other recovery
 * requests including manual recovery requested by a (compromised) host will
 * end up with 'broken' screen.
 *
 * @param ctx		Vboot context
 * @return 1 if recovery is allowed; 0 if no or uncertain.
 */
int vb2_allow_recovery(struct vb2_context *ctx);

/**
 * Clear recovery request appropriately.
 *
 * To avoid the recovery request "sticking" and the user being in a permanent
 * recovery loop, the recovery request must be cleared and committed to nvdata.
 * Note that this should be done at some point after we are certain the system
 * does not require any reboots for non-vboot-related reasons (e.g. FSP
 * initialization), and before triggering a reboot to exit a transient recovery
 * mode (e.g. memory retraining request).
 *
 * In BROKEN cases, the recovery reason will be stowed away as subcode, to be
 * retrieved after the user reboots in manual recovery.  In manual recovery,
 * subcode will be left alone to keep available for subsequent manual recovery
 * requests, or for accessing from userspace on the next boot.
 *
 * This function modifies nvdata in vb2_context, but the caller is still
 * expected to call vb2_commit_data.
 *
 * @param ctx		Vboot context
 */
void vb2_clear_recovery(struct vb2_context *ctx);

/**
 * Determine if developer mode is allowed.
 *
 * Developer boot is not allowed if and only if FWMP_DEV_DISABLE_BOOT is set and
 * GBB_FORCE_DEV_SWITCH_ON is not set.
 *
 * @param ctx		Vboot context
 * @return 1 if allowed, or 0 otherwise.
 */
int vb2_dev_boot_allowed(struct vb2_context *ctx);

/**
 * Determine if booting from legacy BIOS is allowed.
 *
 * Legacy BIOS is allowed if any of these flags are set:
 * VB2_NV_DEV_BOOT_ALTFW, VB2_GBB_FLAG_FORCE_DEV_BOOT_ALTFW, and
 * VB2_SECDATA_FWMP_DEV_ENABLE_ALTFW.
 *
 * @param ctx		Vboot context
 * @return 1 if allowed, or 0 otherwise.
 */
int vb2_dev_boot_altfw_allowed(struct vb2_context *ctx);

/**
 * Determine if booting from external disk is allowed.
 *
 * Booting from external disk is allowed if any of these flags are set:
 * VB2_NV_DEV_BOOT_EXTERNAL, VB2_GBB_FLAG_FORCE_DEV_BOOT_USB, and
 * VB2_SECDATA_FWMP_DEV_ENABLE_EXTERNAL.
 *
 * @param ctx		Vboot context
 * @return 1 if allowed, or 0 otherwise.
 */
int vb2_dev_boot_external_allowed(struct vb2_context *ctx);

#endif  /* VBOOT_REFERENCE_2MISC_H_ */
