/* Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Common functions between firmware and kernel verified boot.
 */

#ifndef VBOOT_REFERENCE_VB2_COMMON_H_
#define VBOOT_REFERENCE_VB2_COMMON_H_

#include "2api.h"
#include "2common.h"
#include "2return_codes.h"
#include "2sha.h"
#include "2struct.h"
#include "2sysincludes.h"

struct vb2_public_key;

/**
 * Verify a keyblock using its hash.
 *
 * Header fields are also checked for validity. Does not verify key index or key
 * block flags.  Use this for self-signed keyblocks in developer mode.
 *
 * @param block		Keyblock to verify
 * @param size		Size of keyblock buffer
 * @param key		Key to use to verify block
 * @param wb		Work buffer
 * @return VB2_SUCCESS, or non-zero error code if error.
 */
vb2_error_t vb2_verify_keyblock_hash(const struct vb2_keyblock *block,
				     uint32_t size,
				     const struct vb2_workbuf *wb);

/**
 * Check the validity of a kernel preamble using a public key.
 *
 * The signature in the preamble is destroyed during the check.
 *
 * @param preamble     	Preamble to verify
 * @param size		Size of preamble buffer
 * @param key		Key to use to verify preamble
 * @param wb		Work buffer
 * @return VB2_SUCCESS, or non-zero error code if error.
 */
vb2_error_t vb2_verify_kernel_preamble(struct vb2_kernel_preamble *preamble,
				       uint32_t size,
				       const struct vb2_public_key *key,
				       const struct vb2_workbuf *wb);

/**
 * Retrieve the 16-bit vmlinuz header address and size from the preamble.
 *
 * Size 0 means there is no 16-bit vmlinuz header present.  Old preamble
 * versions (<2.1) return 0 for both fields.
 *
 * @param preamble	Preamble to check
 * @param vmlinuz_header_address	Destination for header address
 * @param vmlinuz_header_size		Destination for header size
 */
void vb2_kernel_get_vmlinuz_header(const struct vb2_kernel_preamble *preamble,
				   uint64_t *vmlinuz_header_address,
				   uint32_t *vmlinuz_header_size);

/**
 * Get the flags for the kernel preamble.
 *
 * @param preamble	Preamble to check
 * @return Flags for the preamble.  Old preamble versions (<2.2) return 0.
 */
uint32_t vb2_kernel_get_flags(const struct vb2_kernel_preamble *preamble);

#endif  /* VBOOT_REFERENCE_VB2_COMMON_H_ */
