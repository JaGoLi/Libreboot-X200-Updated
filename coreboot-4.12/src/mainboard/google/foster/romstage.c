/* SPDX-License-Identifier: GPL-2.0-only */

#include <soc/addressmap.h>
#include <soc/clock.h>
#include <soc/funitcfg.h>
#include <soc/nvidia/tegra/i2c.h>
#include <soc/padconfig.h>
#include <soc/romstage.h>

void romstage_mainboard_init(void)
{
	/* No EC or TPM on Foster, do nothing here */
}

void mainboard_configure_pmc(void)
{
}

void mainboard_enable_vdd_cpu(void)
{
	/* VDD_CPU is already enabled in bootblock. */
}
