/* Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Tests for vboot_api_kernel, part 2
 */

#include "2common.h"
#include "2misc.h"
#include "2nvstorage.h"
#include "2secdata.h"
#include "2secdata_struct.h"
#include "host_common.h"
#include "load_kernel_fw.h"
#include "test_common.h"
#include "tss_constants.h"
#include "vboot_audio.h"
#include "vboot_kernel.h"
#include "vboot_struct.h"
#include "vboot_test.h"
#include "vboot_ui_legacy.h"

/* Mock data */
static LoadKernelParams lkp;
static uint8_t workbuf[VB2_KERNEL_WORKBUF_RECOMMENDED_SIZE]
	__attribute__((aligned(VB2_WORKBUF_ALIGN)));
static struct vb2_context *ctx;
static struct vb2_shared_data *sd;
static struct vb2_gbb_header gbb;
static struct vb2_secdata_fwmp *fwmp;

static int audio_looping_calls_left;
static uint32_t vbtlk_retval;
static int vbtlk_expect_fixed;
static int vbtlk_expect_removable;
static int vbexlegacy_called;
static enum VbAltFwIndex_t altfw_num;
static uint32_t current_ticks;
static int trust_ec;
static int virtdev_set;
static uint32_t virtdev_fail;
static uint32_t mock_keypress[16];
static uint32_t mock_keyflags[8];
static uint32_t mock_keypress_count;

#define GPIO_SHUTDOWN   1
#define GPIO_PRESENCE   2
#define GPIO_LID_CLOSED 4
typedef struct GpioState {
	uint32_t gpio_flags;
	uint32_t count;
} GpioState;
struct GpioState mock_gpio[8];
static uint32_t mock_gpio_count;

static uint32_t screens_displayed[8];
static uint32_t screens_count = 0;
static uint32_t mock_num_disks[8];
static uint32_t mock_num_disks_count;
static int tpm_set_mode_called;
static enum vb2_tpm_mode tpm_mode;

/* Extra character to guarantee null termination. */
static char set_vendor_data[VENDOR_DATA_LENGTH + 2];
static int set_vendor_data_called;

/*
 * Mocks the assertion of 1 or more gpios in |gpio_flags| for 100 ticks after
 * an optional |ticks| delay.
 */
static void MockGpioAfter(uint32_t ticks, uint32_t gpio_flags)
{
	uint32_t index = 0;
	if (ticks > 0)
		mock_gpio[index++].count = ticks - 1;

	mock_gpio[index].gpio_flags = gpio_flags;
	mock_gpio[index].count = 100;
}

/* Reset mock data (for use before each test) */
static void ResetMocks(void)
{
	vb2_reset_power_button();

	memset(&lkp, 0, sizeof(lkp));

	TEST_SUCC(vb2api_init(workbuf, sizeof(workbuf), &ctx),
		  "vb2api_init failed");
	vb2_nv_init(ctx);

	sd = vb2_get_sd(ctx);
	sd->flags |= VB2_SD_FLAG_DISPLAY_AVAILABLE;

	/* CRC will be invalid after here, but nobody's checking */
	sd->status |= VB2_SD_STATUS_SECDATA_FWMP_INIT;
	fwmp = (struct vb2_secdata_fwmp *)ctx->secdata_fwmp;

	memset(&gbb, 0, sizeof(gbb));

	audio_looping_calls_left = 30;
	vbtlk_retval = VB2_ERROR_MOCK;
	vbtlk_expect_fixed = 0;
	vbtlk_expect_removable = 0;
	vbexlegacy_called = 0;
	altfw_num = -100;
	current_ticks = 0;
	trust_ec = 0;
	virtdev_set = 0;
	virtdev_fail = 0;
	set_vendor_data_called = 0;

	memset(screens_displayed, 0, sizeof(screens_displayed));
	screens_count = 0;

	memset(mock_keypress, 0, sizeof(mock_keypress));
	memset(mock_keyflags, 0, sizeof(mock_keyflags));
	mock_keypress_count = 0;
	memset(mock_gpio, 0, sizeof(mock_gpio));
	mock_gpio_count = 0;
	memset(mock_num_disks, 0, sizeof(mock_num_disks));
	mock_num_disks_count = 0;

	tpm_set_mode_called = 0;
	tpm_mode = VB2_TPM_MODE_ENABLED_TENTATIVE;
}

/* Mock functions */

struct vb2_gbb_header *vb2_get_gbb(struct vb2_context *c)
{
	return &gbb;
}

uint32_t VbExIsShutdownRequested(void)
{
	uint32_t result = 0;
	if (mock_gpio_count >= ARRAY_SIZE(mock_gpio))
		return 0;
	if (mock_gpio[mock_gpio_count].gpio_flags & GPIO_SHUTDOWN)
		result |= VB_SHUTDOWN_REQUEST_POWER_BUTTON;
	if (mock_gpio[mock_gpio_count].gpio_flags & GPIO_LID_CLOSED)
		result |= VB_SHUTDOWN_REQUEST_LID_CLOSED;
	if (mock_gpio[mock_gpio_count].count > 0) {
		--mock_gpio[mock_gpio_count].count;
	} else {
		++mock_gpio_count;
	}
	return result;
}

uint32_t VbExKeyboardRead(void)
{
	return VbExKeyboardReadWithFlags(NULL);
}

uint32_t VbExKeyboardReadWithFlags(uint32_t *key_flags)
{
	if (mock_keypress_count < ARRAY_SIZE(mock_keypress)) {
		if (key_flags != NULL &&
		    mock_keypress_count < ARRAY_SIZE(mock_keyflags))
			*key_flags = mock_keyflags[mock_keypress_count];
		return mock_keypress[mock_keypress_count++];
	} else
		return 0;
}

int vb2ex_physical_presence_pressed(void)
{
	uint32_t result = 0;

	if (mock_gpio_count >= ARRAY_SIZE(mock_gpio))
		return 0;

	if ((mock_gpio[mock_gpio_count].gpio_flags & GPIO_PRESENCE))
		result = 1;

	if (mock_gpio[mock_gpio_count].count > 0)
		--mock_gpio[mock_gpio_count].count;
	else
		++mock_gpio_count;

	return result;
}

vb2_error_t VbExLegacy(enum VbAltFwIndex_t _altfw_num)
{
	vbexlegacy_called++;
	altfw_num = _altfw_num;

	/* VbExLegacy() can only return failure, or not return at all. */
	return VB2_ERROR_UNKNOWN;
}

void vb2ex_msleep(uint32_t msec)
{
	current_ticks += msec;
}

uint32_t vb2ex_mtime(void)
{
	return current_ticks;
}

vb2_error_t VbExDiskGetInfo(VbDiskInfo **infos_ptr, uint32_t *count,
			    uint32_t disk_flags)
{
	if (mock_num_disks_count < ARRAY_SIZE(mock_num_disks)) {
		if (mock_num_disks[mock_num_disks_count] == -1)
			return VB2_ERROR_MOCK;
		else
			*count = mock_num_disks[mock_num_disks_count++];
	} else {
		*count = 0;
	}
	return VB2_SUCCESS;
}

vb2_error_t VbExDiskFreeInfo(VbDiskInfo *infos,
			     VbExDiskHandle_t preserve_handle)
{
	return VB2_SUCCESS;
}

int vb2ex_ec_trusted(void)
{
	return trust_ec;
}

int vb2_audio_looping(void)
{
	if (audio_looping_calls_left == 0)
		return 0;
	else if (audio_looping_calls_left > 0)
		audio_looping_calls_left--;

	return 1;
}

vb2_error_t VbTryLoadKernel(struct vb2_context *c, uint32_t get_info_flags)
{
	/*
	 * TODO: Currently we don't have a good way of testing for an ordered
	 * sequence of VB_DISK_FLAG_FIXED and then VB_DISK_FLAG_REMOVABLE.  If
	 * both are set, then just assume success.
	 */
	if (vbtlk_expect_fixed && vbtlk_expect_removable)
		return vbtlk_retval;

	TEST_EQ(!!vbtlk_expect_fixed,
		!!(get_info_flags & VB_DISK_FLAG_FIXED),
		"  VbTryLoadKernel unexpected fixed disk call");
	TEST_EQ(!!vbtlk_expect_removable,
		!!(get_info_flags & VB_DISK_FLAG_REMOVABLE),
		"  VbTryLoadKernel unexpected removable disk call");

	return vbtlk_retval;
}

vb2_error_t VbDisplayScreen(struct vb2_context *c, uint32_t screen, int force,
			    const VbScreenData *data)
{
	if (screens_count < ARRAY_SIZE(screens_displayed))
		screens_displayed[screens_count++] = screen;

	return VB2_SUCCESS;
}

void vb2_enable_developer_mode(struct vb2_context *c)
{
	VB2_ASSERT(!virtdev_fail);
	virtdev_set = 1;
}

vb2_error_t VbExSetVendorData(const char *vendor_data_value)
{
	set_vendor_data_called = 1;
	/*
	 * set_vendor_data is a global variable, so it is automatically
	 * initialized to zero, and so the -1 will ensure the string is null
	 * terminated.
	 */
	strncpy(set_vendor_data, vendor_data_value, sizeof(set_vendor_data) - 1);

	return VB2_SUCCESS;
}

vb2_error_t vb2ex_tpm_set_mode(enum vb2_tpm_mode mode_val)
{
	tpm_set_mode_called = 1;

	/* Fail if the TPM is already disabled. */
	if (tpm_mode == VB2_TPM_MODE_DISABLED)
		return VB2_ERROR_UNKNOWN;

	tpm_mode = mode_val;
	return VB2_SUCCESS;
}

/* Tests */

/*
 * Helper function to test VbUserConfirms against a sequence of gpio events.
 * caller specifies a sequence of gpio events and the expected confirm vs.
 * reboot result.
 *
 * Non-asserted gpios are used for 5 events, then 'first' for 5 events,
 * 'second' for 5 events, and 'third' for 5 events.
 * Typically most tests want 5 events of each type (so they'll specify 0 for
 * 'first' and use 'second' through 'fourth'), but a few tests want the
 * shutdown event to be seen once.
 */
static void VbUserConfirmsTestGpio(uint32_t first, uint32_t second,
				   uint32_t third, uint32_t confirm,
				   const char *msg)
{
	ResetMocks();
	mock_gpio[0].gpio_flags = 0;
	mock_gpio[0].count = 4;
	mock_gpio[1].gpio_flags = first;
	mock_gpio[1].count = 4;
	mock_gpio[2].gpio_flags = second;
	mock_gpio[2].count = 4;
	mock_gpio[3].gpio_flags = third;
	mock_gpio[3].count = 4;
	if (confirm) {
		TEST_EQ(VbUserConfirms(ctx,
			VB_CONFIRM_SPACE_MEANS_NO |
			VB_CONFIRM_MUST_TRUST_KEYBOARD),
			1, msg);
	} else {
		TEST_EQ(VbUserConfirms(ctx,
			VB_CONFIRM_SPACE_MEANS_NO |
			VB_CONFIRM_MUST_TRUST_KEYBOARD),
			-1, msg);
	}
}

static void VbUserConfirmsKeyboardTest(void)
{
	VB2_DEBUG("Testing VbUserConfirms()...\n");

	ResetMocks();
	MockGpioAfter(1, GPIO_SHUTDOWN);
	TEST_EQ(VbUserConfirms(ctx, 0), -1, "Shutdown requested");

	ResetMocks();
	mock_keypress[0] = VB_BUTTON_POWER_SHORT_PRESS;
	TEST_EQ(VbUserConfirms(ctx, 0), -1, "Shutdown requested");

	ResetMocks();
	mock_keypress[0] = VB_KEY_ENTER;
	TEST_EQ(VbUserConfirms(ctx, 0), 1, "Enter");

	ResetMocks();
	mock_keypress[0] = VB_KEY_ESC;
	TEST_EQ(VbUserConfirms(ctx, 0), 0, "Esc");

	ResetMocks();
	mock_keypress[0] = ' ';
	MockGpioAfter(1, GPIO_SHUTDOWN);
	TEST_EQ(VbUserConfirms(ctx, VB_CONFIRM_SPACE_MEANS_NO), 0,
		"Space means no");

	ResetMocks();
	mock_keypress[0] = ' ';
	MockGpioAfter(1, GPIO_SHUTDOWN);
	TEST_EQ(VbUserConfirms(ctx, 0), -1, "Space ignored");

	ResetMocks();
	mock_keypress[0] = VB_KEY_ENTER;
	mock_keyflags[0] = VB_KEY_FLAG_TRUSTED_KEYBOARD;
	TEST_EQ(VbUserConfirms(ctx, VB_CONFIRM_MUST_TRUST_KEYBOARD),
		1, "Enter with trusted keyboard");

	ResetMocks();
	mock_keypress[0] = VB_KEY_ENTER;	/* untrusted */
	mock_keypress[1] = ' ';
	TEST_EQ(VbUserConfirms(ctx,
			       VB_CONFIRM_SPACE_MEANS_NO |
			       VB_CONFIRM_MUST_TRUST_KEYBOARD),
		0, "Untrusted keyboard");

	ResetMocks();
	mock_keypress[0] = VB_KEY_ENTER;
	mock_keypress[1] = 'y';
	mock_keypress[2] = 'z';
	mock_keypress[3] = ' ';
	mock_gpio[0].gpio_flags = GPIO_PRESENCE;
	mock_gpio[0].count = ~0;
	TEST_EQ(VbUserConfirms(ctx,
			       VB_CONFIRM_SPACE_MEANS_NO |
			       VB_CONFIRM_MUST_TRUST_KEYBOARD),
		0, "Recovery button stuck");

	VB2_DEBUG("...done.\n");
}

static void VbUserConfirmsPhysicalPresenceTest(void)
{
	ResetMocks();
	MockGpioAfter(0, GPIO_PRESENCE);
	TEST_EQ(VbUserConfirms(ctx,
			       VB_CONFIRM_SPACE_MEANS_NO |
			       VB_CONFIRM_MUST_TRUST_KEYBOARD),
		1, "Presence button");

	/*
	 * List of possiblities for shutdown and physical presence events that
	 * occur over time.  Time advanced from left to right (where each
	 * represents the gpio[s] that are seen during a given iteration of
	 * the loop).  The meaning of the characters:
	 *
	 *   _ means no gpio
	 *   s means shutdown gpio
	 *   p means presence gpio
	 *   B means both shutdown and presence gpio
	 *
	 *  1: ______ppp______ -> confirm
	 *  2: ______sss______ -> shutdown
	 *  3: ___pppsss______ -> confirm
	 *  4: ___sssppp______ -> shutdown
	 *  5: ___pppBBB______ -> confirm
	 *  6: ___pppBBBppp___ -> shutdown
	 *  7: ___pppBBBsss___ -> confirm
	 *  8: ___sssBBB______ -> confirm
	 *  9: ___sssBBBppp___ -> shutdown
	 * 10: ___sssBBBsss___ -> confirm
	 * 11: ______BBB______ -> confirm
	 * 12: ______BBBsss___ -> confirm
	 * 13: ______BBBppp___ -> shutdown
	 */

	/* 1: presence means confirm */
	VbUserConfirmsTestGpio(GPIO_PRESENCE, 0, 0, 1, "presence");

	/* 2: shutdown means shutdown */
	VbUserConfirmsTestGpio(GPIO_SHUTDOWN, 0, 0, 0, "shutdown");

	/* 3: presence then shutdown means confirm */
	VbUserConfirmsTestGpio(GPIO_PRESENCE, GPIO_SHUTDOWN, 0, 1,
			       "presence then shutdown");

	/* 4: shutdown then presence means shutdown */
	VbUserConfirmsTestGpio(GPIO_SHUTDOWN, GPIO_PRESENCE, 0, 0,
			       "shutdown then presence");

	/* 5: presence then shutdown+presence then none mean confirm */
	VbUserConfirmsTestGpio(GPIO_PRESENCE, GPIO_PRESENCE | GPIO_SHUTDOWN,
			       0, 1, "presence, both, none");

	/* 6: presence then shutdown+presence then presence means shutdown */
	VbUserConfirmsTestGpio(GPIO_PRESENCE, GPIO_PRESENCE | GPIO_SHUTDOWN,
			       GPIO_PRESENCE, 0, "presence, both, presence");

	/* 7: presence then shutdown+presence then shutdown means confirm */
	VbUserConfirmsTestGpio(GPIO_PRESENCE, GPIO_PRESENCE | GPIO_SHUTDOWN,
			       GPIO_SHUTDOWN, 1, "presence, both, shutdown");

	/* 8: shutdown then shutdown+presence then none means confirm */
	VbUserConfirmsTestGpio(GPIO_SHUTDOWN, GPIO_PRESENCE | GPIO_SHUTDOWN,
			       0, 1, "shutdown, both, none");

	/* 9: shutdown then shutdown+presence then presence means shutdown */
	VbUserConfirmsTestGpio(GPIO_SHUTDOWN, GPIO_PRESENCE | GPIO_SHUTDOWN,
			       GPIO_PRESENCE, 0, "shutdown, both, presence");

	/* 10: shutdown then shutdown+presence then shutdown means confirm */
	VbUserConfirmsTestGpio(GPIO_SHUTDOWN, GPIO_PRESENCE | GPIO_SHUTDOWN,
			       GPIO_SHUTDOWN, 1, "shutdown, both, shutdown");

	/* 11: shutdown+presence then none means confirm */
	VbUserConfirmsTestGpio(GPIO_PRESENCE | GPIO_SHUTDOWN, 0, 0, 1,
			       "both");

	/* 12: shutdown+presence then shutdown means confirm */
	VbUserConfirmsTestGpio(GPIO_PRESENCE | GPIO_SHUTDOWN,
			       GPIO_SHUTDOWN, 0, 1, "both, shutdown");

	/* 13: shutdown+presence then presence means shutdown */
	VbUserConfirmsTestGpio(GPIO_PRESENCE | GPIO_SHUTDOWN,
			       GPIO_PRESENCE, 0, 0, "both, presence");

}

static void VbBootDevTest(void)
{
	int key;

	VB2_DEBUG("Testing VbBootDeveloperLegacyClamshell()...\n");

	/* Proceed after timeout */
	ResetMocks();
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK, "Timeout");
	TEST_EQ(screens_displayed[0], VB_SCREEN_DEVELOPER_WARNING,
		"  warning screen");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST), 0,
		"  recovery reason");
	TEST_EQ(audio_looping_calls_left, 0, "  used up audio");

	/* Proceed to legacy after timeout if GBB flag set */
	ResetMocks();
	gbb.flags |= VB2_GBB_FLAG_DEFAULT_DEV_BOOT_LEGACY |
			VB2_GBB_FLAG_FORCE_DEV_BOOT_LEGACY;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK, "Timeout");
	TEST_EQ(vbexlegacy_called, 1, "  try legacy");
	TEST_EQ(altfw_num, 0, "  check altfw_num");

	/* Proceed to legacy after timeout if GBB flag set */
	ResetMocks();
	gbb.flags |= VB2_GBB_FLAG_DEFAULT_DEV_BOOT_LEGACY |
			VB2_GBB_FLAG_FORCE_DEV_BOOT_LEGACY;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK, "Timeout");
	TEST_EQ(vbexlegacy_called, 1, "  try legacy");
	TEST_EQ(altfw_num, 0, "  check altfw_num");

	/* Proceed to legacy after timeout if boot legacy and default boot
	   legacy are set */
	ResetMocks();
	vb2_nv_set(ctx, VB2_NV_DEV_DEFAULT_BOOT,
		   VB2_DEV_DEFAULT_BOOT_TARGET_LEGACY);
	vb2_nv_set(ctx, VB2_NV_DEV_BOOT_LEGACY, 1);
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK, "Timeout");
	TEST_EQ(vbexlegacy_called, 1, "  try legacy");
	TEST_EQ(altfw_num, 0, "  check altfw_num");

	/* Proceed to legacy boot mode only if enabled */
	ResetMocks();
	vb2_nv_set(ctx, VB2_NV_DEV_DEFAULT_BOOT,
		   VB2_DEV_DEFAULT_BOOT_TARGET_LEGACY);
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK, "Timeout");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");

	/* Proceed to external disk after timeout if boot external and default
	 * boot external are set */
	ResetMocks();
	vb2_nv_set(ctx, VB2_NV_DEV_DEFAULT_BOOT,
		   VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL);
	vb2_nv_set(ctx, VB2_NV_DEV_BOOT_EXTERNAL, 1);
	vbtlk_retval = VB2_SUCCESS;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), 0, "Ctrl+U external");

	/* Proceed to external boot mode only if enabled */
	ResetMocks();
	vb2_nv_set(ctx, VB2_NV_DEV_DEFAULT_BOOT,
		   VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL);
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK, "Timeout");

	/* If no external tries fixed disk */
	ResetMocks();
	vb2_nv_set(ctx, VB2_NV_DEV_BOOT_EXTERNAL, 1);
	vb2_nv_set(ctx, VB2_NV_DEV_DEFAULT_BOOT,
		   VB2_DEV_DEFAULT_BOOT_TARGET_EXTERNAL);
	vbtlk_expect_fixed = 1;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Ctrl+U enabled");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");

	/* Up arrow is uninteresting / passed to VbCheckDisplayKey() */
	ResetMocks();
	mock_keypress[0] = VB_KEY_UP;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Up arrow");

	/* Shutdown requested in loop */
	ResetMocks();
	mock_gpio[0].gpio_flags = 0;
	mock_gpio[0].count = 2;
	mock_gpio[1].gpio_flags = GPIO_SHUTDOWN;
	mock_gpio[1].count = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Shutdown requested");
	TEST_NEQ(audio_looping_calls_left, 0, "  aborts audio");

	/* Shutdown requested by keyboard in loop */
	ResetMocks();
	mock_keypress[0] = VB_BUTTON_POWER_SHORT_PRESS;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Shutdown requested by keyboard");

	/* Space asks to disable virtual dev switch */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_DEV_MODE_ENABLED;
	mock_keypress[0] = ' ';
	mock_keypress[1] = VB_KEY_ENTER;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Space = tonorm");
	TEST_EQ(screens_displayed[0], VB_SCREEN_DEVELOPER_WARNING,
		"  warning screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_DEVELOPER_TO_NORM,
		"  tonorm screen");
	TEST_EQ(screens_displayed[2], VB_SCREEN_TO_NORM_CONFIRMED,
		"  confirm screen");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISABLE_DEV_REQUEST), 1,
		"  disable dev request");

	/* Space-space doesn't disable it */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_DEV_MODE_ENABLED;
	mock_keypress[0] = ' ';
	mock_keypress[1] = ' ';
	mock_keypress[2] = VB_KEY_ESC;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Space-space");
	TEST_EQ(screens_displayed[0], VB_SCREEN_DEVELOPER_WARNING,
		"  warning screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_DEVELOPER_TO_NORM,
		"  tonorm screen");
	TEST_EQ(screens_displayed[2], VB_SCREEN_DEVELOPER_WARNING,
		"  warning screen");

	/* Enter doesn't by default */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_DEV_MODE_ENABLED;
	mock_keypress[0] = VB_KEY_ENTER;
	mock_keypress[1] = VB_KEY_ENTER;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Enter ignored");

	/* Enter does if GBB flag set */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_DEV_MODE_ENABLED;
	gbb.flags |= VB2_GBB_FLAG_ENTER_TRIGGERS_TONORM;
	mock_keypress[0] = VB_KEY_ENTER;
	mock_keypress[1] = VB_KEY_ENTER;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter = tonorm");

	/* Tonorm ignored if GBB forces dev switch on */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_DEV_MODE_ENABLED;
	gbb.flags |= VB2_GBB_FLAG_FORCE_DEV_SWITCH_ON;
	mock_keypress[0] = ' ';
	mock_keypress[1] = VB_KEY_ENTER;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Can't tonorm gbb-dev");

	/* Shutdown requested at tonorm screen */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_DEV_MODE_ENABLED;
	mock_keypress[0] = ' ';
	MockGpioAfter(3, GPIO_SHUTDOWN);
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Shutdown requested at tonorm");
	TEST_EQ(screens_displayed[0], VB_SCREEN_DEVELOPER_WARNING,
		"  warning screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_DEVELOPER_TO_NORM,
		"  tonorm screen");

	/* Shutdown requested by keyboard at tonorm screen */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_DEV_MODE_ENABLED;
	mock_keypress[0] = VB_BUTTON_POWER_SHORT_PRESS;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Shutdown requested by keyboard at nonorm");

	/* Ctrl+D dismisses warning */
	ResetMocks();
	mock_keypress[0] = VB_KEY_CTRL('D');
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK, "Ctrl+D");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST), 0,
		"  recovery reason");
	TEST_NEQ(audio_looping_calls_left, 0, "  aborts audio");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");

	/* Ctrl+D doesn't boot legacy even if GBB flag is set */
	ResetMocks();
	mock_keypress[0] = VB_KEY_CTRL('D');
	gbb.flags |= VB2_GBB_FLAG_DEFAULT_DEV_BOOT_LEGACY;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK, "Ctrl+D");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");

	/* Ctrl+L tries legacy boot mode only if enabled */
	ResetMocks();
	mock_keypress[0] = VB_KEY_CTRL('L');
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Ctrl+L normal");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");

	/* Enter altfw menu and time out */
	ResetMocks();
	MockGpioAfter(1000, GPIO_SHUTDOWN);
	gbb.flags |= VB2_GBB_FLAG_FORCE_DEV_BOOT_LEGACY;
	mock_keypress[0] = VB_KEY_CTRL('L');
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_SHUTDOWN,
		"Ctrl+L force legacy");
	TEST_EQ(vbexlegacy_called, 0, "  try legacy");

	/* Enter altfw menu and select firmware 0 */
	ResetMocks();
	gbb.flags |= VB2_GBB_FLAG_FORCE_DEV_BOOT_LEGACY;
	mock_keypress[0] = VB_KEY_CTRL('L');
	mock_keypress[1] = '0';
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Ctrl+L force legacy");
	TEST_EQ(vbexlegacy_called, 1, "  try legacy");
	TEST_EQ(altfw_num, 0, "  check altfw_num");

	/* Enter altfw menu and then exit it */
	ResetMocks();
	vb2_nv_set(ctx, VB2_NV_DEV_BOOT_LEGACY, 1);
	mock_keypress[0] = VB_KEY_CTRL('L');
	mock_keypress[1] = VB_KEY_ESC;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Ctrl+L nv legacy");
	TEST_EQ(vbexlegacy_called, 0, "  try legacy");

	/* Enter altfw menu and select firmware 0 */
	ResetMocks();
	vb2_nv_set(ctx, VB2_NV_DEV_BOOT_LEGACY, 1);
	mock_keypress[0] = VB_KEY_CTRL('L');
	mock_keypress[1] = '0';
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Ctrl+L nv legacy");
	TEST_EQ(vbexlegacy_called, 1, "  try legacy");
	TEST_EQ(altfw_num, 0, "  check altfw_num");

	/* Enter altfw menu and select firmware 0 */
	ResetMocks();
	fwmp->flags |= VB2_SECDATA_FWMP_DEV_ENABLE_LEGACY;
	mock_keypress[0] = VB_KEY_CTRL('L');
	mock_keypress[1] = '0';
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Ctrl+L fwmp legacy");
	TEST_EQ(vbexlegacy_called, 1, "  fwmp legacy");
	TEST_EQ(altfw_num, 0, "  check altfw_num");

	/* Pressing 1-9 boots alternative firmware only if enabled */
	for (key = '1'; key <= '9'; key++) {
		ResetMocks();
		mock_keypress[0] = key;
		vbtlk_expect_fixed = 1;
		TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
			"'1' normal");
		TEST_EQ(vbexlegacy_called, 0, "  not legacy");

		ResetMocks();
		gbb.flags |= VB2_GBB_FLAG_FORCE_DEV_BOOT_LEGACY;
		mock_keypress[0] = key;
		vbtlk_expect_fixed = 1;
		TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
			"Ctrl+L force legacy");
		TEST_EQ(vbexlegacy_called, 1, "  try legacy");
		TEST_EQ(altfw_num, key - '0', "  check altfw_num");

		ResetMocks();
		vb2_nv_set(ctx, VB2_NV_DEV_BOOT_LEGACY, 1);
		mock_keypress[0] = key;
		vbtlk_expect_fixed = 1;
		TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
			"Ctrl+L nv legacy");
		TEST_EQ(vbexlegacy_called, 1, "  try legacy");
		TEST_EQ(altfw_num, key - '0', "  check altfw_num");

		ResetMocks();
		fwmp->flags |= VB2_SECDATA_FWMP_DEV_ENABLE_LEGACY;
		mock_keypress[0] = key;
		vbtlk_expect_fixed = 1;
		TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
			"Ctrl+L fwmp legacy");
		TEST_EQ(vbexlegacy_called, 1, "  fwmp legacy");
		TEST_EQ(altfw_num, key - '0', "  check altfw_num");
	}

	/* Ctrl+U boots external only if enabled */
	ResetMocks();
	mock_keypress[0] = VB_KEY_CTRL('U');
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Ctrl+U normal");

	/* Ctrl+U enabled, with good external boot */
	ResetMocks();
	vb2_nv_set(ctx, VB2_NV_DEV_BOOT_EXTERNAL, 1);
	mock_keypress[0] = VB_KEY_CTRL('U');
	vbtlk_retval = VB2_SUCCESS;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), 0, "Ctrl+U external");

	/* Ctrl+U enabled via GBB */
	ResetMocks();
	gbb.flags |= VB2_GBB_FLAG_FORCE_DEV_BOOT_USB;
	mock_keypress[0] = VB_KEY_CTRL('U');
	vbtlk_retval = VB2_SUCCESS;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), 0, "Ctrl+U force external");

	/* Ctrl+U enabled via FWMP */
	ResetMocks();
	fwmp->flags |= VB2_SECDATA_FWMP_DEV_ENABLE_EXTERNAL;
	mock_keypress[0] = VB_KEY_CTRL('U');
	vbtlk_retval = VB2_SUCCESS;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), 0, "Ctrl+U force external");

	/* If no external disk, eventually times out and tries internal disk */
	ResetMocks();
	vb2_nv_set(ctx, VB2_NV_DEV_BOOT_EXTERNAL, 1);
	mock_keypress[0] = VB_KEY_CTRL('U');
	/* TODO: Currently the test suite has no way of specifying the order in
	   which the expected VbTryLoadKernel calls occur. */
	vbtlk_expect_fixed = 1;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Ctrl+U enabled");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST), 0,
		"  recovery reason");
	TEST_EQ(audio_looping_calls_left, 0, "  used up audio");

	/* If dev mode is disabled, goes to TONORM screen repeatedly */
	ResetMocks();
	fwmp->flags |= VB2_SECDATA_FWMP_DEV_DISABLE_BOOT;
	mock_keypress[0] = VB_KEY_ESC;  /* Just causes TONORM again */
	mock_keypress[1] = VB_KEY_ENTER;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"FWMP dev disabled");
	TEST_EQ(screens_displayed[0], VB_SCREEN_DEVELOPER_TO_NORM,
		"  tonorm screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_DEVELOPER_TO_NORM,
		"  tonorm screen");
	TEST_EQ(screens_displayed[2], VB_SCREEN_TO_NORM_CONFIRMED,
		"  confirm screen");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISABLE_DEV_REQUEST), 1,
		"  disable dev request");

	/* Shutdown requested when dev disabled */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_DEV_MODE_ENABLED;
	fwmp->flags |= VB2_SECDATA_FWMP_DEV_DISABLE_BOOT;
	MockGpioAfter(1, GPIO_SHUTDOWN);
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Shutdown requested when dev disabled");
	TEST_EQ(screens_displayed[0], VB_SCREEN_DEVELOPER_TO_NORM,
		"  tonorm screen");

	/* Shutdown requested by keyboard when dev disabled */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_DEV_MODE_ENABLED;
	fwmp->flags |= VB2_SECDATA_FWMP_DEV_DISABLE_BOOT;
	mock_keypress[0] = VB_BUTTON_POWER_SHORT_PRESS;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Shutdown requested by keyboard when dev disabled");

	VB2_DEBUG("...done.\n");
}

static void VbBootDevVendorDataTest(void)
{
	/* Enter set vendor data and reboot */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = '4';
	mock_keypress[2] = '3';
	mock_keypress[3] = '2';
	mock_keypress[4] = '1';
	mock_keypress[5] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[6] = VB_KEY_ENTER;  /* Confirm vendor data (Default YES) */
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter set vendor data, don't confirm, esc");
	TEST_EQ(set_vendor_data_called, 1, "  VbExSetVendorData() called");
	TEST_STR_EQ(set_vendor_data, "4321", "  Vendor data correct");

	/* Enter set vendor data; don't confirm and esc */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = '4';
	mock_keypress[2] = '3';
	mock_keypress[3] = '2';
	mock_keypress[4] = '1';
	mock_keypress[5] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[6] = VB_KEY_RIGHT;  /* Select NO */
	mock_keypress[7] = VB_KEY_ENTER;  /* Do not confirm vendor data */
	mock_keypress[8] = VB_KEY_ESC;  /* Escape to boot */
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Enter set vendor data, don't confirm, esc");
	TEST_EQ(set_vendor_data_called, 0, "  VbExSetVendorData() not called");

	/* Enter set vendor data; esc, don't confirm, and change last character */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = '4';
	mock_keypress[2] = '3';
	mock_keypress[3] = '2';
	mock_keypress[4] = '1';
	mock_keypress[5] = VB_KEY_ENTER;
	mock_keypress[6] = VB_KEY_RIGHT;  /* Select NO */
	mock_keypress[7] = VB_KEY_ENTER;  /* Do not confirm vendor data */
	mock_keypress[8] = VB_KEY_BACKSPACE;  /* Remove last character */
	mock_keypress[9] = 'B';
	mock_keypress[10] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[11] = VB_KEY_ENTER;  /* Confirm vendor data */
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter set vendor data esc, don't confirm, change last character");
	TEST_EQ(set_vendor_data_called, 1, "  VbExSetVendorData() called");
	TEST_STR_EQ(set_vendor_data, "432B", "  Vendor data correct");

	/* Enter set vendor data; extra keys ignored */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = '4';
	mock_keypress[2] = '3';
	mock_keypress[3] = '2';
	mock_keypress[4] = '1';
	mock_keypress[5] = '5';
	mock_keypress[6] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[7] = VB_KEY_ENTER;  /* Confirm vendor data (Default YES) */
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter set vendor data extra keys ignored");
	TEST_EQ(set_vendor_data_called, 1, "  VbExSetVendorData() called");
	TEST_STR_EQ(set_vendor_data, "4321", "  Vendor data correct");

	/* Enter set vendor data; converts case */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = 'a';
	mock_keypress[2] = 'B';
	mock_keypress[3] = 'Y';
	mock_keypress[4] = 'z';
	mock_keypress[5] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[6] = VB_KEY_ENTER;  /* Confirm vendor data (Default YES) */
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter set vendor data converts case");
	TEST_EQ(set_vendor_data_called, 1, "  VbExSetVendorData() called");
	TEST_STR_EQ(set_vendor_data, "ABYZ", "  Vendor data correct");

	/* Enter set vendor data; backspace works */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = 'A';
	mock_keypress[2] = 'B';
	mock_keypress[3] = 'C';
	mock_keypress[4] = VB_KEY_BACKSPACE;
	mock_keypress[5] = VB_KEY_BACKSPACE;
	mock_keypress[6] = '3';
	mock_keypress[7] = '2';
	mock_keypress[8] = '1';
	mock_keypress[9] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[10] = VB_KEY_ENTER;  /* Confirm vendor data (Default YES) */
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter set vendor data backspace works");
	TEST_EQ(set_vendor_data_called, 1, "  VbExSetVendorData() called");
	TEST_STR_EQ(set_vendor_data, "A321", "  Vendor data correct");

	/* Enter set vendor data; invalid chars don't print */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = '4';
	mock_keypress[2] = '-';
	mock_keypress[3] = '^';
	mock_keypress[4] = '&';
	mock_keypress[5] = '$';
	mock_keypress[6] = '.';
	mock_keypress[7] = '3';
	mock_keypress[8] = '2';
	mock_keypress[9] = '1';
	mock_keypress[10] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[11] = VB_KEY_ENTER;  /* Confirm vendor data (Default YES) */
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter set vendor data invalid chars don't print");
	TEST_EQ(set_vendor_data_called, 1, "  VbExSetVendorData() called");
	TEST_STR_EQ(set_vendor_data, "4321", "  Vendor data correct");

	/* Enter set vendor data; invalid chars don't print with backspace */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = '4';
	mock_keypress[2] = '-';
	mock_keypress[3] = VB_KEY_BACKSPACE;  /* Should delete 4 */
	mock_keypress[4] = '3';
	mock_keypress[5] = '2';
	mock_keypress[6] = '1';
	mock_keypress[7] = '0';
	mock_keypress[8] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[9] = VB_KEY_ENTER;  /* Confirm vendor data (Default YES) */
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter set vendor data invalid chars don't print with backspace");
	TEST_EQ(set_vendor_data_called, 1, "  VbExSetVendorData() called");
	TEST_STR_EQ(set_vendor_data, "3210", "  Vendor data correct");

	/* Enter set vendor data; backspace only doesn't underrun */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = 'A';
	mock_keypress[2] = VB_KEY_BACKSPACE;
	mock_keypress[3] = VB_KEY_BACKSPACE;
	mock_keypress[4] = '4';
	mock_keypress[5] = '3';
	mock_keypress[6] = '2';
	mock_keypress[7] = '1';
	mock_keypress[8] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[9] = VB_KEY_ENTER;  /* Confirm vendor data (Default YES) */
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter set vendor data backspace only doesn't underrun");
	TEST_EQ(set_vendor_data_called, 1, "  VbExSetVendorData() called");
	TEST_STR_EQ(set_vendor_data, "4321", "  Vendor data correct");

	/* Enter set vendor data; vowels not allowed after first char */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = 'A';
	mock_keypress[2] = 'A';
	mock_keypress[3] = 'B';
	mock_keypress[4] = 'E';
	mock_keypress[5] = 'i';
	mock_keypress[6] = 'C';
	mock_keypress[7] = 'O';
	mock_keypress[8] = 'u';
	mock_keypress[9] = 'D';
	mock_keypress[10] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[11] = VB_KEY_ENTER;  /* Confirm vendor data (Default YES) */
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Enter set vendor data vowels not allowed after first char");
	TEST_EQ(set_vendor_data_called, 1, "  VbExSetVendorData() called");
	TEST_STR_EQ(set_vendor_data, "ABCD", "  Vendor data correct");

	/* Enter set vendor data; too short */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = '1';
	mock_keypress[2] = '2';
	mock_keypress[3] = '3';
	/* Set vendor data (nothing happens) */
	mock_keypress[4] = VB_KEY_ENTER;
	/* Confirm vendor data (nothing happens) */
	mock_keypress[5] = VB_KEY_ENTER;
	mock_keypress[6] = VB_KEY_ESC;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Enter set vendor data too short");
	TEST_EQ(set_vendor_data_called, 0, "  VbExSetVendorData() not called");

	/* Enter set vendor data; esc from set screen */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = VB_KEY_ESC;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Enter set vendor data esc from set screen");
	TEST_EQ(set_vendor_data_called, 0, "  VbExSetVendorData() not called");

	/* Enter set vendor data; esc from set screen with tag */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = '4';
	mock_keypress[2] = '3';
	mock_keypress[3] = '2';
	mock_keypress[4] = '1';
	mock_keypress[5] = VB_KEY_ESC;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Enter set vendor data esc from set screen with tag");
	TEST_EQ(set_vendor_data_called, 0, "  VbExSetVendorData() not called");

	/* Enter set vendor data; esc from confirm screen */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ENTER;  /* Enter vendor data setting */
	mock_keypress[1] = '4';
	mock_keypress[2] = '3';
	mock_keypress[3] = '2';
	mock_keypress[4] = '1';
	mock_keypress[5] = VB_KEY_ENTER;  /* Set vendor data */
	mock_keypress[6] = VB_KEY_ESC;
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Enter set vendor data esc from set screen");
	TEST_EQ(set_vendor_data_called, 0, "  VbExSetVendorData() not called");

	/* Escape from vendor data warning screen */
	ResetMocks();
	ctx->flags |= VB2_CONTEXT_VENDOR_DATA_SETTABLE;
	mock_keypress[0] = VB_KEY_ESC;  /* Enter vendor data setting */
	vbtlk_expect_fixed = 1;
	TEST_EQ(VbBootDeveloperLegacyClamshell(ctx), VB2_ERROR_MOCK,
		"Enter set vendor data esc, don't confirm, change last character");
	TEST_EQ(set_vendor_data_called, 0, "  VbExSetVendorData() not called");

	VB2_DEBUG("...done.\n");
}

/*
 * Helper function to test VbBootRecovery against a sequence of gpio events.
 * caller specifies a sequence of gpio events and the expected confirm vs.
 * reboot result.
 *
 * Non-asserted gpios are used for 5 events, then 'first' for 5 events,
 * 'second' for 5 events, and 'third' for 5 events.
 */
static void VbBootRecTestGpio(uint32_t first, uint32_t second, uint32_t third,
			      uint32_t confirm, const char *msg)
{
	ResetMocks();
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY;
	vbtlk_retval = VB2_ERROR_LK_NO_DISK_FOUND;
	trust_ec = 1;
	mock_keypress[0] = VB_KEY_CTRL('D');
	mock_gpio[0].gpio_flags = 0;
	mock_gpio[0].count = 4;
	mock_gpio[1].gpio_flags = first;
	mock_gpio[1].count = 4;
	mock_gpio[2].gpio_flags = second;
	mock_gpio[2].count = 4;
	mock_gpio[3].gpio_flags = third;
	mock_gpio[3].count = 4;
	vbtlk_expect_removable = 1;

	if (confirm) {
		TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
			VB2_REQUEST_REBOOT_EC_TO_RO, msg);
		TEST_EQ(virtdev_set, 1, "  virtual dev mode on");
		TEST_EQ(vb2_nv_get(ctx, VB2_NV_DEV_BOOT_EXTERNAL),
			!!BOOT_EXTERNAL_ON_DEV,
			"  NV_DEV_BOOT_EXTERNAL enabled");
	} else {
		TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
			VB2_REQUEST_SHUTDOWN, msg);
		TEST_EQ(virtdev_set, 0, "  virtual dev mode off");
	}
}

static void VbBootRecTest(void)
{
	VB2_DEBUG("Testing VbBootRecoveryLegacyClamshell()...\n");

	/* Shutdown requested in loop */
	ResetMocks();
	MockGpioAfter(10, GPIO_SHUTDOWN);
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Shutdown requested");

	TEST_EQ(vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST), 0,
		"  recovery reason");
	TEST_EQ(screens_displayed[0], VB_SCREEN_OS_BROKEN,
		"  broken screen");

	/* Shutdown requested by keyboard */
	ResetMocks();
	mock_keypress[0] = VB_BUTTON_POWER_SHORT_PRESS;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Shutdown requested by keyboard");

	/* Ignore power button held on boot */
	ResetMocks();
	mock_gpio[0].gpio_flags = GPIO_SHUTDOWN;
	mock_gpio[0].count = 10;
	mock_gpio[1].gpio_flags = 0;
	mock_gpio[1].count = 10;
	mock_gpio[2].gpio_flags = GPIO_SHUTDOWN;
	mock_gpio[2].count = 10;
	mock_gpio[3].gpio_flags = 0;
	mock_gpio[3].count = 100;
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY;
	trust_ec = 1;
	vbtlk_retval = VB2_ERROR_LK_NO_DISK_FOUND;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Ignore power button held on boot");
	TEST_EQ(screens_displayed[0], VB_SCREEN_RECOVERY_INSERT,
		"  insert screen");
	/* Shutdown should happen while we're sending the 2nd block of events */

	/* Broken screen */
	ResetMocks();
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_num_disks[0] = 1;
	mock_num_disks[1] = 1;
	mock_num_disks[2] = 1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Broken");
	TEST_EQ(screens_displayed[0], VB_SCREEN_OS_BROKEN,
		"  broken screen");

	/* Broken screen even if dev switch is on */
	ResetMocks();
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_num_disks[0] = 1;
	mock_num_disks[1] = 1;
	sd->flags |= VB2_SD_FLAG_DEV_MODE_ENABLED;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Broken (dev)");
	TEST_EQ(screens_displayed[0], VB_SCREEN_OS_BROKEN,
		"  broken screen");

	/* Force insert screen with GBB flag */
	ResetMocks();
	MockGpioAfter(10, GPIO_SHUTDOWN);
	gbb.flags |= VB2_GBB_FLAG_FORCE_MANUAL_RECOVERY;
	vbtlk_retval = VB2_ERROR_LK_NO_DISK_FOUND;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Insert (forced by GBB)");
	TEST_EQ(screens_displayed[0], VB_SCREEN_RECOVERY_INSERT,
		"  insert screen");

	/* No removal if recovery button physically pressed */
	ResetMocks();
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_num_disks[0] = 1;
	mock_num_disks[1] = 1;
	sd->flags |= VB2_SD_FLAG_MANUAL_RECOVERY;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"No remove in rec");
	TEST_EQ(screens_displayed[0], VB_SCREEN_OS_BROKEN,
		"  broken screen");

	/* Removal if no disk initially found, but found on second attempt */
	ResetMocks();
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_num_disks[0] = 0;
	mock_num_disks[1] = 1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Remove");
	TEST_EQ(screens_displayed[0], VB_SCREEN_OS_BROKEN,
		"  broken screen");

	/* Bad disk count doesn't require removal */
	ResetMocks();
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_num_disks[0] = -1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Bad disk count");
	TEST_EQ(screens_displayed[0], VB_SCREEN_OS_BROKEN,
		"  broken screen");

	/* Ctrl+D ignored for many reasons... */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY;
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_keypress[0] = VB_KEY_CTRL('D');
	trust_ec = 0;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Ctrl+D ignored if EC not trusted");
	TEST_EQ(virtdev_set, 0, "  virtual dev mode off");
	TEST_NEQ(screens_displayed[1], VB_SCREEN_RECOVERY_TO_DEV,
		 "  todev screen");

	ResetMocks();
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY | VB2_SD_FLAG_DEV_MODE_ENABLED;
	trust_ec = 1;
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_keypress[0] = VB_KEY_CTRL('D');
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Ctrl+D ignored if already in dev mode");
	TEST_EQ(virtdev_set, 0, "  virtual dev mode off");
	TEST_NEQ(screens_displayed[1], VB_SCREEN_RECOVERY_TO_DEV,
		 "  todev screen");

	ResetMocks();
	trust_ec = 1;
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_keypress[0] = VB_KEY_CTRL('D');
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Ctrl+D ignored if recovery not manually triggered");
	TEST_EQ(virtdev_set, 0, "  virtual dev mode off");
	TEST_NEQ(screens_displayed[1], VB_SCREEN_RECOVERY_TO_DEV,
		 "  todev screen");

	/* Ctrl+D then space means don't enable */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY;
	MockGpioAfter(2, GPIO_SHUTDOWN);
	vbtlk_retval = VB2_ERROR_LK_NO_DISK_FOUND;
	trust_ec = 1;
	mock_keypress[0] = VB_KEY_CTRL('D');
	mock_keypress[1] = ' ';
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Ctrl+D todev abort");
	TEST_EQ(screens_displayed[0], VB_SCREEN_RECOVERY_INSERT,
		"  insert screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_RECOVERY_TO_DEV,
		"  todev screen");
	TEST_EQ(screens_displayed[2], VB_SCREEN_RECOVERY_INSERT,
		"  insert screen");
	TEST_EQ(virtdev_set, 0, "  virtual dev mode off");

	/* Ctrl+D then enter means enable */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY;
	MockGpioAfter(10, GPIO_SHUTDOWN);
	vbtlk_retval = VB2_ERROR_LK_NO_DISK_FOUND;
	trust_ec = 1;
	mock_keypress[0] = VB_KEY_CTRL('D');
	mock_keypress[1] = VB_KEY_ENTER;
	mock_keyflags[1] = VB_KEY_FLAG_TRUSTED_KEYBOARD;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_REBOOT_EC_TO_RO,
		"Ctrl+D todev confirm via enter");
	TEST_EQ(virtdev_set, 1, "  virtual dev mode on");

	/* Don't handle TPM error in enabling dev mode */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY;
	MockGpioAfter(10, GPIO_SHUTDOWN);
	vbtlk_retval = VB2_ERROR_LK_NO_DISK_FOUND;
	trust_ec = 1;
	mock_keypress[0] = VB_KEY_CTRL('D');
	mock_keypress[1] = VB_KEY_ENTER;
	mock_keyflags[1] = VB_KEY_FLAG_TRUSTED_KEYBOARD;
	virtdev_fail = 1;
	vbtlk_expect_removable = 1;
	TEST_ABORT(VbBootRecoveryLegacyClamshell(ctx),
		   "Ctrl+D todev failure");
	TEST_EQ(virtdev_set, 0, "  virtual dev mode still off");

	/* Test Diagnostic Mode via Ctrl-C - display available */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY;
	trust_ec = 1;
	vbtlk_retval = VB2_ERROR_LK_NO_DISK_FOUND;
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_keypress[0] = VB_KEY_CTRL('C');
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST), 0,
		"todiag is zero");
	vbtlk_expect_removable = 1;
	if (DIAGNOSTIC_UI)
		TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
			VB2_REQUEST_REBOOT,
			"Ctrl+C todiag - enabled");
	else
		TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
			VB2_REQUEST_SHUTDOWN,
			"Ctrl+C todiag - disabled");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST), DIAGNOSTIC_UI,
		"  todiag is updated for Ctrl-C");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISPLAY_REQUEST), 0,
		"  todiag doesn't set unneeded DISPLAY_REQUEST");
	TEST_EQ(screens_displayed[0], VB_SCREEN_RECOVERY_INSERT,
		"  insert screen");

	/* Test Diagnostic Mode via F12 - display disabled */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY;
	sd->flags &= ~VB2_SD_FLAG_DISPLAY_AVAILABLE;
	trust_ec = 1;
	vbtlk_retval = VB2_ERROR_LK_NO_DISK_FOUND;
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_keypress[0] = VB_KEY_F(12);
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST), 0,
		"todiag is zero");
	vbtlk_expect_removable = 1;
	if (DIAGNOSTIC_UI)
		TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
			VB2_REQUEST_REBOOT,
			"F12 todiag - enabled");
	else
		TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
			VB2_REQUEST_SHUTDOWN,
			"F12 todiag - disabled");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST), DIAGNOSTIC_UI,
		"  todiag is updated for F12");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISPLAY_REQUEST), 0,
		"  todiag doesn't set unneeded DISPLAY_REQUEST");
	TEST_EQ(screens_displayed[0], VB_SCREEN_RECOVERY_INSERT,
		"  insert screen");

	/* Test Diagnostic Mode via Ctrl-C OS broken - display available */
	ResetMocks();
	MockGpioAfter(10, GPIO_SHUTDOWN);
	mock_keypress[0] = VB_KEY_CTRL('C');
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST), 0,
		"todiag is zero");
	if (DIAGNOSTIC_UI)
		TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
			VB2_REQUEST_REBOOT,
			"Ctrl+C todiag os broken - enabled");
	else
		TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
			VB2_REQUEST_SHUTDOWN,
			"Ctrl+C todiag os broken - disabled");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DIAG_REQUEST), DIAGNOSTIC_UI,
		"  todiag is updated for Ctrl-C");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_DISPLAY_REQUEST), 0,
		"  todiag doesn't set unneeded DISPLAY_REQUEST");
	TEST_EQ(screens_displayed[0], VB_SCREEN_OS_BROKEN,
		"  os broken screen");

	VB2_DEBUG("...done.\n");
}

static void VbBootRecPhysicalPresenceTest(void)
{

	/* Ctrl+D ignored because the physical presence switch is still pressed
	   and we don't like that. */
	ResetMocks();
	sd->flags = VB2_SD_FLAG_MANUAL_RECOVERY;
	trust_ec = 1;
	mock_keypress[0] = VB_KEY_CTRL('D');
	mock_gpio[0].gpio_flags = GPIO_PRESENCE;
	mock_gpio[0].count = 100;
	mock_gpio[1].gpio_flags = GPIO_PRESENCE | GPIO_SHUTDOWN;
	mock_gpio[1].count = 100;
	vbtlk_expect_removable = 1;
	TEST_EQ(VbBootRecoveryLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN,
		"Ctrl+D ignored if phys pres button is still pressed");
	TEST_NEQ(screens_displayed[1], VB_SCREEN_RECOVERY_TO_DEV,
		 "  todev screen");

	/*
	 * List of possiblities for shutdown and physical presence events that
	 * occur over time.  Time advanced from left to right (where each
	 * represents the gpio[s] that are seen during a given iteration of
	 * the loop).  The meaning of the characters:
	 *
	 *   _ means no gpio
	 *   s means shutdown gpio
	 *   p means presence gpio
	 *   B means both shutdown and presence gpio
	 *
	 *  1: ______ppp______ -> confirm
	 *  2: ______sss______ -> shutdown
	 *  3: ___pppsss______ -> confirm
	 *  4: ___sssppp______ -> shutdown
	 *  5: ___pppBBB______ -> confirm
	 *  6: ___pppBBBppp___ -> shutdown
	 *  7: ___pppBBBsss___ -> confirm
	 *  8: ___sssBBB______ -> confirm
	 *  9: ___sssBBBppp___ -> shutdown
	 * 10: ___sssBBBsss___ -> confirm
	 * 11: ______BBB______ -> confirm
	 * 12: ______BBBsss___ -> confirm
	 * 13: ______BBBppp___ -> shutdown
	 */

	/* 1: Ctrl+D then presence means enable */
	VbBootRecTestGpio(GPIO_PRESENCE, 0, 0, 1,
			  "Ctrl+D todev confirm via presence");

	/* 2: Ctrl+D then shutdown means shutdown */
	VbBootRecTestGpio(GPIO_SHUTDOWN, 0, 0, 0,
			  "Ctrl+D todev then shutdown");

	/* 3: Ctrl+D then presence then shutdown means confirm */
	VbBootRecTestGpio(GPIO_PRESENCE, GPIO_SHUTDOWN, 0, 1,
			  "Ctrl+D todev confirm via presence then shutdown");

	/* 4: Ctrl+D then 2+ instance shutdown then presence means shutdown */
	VbBootRecTestGpio(GPIO_SHUTDOWN, GPIO_PRESENCE, 0, 0,
			  "Ctrl+D todev then 2+ shutdown then presence");

	/* 5: Ctrl+D then presence then shutdown+presence then none */
	VbBootRecTestGpio(GPIO_PRESENCE, GPIO_PRESENCE | GPIO_SHUTDOWN, 0, 1,
			  "Ctrl+D todev confirm via presence, both, none");

	/* 6: Ctrl+D then presence then shutdown+presence then presence */
	VbBootRecTestGpio(GPIO_PRESENCE, GPIO_PRESENCE | GPIO_SHUTDOWN,
			  GPIO_PRESENCE, 0,
			  "Ctrl+D todev confirm via presence, both, presence");

	/* 7: Ctrl+D then presence then shutdown+presence then shutdown */
	VbBootRecTestGpio(GPIO_PRESENCE, GPIO_PRESENCE | GPIO_SHUTDOWN,
			  GPIO_SHUTDOWN, 1,
			  "Ctrl+D todev confirm via presence, both, shutdown");

	/* 8: Ctrl+D then shutdown then shutdown+presence then none */
	VbBootRecTestGpio(GPIO_SHUTDOWN, GPIO_PRESENCE | GPIO_SHUTDOWN, 0, 1,
			  "Ctrl+D todev then 2+ shutdown, both, none");

	/* 9: Ctrl+D then shutdown then shutdown+presence then presence */
	VbBootRecTestGpio(GPIO_SHUTDOWN, GPIO_PRESENCE | GPIO_SHUTDOWN,
			  GPIO_PRESENCE, 0,
			  "Ctrl+D todev then 2+ shutdown, both, presence");

	/* 10: Ctrl+D then shutdown then shutdown+presence then shutdown */
	VbBootRecTestGpio(GPIO_SHUTDOWN, GPIO_PRESENCE | GPIO_SHUTDOWN,
			  GPIO_SHUTDOWN, 1,
			  "Ctrl+D todev then 2+ shutdown, both, shutdown");

	/* 11: Ctrl+D then shutdown+presence then none */
	VbBootRecTestGpio(GPIO_PRESENCE | GPIO_SHUTDOWN, 0, 0, 1,
			  "Ctrl+D todev confirm via both then none");

	/* 12: Ctrl+D then shutdown+presence then shutdown */
	VbBootRecTestGpio(GPIO_PRESENCE | GPIO_SHUTDOWN, GPIO_SHUTDOWN, 0, 1,
			  "Ctrl+D todev confirm via both then shutdown");

	/* 13: Ctrl+D then shutdown+presence then presence */
	VbBootRecTestGpio(GPIO_PRESENCE | GPIO_SHUTDOWN, GPIO_PRESENCE, 0, 0,
			  "Ctrl+D todev confirm via both then presence");
}

static void VbBootDiagTest(void)
{
	VB2_DEBUG("Testing VbBootDiagnosticLegacyClamshell()...\n");

	/* No key pressed - timeout. */
	ResetMocks();
	TEST_EQ(VbBootDiagnosticLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Timeout");
	TEST_EQ(screens_displayed[0], VB_SCREEN_CONFIRM_DIAG,
		"  confirm screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_BLANK,
		"  blank screen");
	TEST_EQ(tpm_set_mode_called, 0, "  no tpm call");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");
	TEST_EQ(current_ticks, 30 * VB2_MSEC_PER_SEC,
		"  waited for 30 seconds");

	/* Esc key pressed. */
	ResetMocks();
	mock_keypress[0] = VB_KEY_ESC;
	TEST_EQ(VbBootDiagnosticLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Esc key");
	TEST_EQ(screens_displayed[0], VB_SCREEN_CONFIRM_DIAG,
		"  confirm screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_BLANK,
		"  blank screen");
	TEST_EQ(tpm_set_mode_called, 0, "  no tpm call");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");
	TEST_EQ(current_ticks, 0, "  didn't wait at all");

	/* Shutdown requested via lid close */
	ResetMocks();
	MockGpioAfter(10, GPIO_LID_CLOSED);
	TEST_EQ(VbBootDiagnosticLegacyClamshell(ctx),
		VB2_REQUEST_SHUTDOWN, "Shutdown");
	TEST_EQ(screens_displayed[0], VB_SCREEN_CONFIRM_DIAG,
		"  confirm screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_BLANK,
		"  blank screen");
	TEST_EQ(tpm_set_mode_called, 0, "  no tpm call");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");
	TEST_TRUE(current_ticks < VB2_MSEC_PER_SEC, "  didn't wait long");

	/* Power button pressed but not released. */
	ResetMocks();
	mock_gpio[0].gpio_flags = GPIO_PRESENCE;
	mock_gpio[0].count = ~0;
	TEST_EQ(VbBootDiagnosticLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Power held");
	TEST_EQ(screens_displayed[0], VB_SCREEN_CONFIRM_DIAG,
		"  confirm screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_BLANK,
		"  blank screen");
	TEST_EQ(tpm_set_mode_called, 0, "  no tpm call");
	TEST_EQ(vbexlegacy_called, 0, "  not legacy");

	/* Power button is pressed and released. */
	ResetMocks();
	MockGpioAfter(3, GPIO_PRESENCE);
	TEST_EQ(VbBootDiagnosticLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Confirm");
	TEST_EQ(screens_displayed[0], VB_SCREEN_CONFIRM_DIAG,
		"  confirm screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_BLANK,
		"  blank screen");
	TEST_EQ(tpm_set_mode_called, 1, "  tpm call");
	TEST_EQ(tpm_mode, VB2_TPM_MODE_DISABLED, "  tpm disabled");
	TEST_EQ(vbexlegacy_called, 1, "  legacy");
	TEST_EQ(altfw_num, VB_ALTFW_DIAGNOSTIC, "  check altfw_num");
	/*
	 * Ideally we'd that no recovery request was recorded, but
	 * VbExLegacy() can only fail or crash the tests.
	 */
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST),
		VB2_RECOVERY_ALTFW_HASH_FAILED,
		"  recovery request");

	/* Power button confirm, but now with a TPM failure. */
	ResetMocks();
	tpm_mode = VB2_TPM_MODE_DISABLED;
	mock_gpio[0].gpio_flags = 0;
	mock_gpio[0].count = 2;
	mock_gpio[1].gpio_flags = GPIO_PRESENCE;
	mock_gpio[1].count = 2;
	TEST_EQ(VbBootDiagnosticLegacyClamshell(ctx), VB2_REQUEST_REBOOT,
		"Confirm but tpm fail");
	TEST_EQ(screens_displayed[0], VB_SCREEN_CONFIRM_DIAG,
		"  confirm screen");
	TEST_EQ(screens_displayed[1], VB_SCREEN_BLANK,
		"  blank screen");
	TEST_EQ(tpm_set_mode_called, 1, "  tpm call");
	TEST_EQ(tpm_mode, VB2_TPM_MODE_DISABLED, "  tpm disabled");
	TEST_EQ(vbexlegacy_called, 0, "  legacy not called");
	TEST_EQ(vb2_nv_get(ctx, VB2_NV_RECOVERY_REQUEST),
		VB2_RECOVERY_TPM_DISABLE_FAILED,
		"  recovery request");

	VB2_DEBUG("...done.\n");
}


int main(void)
{
	VbUserConfirmsKeyboardTest();
	if (!PHYSICAL_PRESENCE_KEYBOARD)
		VbUserConfirmsPhysicalPresenceTest();
	VbBootDevTest();
	VbBootDevVendorDataTest();
	VbBootRecTest();
	if (!PHYSICAL_PRESENCE_KEYBOARD)
		VbBootRecPhysicalPresenceTest();
	if (DIAGNOSTIC_UI)
		VbBootDiagTest();

	return gTestSuccess ? 0 : 255;
}
