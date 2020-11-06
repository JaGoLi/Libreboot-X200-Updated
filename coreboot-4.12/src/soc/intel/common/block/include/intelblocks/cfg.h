/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef SOC_INTEL_COMMON_BLOCK_CFG_H
#define SOC_INTEL_COMMON_BLOCK_CFG_H

#include <intelblocks/gspi.h>
#include <drivers/i2c/designware/dw_i2c.h>
#include <intelblocks/mmc.h>

enum {
	CHIPSET_LOCKDOWN_FSP = 0, /* FSP handles locking per UPDs */
	CHIPSET_LOCKDOWN_COREBOOT, /* coreboot handles locking */
};

/*
 * This structure will hold data required by common blocks.
 * These are soc specific configurations which will be filled by soc.
 * We'll fill this structure once during init and use the data in common block.
 */
struct soc_intel_common_config {
	int chipset_lockdown;
	struct gspi_cfg gspi[CONFIG_SOC_INTEL_COMMON_BLOCK_GSPI_MAX];
	struct dw_i2c_bus_config i2c[CONFIG_SOC_INTEL_I2C_DEV_MAX];
	/* PCH Thermal Trip Temperature in deg C */
	uint8_t pch_thermal_trip;
	struct mmc_dll_params emmc_dll;
	int enable_above_4GB_mmio;
};

/* This function to retrieve soc config structure required by common code */
const struct soc_intel_common_config *chip_get_common_soc_structure(void);

#endif /* SOC_INTEL_COMMON_BLOCK_CFG_H */
