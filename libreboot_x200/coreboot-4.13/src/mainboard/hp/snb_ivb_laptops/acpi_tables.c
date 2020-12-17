/* SPDX-License-Identifier: GPL-2.0-only */

#include <acpi/acpi_gnvs.h>
#include <southbridge/intel/bd82x6x/nvs.h>

void acpi_create_gnvs(struct global_nvs *gnvs)
{
	// the lid is open by default.
	gnvs->lids = 1;

	gnvs->tcrt = 100;
	gnvs->tpsv = 90;
}
