/* SPDX-License-Identifier: GPL-2.0-or-later */

#include <intelblocks/gpio.h>
#include <soc/soc_chip.h>

/*
 * Routine to perform below operations:
 * 1. SoC rotine to fill GPIO PM mask and value for GPIO_MISCCFG register
 * 2. Program GPIO PM configuration based on PM mask and value
 */
void soc_gpio_pm_configuration(void)
{
	uint8_t value[TOTAL_GPIO_COMM];
	const config_t *config = config_of_soc();

	if (config->gpio_override_pm)
		memcpy(value, config->gpio_pm, sizeof(uint8_t) *
				TOTAL_GPIO_COMM);
	else
		memset(value, MISCCFG_ENABLE_GPIO_PM_CONFIG, sizeof(uint8_t) *
				TOTAL_GPIO_COMM);

	gpio_pm_configure(value, TOTAL_GPIO_COMM);
}
