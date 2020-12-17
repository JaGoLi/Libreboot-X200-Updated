/* SPDX-License-Identifier: GPL-2.0-only */

#include <amdblocks/dimm_spd.h>
#include <baseboard/variants.h>
#include <soc/gpio.h>
#include <soc/romstage.h>

int mainboard_read_spd(uint8_t spdAddress, char *buf, size_t len)
{
	return variant_mainboard_read_spd(spdAddress, buf, len);
}

void __weak variant_romstage_entry(int s3_resume)
{
	/* By default, don't do anything */
}

void mainboard_romstage_entry_s3(int s3_resume)
{
	size_t num_gpios;
	const struct soc_amd_gpio *gpios;

	gpios = variant_romstage_gpio_table(&num_gpios);
	program_gpios(gpios, num_gpios);

	variant_romstage_entry(s3_resume);
}
