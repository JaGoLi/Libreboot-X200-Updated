/* SPDX-License-Identifier: GPL-2.0-only */

#include <acpi/acpi_gnvs.h>
#include <southbridge/intel/bd82x6x/nvs.h>

#include <variant/thermal.h>

void acpi_create_gnvs(struct global_nvs *gnvs)
{
	/* The lid is open by default */
	gnvs->lids = 1;

	gnvs->tcrt = CRITICAL_TEMPERATURE;
	gnvs->tpsv = PASSIVE_TEMPERATURE;
}
