/* Copyright 2019 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Tests for vb2_hash_(calculate|verify) functions.
 */

#include "2return_codes.h"
#include "2sha.h"
#include "2sysincludes.h"
#include "test_common.h"

uint8_t mock_sha1[] = {0x1, 0x3, 0x5, 0x2, 0x4, 0x6, 0xa, 0xb, 0xc, 0xd,
		       0xd, 0xe, 0xa, 0xd, 0xb, 0xe, 0xe, 0xf, 0x0, 0xf0};
_Static_assert(sizeof(mock_sha1) == VB2_SHA1_DIGEST_SIZE, "");

struct vb2_hash mock_hash;
uint8_t mock_buffer[] = "Mock Buffer";

vb2_error_t mock_init_rv;
vb2_error_t mock_extend_rv;
vb2_error_t mock_finalize_rv;

static void reset_common_data(void)
{
	memset(&mock_hash, 0xaa, sizeof(mock_hash));

	mock_init_rv = VB2_SUCCESS;
	mock_extend_rv = VB2_SUCCESS;
	mock_finalize_rv = VB2_SUCCESS;
}

vb2_error_t vb2_digest_init(struct vb2_digest_context *dc,
			    enum vb2_hash_algorithm hash_alg)
{
	if (hash_alg != VB2_HASH_SHA1)
		return VB2_ERROR_MOCK;
	return mock_init_rv;
}

vb2_error_t vb2_digest_extend(struct vb2_digest_context *dc, const uint8_t *buf,
			      uint32_t size)
{
	TEST_PTR_EQ(buf, mock_buffer, "digest_extend unexpected buf");
	TEST_EQ(size, sizeof(mock_buffer), "digest_extend unexpected size");
	return mock_extend_rv;
}

vb2_error_t vb2_digest_finalize(struct vb2_digest_context *dc, uint8_t *digest,
				uint32_t size)
{
	TEST_EQ(size, VB2_SHA1_DIGEST_SIZE, "digest_finalize unexpected size");
	memcpy(digest, mock_sha1, size);
	return mock_finalize_rv;
}

static void vb2_hash_cbfs_compatibility_test(void)
{
	/* 'algo' used to be represented as a 4-byte big-endian in CBFS. Confirm
	   that the new representation is binary compatible for small values. */
	union {
		struct vb2_hash hash;
		struct {
			uint32_t be32;
			uint8_t bytes[0];
		};
	} test = {0};

	test.be32 = htobe32(0xa5);
	TEST_EQ(test.hash.algo, 0xa5, "vb2_hash algo compatible to CBFS attr");
	TEST_PTR_EQ(&test.hash.raw, &test.bytes, "  digest offset matches");
}

static void vb2_hash_calculate_tests(void)
{
	reset_common_data();
	TEST_SUCC(vb2_hash_calculate(&mock_buffer, sizeof(mock_buffer),
				     VB2_HASH_SHA1, &mock_hash),
		  "hash_calculate success");
	TEST_SUCC(memcmp(mock_hash.sha1, mock_sha1, sizeof(mock_sha1)),
		  "  got the right hash");
	TEST_EQ(mock_hash.algo, VB2_HASH_SHA1, "  set algo correctly");

	reset_common_data();
	mock_init_rv = VB2_ERROR_MOCK;
	TEST_EQ(vb2_hash_calculate(mock_buffer, sizeof(mock_buffer),
				   VB2_HASH_SHA1, &mock_hash),
		VB2_ERROR_MOCK, "hash_calculate init error");

	reset_common_data();
	mock_extend_rv = VB2_ERROR_MOCK;
	TEST_EQ(vb2_hash_calculate(mock_buffer, sizeof(mock_buffer),
				   VB2_HASH_SHA1, &mock_hash),
		VB2_ERROR_MOCK, "hash_calculate extend error");

	reset_common_data();
	mock_finalize_rv = VB2_ERROR_MOCK;
	TEST_EQ(vb2_hash_calculate(mock_buffer, sizeof(mock_buffer),
				   VB2_HASH_SHA1, &mock_hash),
		VB2_ERROR_MOCK, "hash_calculate finalize error");
}

static void vb2_hash_verify_tests(void)
{
	reset_common_data();

	memcpy(mock_hash.sha1, mock_sha1, sizeof(mock_sha1));
	mock_hash.algo = VB2_HASH_SHA1;
	TEST_SUCC(vb2_hash_verify(mock_buffer, sizeof(mock_buffer),
				  &mock_hash), "hash_verify success");

	memcpy(mock_hash.sha1, mock_sha1, sizeof(mock_sha1));
	mock_hash.algo = VB2_HASH_SHA256;
	TEST_EQ(vb2_hash_verify(mock_buffer, sizeof(mock_buffer),
				&mock_hash), VB2_ERROR_MOCK,
		"hash_verify wrong algo");

	memcpy(mock_hash.sha1, mock_sha1, sizeof(mock_sha1));
	mock_hash.sha1[5] = 0xfe;
	mock_hash.algo = VB2_HASH_SHA1;
	TEST_EQ(vb2_hash_verify(mock_buffer, sizeof(mock_buffer),
				&mock_hash), VB2_ERROR_SHA_MISMATCH,
		"hash_verify mismatch");
}

int main(int argc, char *argv[])
{
	TEST_EQ(sizeof(mock_hash),
		offsetof(struct vb2_hash, raw) + VB2_SHA512_DIGEST_SIZE,
		"tests run with all SHA algorithms enabled");

	vb2_hash_cbfs_compatibility_test();
	vb2_hash_calculate_tests();
	vb2_hash_verify_tests();

	return gTestSuccess ? 0 : 255;
}
