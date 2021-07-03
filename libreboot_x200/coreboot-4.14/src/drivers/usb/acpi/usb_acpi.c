/* SPDX-License-Identifier: GPL-2.0-only */

#include <acpi/acpi_device.h>
#include <acpi/acpi_pld.h>
#include <acpi/acpigen.h>
#include <console/console.h>
#include <device/device.h>
#include <device/path.h>
#include "chip.h"

static bool usb_acpi_add_gpios_to_crs(struct drivers_usb_acpi_config *cfg)
{
	if (cfg->privacy_gpio.pin_count)
		return true;

	if (cfg->reset_gpio.pin_count && !cfg->has_power_resource)
		return true;

	return false;
}

static int usb_acpi_write_gpio(struct acpi_gpio *gpio, int *curr_index)
{
	int ret = -1;

	if (gpio->pin_count == 0)
		return ret;

	acpi_device_write_gpio(gpio);
	ret = *curr_index;
	(*curr_index)++;

	return ret;
}

static void usb_acpi_fill_ssdt_generator(const struct device *dev)
{
	struct drivers_usb_acpi_config *config = dev->chip_info;
	const char *path = acpi_device_path(dev);

	if (!path || !config)
		return;

	/* Don't generate output for hubs, only ports */
	if (config->type == UPC_TYPE_HUB)
		return;

	acpigen_write_scope(path);
	if (config->desc)
		acpigen_write_name_string("_DDN", config->desc);
	acpigen_write_upc(config->type);

	if (config->use_custom_pld) {
		/* Use board defined PLD */
		acpigen_write_pld(&config->custom_pld);
	} else {
		/* Fill PLD strucutre based on port type */
		struct acpi_pld pld;
		acpi_pld_fill_usb(&pld, config->type, &config->group);
		acpigen_write_pld(&pld);
	}

	/* Resources */
	if (usb_acpi_add_gpios_to_crs(config) == true) {
		struct acpi_dp *dsd;
		int idx = 0;
		int reset_gpio_index = -1;
		int privacy_gpio_index;

		acpigen_write_name("_CRS");
		acpigen_write_resourcetemplate_header();
		if (!config->has_power_resource) {
			reset_gpio_index = usb_acpi_write_gpio(
						&config->reset_gpio, &idx);
		}
		privacy_gpio_index = usb_acpi_write_gpio(&config->privacy_gpio,
							 &idx);
		acpigen_write_resourcetemplate_footer();

		dsd = acpi_dp_new_table("_DSD");
		if (reset_gpio_index >= 0)
			acpi_dp_add_gpio(dsd, "reset-gpio", path,
					 reset_gpio_index, 0,
					 config->reset_gpio.active_low);
		if (privacy_gpio_index >= 0)
			acpi_dp_add_gpio(dsd, "privacy-gpio", path,
					 privacy_gpio_index, 0,
					 config->privacy_gpio.active_low);
		acpi_dp_write(dsd);
	}

	if (config->has_power_resource) {
		const struct acpi_power_res_params power_res_params = {
			&config->reset_gpio,
			config->reset_delay_ms,
			config->reset_off_delay_ms,
			&config->enable_gpio,
			config->enable_delay_ms,
			config->enable_off_delay_ms,
			NULL,
			0,
			0
		};
		acpi_device_add_power_res(&power_res_params);
	}

	acpigen_pop_len();

	printk(BIOS_INFO, "%s: %s at %s\n", path,
	       config->desc ? : dev->chip_ops->name, dev_path(dev));
}

static struct device_operations usb_acpi_ops = {
	.read_resources		= noop_read_resources,
	.set_resources		= noop_set_resources,
	.scan_bus		= scan_static_bus,
	.acpi_fill_ssdt		= usb_acpi_fill_ssdt_generator,
};

static void usb_acpi_enable(struct device *dev)
{
	dev->ops = &usb_acpi_ops;
}

struct chip_operations drivers_usb_acpi_ops = {
	CHIP_NAME("USB ACPI Device")
	.enable_dev = usb_acpi_enable
};
