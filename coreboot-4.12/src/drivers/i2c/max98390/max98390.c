/* This file is part of the coreboot project. */
/* SPDX-License-Identifier: GPL-2.0-or-later */

#include <arch/acpi.h>
#include <arch/acpi_device.h>
#include <arch/acpigen.h>
#include <console/console.h>
#include <device/i2c.h>
#include <device/device.h>
#include <device/path.h>
#include <stdint.h>
#include <vendorcode/google/chromeos/chromeos.h>
#include "chip.h"

#define MAX98390_ACPI_HID "MX98390"

#define MAX98390_DP_INT(key, val) acpi_dp_add_integer(dp, "maxim," key, (val))

static void max98390_fill_ssdt(struct device *dev)
{
	struct drivers_i2c_max98390_config *config = dev->chip_info;
	const char *scope = acpi_device_scope(dev);
	struct acpi_i2c i2c = {
		.address = dev->path.i2c.device,
		.mode_10bit = dev->path.i2c.mode_10bit,
		.speed = I2C_SPEED_FAST,
		.resource = scope,
	};
	struct acpi_dp *dp;
	uint64_t r0_value, temp_value;

	if (!dev->enabled || !scope)
		return;

	/* Device */
	acpigen_write_scope(scope);
	acpigen_write_device(acpi_device_name(dev));
	acpigen_write_name_string("_HID", MAX98390_ACPI_HID);
	acpigen_write_name_integer("_UID", config->uid);
	acpigen_write_name_string("_DDN", config->desc);
	acpigen_write_STA(acpi_device_status(dev));

	/* Resources */
	acpigen_write_name("_CRS");
	acpigen_write_resourcetemplate_header();
	acpi_device_write_i2c(&i2c);
	acpigen_write_resourcetemplate_footer();

	/* Device Properties */
	if (CONFIG(CHROMEOS_DSM_CALIB)) {
		if (get_dsm_calibration_from_key(config->r0_calib_key, &r0_value)
		    || get_dsm_calibration_from_key(config->temperature_calib_key,
						    &temp_value)) {
			printk(BIOS_ERR,
			       "Failed to get dsm_calib parameters from VPD"
			       " with key %s and %s\n",
			       config->r0_calib_key, config->temperature_calib_key);
		} else {
			dp = acpi_dp_new_table("_DSD");
			MAX98390_DP_INT("r0_calib", r0_value);
			MAX98390_DP_INT("temperature_calib", temp_value);
			acpi_dp_write(dp);
			printk(BIOS_INFO, "set dsm_calib properties\n");
		}
	}

	acpigen_pop_len(); /* Device */
	acpigen_pop_len(); /* Scope */

	printk(BIOS_INFO, "%s: %s address 0%xh\n", acpi_device_path(dev), dev->chip_ops->name,
	       dev->path.i2c.device);
}

static const char *max98390_acpi_name(const struct device *dev)
{
	struct drivers_i2c_max98390_config *config = dev->chip_info;
	static char name[5];

	if (config->name)
		return config->name;

	snprintf(name, sizeof(name), "D%03.3X", dev->path.i2c.device);
	return name;
}

static struct device_operations max98390_ops = {
	.read_resources = noop_read_resources,
	.set_resources = noop_set_resources,
	.acpi_name = max98390_acpi_name,
	.acpi_fill_ssdt_generator = max98390_fill_ssdt,
};

static void max98390_enable(struct device *dev)
{
	struct drivers_i2c_max98390_config *config = dev->chip_info;

	if (!config)
		return;

	dev->ops = &max98390_ops;

	/* Name the device as per description provided in devicetree */
	if (config->desc)
		dev->name = config->desc;
}

struct chip_operations drivers_i2c_max98390_ops = {
	CHIP_NAME("Maxim MAX98390 Codec")
	.enable_dev = max98390_enable
};
