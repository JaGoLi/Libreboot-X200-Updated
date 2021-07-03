/* Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Common functions between firmware and kernel verified boot.
 * (Firmware portion)
 */

#include "2common.h"
#include "2rsa.h"
#include "2sha.h"
#include "2sysincludes.h"

vb2_error_t vb2_safe_memcmp(const void *s1, const void *s2, size_t size)
{
	const unsigned char *us1 = s1;
	const unsigned char *us2 = s2;
	int result = 0;

	if (0 == size)
		return 0;

	/*
	 * Code snippet without data-dependent branch due to Nate Lawson
	 * (nate@root.org) of Root Labs.
	 */
	while (size--)
		result |= *us1++ ^ *us2++;

	return result != 0;
}

vb2_error_t vb2_align(uint8_t **ptr, uint32_t *size, uint32_t align,
		      uint32_t want_size)
{
	uintptr_t p = (uintptr_t)*ptr;
	uintptr_t offs = p & (align - 1);

	if (offs) {
		offs = align - offs;

		if (*size < offs)
			return VB2_ERROR_ALIGN_BIGGER_THAN_SIZE;

		*ptr += offs;
		*size -= offs;
	}

	if (*size < want_size)
		return VB2_ERROR_ALIGN_SIZE;

	return VB2_SUCCESS;
}

void vb2_workbuf_init(struct vb2_workbuf *wb, uint8_t *buf, uint32_t size)
{
	wb->buf = buf;
	wb->size = size;

	/* Align the buffer so allocations will be aligned */
	if (vb2_align(&wb->buf, &wb->size, VB2_WORKBUF_ALIGN, 0))
		wb->size = 0;
}

void *vb2_workbuf_alloc(struct vb2_workbuf *wb, uint32_t size)
{
	uint8_t *ptr = wb->buf;

	/* Round up size to work buffer alignment */
	size = vb2_wb_round_up(size);

	if (size > wb->size)
		return NULL;

	wb->buf += size;
	wb->size -= size;

	return ptr;
}

void *vb2_workbuf_realloc(struct vb2_workbuf *wb, uint32_t oldsize,
			  uint32_t newsize)
{
	/*
	 * Just free and allocate to update the size.  No need to move/copy
	 * memory, since the new pointer is guaranteed to be the same as the
	 * old one.  The new allocation can fail, if the new size is too big.
	 */
	vb2_workbuf_free(wb, oldsize);
	return vb2_workbuf_alloc(wb, newsize);
}

void vb2_workbuf_free(struct vb2_workbuf *wb, uint32_t size)
{
	/* Round up size to work buffer alignment */
	size = vb2_wb_round_up(size);

	wb->buf -= size;
	wb->size += size;
}

ptrdiff_t vb2_offset_of(const void *base, const void *ptr)
{
	return (uintptr_t)ptr - (uintptr_t)base;
}

void *vb2_member_of(void *parent, ptrdiff_t offset)
{
	/* TODO(kitching): vb2_assert(parent && offset) */
	return parent + offset;
}

vb2_error_t vb2_verify_member_inside(const void *parent, size_t parent_size,
				     const void *member, size_t member_size,
				     ptrdiff_t member_data_offset,
				     size_t member_data_size)
{
	const uintptr_t parent_end = (uintptr_t)parent + parent_size;
	const ptrdiff_t member_offs = vb2_offset_of(parent, member);
	const ptrdiff_t member_end_offs = member_offs + member_size;
	const ptrdiff_t data_offs = member_offs + member_data_offset;
	const ptrdiff_t data_end_offs = data_offs + member_data_size;

	/* Make sure parent doesn't wrap */
	if (parent_end < (uintptr_t)parent)
		return VB2_ERROR_INSIDE_PARENT_WRAPS;

	/*
	 * Make sure the member is fully contained in the parent and doesn't
	 * wrap.  Use >, not >=, since member_size = 0 is possible.
	 */
	if (member_end_offs < member_offs)
		return VB2_ERROR_INSIDE_MEMBER_WRAPS;
	if (member_offs < 0 || member_offs > parent_size ||
	    member_end_offs > parent_size)
		return VB2_ERROR_INSIDE_MEMBER_OUTSIDE;

	/* Make sure the member data is after the member */
	if (member_data_size > 0 && data_offs < member_end_offs)
		return VB2_ERROR_INSIDE_DATA_OVERLAP;

	/* Make sure parent fully contains member data, if any */
	if (data_end_offs < data_offs)
		return VB2_ERROR_INSIDE_DATA_WRAPS;
	if (data_offs < 0 || data_offs > parent_size ||
	    data_end_offs > parent_size)
		return VB2_ERROR_INSIDE_DATA_OUTSIDE;

	return VB2_SUCCESS;
}

vb2_error_t vb2_verify_digest(const struct vb2_public_key *key,
			      struct vb2_signature *sig, const uint8_t *digest,
			      const struct vb2_workbuf *wb)
{
	/* A signature is destroyed in the process of being verified. */
	uint8_t *sig_data = vb2_signature_data_mutable(sig);

	if (sig->sig_size != vb2_rsa_sig_size(key->sig_alg)) {
		VB2_DEBUG("Wrong data signature size for algorithm, "
			  "sig_size=%d, expected %d for algorithm %d.\n",
			  sig->sig_size, vb2_rsa_sig_size(key->sig_alg),
			  key->sig_alg);
		return VB2_ERROR_VDATA_SIG_SIZE;
	}

	if (key->allow_hwcrypto) {
		vb2_error_t rv =
			vb2ex_hwcrypto_rsa_verify_digest(key, sig_data, digest);

		if (rv != VB2_ERROR_EX_HWCRYPTO_UNSUPPORTED) {
			VB2_DEBUG("Using HW RSA engine for sig_alg %d %s\n",
					key->sig_alg,
					rv ? "failed" : "succeeded");
			return rv;
		}

		VB2_DEBUG("HW RSA for sig_alg %d not supported, using SW\n",
			  key->sig_alg);
	} else {
		VB2_DEBUG("HW RSA forbidden, using SW\n");
	}

	return vb2_rsa_verify_digest(key, sig_data, digest, wb);
}

vb2_error_t vb2_verify_data(const uint8_t *data, uint32_t size,
			    struct vb2_signature *sig,
			    const struct vb2_public_key *key,
			    const struct vb2_workbuf *wb)
{
	struct vb2_workbuf wblocal = *wb;
	uint8_t *digest;
	uint32_t digest_size;
	vb2_error_t rv;

	if (sig->data_size > size) {
		VB2_DEBUG("Data buffer smaller than length of signed data.\n");
		return VB2_ERROR_VDATA_NOT_ENOUGH_DATA;
	}

	/* Digest goes at start of work buffer */
	digest_size = vb2_digest_size(key->hash_alg);
	if (!digest_size)
		return VB2_ERROR_VDATA_DIGEST_SIZE;

	digest = vb2_workbuf_alloc(&wblocal, digest_size);
	if (!digest)
		return VB2_ERROR_VDATA_WORKBUF_DIGEST;

	if (key->allow_hwcrypto) {
		rv = vb2ex_hwcrypto_digest_init(key->hash_alg, sig->data_size);
		if (rv == VB2_SUCCESS) {
			VB2_DEBUG("Using HW crypto engine for hash_alg %d\n", key->hash_alg);
			VB2_TRY(vb2ex_hwcrypto_digest_extend(data, sig->data_size));
			VB2_TRY(vb2ex_hwcrypto_digest_finalize(digest, digest_size));
		} else if (rv == VB2_ERROR_EX_HWCRYPTO_UNSUPPORTED) {
			VB2_DEBUG("HW crypto for hash_alg %d not supported, using SW\n",
				  key->hash_alg);
			VB2_TRY(vb2_digest_buffer(data, sig->data_size, key->hash_alg,
						  digest, digest_size));
		} else {
			VB2_DEBUG("HW crypto init error : %d\n", rv);
			return rv;
		}
	} else {
		VB2_DEBUG("HW crypto forbidden by TPM flag, using SW\n");
		VB2_TRY(vb2_digest_buffer(data, sig->data_size, key->hash_alg,
					  digest, digest_size));
	}

	return vb2_verify_digest(key, sig, digest, &wblocal);
}

vb2_error_t vb2_check_keyblock(const struct vb2_keyblock *block, uint32_t size,
			       const struct vb2_signature *sig)
{
	if(size < sizeof(*block)) {
		VB2_DEBUG("Not enough space for keyblock header.\n");
		return VB2_ERROR_KEYBLOCK_TOO_SMALL_FOR_HEADER;
	}

	if (memcmp(block->magic, VB2_KEYBLOCK_MAGIC, VB2_KEYBLOCK_MAGIC_SIZE)) {
		VB2_DEBUG("Not a valid verified boot keyblock.\n");
		return VB2_ERROR_KEYBLOCK_MAGIC;
	}

	if (block->header_version_major != VB2_KEYBLOCK_VERSION_MAJOR) {
		VB2_DEBUG("Incompatible keyblock header version.\n");
		return VB2_ERROR_KEYBLOCK_HEADER_VERSION;
	}

	if (size < block->keyblock_size) {
		VB2_DEBUG("Not enough data for keyblock.\n");
		return VB2_ERROR_KEYBLOCK_SIZE;
	}

	if (vb2_verify_signature_inside(block, block->keyblock_size, sig)) {
		VB2_DEBUG("Keyblock signature off end of block\n");
		return VB2_ERROR_KEYBLOCK_SIG_OUTSIDE;
	}

	/* Make sure advertised signature data sizes are valid. */
	if (block->keyblock_size < sig->data_size) {
		VB2_DEBUG("Signature calculated past end of block\n");
		return VB2_ERROR_KEYBLOCK_SIGNED_TOO_MUCH;
	}

	/* Verify we signed enough data */
	if (sig->data_size < sizeof(struct vb2_keyblock)) {
		VB2_DEBUG("Didn't sign enough data\n");
		return VB2_ERROR_KEYBLOCK_SIGNED_TOO_LITTLE;
	}

	/* Verify data key is inside the block and inside signed data */
	if (vb2_verify_packed_key_inside(block, block->keyblock_size,
					 &block->data_key)) {
		VB2_DEBUG("Data key off end of keyblock\n");
		return VB2_ERROR_KEYBLOCK_DATA_KEY_OUTSIDE;
	}
	if (vb2_verify_packed_key_inside(block, sig->data_size,
					 &block->data_key)) {
		VB2_DEBUG("Data key off end of signed data\n");
		return VB2_ERROR_KEYBLOCK_DATA_KEY_UNSIGNED;
	}

	return VB2_SUCCESS;
}

vb2_error_t vb2_verify_keyblock(struct vb2_keyblock *block, uint32_t size,
				const struct vb2_public_key *key,
				const struct vb2_workbuf *wb)
{
	struct vb2_signature *sig = &block->keyblock_signature;
	vb2_error_t rv;

	/* Validity check keyblock before attempting signature check of data */
	VB2_TRY(vb2_check_keyblock(block, size, sig));

	VB2_DEBUG("Checking keyblock signature...\n");
	rv = vb2_verify_data((const uint8_t *)block, size, sig, key, wb);
	if (rv) {
		VB2_DEBUG("Invalid keyblock signature.\n");
		return VB2_ERROR_KEYBLOCK_SIG_INVALID;
	}

	/* Success */
	return VB2_SUCCESS;
}

vb2_error_t vb2_verify_fw_preamble(struct vb2_fw_preamble *preamble,
				   uint32_t size,
				   const struct vb2_public_key *key,
				   const struct vb2_workbuf *wb)
{
	struct vb2_signature *sig = &preamble->preamble_signature;

	VB2_DEBUG("Verifying preamble.\n");

	/* Validity checks before attempting signature of data */
	if(size < sizeof(*preamble)) {
		VB2_DEBUG("Not enough data for preamble header\n");
		return VB2_ERROR_PREAMBLE_TOO_SMALL_FOR_HEADER;
	}
	if (preamble->header_version_major !=
	    VB2_FIRMWARE_PREAMBLE_HEADER_VERSION_MAJOR) {
		VB2_DEBUG("Incompatible firmware preamble header version.\n");
		return VB2_ERROR_PREAMBLE_HEADER_VERSION;
	}

	if (preamble->header_version_minor < 1) {
		VB2_DEBUG("Only preamble header 2.1+ supported\n");
		return VB2_ERROR_PREAMBLE_HEADER_OLD;
	}

	if (size < preamble->preamble_size) {
		VB2_DEBUG("Not enough data for preamble.\n");
		return VB2_ERROR_PREAMBLE_SIZE;
	}

	/* Check signature */
	if (vb2_verify_signature_inside(preamble, preamble->preamble_size,
					sig)) {
		VB2_DEBUG("Preamble signature off end of preamble\n");
		return VB2_ERROR_PREAMBLE_SIG_OUTSIDE;
	}

	/* Make sure advertised signature data sizes are valid. */
	if (preamble->preamble_size < sig->data_size) {
		VB2_DEBUG("Signature calculated past end of the block\n");
		return VB2_ERROR_PREAMBLE_SIGNED_TOO_MUCH;
	}

	if (vb2_verify_data((const uint8_t *)preamble, size, sig, key, wb)) {
		VB2_DEBUG("Preamble signature validation failed\n");
		return VB2_ERROR_PREAMBLE_SIG_INVALID;
	}

	/* Verify we signed enough data */
	if (sig->data_size < sizeof(struct vb2_fw_preamble)) {
		VB2_DEBUG("Didn't sign enough data\n");
		return VB2_ERROR_PREAMBLE_SIGNED_TOO_LITTLE;
	}

	/* Verify body signature is inside the signed data */
	if (vb2_verify_signature_inside(preamble, sig->data_size,
					&preamble->body_signature)) {
		VB2_DEBUG("Firmware body signature off end of preamble\n");
		return VB2_ERROR_PREAMBLE_BODY_SIG_OUTSIDE;
	}

	/* Verify kernel subkey is inside the signed data */
	if (vb2_verify_packed_key_inside(preamble, sig->data_size,
					 &preamble->kernel_subkey)) {
		VB2_DEBUG("Kernel subkey off end of preamble\n");
		return VB2_ERROR_PREAMBLE_KERNEL_SUBKEY_OUTSIDE;
	}

	/* Success */
	return VB2_SUCCESS;
}
