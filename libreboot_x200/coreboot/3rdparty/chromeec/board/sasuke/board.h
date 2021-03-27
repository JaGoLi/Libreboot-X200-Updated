/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

/* Waddledoo board configuration */

#ifndef __CROS_EC_BOARD_H
#define __CROS_EC_BOARD_H

#define VARIANT_DEDEDE_EC_NPCX796FC
#include "baseboard.h"
#undef GPIO_VOLUME_UP_L
#undef GPIO_VOLUME_DOWN_L
#undef CONFIG_VOLUME_BUTTONS

/*
 * Keep the system unlocked in early development.
 * TODO(b/151264302): Make sure to remove this before production!
 */
#define CONFIG_SYSTEM_UNLOCKED

/* Save some flash space */
#define CONFIG_CHIP_INIT_ROM_REGION

/* EC console commands */
#define CONFIG_CMD_TCPC_DUMP
#define CONFIG_CMD_CHARGER_DUMP

/* Battery */
#define CONFIG_BATTERY_FUEL_GAUGE

/* Charger */
#define CONFIG_CHARGER_RAA489000
#define CONFIG_CHARGER_SENSE_RESISTOR_AC 10
#define CONFIG_CHARGER_SENSE_RESISTOR 10
#define CONFIG_OCPC_DEF_RBATT_MOHMS 22 /* R_DS(on) 11.6mOhm + 10mOhm sns rstr */
#define CONFIG_OCPC
#undef  CONFIG_CHARGER_SINGLE_CHIP

/*
 * GPIO for C1 interrupts, for baseboard use
 *
 * Note this line might already have its pull up disabled for HDMI DBs, but
 * it should be fine to set again before z-state.
 */
#define GPIO_USB_C1_INT_ODL GPIO_SUB_C1_INT_EN_RAILS_ODL

/* Keyboard */

/* LED */
#define CONFIG_LED_COMMON
#define CONFIG_LED_ONOFF_STATES
#define CONFIG_LED_POWER_LED
#define GPIO_BAT_LED_RED_L GPIO_LED_R_ODL
#define GPIO_BAT_LED_GREEN_L GPIO_LED_G_ODL
#define GPIO_PWR_LED_BLUE_L GPIO_LED_B_ODL


/* PWM */
#define NPCX7_PWM1_SEL    0  /* GPIO C2 is not used as PWM1. */

/* USB */
#define CONFIG_BC12_DETECT_PI3USB9201
#define CONFIG_USBC_RETIMER_NB7V904M

/* USB PD */
#define CONFIG_USB_PD_PORT_MAX_COUNT 2
#define CONFIG_USB_PD_TCPM_RAA489000

/* USB defines specific to external TCPCs */
#define CONFIG_USB_PD_DUAL_ROLE_AUTO_TOGGLE
#define CONFIG_USB_PD_VBUS_DETECT_TCPC
#define CONFIG_USB_PD_DISCHARGE_TCPC
#define CONFIG_USB_PD_TCPC_LOW_POWER

/* Variant references the TCPCs to determine Vbus sourcing */
#define CONFIG_USB_PD_5V_EN_CUSTOM

#undef PD_POWER_SUPPLY_TURN_ON_DELAY
#undef PD_POWER_SUPPLY_TURN_OFF_DELAY
#undef PD_VCONN_SWAP_DELAY
/* 20% margin added for these timings */
#define PD_POWER_SUPPLY_TURN_ON_DELAY	13080	/* us */
#define PD_POWER_SUPPLY_TURN_OFF_DELAY	16080	/* us */
#define PD_VCONN_SWAP_DELAY		787	/* us */


/* I2C configuration */
#define I2C_PORT_EEPROM     NPCX_I2C_PORT7_0
#define I2C_PORT_BATTERY    NPCX_I2C_PORT5_0
#define I2C_PORT_SENSOR     NPCX_I2C_PORT0_0
#define I2C_PORT_USB_C0     NPCX_I2C_PORT1_0
#define I2C_PORT_SUB_USB_C1 NPCX_I2C_PORT2_0
#define I2C_PORT_USB_MUX    I2C_PORT_USB_C0
/* TODO(b:147440290): Need to handle multiple charger ICs */
#define I2C_PORT_CHARGER    I2C_PORT_USB_C0

#define I2C_PORT_ACCEL      I2C_PORT_SENSOR

#define I2C_ADDR_EEPROM_FLAGS 0x50 /* 7b address */

/*
 * I2C pin names for baseboard
 *
 * Note: these lines will be set as i2c on start-up, but this should be
 * okay since they're ODL.
 */
#define GPIO_EC_I2C_SUB_USB_C1_SCL GPIO_EC_I2C_SUB_C1_SCL_HDMI_EN_ODL
#define GPIO_EC_I2C_SUB_USB_C1_SDA GPIO_EC_I2C_SUB_C1_SDA_HDMI_HPD_ODL

#define CONFIG_MKBP_EVENT
#define CONFIG_MKBP_USE_GPIO

#define CONFIG_MATH_UTIL

#ifndef __ASSEMBLER__

#include "gpio_signal.h"
#include "registers.h"

enum chg_id {
	CHARGER_PRIMARY,
	CHARGER_SECONDARY,
	CHARGER_NUM,
};

enum adc_channel {
	ADC_TEMP_SENSOR_1,     /* ADC0 */
	ADC_TEMP_SENSOR_2,     /* ADC1 */
	ADC_SUB_ANALOG,	       /* ADC2 */
	ADC_VSNS_PP3300_A,     /* ADC9 */
	ADC_CH_COUNT
};

/* List of possible batteries */
enum battery_type {
	BATTERY_POWER_TECH,
	BATTERY_TYPE_COUNT,
};

int board_is_sourcing_vbus(int port);

#endif /* !__ASSEMBLER__ */
#endif /* __CROS_EC_BOARD_H */
