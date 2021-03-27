/* Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * APIs provided by firmware to vboot_reference.
 *
 * General notes:
 *
 * All verified boot functions now start with "Vb" for namespace clarity.  This
 * fixes the problem where uboot and vboot both defined assert().
 *
 * Verified boot APIs to be implemented by the calling firmware and exported to
 * vboot_reference start with "VbEx".
 *
 * TODO: split this file into a vboot_entry_points.h file which contains the
 * entry points for the firmware to call vboot_reference, and a
 * vboot_firmware_exports.h which contains the APIs to be implemented by the
 * calling firmware and exported to vboot_reference.
 */

#ifndef VBOOT_REFERENCE_VBOOT_API_H_
#define VBOOT_REFERENCE_VBOOT_API_H_

#include <stdint.h>
#include <stdlib.h>

#include "../2lib/include/2return_codes.h"
#include "gpt.h"

#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

struct vb2_context;
typedef struct VbSharedDataHeader VbSharedDataHeader;


/*****************************************************************************/
/* Main entry points from firmware into vboot_reference */

/*
 * We use disk handles rather than indices.  Using indices causes problems if
 * a disk is removed/inserted in the middle of processing.
 */
typedef void *VbExDiskHandle_t;

/* Data used only by VbSelectAndLoadKernel() */
typedef struct VbSelectAndLoadKernelParams {
	/* Inputs to VbSelectAndLoadKernel() */
	/* Destination buffer for kernel (normally at 0x100000 on x86) */
	void *kernel_buffer;
	/* Size of kernel buffer in bytes */
	uint32_t kernel_buffer_size;

	/*
	 * Outputs from VbSelectAndLoadKernel(); valid only if it returns
	 * success.
	 */
	/* Handle of disk containing loaded kernel */
	VbExDiskHandle_t disk_handle;
	/* Partition number on disk to boot (1...M) */
	uint32_t partition_number;
	/* Address of bootloader image in RAM */
	uint64_t bootloader_address;
	/* Size of bootloader image in bytes */
	uint32_t bootloader_size;
	/* UniquePartitionGuid for boot partition */
	uint8_t partition_guid[16];
	/* Flags set by signer */
	uint32_t flags;
	/*
	 * TODO: in H2C, all that pretty much just gets passed to the
	 * bootloader as KernelBootloaderOptions, though the disk handle is
	 * passed as an index instead of a handle.  Is that used anymore now
	 * that we're passing partition_guid?
	 */
} VbSelectAndLoadKernelParams;

/**
 * Select and loads the kernel.
 *
 * Returns VB2_SUCCESS if success, non-zero if error; on error, caller
 * should reboot. */
vb2_error_t VbSelectAndLoadKernel(struct vb2_context *ctx,
				  VbSelectAndLoadKernelParams *kparams);

/*****************************************************************************/
/* Disk access (previously in boot_device.h) */

/* Flags for VbDisk APIs */
/* Disk is removable.  Example removable disks: SD cards, USB keys.  */
#define VB_DISK_FLAG_REMOVABLE 0x00000001
/*
 * Disk is fixed.  If this flag is present, disk is internal to the system and
 * not removable.  Example fixed disks: internal SATA SSD, eMMC.
 */
#define VB_DISK_FLAG_FIXED     0x00000002
/*
 * Note that VB_DISK_FLAG_REMOVABLE and VB_DISK_FLAG_FIXED are
 * mutually-exclusive for a single disk.  VbExDiskGetInfo() may specify both
 * flags to request disks of both types in a single call.
 *
 * At some point we could specify additional flags, but we don't currently
 * have a way to make use of these:
 *
 * USB              Device is known to be attached to USB.  Note that the SD
 *                  card reader inside x86 systems is attached to USB so this
 *                  isn't super useful.
 * SD               Device is known to be a SD card.  Note that external card
 *                  readers might not return this information, so also of
 *                  questionable use.
 * READ_ONLY        Device is known to be read-only.  Could be used by recovery
 *                  when processing read-only recovery image.
 */

/*
 * Disks are used in two ways:
 * - As a random-access device to read and write the GPT
 * - As a streaming device to read the kernel
 * These are implemented differently on raw NAND vs eMMC/SATA/USB
 * - On eMMC/SATA/USB, both of these refer to the same underlying
 *   storage, so they have the same size and LBA size. In this case,
 *   the GPT should not point to the same address as itself.
 * - On raw NAND, the GPT is held on a portion of the SPI flash.
 *   Random access GPT operations refer to the SPI and streaming
 *   operations refer to NAND. The GPT may therefore point into
 *   the same offsets as itself.
 * These types are distinguished by the following flag and VbDiskInfo
 * has separate fields to describe the random-access ("GPT") and
 * streaming aspects of the disk. If a disk is random-access (i.e.
 * not raw NAND) then these fields are equal.
 */
#define VB_DISK_FLAG_EXTERNAL_GPT	0x00000004

/* Information on a single disk */
typedef struct VbDiskInfo {
	/* Disk handle */
	VbExDiskHandle_t handle;
	/* Size of a random-access LBA sector in bytes */
	uint64_t bytes_per_lba;
	/* Number of random-access LBA sectors on the device.
	 * If streaming_lba_count is 0, this stands in for the size of the
	 * randomly accessed portion as well as the streaming portion.
	 * Otherwise, this is only the randomly-accessed portion. */
	uint64_t lba_count;
	/* Number of streaming sectors on the device */
	uint64_t streaming_lba_count;
	/* Flags (see VB_DISK_FLAG_* constants) */
	uint32_t flags;
	/*
	 * Optional name string, for use in debugging.  May be empty or null if
	 * not available.
	 */
	const char *name;
} VbDiskInfo;

/**
 * Store information into [info] for all disks (storage devices) attached to
 * the system which match all of the disk_flags.
 *
 * On output, count indicates how many disks are present, and [infos_ptr]
 * points to a [count]-sized array of VbDiskInfo structs with the information
 * on those disks; this pointer must be freed by calling VbExDiskFreeInfo().
 * If count=0, infos_ptr may point to NULL.  If [infos_ptr] points to NULL
 * because count=0 or error, it is not necessary to call VbExDiskFreeInfo().
 *
 * A multi-function device (such as a 4-in-1 card reader) should provide
 * multiple disk handles.
 *
 * The firmware must not alter or free the list pointed to by [infos_ptr] until
 * VbExDiskFreeInfo() is called.
 */
vb2_error_t VbExDiskGetInfo(VbDiskInfo **infos_ptr, uint32_t *count,
			    uint32_t disk_flags);

/**
 * Free a disk information list [infos] previously returned by
 * VbExDiskGetInfo().  If [preserve_handle] != NULL, the firmware must ensure
 * that handle remains valid after this call; all other handles from the info
 * list need not remain valid after this call.
 */
vb2_error_t VbExDiskFreeInfo(VbDiskInfo *infos,
			     VbExDiskHandle_t preserve_handle);

/**
 * Read lba_count LBA sectors, starting at sector lba_start, from the disk,
 * into the buffer.
 *
 * This is used for random access to the GPT. It is not for the partition
 * contents. The upper limit is lba_count.
 *
 * If the disk handle is invalid (for example, the handle refers to a disk
 * which as been removed), the function must return error but must not
 * crash.
 */
vb2_error_t VbExDiskRead(VbExDiskHandle_t handle, uint64_t lba_start,
			 uint64_t lba_count, void *buffer);

/**
 * Write lba_count LBA sectors, starting at sector lba_start, to the disk, from
 * the buffer.
 *
 * This is used for random access to the GPT. It does not (necessarily) access
 * the streaming portion of the device.
 *
 * If the disk handle is invalid (for example, the handle refers to a disk
 * which as been removed), the function must return error but must not
 * crash.
 */
vb2_error_t VbExDiskWrite(VbExDiskHandle_t handle, uint64_t lba_start,
			  uint64_t lba_count, const void *buffer);

/* Streaming read interface */
typedef void *VbExStream_t;

/**
 * Open a stream on a disk
 *
 * @param handle	Disk to open the stream against
 * @param lba_start	Starting sector offset within the disk to stream from
 * @param lba_count	Maximum extent of the stream in sectors
 * @param stream	out-paramter for the generated stream
 *
 * @return Error code, or VB2_SUCCESS.
 *
 * This is used for access to the contents of the actual partitions on the
 * device. It is not used to access the GPT. The size of the content addressed
 * is within streaming_lba_count.
 */
vb2_error_t VbExStreamOpen(VbExDiskHandle_t handle, uint64_t lba_start,
			   uint64_t lba_count, VbExStream_t *stream_ptr);

/**
 * Read from a stream on a disk
 *
 * @param stream	Stream to read from
 * @param bytes		Number of bytes to read
 * @param buffer	Destination to read into
 *
 * @return Error code, or VB2_SUCCESS. Failure to read as much data as
 * requested is an error.
 *
 * This is used for access to the contents of the actual partitions on the
 * device. It is not used to access the GPT.
 */
vb2_error_t VbExStreamRead(VbExStream_t stream, uint32_t bytes, void *buffer);

/**
 * Close a stream
 *
 * @param stream	Stream to close
 */
void VbExStreamClose(VbExStream_t stream);


/*****************************************************************************/
/* Display */

/* Predefined (default) screens for VbExDisplayScreen(). */
enum VbScreenType_t {
	/* Blank (clear) screen */
	VB_SCREEN_BLANK = 0,
	/* Developer - warning */
	VB_SCREEN_DEVELOPER_WARNING = 0x101,
	/* REMOVED: Developer - easter egg (0x102) */
	/* REMOVED: Recovery - remove inserted devices (0x201) */
	/* Recovery - insert recovery image */
	VB_SCREEN_RECOVERY_INSERT   = 0x202,
	/* Recovery - inserted image invalid */
	VB_SCREEN_RECOVERY_NO_GOOD  = 0x203,
	/* Recovery - confirm dev mode */
	VB_SCREEN_RECOVERY_TO_DEV   = 0x204,
	/* Developer - confirm normal mode */
	VB_SCREEN_DEVELOPER_TO_NORM = 0x205,
	/* Please wait - programming EC */
	VB_SCREEN_WAIT              = 0x206,
	/* Confirm after DEVELOPER_TO_NORM */
	VB_SCREEN_TO_NORM_CONFIRMED = 0x207,
	/* Broken screen shown after verification failure */
	VB_SCREEN_OS_BROKEN         = 0x208,
	/* REMOVED: Display base screen (no icons, no text) (0x209) */
	/* Detachable Menu - Developer Warning */
	VB_SCREEN_DEVELOPER_WARNING_MENU = 0x20a,
	/* Detachable Menu - Developer Boot */
	VB_SCREEN_DEVELOPER_MENU = 0x20b,
	/* REMOVED: Detachable Menu - Recovery (0x20c) */
	/* Detachable Menu - Confirm Dev Mode */
	VB_SCREEN_RECOVERY_TO_DEV_MENU = 0x20d,
	/* Detachable Menu - Confirm Normal Mode */
	VB_SCREEN_DEVELOPER_TO_NORM_MENU = 0x20e,
	/* Detachable Menu - Languages */
	VB_SCREEN_LANGUAGES_MENU = 0x20f,
	/* Detachable Menu - Options */
	VB_SCREEN_OPTIONS_MENU = 0x210,
	/* REMOVED: Alt OS picker screen (0x211) */
	/* Alt firmware picker screen (for keyboard UI) */
	VB_SCREEN_ALT_FW_PICK = 0x212,
	/* Alt firmware menu screen (for detachable UI ) */
	VB_SCREEN_ALT_FW_MENU = 0x213,
	/* 0x300-0x350 reserved for device-specific screens */
	/* Vendor data not set warning screen */
	VB_COMPLETE_VENDOR_DATA = 0x300,
	/* Set vendor data menu screen */
	VB_SCREEN_SET_VENDOR_DATA = 0x301,
	/* Confirm vendor data menu screen */
	VB_SCREEN_CONFIRM_VENDOR_DATA = 0x302,
	/* Confirm reboot for running diagnostics rom */
	VB_SCREEN_CONFIRM_DIAG = 0x303,
};

/* Flags to control behavior of device-specific screens. */
enum VbVendorDataFlags_t {
	/* When set display a cursor after the prompt */
	VB_VENDOR_DATA_SHOW_CURSOR = 1 << 0,
	/* When set only redraw the cursor */
	VB_VENDOR_DATA_ONLY_DRAW_CURSOR = 1 << 1,
};

/**
 * Extra data needed when displaying vendor data screens
 */
typedef struct VbVendorData
{
	/* Current state of the the vendor data input */
	const char *input_text;
	/* Flags (See VbVendorDataFlags_t) */
	uint32_t flags;
	/* Current confirmation selection for new vendor data */
	uint32_t selected_index;
} VbVendorData;

/**
 * Extra data that may be used when displaying a screen
 */
typedef struct VbScreenData
{
	union {
		VbVendorData vendor_data;
	};
} VbScreenData;

/**
 * Display a predefined screen; see VB_SCREEN_* for valid screens.
 *
 * This is a backup method of screen display, intended for use if the GBB does
 * not contain a full set of bitmaps.  It is acceptable for the backup screen
 * to be simple ASCII text such as "NO GOOD" or "INSERT"; these screens should
 * only be seen during development.
 */
vb2_error_t VbExDisplayScreen(uint32_t screen_type, uint32_t locale,
			    const VbScreenData *data);

/**
 * Display a predefined menu screen; see VB_SCREEN_* for valid screens.
 *
 * @param screen_type       ID of screen to draw
 * @param locale            language to display
 * @param selected_index    Index of menu item that is currently selected.
 * @param disabled_idx_mask Bitmap for enabling/disabling certain menu items.
 *                          each bit corresponds to the menu item's index.
 * @param redraw_base       Setting 1 will force a full redraw of the screen
 *
 * @return VB2_SUCCESS or error code on error.
 */
vb2_error_t VbExDisplayMenu(uint32_t screen_type, uint32_t locale,
			  uint32_t selected_index, uint32_t disabled_idx_mask,
			  uint32_t redraw_base);

/**
 * Display a string containing debug information on the screen, rendered in a
 * platform-dependent font.  Should be able to handle newlines '\n' in the
 * string.  Firmware must support displaying at least 20 lines of text, where
 * each line may be at least 80 characters long.  If the firmware has its own
 * debug state, it may display it to the screen below this information if the
 * full_info parameter is set.
 *
 * @param info_str	The debug string to display
 * @param full_info	1 if firmware should append its own info, 0 if not
 *
 * @return VB2_SUCCESS or error code on error.
 */
vb2_error_t VbExDisplayDebugInfo(const char *info_str, int full_info);

/**
 * Write vendor data to read-only VPD
 *
 * @param vendor_data_value   The value of vendor data to write to VPD. The
 *                            string length will be exactly VENDOR_DATA_LENGTH
 *                            characters and null-terminated.
 *
 * @return VB2_SUCCESS or error code on error.
 */
vb2_error_t VbExSetVendorData(const char *vendor_data_value);

/*****************************************************************************/
/* Keyboard and switches */

/* Key code for CTRL + letter */
#define VB_KEY_CTRL(letter) (letter & 0x1f)

/* Key code for fn keys */
#define VB_KEY_F(num) (num + 0x108)

/* Key codes for required non-printable-ASCII characters. */
enum VbKeyCode_t {
	VB_KEY_ENTER = '\r',
	VB_KEY_ESC = 0x1b,
	VB_KEY_BACKSPACE = 0x8,
	VB_KEY_UP = 0x100,
	VB_KEY_DOWN = 0x101,
	VB_KEY_LEFT = 0x102,
	VB_KEY_RIGHT = 0x103,
	VB_KEY_CTRL_ENTER = 0x104,
};

/*
 * WARNING!!! Before updating the codes in enum VbButtonCode_t, ensure that the
 * code does not overlap the values in VbKeyCode_t unless the button action is
 * the same as key action.
 */
enum VbButtonCode_t {
	/* Volume up/down short press match the values in 8042 driver. */
	VB_BUTTON_VOL_UP_SHORT_PRESS = 0x62,
	VB_BUTTON_VOL_DOWN_SHORT_PRESS = 0x63,
	/* Dummy values used below. */
	VB_BUTTON_POWER_SHORT_PRESS = 0x90,
	VB_BUTTON_VOL_UP_LONG_PRESS = 0x91,
	VB_BUTTON_VOL_DOWN_LONG_PRESS = 0x92,
	VB_BUTTON_VOL_UP_DOWN_COMBO_PRESS = 0x93,
};

/* Flags for additional information.
 * TODO(semenzato): consider adding flags for modifiers instead of
 * making up some of the key codes above.
 */
enum VbKeyFlags_t {
	VB_KEY_FLAG_TRUSTED_KEYBOARD = 1 << 0,
};

/**
 * Read the next keypress from the keyboard buffer.
 *
 * Returns the keypress, or zero if no keypress is pending or error.
 *
 * The following keys must be returned as ASCII character codes:
 *    0x08          Backspace
 *    0x09          Tab
 *    0x0D          Enter (carriage return)
 *    0x01 - 0x1A   Ctrl+A - Ctrl+Z (yes, those alias with backspace/tab/enter)
 *    0x1B          Esc (VB_KEY_ESC)
 *    0x20          Space
 *    0x30 - 0x39   '0' - '9'
 *    0x60 - 0x7A   'a' - 'z'
 *
 * Some extended keys must also be supported; see the VB_KEY_* defines above.
 *
 * Keys ('/') or key-chords (Fn+Q) not defined above may be handled in any of
 * the following ways:
 *    1. Filter (don't report anything if one of these keys is pressed).
 *    2. Report as ASCII (if a well-defined ASCII value exists for the key).
 *    3. Report as any other value in the range 0x200 - 0x2FF.
 * It is not permitted to report a key as a multi-byte code (for example,
 * sending an arrow key as the sequence of keys '\x1b', '[', '1', 'A'). */
uint32_t VbExKeyboardRead(void);

/**
 * Same as VbExKeyboardRead(), but return extra information.
 */
uint32_t VbExKeyboardReadWithFlags(uint32_t *flags_ptr);

/*****************************************************************************/
/* Misc */

/**
 * Check if the firmware needs to shut down the system.
 *
 * Returns a non-zero VB_SHUTDOWN_REQUEST mask indicating the reason(s) for
 * shutdown if a shutdown is being requested (see VB_SHUTDOWN_REQUEST_*), or 0
 * if a shutdown is not being requested.
 *
 * NOTE: When we're displaying a screen, pressing the power button should shut
 * down the computer.  We need a way to break out of our control loop so this
 * can occur cleanly.
 */
uint32_t VbExIsShutdownRequested(void);

/*
 * Shutdown requested for a reason which is not defined among other
 * VB_SHUTDOWN_REQUEST_* values. This must be defined as 1 for backward
 * compatibility with old versions of the API.
 */
#define VB_SHUTDOWN_REQUEST_OTHER		0x00000001
/* Shutdown requested due to a lid switch being closed. */
#define VB_SHUTDOWN_REQUEST_LID_CLOSED		0x00000002
/* Shutdown requested due to a power button being pressed. */
#define VB_SHUTDOWN_REQUEST_POWER_BUTTON	0x00000004

enum VbAltFwIndex_t {
	VB_ALTFW_DIAGNOSTIC = -1,
	VB_ALTFW_DEFAULT = 0,
	VB_ALTFW_FIRST = 1,
	VB_ALTFW_SECOND,
	VB_ALTFW_THIRD,
	VB_ALTFW_FOURTH,
	VB_ALTFW_FIFTH,
	VB_ALTFW_SIXTH,
	VB_ALTFW_SEVENTH,
	VB_ALTFW_EIGHTH,
	VB_ALTFW_NINTH,
};

/**
 * Execute legacy boot option.
 *
 * @param altfw_num	Bootloader sequence number to execute. Use
 *	0 to boot the default payload, if any
 *     >0 (i.e., positive #) run a payload by # based in altfw/list file
 *     <0 (i.e., negative #) run a specific payload by name without using
 *        the altfw/list file.  Typically payloads in this category will be
 *        verified before they are run. Currently these #s are defined:
 *          -1 diagnostic payload
 */
vb2_error_t VbExLegacy(enum VbAltFwIndex_t altfw_num);

enum vb_altfw {
	VB_ALTFW_COUNT	= 9,	/* We allow 9 bootloaders, numbered 1-9 */
};

/**
 * Get a mask of available alternative firmware options
 *
 * There are up to 9 bootloaders, numbered 1 to 9, using bits 1 to 9 of this
 * mask. Bit 0 is unused.
 *
 * @return Bit mask indicating which bootloaders are present (bit n indicates
 *	bootloader n is present)
 */
uint32_t VbExGetAltFwIdxMask(void);

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif  /* VBOOT_REFERENCE_VBOOT_API_H_ */
