/* Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Tests for firmware image library.
 */

#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "2common.h"
#include "2rsa.h"
#include "2sysincludes.h"
#include "file_keys.h"
#include "host_common.h"
#include "host_key21.h"
#include "test_common.h"

static const uint8_t test_data[] = "This is some test data to sign.";
static const uint32_t test_size = sizeof(test_data);

static enum hwcrypto_state {
	HWCRYPTO_OK,
	HWCRYPTO_NOTSUPPORTED,
	HWCRYPTO_ERROR,
	HWCRYPTO_ABORT,
} hwcrypto_state_rsa, hwcrypto_state_digest;

static vb2_error_t hwcrypto_mock(enum hwcrypto_state *state)
{
	switch (*state) {
		case HWCRYPTO_OK:
			return VB2_SUCCESS;
		case HWCRYPTO_NOTSUPPORTED:
			return VB2_ERROR_EX_HWCRYPTO_UNSUPPORTED;
		case HWCRYPTO_ERROR:
			return VB2_ERROR_MOCK;
		case HWCRYPTO_ABORT:
			vb2ex_abort();
			/* shouldn't reach here but added for compiler */
			return VB2_ERROR_MOCK;
	}
}

vb2_error_t vb2ex_hwcrypto_digest_init(enum vb2_hash_algorithm hash_alg,
				       uint32_t data_size)
{
	return hwcrypto_mock(&hwcrypto_state_digest);
}

vb2_error_t vb2ex_hwcrypto_digest_extend(const uint8_t *buf, uint32_t size)
{
	return hwcrypto_mock(&hwcrypto_state_digest);
}

vb2_error_t vb2ex_hwcrypto_digest_finalize(uint8_t *digest,
					   uint32_t digest_size)
{
	return hwcrypto_mock(&hwcrypto_state_digest);
}

vb2_error_t vb2ex_hwcrypto_rsa_verify_digest(const struct vb2_public_key *key,
					     const uint8_t *sig, const uint8_t *digest)
{
	return hwcrypto_mock(&hwcrypto_state_rsa);
}


static void test_unpack_key(const struct vb2_packed_key *key1)
{
	struct vb2_public_key pubk;

	/*
	 * Key data follows the header for a newly allocated key, so we can
	 * calculate the buffer size by looking at how far the key data goes.
	 */
	uint32_t size = key1->key_offset + key1->key_size;
	uint8_t *buf = malloc(size);
	struct vb2_packed_key *key = (struct vb2_packed_key *)buf;

	memcpy(key, key1, size);
	TEST_SUCC(vb2_unpack_key_buffer(&pubk, buf, size),
		  "vb2_unpack_key_buffer() ok");

	TEST_EQ(pubk.sig_alg, vb2_crypto_to_signature(key->algorithm),
		"vb2_unpack_key_buffer() sig_alg");
	TEST_EQ(pubk.hash_alg, vb2_crypto_to_hash(key->algorithm),
		"vb2_unpack_key_buffer() hash_alg");


	memcpy(key, key1, size);
	key->algorithm = VB2_ALG_COUNT;
	TEST_EQ(vb2_unpack_key_buffer(&pubk, buf, size),
		VB2_ERROR_UNPACK_KEY_SIG_ALGORITHM,
		"vb2_unpack_key_buffer() invalid algorithm");

	memcpy(key, key1, size);
	key->key_size--;
	TEST_EQ(vb2_unpack_key_buffer(&pubk, buf, size),
		VB2_ERROR_UNPACK_KEY_SIZE,
		"vb2_unpack_key_buffer() invalid size");

	memcpy(key, key1, size);
	key->key_offset++;
	TEST_EQ(vb2_unpack_key_buffer(&pubk, buf, size + 1),
		VB2_ERROR_UNPACK_KEY_ALIGN,
		"vb2_unpack_key_buffer() unaligned data");

	memcpy(key, key1, size);
	*(uint32_t *)(buf + key->key_offset) /= 2;
	TEST_EQ(vb2_unpack_key_buffer(&pubk, buf, size),
		VB2_ERROR_UNPACK_KEY_ARRAY_SIZE,
		"vb2_unpack_key_buffer() invalid key array size");

	memcpy(key, key1, size);
	TEST_EQ(vb2_unpack_key_buffer(&pubk, buf, size - 1),
		VB2_ERROR_INSIDE_DATA_OUTSIDE,
		"vb2_unpack_key_buffer() buffer too small");

	free(key);

	TEST_EQ(vb2_unpack_key(&pubk, NULL),
		VB2_ERROR_UNPACK_KEY_BUFFER,
		"vb2_unpack_key_() buffer NULL");
}

static void test_verify_data(const struct vb2_packed_key *key1,
			     const struct vb2_signature *sig)
{
	uint8_t workbuf[VB2_VERIFY_DATA_WORKBUF_BYTES]
		 __attribute__((aligned(VB2_WORKBUF_ALIGN)));
	struct vb2_workbuf wb;

	struct vb2_public_key pubk, pubk_orig;
	uint32_t sig_total_size = sig->sig_offset + sig->sig_size;
	struct vb2_signature *sig2;

	hwcrypto_state_rsa = HWCRYPTO_ABORT;
	hwcrypto_state_digest = HWCRYPTO_ABORT;

	vb2_workbuf_init(&wb, workbuf, sizeof(workbuf));

	/* Allocate signature copy for tests */
	sig2 = (struct vb2_signature *)malloc(sig_total_size);

	TEST_SUCC(vb2_unpack_key(&pubk, key1), "vb2_verify_data() unpack key");
	pubk_orig = pubk;

	memcpy(sig2, sig, sig_total_size);
	pubk.sig_alg = VB2_SIG_INVALID;
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		 0, "vb2_verify_data() bad sig alg");
	pubk.sig_alg = pubk_orig.sig_alg;

	memcpy(sig2, sig, sig_total_size);
	pubk.hash_alg = VB2_HASH_INVALID;
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		 0, "vb2_verify_data() bad hash alg");
	pubk.hash_alg = pubk_orig.hash_alg;

	vb2_workbuf_init(&wb, workbuf, 4);
	memcpy(sig2, sig, sig_total_size);
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		 0, "vb2_verify_data() workbuf too small");
	vb2_workbuf_init(&wb, workbuf, sizeof(workbuf));

	memcpy(sig2, sig, sig_total_size);
	TEST_EQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() ok");

	memcpy(sig2, sig, sig_total_size);
	sig2->sig_size -= 16;
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		 0, "vb2_verify_data() wrong sig size");

	memcpy(sig2, sig, sig_total_size);
	TEST_NEQ(vb2_verify_data(test_data, test_size - 1, sig2, &pubk, &wb),
		 0, "vb2_verify_data() input buffer too small");

	memcpy(sig2, sig, sig_total_size);
	vb2_signature_data_mutable(sig2)[0] ^= 0x5A;
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		 0, "vb2_verify_data() wrong sig");

	pubk.allow_hwcrypto = 1;

	hwcrypto_state_digest = HWCRYPTO_OK;
	hwcrypto_state_rsa = HWCRYPTO_OK;
	memcpy(sig2, sig, sig_total_size);
	vb2_signature_data_mutable(sig2)[0] ^= 0x5A;
	TEST_EQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto ok");

	hwcrypto_state_rsa = HWCRYPTO_ERROR;
	memcpy(sig2, sig, sig_total_size);
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto error");

	hwcrypto_state_rsa = HWCRYPTO_NOTSUPPORTED;
	memcpy(sig2, sig, sig_total_size);
	TEST_EQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto fallback ok");

	memcpy(sig2, sig, sig_total_size);
	sig2->sig_size -= 16;
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto fallback error");

	hwcrypto_state_digest = HWCRYPTO_ERROR;
	hwcrypto_state_rsa = HWCRYPTO_OK;
	memcpy(sig2, sig, sig_total_size);
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto error");

	hwcrypto_state_rsa = HWCRYPTO_ERROR;
	memcpy(sig2, sig, sig_total_size);
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto error");

	hwcrypto_state_rsa = HWCRYPTO_NOTSUPPORTED;
	memcpy(sig2, sig, sig_total_size);
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto fallback error");

	hwcrypto_state_digest = HWCRYPTO_NOTSUPPORTED;
	hwcrypto_state_rsa = HWCRYPTO_OK;
	memcpy(sig2, sig, sig_total_size);
	vb2_signature_data_mutable(sig2)[0] ^= 0x5A;
	TEST_EQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto ok");

	hwcrypto_state_rsa = HWCRYPTO_ERROR;
	memcpy(sig2, sig, sig_total_size);
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto error");

	hwcrypto_state_rsa = HWCRYPTO_NOTSUPPORTED;
	memcpy(sig2, sig, sig_total_size);
	TEST_EQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto fallback ok");

	memcpy(sig2, sig, sig_total_size);
	sig2->sig_size -= 16;
	TEST_NEQ(vb2_verify_data(test_data, test_size, sig2, &pubk, &wb),
		0, "vb2_verify_data() hwcrypto fallback error");

	pubk.allow_hwcrypto = 0;


	free(sig2);
}


static int test_algorithm(int key_algorithm, const char *keys_dir)
{
	char filename[1024];
	struct vb2_private_key *private_key = NULL;
	struct vb2_signature *sig = NULL;
	struct vb2_packed_key *key1 = NULL;

	int retval = 1;

	printf("***Testing algorithm: %s\n",
	       vb2_get_crypto_algorithm_name(key_algorithm));

	snprintf(filename, sizeof(filename), "%s/key_%s.pem",
		 keys_dir,
		 vb2_get_crypto_algorithm_file(key_algorithm));
	private_key = vb2_read_private_key_pem(filename, key_algorithm);
	if (!private_key) {
		fprintf(stderr, "Error reading private_key: %s\n", filename);
		goto cleanup_algorithm;
	}

	snprintf(filename, sizeof(filename), "%s/key_%s.keyb",
		 keys_dir,
		 vb2_get_crypto_algorithm_file(key_algorithm));
	key1 = vb2_read_packed_keyb(filename, key_algorithm, 1);
	if (!key1) {
		fprintf(stderr, "Error reading public_key: %s\n", filename);
		goto cleanup_algorithm;
	}

	/* Calculate good signatures */
	sig = vb2_calculate_signature(test_data, sizeof(test_data),
				      private_key);
	TEST_PTR_NEQ(sig, 0, "Calculate signature");
	if (!sig)
		goto cleanup_algorithm;

	test_unpack_key(key1);
	test_verify_data(key1, sig);

	retval = 0;

cleanup_algorithm:
	if (key1)
		free(key1);
	if (private_key)
		free(private_key);
	if (sig)
		free(sig);

	return retval;
}

/* Test only the algorithms we use */
const int key_algs[] = {
	VB2_ALG_RSA2048_SHA256,
	VB2_ALG_RSA4096_SHA256,
	VB2_ALG_RSA8192_SHA512,
};

int main(int argc, char *argv[]) {

	if (argc == 2) {
		int i;

		for (i = 0; i < ARRAY_SIZE(key_algs); i++) {
			if (test_algorithm(key_algs[i], argv[1]))
				return 1;
		}

	} else if (argc == 3 && !strcasecmp(argv[2], "--all")) {
		/* Test all the algorithms */
		int alg;

		for (alg = 0; alg < VB2_ALG_COUNT; alg++) {
			if (test_algorithm(alg, argv[1]))
				return 1;
		}

	} else {
		fprintf(stderr, "Usage: %s <keys_dir> [--all]", argv[0]);
		return -1;
	}

	return gTestSuccess ? 0 : 255;
}
