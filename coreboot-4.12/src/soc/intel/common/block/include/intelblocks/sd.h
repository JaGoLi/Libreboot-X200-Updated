/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef SOC_INTEL_COMMON_BLOCK_SD_H
#define SOC_INTEL_COMMON_BLOCK_SD_H

#include <acpi/acpi_device.h>

/*
 * Fill the GPIO Interrupt or I/O information that will be used for the
 * GPIO Connection Descriptor.
 */
int sd_fill_soc_gpio_info(struct acpi_gpio* gpio, const struct device *dev);

#endif /* SOC_INTEL_COMMON_BLOCK_SD_H */
