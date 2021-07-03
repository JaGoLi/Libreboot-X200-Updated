/* Copyright 2019 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

/* Intel Jasperlake RVP with ITE EC board specific configuration */

#ifndef __CROS_EC_BOARD_H
#define __CROS_EC_BOARD_H

/* ITE EC variant */
#define VARIANT_INTELRVP_EC_IT8320

/* MECC config */
#define CONFIG_INTEL_RVP_MECC_VERSION_0_9

#define CONFIG_CHIPSET_JASPERLAKE
#define GPIO_PG_EC_RSMRST_ODL		GPIO_RSMRST_L_PGOOD
#define GPIO_PCH_DSW_PWROK		GPIO_EC_PCH_DSW_PWROK
#define GPIO_PG_EC_ALL_SYS_PWRGD	GPIO_ALL_SYS_PWRGD
#define CONFIG_BATTERY_PRESENT_GPIO	GPIO_EC_BATT_PRES_L
#define GMR_TABLET_MODE_GPIO_L		GPIO_TABLET_MODE_L
#define GPIO_BAT_LED_RED_L		GPIO_BAT_LED_GREEN_L
#define GPIO_PWR_LED_WHITE_L		GPIO_AC_LED_GREEN_L

/* Fan features */
#define CONFIG_FANS 1
#define BOARD_FAN_MIN_RPM 3000
#define BOARD_FAN_MAX_RPM 10000

/* Temperature sensor */
#define CONFIG_TEMP_SENSOR

#include "baseboard.h"

/* Charger */
#define CONFIG_CHARGER_ISL9238

/* DC Jack charge ports */
#undef  CONFIG_DEDICATED_CHARGE_PORT_COUNT
#define CONFIG_DEDICATED_CHARGE_PORT_COUNT 1

/* USB ports */
#define CONFIG_USB_PD_PORT_MAX_COUNT 2
#define DEDICATED_CHARGE_PORT 2

/* USB PD config */
#define CONFIG_USB_PD_TCPM_ITE_ON_CHIP
#define CONFIG_USB_PD_ITE_ACTIVE_PORT_COUNT 2

/* USB MUX */
#define CONFIG_USB_MUX_ANX7440

/* USB HPD */
#define CONFIG_USB_PD_DP_HPD_GPIO

/* Thermal configs */

/* I2C ports */
#define CONFIG_IT83XX_SMCLK2_ON_GPC7

#define I2C_PORT_CHARGER	IT83XX_I2C_CH_B
#define I2C_PORT_BATTERY	IT83XX_I2C_CH_B
#define I2C_PORT_PCA9555_BOARD_ID_GPIO	IT83XX_I2C_CH_B
#define I2C_PORT_PORT80		IT83XX_I2C_CH_B
#define I2C_PORT_USB_MUX    IT83XX_I2C_CH_E

#define I2C_ADDR_PCA9555_BOARD_ID_GPIO	0x22
#define PORT80_I2C_ADDR			MAX695X_I2C_ADDR1_FLAGS

#ifndef __ASSEMBLER__

enum jslrvp_charge_ports {
	TYPE_C_PORT_0,
	TYPE_C_PORT_1,
};

enum jslrvp_i2c_channel {
	I2C_CHAN_FLASH,
	I2C_CHAN_BATT_CHG,
	I2C_CHAN_RETIMER,
	I2C_CHAN_COUNT,
};

enum battery_type {
	BATTERY_SIMPLO_SMP_HHP_408,
	BATTERY_SIMPLO_SMP_CA_445,
	BATTERY_TYPE_COUNT,
};

/* Define max power */
#define PD_MAX_POWER_MW        45000

int board_get_version(void);

#endif /* !__ASSEMBLER__ */

#endif /* __CROS_EC_BOARD_H */
