/* Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Data structure and API definitions for a verified boot kernel image.
 * (Firmware Portion)
 */

#ifndef VBOOT_REFERENCE_VBOOT_KERNEL_H_
#define VBOOT_REFERENCE_VBOOT_KERNEL_H_

#include "cgptlib.h"
#include "gpt_misc.h"
#include "load_kernel_fw.h"
#include "vboot_api.h"

struct vb2_context;

/* Flags for VbSharedDataKernelPart.flags */
#define VBSD_LKP_FLAG_KEYBLOCK_VALID   0x01

/* Result codes for VbSharedDataKernelPart.check_result */
#define VBSD_LKP_CHECK_NOT_DONE           0
#define VBSD_LKP_CHECK_TOO_SMALL          1
#define VBSD_LKP_CHECK_READ_START         2
#define VBSD_LKP_CHECK_KEYBLOCK_SIG      3
#define VBSD_LKP_CHECK_KEYBLOCK_HASH     4
#define VBSD_LKP_CHECK_DEV_MISMATCH       5
#define VBSD_LKP_CHECK_REC_MISMATCH       6
#define VBSD_LKP_CHECK_KEY_ROLLBACK       7
#define VBSD_LKP_CHECK_DATA_KEY_PARSE     8
#define VBSD_LKP_CHECK_VERIFY_PREAMBLE    9
#define VBSD_LKP_CHECK_KERNEL_ROLLBACK    10
#define VBSD_LKP_CHECK_PREAMBLE_VALID     11
/*
 * Body load address check is omitted; this result code is deprecated and not
 * used anywhere in the codebase.
 */
#define VBSD_LKP_CHECK_BODY_ADDRESS       12
#define VBSD_LKP_CHECK_BODY_OFFSET        13
#define VBSD_LKP_CHECK_SELF_SIGNED        14
#define VBSD_LKP_CHECK_BODY_EXCEEDS_MEM   15
#define VBSD_LKP_CHECK_BODY_EXCEEDS_PART  16
#define VBSD_LKP_CHECK_READ_DATA          17
#define VBSD_LKP_CHECK_VERIFY_DATA        18
#define VBSD_LKP_CHECK_KERNEL_GOOD        19

/* Information about a single kernel partition check in LoadKernel() */
typedef struct VbSharedDataKernelPart {
	uint64_t sector_start;     /* Start sector of partition */
	uint64_t sector_count;     /* Sector count of partition */
	uint32_t combined_version; /* Combined key+kernel version */
	uint8_t gpt_index;         /* Index of partition in GPT */
	uint8_t check_result;      /* Check result; see VBSD_LKP_CHECK_* */
	uint8_t flags;             /* Flags (see VBSD_LKP_FLAG_* */
	uint8_t reserved0;         /* Reserved for padding */
} VbSharedDataKernelPart;

/* Number of kernel partitions to track per call.  Must be power of 2. */
#define VBSD_MAX_KERNEL_PARTS 8

/* Result codes for VbSharedDataKernelCall.check_result */
#define VBSD_LKC_CHECK_NOT_DONE            0
#define VBSD_LKC_CHECK_DEV_SWITCH_MISMATCH 1
#define VBSD_LKC_CHECK_GPT_READ_ERROR      2
#define VBSD_LKC_CHECK_GPT_PARSE_ERROR     3
#define VBSD_LKC_CHECK_GOOD_PARTITION      4
#define VBSD_LKC_CHECK_INVALID_PARTITIONS  5
#define VBSD_LKC_CHECK_NO_PARTITIONS       6

/* Information about a single call to LoadKernel() */
typedef struct VbSharedDataKernelCall {
	/* Bottom 32 bits of flags passed in LoadKernelParams.boot_flags */
	uint32_t boot_flags;
	/* Debug flags; see VBSD_LK_FLAG_* */
	uint32_t flags;
	/* Number of sectors on drive */
	uint64_t sector_count;
	/* Sector size in bytes */
	uint32_t sector_size;
	/* Check result; see VBSD_LKC_CHECK_* */
	uint8_t check_result;
	/* Test error number, if non-zero */
	uint8_t test_error_num;
	/* Return code from LoadKernel() */
	uint8_t return_code;
	/* Number of kernel partitions found */
	uint8_t kernel_parts_found;
	/* Reserved for padding */
	uint8_t reserved0[7];
	/* Data on kernels */
	VbSharedDataKernelPart parts[VBSD_MAX_KERNEL_PARTS];
} VbSharedDataKernelCall;

/**
 * Attempt loading a kernel from the specified type(s) of disks.
 *
 * If successful, sets lkp.disk_handle to the disk for the kernel and returns
 * VB2_SUCCESS.
 *
 * @param ctx			Vboot context
 * @param get_info_flags	Flags to pass to VbExDiskGetInfo()
 * @return VB2_SUCCESS or the most specific VB2_ERROR_LK error.
 */
vb2_error_t VbTryLoadKernel(struct vb2_context *ctx, uint32_t get_info_flags);

#endif  /* VBOOT_REFERENCE_VBOOT_KERNEL_H_ */
