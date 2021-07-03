/* SPDX-License-Identifier: GPL-2.0-only */

#include <bootstate.h>
#include <console/console.h>
#include <device/mmio.h>
#include <device/device.h>
#include <intelblocks/pmc.h>
#include <intelblocks/pmclib.h>
#include <intelblocks/rtc.h>
#include <soc/pci_devs.h>
#include <soc/pm.h>

#include "chip.h"

static void pm1_enable_pwrbtn_smi(void *unused)
{
	/*
	 * Enable power button SMI only before jumping to payload. This ensures
	 * that:
	 * 1. Power button SMI is enabled only after coreboot is done.
	 * 2. On resume path, power button SMI is not enabled and thus avoids
	 * any shutdowns because of power button presses due to power button
	 * press in resume path.
	 */
	pmc_update_pm1_enable(PWRBTN_EN);
}

BOOT_STATE_INIT_ENTRY(BS_PAYLOAD_LOAD, BS_ON_EXIT, pm1_enable_pwrbtn_smi, NULL);

static void config_deep_sX(uint32_t offset, uint32_t mask, int sx, int enable)
{
	uint32_t reg;
	uint8_t *pmcbase = pmc_mmio_regs();

	printk(BIOS_DEBUG, "%sabling Deep S%c\n",
		enable ? "En" : "Dis", sx + '0');
	reg = read32(pmcbase + offset);
	if (enable)
		reg |= mask;
	else
		reg &= ~mask;
	write32(pmcbase + offset, reg);
}

static void config_deep_s5(int on_ac, int on_dc)
{
	/* Treat S4 the same as S5. */
	config_deep_sX(S4_PWRGATE_POL, S4AC_GATE_SUS, 4, on_ac);
	config_deep_sX(S4_PWRGATE_POL, S4DC_GATE_SUS, 4, on_dc);
	config_deep_sX(S5_PWRGATE_POL, S5AC_GATE_SUS, 5, on_ac);
	config_deep_sX(S5_PWRGATE_POL, S5DC_GATE_SUS, 5, on_dc);
}

static void config_deep_s3(int on_ac, int on_dc)
{
	config_deep_sX(S3_PWRGATE_POL, S3AC_GATE_SUS, 3, on_ac);
	config_deep_sX(S3_PWRGATE_POL, S3DC_GATE_SUS, 3, on_dc);
}

static void config_deep_sx(uint32_t deepsx_config)
{
	uint32_t reg;
	uint8_t *pmcbase = pmc_mmio_regs();

	reg = read32(pmcbase + DSX_CFG);
	reg &= ~DSX_CFG_MASK;
	reg |= deepsx_config;
	write32(pmcbase + DSX_CFG, reg);
}

static void pmc_init(void *unused)
{
	const config_t *config = config_of_soc();

	rtc_init();

	pmc_set_power_failure_state(true);
	pmc_gpe_init();

	config_deep_s3(config->deep_s3_enable_ac, config->deep_s3_enable_dc);
	config_deep_s5(config->deep_s5_enable_ac, config->deep_s5_enable_dc);
	config_deep_sx(config->deep_sx_config);
}

/*
* Initialize PMC controller.
*
* PMC controller gets hidden from PCI bus during FSP-Silicon init call.
* Hence PCI enumeration can't be used to initialize bus device and
* allocate resources.
*/
BOOT_STATE_INIT_ENTRY(BS_DEV_INIT_CHIPS, BS_ON_EXIT, pmc_init, NULL);

static void soc_acpi_mode_init(void *unused)
{
	/*
	 * PMC initialization happens earlier for this SoC because FSP-Silicon
	 * init hides PMC from PCI bus. However, pmc_set_acpi_mode, which
	 * disables ACPI mode doesn't need to happen that early and can be
	 * delayed till typical BS_DEV_INIT. This ensures that ACPI mode
	 * disabling happens the same way for all SoCs and hence the ordering of
	 * events is the same.
	 *
	 * This is important to ensure that the ordering does not break the
	 * assumptions of any other drivers (e.g. ChromeEC) which could be
	 * taking different actions based on disabling of ACPI (e.g. flushing of
	 * all EC hostevent bits).
	 *
	 * P.S.: This cannot be done as part of pmc_soc_init as PMC device is
	 * hidden and hence the PMC driver never gets enumerated and so init is
	 * not called for it.
	 */
	pmc_set_acpi_mode();
}

BOOT_STATE_INIT_ENTRY(BS_DEV_INIT, BS_ON_EXIT, soc_acpi_mode_init, NULL);
