/* SPDX-License-Identifier: GPL-2.0-only */

#include <drivers/intel/dptf/dptf.h>

static const struct dptf_platform_info cnl_dptf_platform_info = {
	.use_eisa_hids = true,
	/* _HID for the toplevel DPTF device, typically \_SB.DPTF */
	.dptf_device_hid = "INT3400",
	/* _HID for Intel DPTF Generic Device (these require PTYP as well) */
	.generic_hid = "INT3403",
	/* _HID for Intel DPTF Fan Device */
	.fan_hid = "INT3404",
};

const struct dptf_platform_info *get_dptf_platform_info(void)
{
	return &cnl_dptf_platform_info;
}
