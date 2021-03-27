/* SPDX-License-Identifier: GPL-2.0-only */

#include <amdblocks/acpimmio.h>
#include <device/mmio.h>
#include <console/console.h>
#include <delay.h>
#include <device/device.h>
#include <southbridge/amd/common/amd_pci_util.h>
#include <device/pci_ops.h>

static const u8 mainboard_intr_data[] = {
	[0x00] = 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,  /* INTA# - INTH# */
	[0x08] = 0x00, 0x00, 0x00, 0x00, 0x1F, 0x1F, 0x1F, 0x1F,  /* Misc-nil, 0, 1, 2,  INT from Serial irq */
	[0x10] = 0x09, 0x1F, 0x1F, 0x10, 0x1F, 0x12, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x12, 0x11, 0x12, 0x11, 0x12, 0x11, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x11, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x10, 0x11, 0x12, 0x13
};

/* PIRQ Setup */
static void pirq_setup(void)
{
	intr_data_ptr = mainboard_intr_data;
}

/**********************************************
 * Enable the dedicated functions of the board.
 **********************************************/
static void mainboard_enable(struct device *dev)
{
	pirq_setup();

	/* enable GPP CLK0 thru CLK1 */
	/* disable GPP CLK2 thru SLT_GFX_CLK */
	misc_write8(0, 0xFF);
	misc_write8(1, 0);
	misc_write8(2, 0);
	misc_write8(3, 0);
	misc_write8(4, 0);

	/*
	 * Force the onboard SATA port to GEN2 speed.
	 * The offboard SATA port can remain at GEN3.
	 */
	pm_write8(0xda, (pm_read8(0xda) & 0xfb) | 0x04);
}

static void mainboard_final(void *chip_info)
{
	struct device *ahci_dev;
	uintptr_t ABAR;
	u8 *memptr;

	ahci_dev = pcidev_on_root(0x11, 0);
	ABAR = pci_read_config32(ahci_dev, 0x24);
	ABAR &= 0xFFFFFC00;
	memptr = (u8 *)(ABAR + 0x100 + 0x80 + 0x2C); /* we're on the 2nd port */
	*memptr = 0x21; /* force to GEN2 and start re-negotiate */
	mdelay(1);
	*memptr = 0x20;
}

struct chip_operations mainboard_ops = {
	.enable_dev = mainboard_enable,
	.final = mainboard_final,
};
