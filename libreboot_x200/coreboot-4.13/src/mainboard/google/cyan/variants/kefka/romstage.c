/* SPDX-License-Identifier: GPL-2.0-only */

#include <soc/romstage.h>
#include <baseboard/variants.h>
#include <mainboard/google/cyan/spd/spd_util.h>

void variant_memory_init_params(MEMORY_INIT_UPD *memory_params)
{
	int ram_id = get_ramid();

	/*
	 *  RAMID = 2 - 4GiB Micron MT52L256M32D1PF-107
	 *  RAMID = 3 - 2GiB Micron MT52L256M32D1PF-107
	 */
	if (ram_id == 2 || ram_id == 3) {

		/*
		 * For new micron part, it requires read/receive
		 * enable training before sending cmds to get MR8.
		 * To override dram geometry settings as below:
		 *
		 * PcdDramWidth = x32
		 * PcdDramDensity = 8Gb
		 * PcdDualRankDram = disable
		 */
		memory_params->PcdRxOdtLimitChannel0 = 1;
		memory_params->PcdRxOdtLimitChannel1 = 1;
		memory_params->PcdDisableAutoDetectDram = 1;
		memory_params->PcdDramWidth = 2;
		memory_params->PcdDramDensity = 3;
		memory_params->PcdDualRankDram = 0;
	}
}
