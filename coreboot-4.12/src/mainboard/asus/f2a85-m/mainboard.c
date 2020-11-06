/* SPDX-License-Identifier: GPL-2.0-only */

#include <console/console.h>
#include <cpu/x86/msr.h>
#include <cpu/amd/msr.h>
#include <device/device.h>

/*************************************************
 * enable the dedicated function in thatcher board.
 *************************************************/
static void mainboard_enable(struct device *dev)
{
	msr_t msr;

	printk(BIOS_INFO, "Mainboard " CONFIG_MAINBOARD_PART_NUMBER " Enable.\n");

	msr = rdmsr(LS_CFG_MSR);
	msr.lo &= ~(1 << 28);
	wrmsr(LS_CFG_MSR, msr);

	msr = rdmsr(DC_CFG_MSR);
	msr.lo &= ~(1 << 4);
	msr.lo &= ~(1 << 13);
	wrmsr(DC_CFG_MSR, msr);

	msr = rdmsr(BU_CFG_MSR);
	msr.lo &= ~(1 << 23);
	wrmsr(BU_CFG_MSR, msr);
}

struct chip_operations mainboard_ops = {
	.enable_dev = mainboard_enable,
};
