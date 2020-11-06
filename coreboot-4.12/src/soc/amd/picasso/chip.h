/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef __PICASSO_CHIP_H__
#define __PICASSO_CHIP_H__

#include <stddef.h>
#include <stdint.h>
#include <commonlib/helpers.h>
#include <drivers/i2c/designware/dw_i2c.h>
#include <soc/i2c.h>
#include <soc/iomap.h>
#include <soc/southbridge.h>
#include <acpi/acpi_device.h>

struct soc_amd_picasso_config {
	/*
	 * If sb_reset_i2c_slaves() is called, this devicetree register
	 * defines which I2C SCL will be toggled 9 times at 100 KHz.
	 * For example, should we need I2C0 and  I2C3 have their slave
	 * devices reseted by toggling SCL, use:
	 *
	 * register i2c_scl_reset = (GPIO_I2C0_SCL | GPIO_I2C3_SCL)
	 */
	u8 i2c_scl_reset;
	struct dw_i2c_bus_config i2c[I2C_MASTER_DEV_COUNT];
	enum {
		I2S_PINS_MAX_HDA = 0,	/* HDA w/reset  3xSDI, SW w/Data0 */
		I2S_PINS_MAX_MHDA = 1,	/* HDA no reset 3xSDI, SW w/Data0-1 */
		I2S_PINS_MIN_HDA = 2,	/* HDA w/reset  1xSDI, SW w/Data0-2 */
		I2S_PINS_MIN_MHDA = 3,	/* HDA no reset 1xSDI, SW w/Data0-3 */
		I2S_PINS_I2S_TDM = 4,
		I2S_PINS_UNCONF = 7,	/* All pads will be input mode */
	} acp_pin_cfg;

	/* Options for these are in src/arch/x86/include/acpi/acpi.h */
	uint8_t  fadt_pm_profile;
	uint16_t fadt_boot_arch;
	uint32_t fadt_flags;

	/* System config index */
	uint8_t system_config;

	/* STAPM Configuration */
	uint32_t fast_ppt_limit;
	uint32_t slow_ppt_limit;
	uint32_t slow_ppt_time_constant;
	uint32_t stapm_time_constant;
	uint32_t sustained_power_limit;

	/* PROCHOT_L de-assertion Ramp Time */
	uint32_t prochot_l_deassertion_ramp_time;

	/* Lower die temperature limit */
	uint32_t thermctl_limit;

	/* FP5 Processor Voltage Supply PSI Currents. 0 indicates use SOC default */
	uint32_t psi0_current_limit;
	uint32_t psi0_soc_current_limit;
	uint32_t vddcr_soc_voltage_margin;
	uint32_t vddcr_vdd_voltage_margin;

	/* VRM Limits. 0 indicates use SOC default */
	uint32_t vrm_maximum_current_limit;
	uint32_t vrm_soc_maximum_current_limit;
	uint32_t vrm_current_limit;
	uint32_t vrm_soc_current_limit;

	/* Misc SMU settings */
	uint8_t sb_tsi_alert_comparator_mode_en;
	uint8_t core_dldo_bypass;
	uint8_t min_soc_vid_offset;
	uint8_t aclk_dpm0_freq_400MHz;

	/*
	 * SPI config
	 * Default values if not overridden by mainboard:
	 * Read mode - Normal 33MHz
	 * Normal speed - 66MHz
	 * Fast speed - 66MHz
	 * Alt speed - 66MHz
	 * TPM speed - 66MHz
	 */
	enum spi_read_mode spi_read_mode;
	enum spi100_speed spi_normal_speed;
	enum spi100_speed spi_fast_speed;
	enum spi100_speed spi_altio_speed;
	enum spi100_speed spi_tpm_speed;

	enum {
		SD_EMMC_DISABLE,
		SD_EMMC_SD_LOW_SPEED,
		SD_EMMC_SD_HIGH_SPEED,
		SD_EMMC_SD_UHS_I_SDR_50,
		SD_EMMC_SD_UHS_I_DDR_50,
		SD_EMMC_SD_UHS_I_SDR_104,
		SD_EMMC_EMMC_SDR_26,
		SD_EMMC_EMMC_SDR_52,
		SD_EMMC_EMMC_DDR_52,
		SD_EMMC_EMMC_HS200,
		SD_EMMC_EMMC_HS400,
		SD_EMMC_EMMC_HS300,
	} sd_emmc_config;
};

typedef struct soc_amd_picasso_config config_t;

extern struct device_operations pci_domain_ops;

#endif /* __PICASSO_CHIP_H__ */
