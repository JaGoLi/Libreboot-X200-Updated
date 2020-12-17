/* SPDX-License-Identifier: GPL-2.0-only */

#include <bootblock_common.h>
#include <soc/southbridge.h>

#include "../gpio.h"

void bootblock_mainboard_early_init(void)
{
	size_t num_gpios;
	const struct soc_amd_gpio *gpios;
	gpios = early_gpio_table(&num_gpios);
	program_gpios(gpios, num_gpios);
}
