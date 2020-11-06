/* SPDX-License-Identifier: GPL-2.0-only */

#include <device/device.h>
#include <drivers/intel/gma/int15.h>

static void mainboard_enable(struct device *dev)
{
	install_intel_vga_int15_handler(GMA_INT15_ACTIVE_LFP_NONE,
		GMA_INT15_PANEL_FIT_DEFAULT, GMA_INT15_BOOT_DISPLAY_CRT, 0);
}

struct chip_operations mainboard_ops = {
	.enable_dev = mainboard_enable,
};
