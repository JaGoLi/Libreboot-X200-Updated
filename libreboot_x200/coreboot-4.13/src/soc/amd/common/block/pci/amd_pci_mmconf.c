/* SPDX-License-Identifier: GPL-2.0-only */

#include <amdblocks/amd_pci_mmconf.h>
#include <cpu/amd/msr.h>
#include <cpu/x86/msr.h>
#include <cpu/x86/mtrr.h>

void enable_pci_mmconf(void)
{
	msr_t mmconf;

	mmconf.hi = 0;
	mmconf.lo = CONFIG_MMCONF_BASE_ADDRESS | MMIO_RANGE_EN
			| fms(CONFIG_MMCONF_BUS_NUMBER) << MMIO_BUS_RANGE_SHIFT;
	wrmsr(MMIO_CONF_BASE, mmconf);
}
