/* Copyright 2019 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Utilities for firmware updater.
 */

#ifndef VBOOT_REFERENCE_FUTILITY_UPDATER_UTILS_H_
#define VBOOT_REFERENCE_FUTILITY_UPDATER_UTILS_H_

#include <stdio.h>
#include "fmap.h"

#define ASPRINTF(strp, ...) do { if (asprintf(strp, __VA_ARGS__) >= 0) break; \
	ERROR("Failed to allocate memory, abort.\n"); exit(1); } while (0)

/* Structure(s) declared in updater_archive */
struct archive;

/* flashrom programmers. */
static const char * const PROG_HOST = "host",
		  * const PROG_EC = "ec",
		  * const PROG_PD = "ec:type=pd";

/* Firmware slots */
static const char * const FWACT_A = "A",
		  * const FWACT_B = "B";

enum active_slot {
	SLOT_UNKNOWN = -1,
	SLOT_A = 0,
	SLOT_B,
};

/* Utilities for managing temporary files. */
struct tempfile {
	char *filepath;
	struct tempfile *next;
};

/*
 * Create a new temporary file.
 *
 * The parameter head refers to a linked list dummy head.
 * Returns the path of new file, or NULL on failure.
 */
const char *create_temp_file(struct tempfile *head);

/*
 * Remove all files created by create_temp_file().
 *
 * The parameter head refers to the dummy head of linked list.
 * This is intended to be called only once at end of program execution.
 */
void remove_all_temp_files(struct tempfile *head);

/* Utilities for firmware images and (FMAP) sections */
struct firmware_image {
	const char *programmer;
	uint32_t size;
	uint8_t *data;
	char *file_name;
	char *ro_version, *rw_version_a, *rw_version_b;
	FmapHeader *fmap_header;
};

enum {
	IMAGE_LOAD_SUCCESS = 0,
	IMAGE_READ_FAILURE = -1,
	IMAGE_PARSE_FAILURE = -2,
};

/*
 * Loads a firmware image from file.
 * If archive is provided and file_name is a relative path, read the file from
 * archive.
 * Returns IMAGE_LOAD_SUCCESS on success, IMAGE_READ_FAILURE on file I/O
 * failure, or IMAGE_PARSE_FAILURE for non-vboot images.
 */
int load_firmware_image(struct firmware_image *image, const char *file_name,
			struct archive *archive);

/*
 * Loads the active system firmware image (usually from SPI flash chip).
 * Returns 0 if success, non-zero if error.
 */
int load_system_firmware(struct firmware_image *image,
			 struct tempfile *tempfiles, int verbosity);

/* Frees the allocated resource from a firmware image object. */
void free_firmware_image(struct firmware_image *image);

/*
 * Generates a temporary file for snapshot of firmware image contents.
 *
 * Returns a file path if success, otherwise NULL.
 */
const char *get_firmware_image_temp_file(const struct firmware_image *image,
					 struct tempfile *tempfiles);

/*
 * Writes a section from given firmware image to system firmware.
 * If section_name is NULL, write whole image.
 * Returns 0 if success, non-zero if error.
 */
int write_system_firmware(const struct firmware_image *image,
			  const struct firmware_image *diff_image,
			  const char *section_name,
			  struct tempfile *tempfiles,
			  int verbosity);

struct firmware_section {
	uint8_t *data;
	size_t size;
};

/*
 * Returns true if the given FMAP section exists in the firmware image.
 */
int firmware_section_exists(const struct firmware_image *image,
			    const char *section_name);

/*
 * Finds a firmware section by given name in the firmware image.
 * If successful, return zero and *section argument contains the address and
 * size of the section; otherwise failure.
 */
int find_firmware_section(struct firmware_section *section,
			  const struct firmware_image *image,
			  const char *section_name);

/*
 * Preserves (copies) the given section (by name) from image_from to image_to.
 * The offset may be different, and the section data will be directly copied.
 * If the section does not exist on either images, return as failure.
 * If the source section is larger, contents on destination be truncated.
 * If the source section is smaller, the remaining area is not modified.
 * Returns 0 if success, non-zero if error.
 */
int preserve_firmware_section(const struct firmware_image *image_from,
			      struct firmware_image *image_to,
			      const char *section_name);

/*
 * Finds the GBB (Google Binary Block) header on a given firmware image.
 * Returns a pointer to valid GBB header, or NULL on not found.
 */
struct vb2_gbb_header;
const struct vb2_gbb_header *find_gbb(const struct firmware_image *image);

/*
 * Strips a string (usually from shell execution output) by removing all the
 * trailing characters in pattern. If pattern is NULL, match by space type
 * characters (space, new line, tab, ... etc).
 */
void strip_string(char *s, const char *pattern);

/*
 * Saves everything from stdin to given output file.
 * Returns 0 on success, otherwise failure.
 */
int save_file_from_stdin(const char *output);

/*
 * Executes a command on current host and returns stripped command output.
 * If the command has failed (exit code is not zero), returns an empty string.
 * The caller is responsible for releasing the returned string.
 */
char *host_shell(const char *command);

enum wp_state {
	WP_ERROR = -1,
	WP_DISABLED = 0,
	WP_ENABLED,
};

/* Helper function to return write protection status via given programmer. */
enum wp_state host_get_wp(const char *programmer);

/* The environment variable name for setting servod port. */
#define ENV_SERVOD_PORT	"SERVOD_PORT"

/*
 * Helper function to detect type of Servo board attached to host.
 * Returns a string as programmer parameter on success, otherwise NULL.
 */
char *host_detect_servo(int *need_prepare_ptr);

/*
 * Returns 1 if a given file (cbfs_entry_name) exists inside a particular CBFS
 * section of an image file, otherwise 0.
 */
int cbfs_file_exists(const char *image_file,
		     const char *section_name,
		     const char *cbfs_entry_name);

/*
 * Extracts files from a CBFS on given region (section) of image_file.
 * Returns the path to a temporary file on success, otherwise NULL.
 */
const char *cbfs_extract_file(const char *image_file,
			      const char *cbfs_region,
			      const char *cbfs_name,
			      struct tempfile *tempfiles);

/* Utilities for accessing system properties */
struct system_property {
	int (*getter)(void);
	int value;
	int initialized;
};

enum system_property_type {
	SYS_PROP_MAINFW_ACT,
	SYS_PROP_TPM_FWVER,
	SYS_PROP_FW_VBOOT2,
	SYS_PROP_PLATFORM_VER,
	SYS_PROP_WP_HW,
	SYS_PROP_WP_SW,
	SYS_PROP_MAX
};

/* Helper function to initialize system properties. */
void init_system_properties(struct system_property *props, int num);

/*
 * Returns rootkey hash of firmware image, or NULL on failure.
 */
const char *get_firmware_rootkey_hash(const struct firmware_image *image);

#endif  /* VBOOT_REFERENCE_FUTILITY_UPDATER_UTILS_H_ */
