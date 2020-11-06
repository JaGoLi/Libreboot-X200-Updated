/* SPDX-License-Identifier: GPL-2.0-only */

#include <console/console.h>
#include <fsp/api.h>
#include <soc/ramstage.h>
#include "emmc.h"

static int get_emmc_dll_info(uint16_t signature, size_t num_of_entry,
			     BL_EMMC_INFORMATION **config)
{
	uint8_t entry;

	if ((signature == 0) || (num_of_entry == 0) || (*config == NULL))
		return 1;

	for (entry = 0; entry < num_of_entry; entry++) {
		if ((*config)[entry].Signature == signature) {
			*config = &(*config)[entry];
			return 0;
		}
	}

	return 1;
}

void mainboard_silicon_init_params(FSPS_UPD *params)
{
	size_t num;
	uint16_t emmc_dll_sign;
	BL_EMMC_INFORMATION *emmc_config;

	/* Configure eMMC DLL PCD */
	emmc_dll_sign = DEFAULT_EMMC_DLL_SIGN;
	num = ARRAY_SIZE(harcuvar_emmc_config);
	emmc_config = harcuvar_emmc_config;

	if (get_emmc_dll_info(emmc_dll_sign, num, &emmc_config))
		die("eMMC DLL Configuration is invalid, please correct it!");

	params->FspsConfig.PcdEMMCDLLConfigPtr =
		(uint32_t)&emmc_config->eMMCDLLConfig;
}
