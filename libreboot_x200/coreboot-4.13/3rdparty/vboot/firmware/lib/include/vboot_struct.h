/* Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * VbSharedDataHeader definition, for sharing with OS.
 */

#ifndef VBOOT_REFERENCE_VBOOT_STRUCT_H_
#define VBOOT_REFERENCE_VBOOT_STRUCT_H_

#include <stdint.h>

#include "vboot_kernel.h"

#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

/* Constants and sub-structures for VbSharedDataHeader */

/* Magic number for recognizing VbSharedDataHeader ("VbSD") */
#define VB_SHARED_DATA_MAGIC 0x44536256

/* Version for struct_version */
#define VB_SHARED_DATA_VERSION 2

/*
 * Flags for VbSharedDataHeader
 *
 * TODO(b:124141368): Move these constants into crossystem once they are
 * no longer needed in vboot2 code.
 */

/* LoadFirmware() tried firmware B because of VbNvStorage firmware B tries;
   Deprecated as part of chromium:1010389. */
#define VBSD_FWB_TRIED        0x00000001
/*
 * LoadKernel() verified the good kernel keyblock using the kernel subkey from
 * the firmware.  If this flag is not present, it just used the hash of the
 * kernel keyblock.
 */
#define VBSD_KERNEL_KEY_VERIFIED         0x00000002
/* Developer switch was enabled at boot time */
#define VBSD_BOOT_DEV_SWITCH_ON          0x00000010
/* Recovery switch was enabled at boot time */
#define VBSD_BOOT_REC_SWITCH_ON          0x00000020
/* Firmware write protect was enabled at boot time */
#define VBSD_BOOT_FIRMWARE_WP_ENABLED    0x00000040
/* VbInit() was told the system supports EC software sync */
#define VBSD_EC_SOFTWARE_SYNC            0x00000800
/* Firmware used vboot2 for firmware selection */
#define VBSD_BOOT_FIRMWARE_VBOOT2        0x00008000
/* NvStorage uses 64-byte record, not 16-byte */
#define VBSD_NVDATA_V2                   0x00100000

/* Number of kernel calls to track.  Must be power of 2. */
#define VBSD_MAX_KERNEL_CALLS 4

/* Data shared to OS. */
typedef struct VbSharedDataHeader {
	/* Fields present in version 1 */
	/* Magic number for struct (VB_SHARED_DATA_MAGIC) */
	uint32_t magic;
	/* Version of this structure */
	uint32_t struct_version;
	/* Size of this structure in bytes */
	uint64_t struct_size;
	/* Size of shared data buffer in bytes */
	uint64_t data_size;
	/* Amount of shared data used so far */
	uint64_t data_used;
	/* Flags */
	uint32_t flags;
	/* Reserved for padding */
	uint32_t reserved0;
	/* Previously, kernel subkey, from firmware (struct vb2_packed_key).
	   Now we use vboot2 workbuf for storage. */
	uint8_t reserved1[32];
	/* Offset of kernel subkey data from start of this struct */
	uint64_t kernel_subkey_data_offset;
	/* Size of kernel subkey data */
	uint64_t kernel_subkey_data_size;

	/*
	 * These timer values are all deprecated.  coreboot tstamp_table should
	 * be used instead.  See crosbug.com/1014102.
	 */
	/* VbInit() enter/exit */
	uint64_t timer_vb_init_enter;
	uint64_t timer_vb_init_exit;
	/* VbSelectFirmware() enter/exit */
	uint64_t timer_vb_select_firmware_enter;
	uint64_t timer_vb_select_firmware_exit;
	/* VbSelectAndLoadKernel() enter/exit */
	uint64_t timer_vb_select_and_load_kernel_enter;
	uint64_t timer_vb_select_and_load_kernel_exit;

	/* Information stored in TPM, as retrieved by firmware */
	/* Current firmware version in TPM */
	uint32_t fw_version_tpm;
	/* Current kernel version in TPM */
	uint32_t kernel_version_tpm;

	/* Debugging information from LoadFirmware() */
	/* Result of checking RW firmware A and B */
	uint8_t check_fw_a_result;
	uint8_t check_fw_b_result;
	/* Firmware index returned by LoadFirmware() or 0xFF if failure */
	uint8_t firmware_index;
	/* Reserved for padding */
	uint8_t reserved2;
	/* Firmware TPM version at start of VbSelectFirmware() */
	uint32_t fw_version_tpm_start;
	/* Firmware lowest version found */
	uint32_t fw_version_lowest;

	/* Debugging information from LoadKernel() */
	/* Number of times LoadKernel() called */
	uint32_t lk_call_count;
	/* Info on calls */
	VbSharedDataKernelCall lk_calls[VBSD_MAX_KERNEL_CALLS];

	/*
	 * Offset and size of supplemental kernel data.  Reserve space for
	 * these fields now, so that future LoadKernel() versions can store
	 * information there without needing to shift down whatever data the
	 * original LoadFirmware() might have put immediately following its
	 * VbSharedDataHeader.
	 */
	uint64_t kernel_supplemental_offset;
	uint64_t kernel_supplemental_size;

	/*
	 * Fields added in version 2.  Before accessing, make sure that
	 * struct_version >= 2
	 */
	/* Recovery reason for current boot */
	uint8_t recovery_reason;
	/* Reserved for padding */
	uint8_t reserved3[7];
	/* Flags from firmware keyblock */
	uint64_t fw_keyblock_flags;
	/* Kernel TPM version at start of VbSelectAndLoadKernel() */
	uint32_t kernel_version_tpm_start;
	/* Kernel lowest version found */
	uint32_t kernel_version_lowest;

} __attribute__((packed)) VbSharedDataHeader;

/* Size of VbSharedDataheader for each version */
#define VB_SHARED_DATA_HEADER_SIZE_V1 1072
#define VB_SHARED_DATA_HEADER_SIZE_V2 1096

_Static_assert(VB_SHARED_DATA_HEADER_SIZE_V1
	       == offsetof(VbSharedDataHeader, recovery_reason),
	       "VB_SHARED_DATA_HEADER_SIZE_V1 incorrect");

_Static_assert(VB_SHARED_DATA_HEADER_SIZE_V2 == sizeof(VbSharedDataHeader),
	       "VB_SHARED_DATA_HEADER_SIZE_V2 incorrect");

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif  /* VBOOT_REFERENCE_VBOOT_STRUCT_H_ */
