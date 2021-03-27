/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

#include "adc.h"
#include "adc_chip.h"
#include "button.h"
#include "charge_manager.h"
#include "charge_ramp.h"
#include "charge_state.h"
#include "charger.h"
#include "charger_mt6370.h"
#include "chipset.h"
#include "common.h"
#include "console.h"
#include "driver/accelgyro_bmi_common.h"
#include "driver/als_tcs3400.h"
#include "driver/charger/rt946x.h"
#include "driver/sync.h"
#include "driver/tcpm/mt6370.h"
#include "driver/usb_mux/it5205.h"
#include "extpower.h"
#include "gesture.h"
#include "gpio.h"
#include "hooks.h"
#include "host_command.h"
#include "i2c.h"
#include "lid_switch.h"
#include "power.h"
#include "power_button.h"
#include "pwm.h"
#include "pwm_chip.h"
#include "registers.h"
#include "spi.h"
#include "system.h"
#include "task.h"
#include "tcpm.h"
#include "timer.h"
#include "usb_charge.h"
#include "usb_mux.h"
#include "usb_pd_policy.h"
#include "usb_pd_tcpm.h"
#include "util.h"

#define CPRINTS(format, args...) cprints(CC_USBCHARGE, format, ## args)
#define CPRINTF(format, args...) cprintf(CC_USBCHARGE, format, ## args)

static void tcpc_alert_event(enum gpio_signal signal)
{
	schedule_deferred_pd_interrupt(0 /* port */);
}

static void gauge_interrupt(enum gpio_signal signal)
{
	task_wake(TASK_ID_CHARGER);
}

#include "gpio_list.h"

/******************************************************************************/
/* ADC channels. Must be in the exactly same order as in enum adc_channel. */
const struct adc_t adc_channels[] = {
	[ADC_BOARD_ID] = {"BOARD_ID", 3300, 4096, 0, STM32_AIN(10)},
	[ADC_EC_SKU_ID] = {"EC_SKU_ID", 3300, 4096, 0, STM32_AIN(8)},
	[ADC_BATT_ID] = {"BATT_ID", 3300, 4096, 0, STM32_AIN(7)},
	[ADC_POGO_ADC_INT_L] = {"POGO_ADC_INT_L", 3300, 4096, 0, STM32_AIN(6)},
};
BUILD_ASSERT(ARRAY_SIZE(adc_channels) == ADC_CH_COUNT);

/******************************************************************************/
/* I2C ports */
const struct i2c_port_t i2c_ports[] = {
	{"typec", 0, 400, GPIO_I2C1_SCL, GPIO_I2C1_SDA},
	{"other", 1, 400, GPIO_I2C2_SCL, GPIO_I2C2_SDA},
};
const unsigned int i2c_ports_used = ARRAY_SIZE(i2c_ports);


/* power signal list.  Must match order of enum power_signal. */
const struct power_signal_info power_signal_list[] = {
	{GPIO_AP_IN_SLEEP_L,   POWER_SIGNAL_ACTIVE_LOW,  "AP_IN_S3_L"},
	{GPIO_PMIC_EC_RESETB,  POWER_SIGNAL_ACTIVE_HIGH, "PMIC_PWR_GOOD"},
};
BUILD_ASSERT(ARRAY_SIZE(power_signal_list) == POWER_SIGNAL_COUNT);

/******************************************************************************/
/* SPI devices */
const struct spi_device_t spi_devices[] = {
};
const unsigned int spi_devices_used = ARRAY_SIZE(spi_devices);

/******************************************************************************/
const struct tcpc_config_t tcpc_config[CONFIG_USB_PD_PORT_MAX_COUNT] = {
	{
		.bus_type = EC_BUS_TYPE_I2C,
		.i2c_info = {
			.port = I2C_PORT_TCPC0,
			.addr_flags = MT6370_TCPC_I2C_ADDR_FLAGS,
		},
		.drv = &mt6370_tcpm_drv,
	},
};

struct mt6370_thermal_bound thermal_bound = {
	.target = 80,
	.err = 4,
};

static void board_hpd_update(const struct usb_mux *me,
			     int hpd_lvl, int hpd_irq)
{
	/*
	 * svdm_dp_attention() did most of the work, we only need to notify
	 * host here.
	 */
	host_set_single_event(EC_HOST_EVENT_USB_MUX);
}

__override const struct rt946x_init_setting *board_rt946x_init_setting(void)
{
	static const struct rt946x_init_setting battery_init_setting = {
		.eoc_current = 140,
		.mivr = 4000,
		.ircmp_vclamp = 32,
		.ircmp_res = 25,
		.boost_voltage = 5050,
		.boost_current = 1500,
	};

	return &battery_init_setting;
}

struct usb_mux usb_muxes[CONFIG_USB_PD_PORT_MAX_COUNT] = {
	{
		.usb_port = 0,
		.i2c_port = I2C_PORT_USB_MUX,
		.i2c_addr_flags = IT5205_I2C_ADDR1_FLAGS,
		.driver = &it5205_usb_mux_driver,
		.hpd_update = &board_hpd_update,
	},
};

uint16_t tcpc_get_alert_status(void)
{
	uint16_t status = 0;

	if (!gpio_get_level(GPIO_USB_C0_PD_INT_ODL))
		status |= PD_STATUS_TCPC_ALERT_0;

	return status;
}

static int force_discharge;

int board_set_active_charge_port(int charge_port)
{
	CPRINTS("New chg p%d", charge_port);

	/* ignore all request when discharge mode is on */
	if (force_discharge && charge_port != CHARGE_PORT_NONE)
		return EC_SUCCESS;

	switch (charge_port) {
	case CHARGE_PORT_USB_C:
		/* Don't charge from a source port */
		if (board_vbus_source_enabled(charge_port))
			return -1;
		gpio_set_level(GPIO_EN_POGO_CHARGE_L, 1);
		gpio_set_level(GPIO_EN_USBC_CHARGE_L, 0);
		break;
#if CONFIG_DEDICATED_CHARGE_PORT_COUNT > 0
	case CHARGE_PORT_POGO:
		gpio_set_level(GPIO_EN_USBC_CHARGE_L, 1);
		gpio_set_level(GPIO_EN_POGO_CHARGE_L, 0);
		break;
#endif
	case CHARGE_PORT_NONE:
		/*
		 * To ensure the fuel gauge (max17055) is always powered
		 * even when battery is disconnected, keep VBAT rail on but
		 * set the charging current to minimum.
		 */
		gpio_set_level(GPIO_EN_POGO_CHARGE_L, 1);
		gpio_set_level(GPIO_EN_USBC_CHARGE_L, 1);
		charger_set_current(CHARGER_SOLO, 0);
		break;
	default:
		panic("Invalid charge port\n");
		break;
	}

	return EC_SUCCESS;
}

int board_discharge_on_ac(int enable)
{
	int ret, port;

	if (enable) {
		port = CHARGE_PORT_NONE;
	} else {
		/* restore the charge port state */
		port = charge_manager_get_override();
		if (port == OVERRIDE_OFF)
			port = charge_manager_get_active_charge_port();
	}

	ret = charger_discharge_on_ac(enable);
	if (ret)
		return ret;

	if (force_discharge && !enable)
		rt946x_toggle_bc12_detection();

	force_discharge = enable;
	return board_set_active_charge_port(port);
}

int extpower_is_present(void)
{
	/*
	 * The charger will indicate VBUS presence if we're sourcing 5V,
	 * so exclude such ports.
	 */
	int usb_c_extpower_present;

	if (board_vbus_source_enabled(CHARGE_PORT_USB_C))
		usb_c_extpower_present = 0;
	else
		usb_c_extpower_present = tcpm_check_vbus_level(
							CHARGE_PORT_USB_C,
							VBUS_PRESENT);

	return usb_c_extpower_present;
}

int pd_snk_is_vbus_provided(int port)
{
	if (port)
		panic("Invalid charge port\n");

	return rt946x_is_vbus_ready();
}

static void board_init(void)
{
	/* If the reset cause is external, pulse PMIC force reset. */
	if (system_get_reset_flags() == EC_RESET_FLAG_RESET_PIN) {
		gpio_set_level(GPIO_PMIC_FORCE_RESET_ODL, 0);
		msleep(100);
		gpio_set_level(GPIO_PMIC_FORCE_RESET_ODL, 1);
	}

	/* Enable TCPC alert interrupts */
	gpio_enable_interrupt(GPIO_USB_C0_PD_INT_ODL);

	/* Enable charger interrupts */
	gpio_enable_interrupt(GPIO_CHARGER_INT_ODL);

#ifdef SECTION_IS_RW
	/* Enable interrupts from BMI160 sensor. */
	gpio_enable_interrupt(GPIO_ACCEL_INT_ODL);

	/* Enable interrupt for the camera vsync. */
	gpio_enable_interrupt(GPIO_SYNC_INT);
#endif /* SECTION_IS_RW */

	/* Enable interrupt from PMIC. */
	gpio_enable_interrupt(GPIO_PMIC_EC_RESETB);

	/* Enable gauge interrupt from max17055 */
	gpio_enable_interrupt(GPIO_GAUGE_INT_ODL);

	/*
	 * Fix backlight led maximum current:
	 * tolerance 120mA * 0.75 = 90mA.
	 * (b/133655155)
	 */
	mt6370_backlight_set_dim(MT6370_BLDIM_DEFAULT * 3 / 4);
}
DECLARE_HOOK(HOOK_INIT, board_init, HOOK_PRIO_DEFAULT);

static void board_rev_init(void)
{
	/* Board revision specific configs. */

	/*
	 * It's a P1 pin BOOTBLOCK_MUX_OE, also a P2 pin BC12_DET_EN.
	 * Keep this pin defaults to P1 setting since that eMMC enabled with
	 * High-Z stat.
	 */
	/* TODO */
	/* Put initial code here for different EC board reversion */
	return;
}
DECLARE_HOOK(HOOK_INIT, board_rev_init, HOOK_PRIO_INIT_ADC + 1);

void sensor_board_proc_double_tap(void)
{
	CPRINTS("Detect double tap");
}

/* Motion sensors */
/* Mutexes */
#ifndef VARIANT_KUKUI_NO_SENSORS
static struct mutex g_lid_mutex;

static struct bmi_drv_data_t g_bmi160_data;

/* TCS3400 private data */
static struct als_drv_data_t g_tcs3400_data = {
	.als_cal.scale = 1,
	.als_cal.uscale = 0,
	.als_cal.offset = 0,
	.als_cal.channel_scale = {
		.k_channel_scale = ALS_CHANNEL_SCALE(1.0), /* kc */
		.cover_scale = ALS_CHANNEL_SCALE(1.0),     /* CT */
	},
};

static struct tcs3400_rgb_drv_data_t g_tcs3400_rgb_data = {
	/*
	 * TODO(b:139366662): calculates the actual coefficients and scaling
	 * factors
	 */
	.calibration.rgb_cal[X] = {
		.offset = 0,
		.scale = {
			.k_channel_scale = ALS_CHANNEL_SCALE(1.0), /* kr */
			.cover_scale = ALS_CHANNEL_SCALE(1.0)
		},
		.coeff[TCS_RED_COEFF_IDX] = FLOAT_TO_FP(0),
		.coeff[TCS_GREEN_COEFF_IDX] = FLOAT_TO_FP(0),
		.coeff[TCS_BLUE_COEFF_IDX] = FLOAT_TO_FP(0),
		.coeff[TCS_CLEAR_COEFF_IDX] = FLOAT_TO_FP(0),
	},
	.calibration.rgb_cal[Y] = {
		.offset = 0,
		.scale = {
			.k_channel_scale = ALS_CHANNEL_SCALE(1.0), /* kg */
			.cover_scale = ALS_CHANNEL_SCALE(1.0)
		},
		.coeff[TCS_RED_COEFF_IDX] = FLOAT_TO_FP(0),
		.coeff[TCS_GREEN_COEFF_IDX] = FLOAT_TO_FP(0),
		.coeff[TCS_BLUE_COEFF_IDX] = FLOAT_TO_FP(0),
		.coeff[TCS_CLEAR_COEFF_IDX] = FLOAT_TO_FP(0.1),
	},
	.calibration.rgb_cal[Z] = {
		.offset = 0,
		.scale = {
			.k_channel_scale = ALS_CHANNEL_SCALE(1.0), /* kb */
			.cover_scale = ALS_CHANNEL_SCALE(1.0)
		},
		.coeff[TCS_RED_COEFF_IDX] = FLOAT_TO_FP(0),
		.coeff[TCS_GREEN_COEFF_IDX] = FLOAT_TO_FP(0),
		.coeff[TCS_BLUE_COEFF_IDX] = FLOAT_TO_FP(0),
		.coeff[TCS_CLEAR_COEFF_IDX] = FLOAT_TO_FP(0),
	},
	.calibration.irt = INT_TO_FP(1),
	.saturation.again = TCS_DEFAULT_AGAIN,
	.saturation.atime = TCS_DEFAULT_ATIME,
};

/* Matrix to rotate accelerometer into standard reference frame */
static const mat33_fp_t lid_standard_ref = {
	{FLOAT_TO_FP(-1), 0, 0},
	{0, FLOAT_TO_FP(-1), 0},
	{0, 0, FLOAT_TO_FP(1)}
};

struct motion_sensor_t motion_sensors[] = {
	/*
	 * Note: bmi160: supports accelerometer and gyro sensor
	 * Requirement: accelerometer sensor must init before gyro sensor
	 * DO NOT change the order of the following table.
	 */
	[LID_ACCEL] = {
	 .name = "Accel",
	 .active_mask = SENSOR_ACTIVE_S0_S3,
	 .chip = MOTIONSENSE_CHIP_BMI160,
	 .type = MOTIONSENSE_TYPE_ACCEL,
	 .location = MOTIONSENSE_LOC_LID,
	 .drv = &bmi160_drv,
	 .mutex = &g_lid_mutex,
	 .drv_data = &g_bmi160_data,
	 .port = I2C_PORT_ACCEL,
	 .i2c_spi_addr_flags = BMI160_ADDR0_FLAGS,
	 .rot_standard_ref = &lid_standard_ref,
	 .default_range = 4,  /* g, to meet CDD 7.3.1/C-1-4 reqs */
	 .min_frequency = BMI_ACCEL_MIN_FREQ,
	 .max_frequency = BMI_ACCEL_MAX_FREQ,
	 .config = {
		 /* Enable accel in S0 */
		 [SENSOR_CONFIG_EC_S0] = {
			 .odr = TAP_ODR,
			 .ec_rate = 100 * MSEC,
		 },
		 /* For double tap detection */
		 [SENSOR_CONFIG_EC_S3] = {
			 .odr = TAP_ODR,
			 .ec_rate = 100 * MSEC,
		 },
	 },
	},
	[LID_GYRO] = {
	 .name = "Gyro",
	 .active_mask = SENSOR_ACTIVE_S0_S3,
	 .chip = MOTIONSENSE_CHIP_BMI160,
	 .type = MOTIONSENSE_TYPE_GYRO,
	 .location = MOTIONSENSE_LOC_LID,
	 .drv = &bmi160_drv,
	 .mutex = &g_lid_mutex,
	 .drv_data = &g_bmi160_data,
	 .port = I2C_PORT_ACCEL,
	 .i2c_spi_addr_flags = BMI160_ADDR0_FLAGS,
	 .default_range = 1000, /* dps */
	 .rot_standard_ref = &lid_standard_ref,
	 .min_frequency = BMI_GYRO_MIN_FREQ,
	 .max_frequency = BMI_GYRO_MAX_FREQ,
	},
	[CLEAR_ALS] = {
	 .name = "Clear Light",
	 .active_mask = SENSOR_ACTIVE_S0_S3,
	 .chip = MOTIONSENSE_CHIP_TCS3400,
	 .type = MOTIONSENSE_TYPE_LIGHT,
	 .location = MOTIONSENSE_LOC_LID,
	 .drv = &tcs3400_drv,
	 .drv_data = &g_tcs3400_data,
	 .port = I2C_PORT_ALS,
	 .i2c_spi_addr_flags = TCS3400_I2C_ADDR_FLAGS,
	 .rot_standard_ref = NULL,
	 .default_range = 0x10000, /* scale = 1x, uscale = 0 */
	 .min_frequency = TCS3400_LIGHT_MIN_FREQ,
	 .max_frequency = TCS3400_LIGHT_MAX_FREQ,
	 .config = {
		 /* Run ALS sensor in S0 */
		[SENSOR_CONFIG_EC_S0] = {
			.odr = 1000,
		},
	 },
	},
	[RGB_ALS] = {
	.name = "RGB Light",
	 .active_mask = SENSOR_ACTIVE_S0_S3,
	 .chip = MOTIONSENSE_CHIP_TCS3400,
	 .type = MOTIONSENSE_TYPE_LIGHT_RGB,
	 .location = MOTIONSENSE_LOC_LID,
	 .drv = &tcs3400_rgb_drv,
	 .drv_data = &g_tcs3400_rgb_data,
	 /*.port = I2C_PORT_ALS,*/ /* Unused. RGB channels read by CLEAR_ALS. */
	 .rot_standard_ref = NULL,
	 .default_range = 0x10000, /* scale = 1x, uscale = 0 */
	 .min_frequency = 0, /* 0 indicates we should not use sensor directly */
	 .max_frequency = 0, /* 0 indicates we should not use sensor directly */
	},
	[VSYNC] = {
	 .name = "Camera vsync",
	 .active_mask = SENSOR_ACTIVE_S0,
	 .chip = MOTIONSENSE_CHIP_GPIO,
	 .type = MOTIONSENSE_TYPE_SYNC,
	 .location = MOTIONSENSE_LOC_CAMERA,
	 .drv = &sync_drv,
	 .default_range = 0,
	 .min_frequency = 0,
	 .max_frequency = 1,
	},
};
const unsigned int motion_sensor_count = ARRAY_SIZE(motion_sensors);
const struct motion_sensor_t *motion_als_sensors[] = {
	&motion_sensors[CLEAR_ALS],
};
#endif /* VARIANT_KUKUI_NO_SENSORS */

/*
 * Return if VBUS is sagging too low
 */
int board_is_vbus_too_low(int port, enum chg_ramp_vbus_state ramp_state)
{
	int voltage;
	/*
	 * Though we have a more tolerant range (3.9V~13.4V), setting 4400 to
	 * prevent from a bad charger crashed.
	 *
	 * TODO(b:131284131): mt6370 VBUS reading is not accurate currently.
	 * Vendor will provide a workaround solution to fix the gap between ADC
	 * reading and actual voltage.  After the workaround applied, we could
	 * try to raise this value to 4600.  (when it says it read 4400, it is
	 * actually close to 4600)
	 */
	if (charger_get_vbus_voltage(port, &voltage))
		voltage = 0;

	return voltage < 4400;
}

__override int board_charge_port_is_sink(int port)
{
	/* TODO(b:128386458): Check POGO_ADC_INT_L */
	return 1;
}

__override int board_charge_port_is_connected(int port)
{
	return gpio_get_level(GPIO_POGO_VBUS_PRESENT);
}

__override
void board_fill_source_power_info(int port,
				  struct ec_response_usb_pd_power_info *r)
{
	r->meas.voltage_now = 3300;
	r->meas.voltage_max = 3300;
	r->meas.current_max = 1500;
	r->meas.current_lim = 1500;
	r->max_power = r->meas.voltage_now * r->meas.current_max;
}

