/* SPDX-License-Identifier: GPL-2.0-only */

#include <device/device.h>
#include <drivers/intel/gma/int15.h>
#include <southbridge/intel/bd82x6x/pch.h>
#include <ec/acpi/ec.h>

static void mainboard_init(struct device *dev)
{
	RCBA32(0x38c8) = 0x00002005;
	RCBA32(0x38c4) = 0x00800000;
}

static void mainboard_enable(struct device *dev)
{
	dev->ops->init = mainboard_init;

	install_intel_vga_int15_handler(GMA_INT15_ACTIVE_LFP_EDP, GMA_INT15_PANEL_FIT_DEFAULT, GMA_INT15_BOOT_DISPLAY_DEFAULT, 0);
}

struct chip_operations mainboard_ops = {
	.enable_dev = mainboard_enable,
};
