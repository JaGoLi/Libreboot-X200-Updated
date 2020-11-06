/* Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Signature validation functions
 */

#include "2common.h"
#include "2rsa.h"
#include "2sha.h"
#include "2sysincludes.h"
#include "host_common21.h"

const char *vb21_common_desc(const void *buf)
{
	const struct vb21_struct_common *c = buf;

	return c->desc_size ? (const char *)c + c->fixed_size : "";
}

vb2_error_t vb21_verify_common_header(const void *parent, uint32_t parent_size)
{
	const struct vb21_struct_common *c = parent;

	/* Parent buffer size must be at least the claimed total size */
	if (parent_size < c->total_size)
		return VB2_ERROR_COMMON_TOTAL_SIZE;

	/*
	 * And big enough for the fixed size, which itself must be at least as
	 * big as the common struct header.
	 */
	if (c->total_size < c->fixed_size || c->fixed_size < sizeof(*c))
		return VB2_ERROR_COMMON_FIXED_SIZE;

	/* Make sure sizes are all multiples of 32 bits */
	if (!vb2_aligned(c->total_size, sizeof(uint32_t)))
		return VB2_ERROR_COMMON_TOTAL_UNALIGNED;
	if (!vb2_aligned(c->fixed_size, sizeof(uint32_t)))
		return VB2_ERROR_COMMON_FIXED_UNALIGNED;
	if (!vb2_aligned(c->desc_size, sizeof(uint32_t)))
		return VB2_ERROR_COMMON_DESC_UNALIGNED;

	/* Check description */
	if (c->desc_size > 0) {
		/* Make sure description fits and doesn't wrap */
		if (c->fixed_size + c->desc_size < c->fixed_size)
			return VB2_ERROR_COMMON_DESC_WRAPS;
		if (c->fixed_size + c->desc_size > c->total_size)
			return VB2_ERROR_COMMON_DESC_SIZE;

		/* Description must be null-terminated */
		if (vb21_common_desc(c)[c->desc_size - 1] != 0)
			return VB2_ERROR_COMMON_DESC_TERMINATOR;
	}

	return VB2_SUCCESS;
}

vb2_error_t vb21_verify_common_member(const void *parent, uint32_t *min_offset,
				      uint32_t member_offset,
				      uint32_t member_size)
{
	const struct vb21_struct_common *c = parent;
	uint32_t member_end = member_offset + member_size;

	/* Make sure member doesn't wrap */
	if (member_end < member_offset)
		return VB2_ERROR_COMMON_MEMBER_WRAPS;

	/* Member offset and size must be 32-bit aligned */
	if (!vb2_aligned(member_offset, sizeof(uint32_t)) ||
	    !vb2_aligned(member_size, sizeof(uint32_t)))
		return VB2_ERROR_COMMON_MEMBER_UNALIGNED;

	/* Initialize minimum offset if necessary */
	if (!*min_offset)
		*min_offset = c->fixed_size + c->desc_size;

	/* Member must be after minimum offset */
	if (member_offset < *min_offset)
		return VB2_ERROR_COMMON_MEMBER_OVERLAP;

	/* Member must end before total size */
	if (member_end > c->total_size)
		return VB2_ERROR_COMMON_MEMBER_SIZE;

	/* Update minimum offset for subsequent checks */
	*min_offset = member_end;

	return VB2_SUCCESS;
}

vb2_error_t vb21_verify_common_subobject(const void *parent,
					 uint32_t *min_offset,
					 uint32_t member_offset)
{
	const struct vb21_struct_common *p = parent;
	const struct vb21_struct_common *m =
		(const struct vb21_struct_common *)
		((const uint8_t *)parent + member_offset);
	vb2_error_t rv;

	/*
	 * Verify the parent has space at the member offset for the common
	 * header.
	 */
	rv = vb21_verify_common_member(parent, min_offset, member_offset,
				      sizeof(*m));
	if (rv)
		return rv;

	/*
	 * Now it's safe to look at the member's header, and verify any
	 * additional data for the object past its common header fits in the
	 * parent.
	 */
	rv = vb21_verify_common_header(m, p->total_size - member_offset);
	if (rv)
		return rv;

	/* Advance the min offset to the end of the subobject */
	*min_offset = member_offset + m->total_size;

	return VB2_SUCCESS;
}

uint32_t vb2_sig_size(enum vb2_signature_algorithm sig_alg,
		      enum vb2_hash_algorithm hash_alg)
{
	uint32_t digest_size = vb2_digest_size(hash_alg);

	/* Fail if we don't support the hash algorithm */
	if (!digest_size)
		return 0;

	/* Handle unsigned hashes */
	if (sig_alg == VB2_SIG_NONE)
		return digest_size;

	return vb2_rsa_sig_size(sig_alg);
}

const struct vb2_id *vb2_hash_id(enum vb2_hash_algorithm hash_alg)
{
	switch(hash_alg) {
#ifdef VB2_SUPPORT_SHA1
	case VB2_HASH_SHA1:
		{
			static const struct vb2_id id = VB2_ID_NONE_SHA1;
			return &id;
		}
#endif
#ifdef VB2_SUPPORT_SHA256
	case VB2_HASH_SHA256:
		{
			static const struct vb2_id id = VB2_ID_NONE_SHA256;
			return &id;
		}
#endif
#ifdef VB2_SUPPORT_SHA512
	case VB2_HASH_SHA512:
		{
			static const struct vb2_id id = VB2_ID_NONE_SHA512;
			return &id;
		}
#endif
	default:
		return NULL;
	}
}

vb2_error_t vb21_verify_signature(const struct vb21_signature *sig,
				  uint32_t size)
{
	uint32_t min_offset = 0;
	uint32_t expect_sig_size;
	vb2_error_t rv;

	/* Check magic number */
	if (sig->c.magic != VB21_MAGIC_SIGNATURE)
		return VB2_ERROR_SIG_MAGIC;

	/* Make sure common header is good */
	rv = vb21_verify_common_header(sig, size);
	if (rv)
		return rv;

	/*
	 * Check for compatible version.  No need to check minor version, since
	 * that's compatible across readers matching the major version, and we
	 * haven't added any new fields.
	 */
	if (sig->c.struct_version_major != VB21_SIGNATURE_VERSION_MAJOR)
		return VB2_ERROR_SIG_VERSION;

	/* Make sure header is big enough for signature */
	if (sig->c.fixed_size < sizeof(*sig))
		return VB2_ERROR_SIG_HEADER_SIZE;

	/* Make sure signature data is inside */
	rv = vb21_verify_common_member(sig, &min_offset,
				      sig->sig_offset, sig->sig_size);
	if (rv)
		return rv;

	/* Make sure signature size is correct for the algorithm */
	expect_sig_size = vb2_sig_size(sig->sig_alg, sig->hash_alg);
	if (!expect_sig_size)
		return VB2_ERROR_SIG_ALGORITHM;
	if (sig->sig_size != expect_sig_size)
		return VB2_ERROR_SIG_SIZE;

	return VB2_SUCCESS;
}

/**
 * Return the signature data for a signature
 */
static uint8_t *vb21_signature_data(struct vb21_signature *sig)
{
	return (uint8_t *)sig + sig->sig_offset;
}

vb2_error_t vb21_verify_digest(const struct vb2_public_key *key,
			       struct vb21_signature *sig,
			       const uint8_t *digest,
			       const struct vb2_workbuf *wb)
{
	uint32_t key_sig_size = vb2_sig_size(key->sig_alg, key->hash_alg);

	/* If we can't figure out the signature size, key algorithm was bad */
	if (!key_sig_size)
		return VB2_ERROR_VDATA_ALGORITHM;

	/* Make sure the signature and key algorithms match */
	if (key->sig_alg != sig->sig_alg || key->hash_alg != sig->hash_alg)
		return VB2_ERROR_VDATA_ALGORITHM_MISMATCH;

	if (sig->sig_size != key_sig_size)
		return VB2_ERROR_VDATA_SIG_SIZE;

	if (key->sig_alg == VB2_SIG_NONE) {
		/* Bare hash */
		if (vb2_safe_memcmp(vb21_signature_data(sig),
				    digest, key_sig_size))
			return VB2_ERROR_VDATA_VERIFY_DIGEST;

		return VB2_SUCCESS;
	} else {
		/* RSA-signed digest */
		return vb2_rsa_verify_digest(key,
					     vb21_signature_data(sig),
					     digest, wb);
	}
}

vb2_error_t vb21_verify_data(const void *data, uint32_t size,
			     struct vb21_signature *sig,
			     const struct vb2_public_key *key,
			     const struct vb2_workbuf *wb)
{
	struct vb2_workbuf wblocal = *wb;
	struct vb2_digest_context *dc;
	uint8_t *digest;
	uint32_t digest_size;
	vb2_error_t rv;

	if (sig->data_size != size) {
		VB2_DEBUG("Wrong amount of data signed.\n");
		return VB2_ERROR_VDATA_SIZE;
	}

	/* Digest goes at start of work buffer */
	digest_size = vb2_digest_size(key->hash_alg);
	if (!digest_size)
		return VB2_ERROR_VDATA_DIGEST_SIZE;

	digest = vb2_workbuf_alloc(&wblocal, digest_size);
	if (!digest)
		return VB2_ERROR_VDATA_WORKBUF_DIGEST;

	/* Hashing requires temp space for the context */
	dc = vb2_workbuf_alloc(&wblocal, sizeof(*dc));
	if (!dc)
		return VB2_ERROR_VDATA_WORKBUF_HASHING;

	rv = vb2_digest_init(dc, key->hash_alg);
	if (rv)
		return rv;

	rv = vb2_digest_extend(dc, data, size);
	if (rv)
		return rv;

	rv = vb2_digest_finalize(dc, digest, digest_size);
	if (rv)
		return rv;

	vb2_workbuf_free(&wblocal, sizeof(*dc));

	return vb21_verify_digest(key, sig, digest, &wblocal);
}
