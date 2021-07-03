/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

/* Lazor board configuration */

#ifndef __CROS_EC_BOARD_H
#define __CROS_EC_BOARD_H

#include "baseboard.h"

/* Internal SPI flash on NPCX7 */
#define CONFIG_FLASH_SIZE (512 * 1024)  /* 512KB internal spi flash */

/* Switchcap */
#define CONFIG_LN9310

/* Keyboard */
#define CONFIG_KEYBOARD_BOARD_CONFIG
#define CONFIG_PWM_KBLIGHT

/* Battery */
#define CONFIG_BATTERY_DEVICE_CHEMISTRY  "LION"
#define CONFIG_BATTERY_REVIVE_DISCONNECT
#define CONFIG_BATTERY_FUEL_GAUGE

/* BC 1.2 Charger */
#define CONFIG_BC12_DETECT_PI3USB9201

/* USB */
#define CONFIG_USB_PD_TCPM_MULTI_PS8XXX
#define CONFIG_USB_PD_TCPM_PS8751
#define CONFIG_USB_PD_TCPM_PS8805
#define CONFIG_USBC_PPC_SN5S330
#define CONFIG_USB_PD_PORT_MAX_COUNT 2

/* USB-A */
#define USB_PORT_COUNT 1
#define CONFIG_USB_PORT_POWER_DUMB

/* Sensors */
#define CONFIG_DYNAMIC_MOTION_SENSOR_COUNT

/* BMI160 Base accel/gyro */
#define CONFIG_ACCELGYRO_BMI160
#define CONFIG_ACCEL_INTERRUPTS
#define CONFIG_ACCELGYRO_BMI160_INT_EVENT \
	TASK_EVENT_MOTION_SENSOR_INTERRUPT(BASE_ACCEL)
#define OPT3001_I2C_ADDR_FLAGS OPT3001_I2C_ADDR1_FLAGS

/* BMA253 lid accel */
#define CONFIG_ACCEL_BMA255
#define CONFIG_ACCEL_FORCE_MODE_MASK BIT(LID_ACCEL)

#define CONFIG_LID_ANGLE
#define CONFIG_LID_ANGLE_SENSOR_BASE BASE_ACCEL
#define CONFIG_LID_ANGLE_SENSOR_LID LID_ACCEL
#define CONFIG_LID_ANGLE_UPDATE

#define CONFIG_TABLET_MODE
#define CONFIG_TABLET_MODE_SWITCH
#define CONFIG_GMR_TABLET_MODE
#define GMR_TABLET_MODE_GPIO_L GPIO_TABLET_MODE_L

/* GPIO alias */
#define GPIO_AC_PRESENT GPIO_ACOK_OD
#define GPIO_WP_L GPIO_EC_WP_ODL
#define GPIO_PMIC_RESIN_L GPIO_PM845_RESIN_L
#define GPIO_SWITCHCAP_PG_INT_L GPIO_DA9313_GPIO0
#define GPIO_SWITCHCAP_ON_L GPIO_SWITCHCAP_ON

#ifndef __ASSEMBLER__

#include "gpio_signal.h"
#include "registers.h"

enum adc_channel {
	ADC_VBUS,
	ADC_AMON_BMON,
	ADC_PSYS,
	ADC_CH_COUNT
};

/* Motion sensors */
enum sensor_id {
	LID_ACCEL = 0,
	BASE_ACCEL,
	BASE_GYRO,
	SENSOR_COUNT,
};

enum pwm_channel {
	PWM_CH_KBLIGHT = 0,
	PWM_CH_DISPLIGHT,
	PWM_CH_COUNT
};

/* List of possible batteries */
enum battery_type {
	BATTERY_AP16L5J,
	BATTERY_AP16L5J_009,
	BATTERY_AP16L8J,
	BATTERY_LGC_AP18C8K,
	BATTERY_MURATA_AP18C4K,
	BATTERY_TYPE_COUNT,
};

/* Swithcap functions */
void board_set_switchcap_power(int enable);
int board_is_switchcap_enabled(void);
int board_is_switchcap_power_good(void);
enum battery_cell_type board_get_battery_cell_type(void);
/* Custom function to indicate if sourcing VBUS */
int board_is_sourcing_vbus(int port);
/* Enable VBUS sink for a given port */
int board_vbus_sink_enable(int port, int enable);
/* Reset all TCPCs. */
void board_reset_pd_mcu(void);
void board_set_tcpc_power_mode(int port, int mode);

#endif /* !defined(__ASSEMBLER__) */

#endif /* __CROS_EC_BOARD_H */
