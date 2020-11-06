/* SPDX-License-Identifier: GPL-2.0-only */

#include <southbridge/intel/ibexpeak/nvs.h>

void acpi_create_gnvs(global_nvs_t *gnvs)
{
	/* The lid is open by default */
	gnvs->lids = 1;

	/* Temperature at which OS will shutdown */
	gnvs->tcrt = 100;
	/* Temperature at which OS will throttle CPU */
	gnvs->tpsv = 90;
}
