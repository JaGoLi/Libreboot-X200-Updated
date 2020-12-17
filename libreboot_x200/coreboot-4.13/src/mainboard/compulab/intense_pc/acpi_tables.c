/* SPDX-License-Identifier: GPL-2.0-only */

#include <acpi/acpi_gnvs.h>
#include <southbridge/intel/bd82x6x/nvs.h>

/* FIXME: check this function.  */
void acpi_create_gnvs(struct global_nvs *gnvs)
{
	gnvs->tcrt = 100;
	gnvs->tpsv = 90;
}
