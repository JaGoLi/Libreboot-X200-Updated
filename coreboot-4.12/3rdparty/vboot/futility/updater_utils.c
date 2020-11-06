/* Copyright 2019 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * The utility functions for firmware updater.
 */

#include <assert.h>
#include <limits.h>
#include <unistd.h>

#include "2common.h"
#include "crossystem.h"
#include "host_misc.h"
#include "util_misc.h"
#include "updater.h"

#define COMMAND_BUFFER_SIZE 256
#define FLASHROM_OUTPUT_WP_PATTERN "write protect is "

enum flashrom_ops {
	FLASHROM_READ,
	FLASHROM_WRITE,
	FLASHROM_WP_STATUS,
};

/* System environment values. */
static const char * const STR_REV = "rev",
		  * const FLASHROM_OUTPUT_WP_ENABLED =
			  FLASHROM_OUTPUT_WP_PATTERN "enabled",
		  * const FLASHROM_OUTPUT_WP_DISABLED =
			  FLASHROM_OUTPUT_WP_PATTERN "disabled";

/*
 * Strips a string (usually from shell execution output) by removing all the
 * trailing characters in pattern. If pattern is NULL, match by space type
 * characters (space, new line, tab, ... etc).
 */
void strip_string(char *s, const char *pattern)
{
	int len;
	assert(s);

	len = strlen(s);
	while (len-- > 0) {
		if (pattern) {
			if (!strchr(pattern, s[len]))
				break;
		} else {
			if (!isascii(s[len]) || !isspace(s[len]))
				break;
		}
		s[len] = '\0';
	}
}

/*
 * Saves everything from stdin to given output file.
 * Returns 0 on success, otherwise failure.
 */
int save_file_from_stdin(const char *output)
{
	FILE *in = stdin, *out = fopen(output, "wb");
	char buffer[4096];
	size_t sz;

	assert(in);
	if (!out)
		return -1;

	while (!feof(in)) {
		sz = fread(buffer, 1, sizeof(buffer), in);
		if (fwrite(buffer, 1, sz, out) != sz) {
			fclose(out);
			return -1;
		}
	}
	fclose(out);
	return 0;
}

/*
 * Returns 1 if a given file (cbfs_entry_name) exists inside a particular CBFS
 * section of an image file, otherwise 0.
 */
int cbfs_file_exists(const char *image_file,
		     const char *section_name,
		     const char *cbfs_entry_name)
{
	char *cmd;
	int r;

	ASPRINTF(&cmd,
		 "cbfstool '%s' print -r %s 2>/dev/null | grep -q '^%s '",
		 image_file, section_name, cbfs_entry_name);
	r = system(cmd);
	free(cmd);
	return !r;
}

/*
 * Extracts files from a CBFS on given region (section) of image_file.
 * Returns the path to a temporary file on success, otherwise NULL.
 */
const char *cbfs_extract_file(const char *image_file,
			      const char *cbfs_region,
			      const char *cbfs_name,
			      struct tempfile *tempfiles)
{
	const char *output = create_temp_file(tempfiles);
	char *command, *result;

	if (!output)
		return NULL;

	ASPRINTF(&command, "cbfstool \"%s\" extract -r %s -n \"%s\" "
		 "-f \"%s\" 2>&1", image_file, cbfs_region,
		 cbfs_name, output);

	result = host_shell(command);
	free(command);

	if (!*result)
		output = NULL;

	free(result);
	return output;
}

/*
 * Loads the firmware information from an FMAP section in loaded firmware image.
 * The section should only contain ASCIIZ string as firmware version.
 * Returns 0 if a non-empty version string is stored in *version, otherwise -1.
 */
static int load_firmware_version(struct firmware_image *image,
				 const char *section_name,
				 char **version)
{
	struct firmware_section fwid;
	int len = 0;

	/*
	 * section_name is NULL when parsing the RW versions on a non-vboot
	 * image (and already warned in load_firmware_image). We still need to
	 * initialize *version with empty string.
	 */
	if (section_name) {
		find_firmware_section(&fwid, image, section_name);
		if (fwid.size)
			len = fwid.size;
		else
			WARN("No valid section '%s', missing version info.\n",
			     section_name);
	}

	if (!len) {
		*version = strdup("");
		return -1;
	}

	/*
	 * For 'system current' images, the version string may contain
	 * invalid characters that we do want to strip.
	 */
	*version = strndup((const char *)fwid.data, len);
	strip_string(*version, "\xff");
	return 0;
}

/*
 * Loads a firmware image from file.
 * If archive is provided and file_name is a relative path, read the file from
 * archive.
 * Returns IMAGE_LOAD_SUCCESS on success, IMAGE_READ_FAILURE on file I/O
 * failure, or IMAGE_PARSE_FAILURE for non-vboot images.
 */
int load_firmware_image(struct firmware_image *image, const char *file_name,
			struct archive *archive)
{
	int ret = IMAGE_LOAD_SUCCESS;
	const char *section_a = NULL, *section_b = NULL;

	if (!file_name) {
		ERROR("No file name given\n");
		return IMAGE_READ_FAILURE;
	}

	VB2_DEBUG("Load image file from %s...\n", file_name);

	if (!archive_has_entry(archive, file_name)) {
		ERROR("Does not exist: %s\n", file_name);
		return IMAGE_READ_FAILURE;
	}
	if (archive_read_file(archive, file_name, &image->data, &image->size,
			      NULL) != VB2_SUCCESS) {
		ERROR("Failed to load %s\n", file_name);
		return IMAGE_READ_FAILURE;
	}

	VB2_DEBUG("Image size: %d\n", image->size);
	assert(image->data);
	image->file_name = strdup(file_name);
	image->fmap_header = fmap_find(image->data, image->size);

	if (!image->fmap_header) {
		ERROR("Invalid image file (missing FMAP): %s\n", file_name);
		ret = IMAGE_PARSE_FAILURE;
	}

	if (load_firmware_version(image, FMAP_RO_FRID, &image->ro_version))
		ret = IMAGE_PARSE_FAILURE;

	if (firmware_section_exists(image, FMAP_RW_FWID_A)) {
		section_a = FMAP_RW_FWID_A;
		section_b = FMAP_RW_FWID_B;
	} else if (firmware_section_exists(image, FMAP_RW_FWID)) {
		section_a = FMAP_RW_FWID;
		section_b = FMAP_RW_FWID;
	} else if (!ret) {
		ERROR("Unsupported VBoot firmware (no RW ID): %s\n", file_name);
		ret = IMAGE_PARSE_FAILURE;
	}

	/*
	 * Load and initialize both RW A and B sections.
	 * Note some unit tests will create only RW A.
	 */
	load_firmware_version(image, section_a, &image->rw_version_a);
	load_firmware_version(image, section_b, &image->rw_version_b);

	return ret;
}

/*
 * Generates a temporary file for snapshot of firmware image contents.
 *
 * Returns a file path if success, otherwise NULL.
 */
const char *get_firmware_image_temp_file(const struct firmware_image *image,
					 struct tempfile *tempfiles)
{
	const char *tmp_path = create_temp_file(tempfiles);
	if (!tmp_path)
		return NULL;

	if (vb2_write_file(tmp_path, image->data, image->size) != VB2_SUCCESS) {
		ERROR("Failed writing %s firmware image (%u bytes) to %s.\n",
		      image->programmer ? image->programmer : "temp",
		      image->size, tmp_path);
		return NULL;
	}
	return tmp_path;
}

/*
 * Frees the allocated resource from a firmware image object.
 */
void free_firmware_image(struct firmware_image *image)
{
	/*
	 * The programmer is not allocated by load_firmware_image and must be
	 * preserved explicitly.
	 */
	const char *programmer = image->programmer;

	free(image->data);
	free(image->file_name);
	free(image->ro_version);
	free(image->rw_version_a);
	free(image->rw_version_b);
	memset(image, 0, sizeof(*image));
	image->programmer = programmer;
}

/*
 * Finds a firmware section by given name in the firmware image.
 * If successful, return zero and *section argument contains the address and
 * size of the section; otherwise failure.
 */
int find_firmware_section(struct firmware_section *section,
			  const struct firmware_image *image,
			  const char *section_name)
{
	FmapAreaHeader *fah = NULL;
	uint8_t *ptr;

	section->data = NULL;
	section->size = 0;
	ptr = fmap_find_by_name(
			image->data, image->size, image->fmap_header,
			section_name, &fah);
	if (!ptr)
		return -1;
	section->data = (uint8_t *)ptr;
	section->size = fah->area_size;
	return 0;
}

/*
 * Returns true if the given FMAP section exists in the firmware image.
 */
int firmware_section_exists(const struct firmware_image *image,
			    const char *section_name)
{
	struct firmware_section section;
	find_firmware_section(&section, image, section_name);
	return section.data != NULL;
}

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
			      const char *section_name)
{
	struct firmware_section from, to;

	find_firmware_section(&from, image_from, section_name);
	find_firmware_section(&to, image_to, section_name);
	if (!from.data || !to.data) {
		VB2_DEBUG("Cannot find section %.*s: from=%p, to=%p\n",
			  FMAP_NAMELEN, section_name, from.data, to.data);
		return -1;
	}
	if (from.size > to.size) {
		WARN("Section %.*s is truncated after updated.\n",
		     FMAP_NAMELEN, section_name);
	}
	/* Use memmove in case if we need to deal with sections that overlap. */
	memmove(to.data, from.data, VB2_MIN(from.size, to.size));
	return 0;
}

/*
 * Finds the GBB (Google Binary Block) header on a given firmware image.
 * Returns a pointer to valid GBB header, or NULL on not found.
 */
const struct vb2_gbb_header *find_gbb(const struct firmware_image *image)
{
	struct firmware_section section;
	struct vb2_gbb_header *gbb_header;

	find_firmware_section(&section, image, FMAP_RO_GBB);
	gbb_header = (struct vb2_gbb_header *)section.data;
	if (!futil_valid_gbb_header(gbb_header, section.size, NULL)) {
		ERROR("Cannot find GBB in image: %s.\n", image->file_name);
		return NULL;
	}
	return gbb_header;
}

/*
 * Executes a command on current host and returns stripped command output.
 * If the command has failed (exit code is not zero), returns an empty string.
 * The caller is responsible for releasing the returned string.
 */
char *host_shell(const char *command)
{
	/* Currently all commands we use do not have large output. */
	char buf[COMMAND_BUFFER_SIZE];

	int result;
	FILE *fp = popen(command, "r");

	VB2_DEBUG("%s\n", command);
	buf[0] = '\0';
	if (!fp) {
		VB2_DEBUG("Execution error for %s.\n", command);
		return strdup(buf);
	}

	if (fgets(buf, sizeof(buf), fp))
		strip_string(buf, NULL);
	result = pclose(fp);
	if (!WIFEXITED(result) || WEXITSTATUS(result) != 0) {
		VB2_DEBUG("Execution failure with exit code %d: %s\n",
			  WEXITSTATUS(result), command);
		/*
		 * Discard all output if command failed, for example command
		 * syntax failure may lead to garbage in stdout.
		 */
		buf[0] = '\0';
	}
	return strdup(buf);
}


/* An helper function to return "mainfw_act" system property.  */
static int host_get_mainfw_act(void)
{
	char buf[VB_MAX_STRING_PROPERTY];

	if (!VbGetSystemPropertyString("mainfw_act", buf, sizeof(buf)))
		return SLOT_UNKNOWN;

	if (strcmp(buf, FWACT_A) == 0)
		return SLOT_A;
	else if (strcmp(buf, FWACT_B) == 0)
		return SLOT_B;

	return SLOT_UNKNOWN;
}

/* A helper function to return the "tpm_fwver" system property. */
static int host_get_tpm_fwver(void)
{
	return VbGetSystemPropertyInt("tpm_fwver");
}

/* A helper function to return the "hardware write protection" status. */
static int host_get_wp_hw(void)
{
	/* wpsw refers to write protection 'switch', not 'software'. */
	return VbGetSystemPropertyInt("wpsw_cur");
}

/* A helper function to return "fw_vboot2" system property. */
static int host_get_fw_vboot2(void)
{
	return VbGetSystemPropertyInt("fw_vboot2");
}

/* A help function to get $(mosys platform version). */
static int host_get_platform_version(void)
{
	char *result = host_shell("mosys platform version");
	long rev = -1;

	/* Result should be 'revN' */
	if (strncmp(result, STR_REV, strlen(STR_REV)) == 0)
		rev = strtol(result + strlen(STR_REV), NULL, 0);

	/* we should never have negative or extremely large versions,
	 * but clamp just to be sure
	 */
	if (rev < 0)
		rev = 0;
	if (rev > INT_MAX)
		rev = INT_MAX;

	VB2_DEBUG("Raw data = [%s], parsed version is %ld\n", result, rev);

	free(result);
	return rev;
}

/*
 * Helper function to detect type of Servo board attached to host,
 * and store the right programmer / prepare settings to arguments.
 * Returns 0 if success, non-zero if error.
 */
int host_detect_servo(const char **programmer_ptr, int *need_prepare_ptr)
{
	int ret = 0;
	char *servo_type = host_shell("dut-control -o servo_type 2>/dev/null");
	const char *programmer = NULL;
	int need_prepare = 0;  /* To prepare by dut-control cpu_fw_spi:on */

	if (!*servo_type) {
		ERROR("Failed to get servo type. Check servod.\n");
		ret = 1;
	} else if (strstr(servo_type, "servo_micro")) {
		VB2_DEBUG("Selected Servo Micro.\n");
		programmer = "raiden_debug_spi";
		need_prepare = 1;
	} else if (strstr(servo_type, "ccd_cr50")) {
		VB2_DEBUG("Selected CCD CR50.\n");
		programmer = "raiden_debug_spi:target=AP";
	} else {
		VB2_DEBUG("Selected Servo V2.\n");
		programmer = "ft2232_spi:type=servo-v2";
		need_prepare = 1;
	}

	free(servo_type);
	if (programmer && !*programmer_ptr)
		*programmer_ptr = programmer;
	*need_prepare_ptr = need_prepare;

	return ret;
}

/*
 * A helper function to invoke flashrom(8) command.
 * Returns 0 if success, non-zero if error.
 */
static int host_flashrom(enum flashrom_ops op, const char *image_path,
			 const char *programmer, int verbose,
			 const char *section_name, const char *extra)
{
	char *command, *result;
	const char *op_cmd, *dash_i = "-i", *postfix = "";
	int r;

	switch (verbose) {
	case 0:
		postfix = " >/dev/null 2>&1";
		break;
	case 1:
		break;
	case 2:
		postfix = "-V";
		break;
	case 3:
		postfix = "-V -V";
		break;
	default:
		postfix = "-V -V -V";
		break;
	}

	if (!section_name || !*section_name) {
		dash_i = "";
		section_name = "";
	}

	switch (op) {
	case FLASHROM_READ:
		op_cmd = "-r";
		assert(image_path);
		break;

	case FLASHROM_WRITE:
		op_cmd = "-w";
		assert(image_path);
		break;

	case FLASHROM_WP_STATUS:
		op_cmd = "--wp-status";
		assert(image_path == NULL);
		image_path = "";
		/* grep is needed because host_shell only returns 1 line. */
		postfix = " 2>/dev/null | grep \"" \
			   FLASHROM_OUTPUT_WP_PATTERN "\"";
		break;

	default:
		assert(0);
		return -1;
	}

	if (!extra)
		extra = "";

	/* TODO(hungte) In future we should link with flashrom directly. */
	ASPRINTF(&command, "flashrom %s %s -p %s %s %s %s %s", op_cmd,
		 image_path, programmer, dash_i, section_name, extra,
		 postfix);

	if (verbose)
		INFO("Executing: %s\n", command);

	if (op != FLASHROM_WP_STATUS) {
		r = system(command);
		free(command);
		if (r)
			ERROR("Error code: %d\n", r);
		return r;
	}

	result = host_shell(command);
	strip_string(result, NULL);
	free(command);
	VB2_DEBUG("wp-status: %s\n", result);

	if (strstr(result, FLASHROM_OUTPUT_WP_ENABLED))
		r = WP_ENABLED;
	else if (strstr(result, FLASHROM_OUTPUT_WP_DISABLED))
		r = WP_DISABLED;
	else
		r = WP_ERROR;
	free(result);
	return r;
}

/* Helper function to return write protection status via given programmer. */
enum wp_state host_get_wp(const char *programmer)
{
	return host_flashrom(FLASHROM_WP_STATUS, NULL, programmer, 0, NULL,
			     NULL);
}

/* Helper function to return host software write protection status. */
static int host_get_wp_sw(void)
{
	return host_get_wp(PROG_HOST);
}

/*
 * Loads the active system firmware image (usually from SPI flash chip).
 * Returns 0 if success, non-zero if error.
 */
int load_system_firmware(struct firmware_image *image,
			 struct tempfile *tempfiles, int verbosity)
{
	int r;
	const char *tmp_path = create_temp_file(tempfiles);

	if (!tmp_path)
		return -1;

	r = host_flashrom(FLASHROM_READ, tmp_path, image->programmer,
			  verbosity, NULL, NULL);
	if (!r)
		r = load_firmware_image(image, tmp_path, NULL);
	return r;
}

/*
 * Writes a section from given firmware image to system firmware.
 * If section_name is NULL, write whole image.
 * Returns 0 if success, non-zero if error.
 */
int write_system_firmware(const struct firmware_image *image,
			  const struct firmware_image *diff_image,
			  const char *section_name,
			  struct tempfile *tempfiles,
			  int verbosity)
{
	const char *tmp_path = get_firmware_image_temp_file(image, tempfiles);
	const char *tmp_diff = NULL;

	const char *programmer = image->programmer;
	char *extra = NULL;
	int r;

	if (!tmp_path)
		return -1;

	if (diff_image) {
		tmp_diff = get_firmware_image_temp_file(
				diff_image, tempfiles);
		if (!tmp_diff)
			return -1;
		ASPRINTF(&extra, "--noverify --diff=%s", tmp_diff);
	}

	r = host_flashrom(FLASHROM_WRITE, tmp_path, programmer, verbosity,
			  section_name, extra);
	free(extra);
	return r;
}

/* Helper function to configure all properties. */
void init_system_properties(struct system_property *props, int num)
{
	memset(props, 0, num * sizeof(*props));
	assert(num >= SYS_PROP_MAX);
	props[SYS_PROP_MAINFW_ACT].getter = host_get_mainfw_act;
	props[SYS_PROP_TPM_FWVER].getter = host_get_tpm_fwver;
	props[SYS_PROP_FW_VBOOT2].getter = host_get_fw_vboot2;
	props[SYS_PROP_PLATFORM_VER].getter = host_get_platform_version;
	props[SYS_PROP_WP_HW].getter = host_get_wp_hw;
	props[SYS_PROP_WP_SW].getter = host_get_wp_sw;
}

/*
 * Helper function to create a new temporary file.
 * All files created will be removed remove_all_temp_files().
 * Returns the path of new file, or NULL on failure.
 */
const char *create_temp_file(struct tempfile *head)
{
	struct tempfile *new_temp;
	char new_path[] = P_tmpdir "/fwupdater.XXXXXX";
	int fd;

	fd = mkstemp(new_path);
	if (fd < 0) {
		ERROR("Failed to create new temp file in %s\n", new_path);
		return NULL;
	}
	close(fd);
	new_temp = (struct tempfile *)malloc(sizeof(*new_temp));
	if (new_temp)
		new_temp->filepath = strdup(new_path);
	if (!new_temp || !new_temp->filepath) {
		remove(new_path);
		free(new_temp);
		ERROR("Failed to allocate buffer for new temp file.\n");
		return NULL;
	}
	VB2_DEBUG("Created new temporary file: %s.\n", new_path);
	new_temp->next = NULL;
	while (head->next)
		head = head->next;
	head->next = new_temp;
	return new_temp->filepath;
}

/*
 * Helper function to remove all files created by create_temp_file().
 * This is intended to be called only once at end of program execution.
 */
void remove_all_temp_files(struct tempfile *head)
{
	/* head itself is dummy and should not be removed. */
	assert(!head->filepath);
	struct tempfile *next = head->next;
	head->next = NULL;
	while (next) {
		head = next;
		next = head->next;
		assert(head->filepath);
		VB2_DEBUG("Remove temporary file: %s.\n", head->filepath);
		remove(head->filepath);
		free(head->filepath);
		free(head);
	}
}

/*
 * Returns rootkey hash of firmware image, or NULL on failure.
 */
const char *get_firmware_rootkey_hash(const struct firmware_image *image)
{
	const struct vb2_gbb_header *gbb = NULL;
	const struct vb2_packed_key *rootkey = NULL;

	assert(image->data);

	gbb = find_gbb(image);
	if (!gbb) {
		WARN("No GBB found in image.\n");
		return NULL;
	}

	rootkey = get_rootkey(gbb);
	if (!rootkey) {
		WARN("No rootkey found in image.\n");
		return NULL;
	}

	return packed_key_sha1_string(rootkey);
}
