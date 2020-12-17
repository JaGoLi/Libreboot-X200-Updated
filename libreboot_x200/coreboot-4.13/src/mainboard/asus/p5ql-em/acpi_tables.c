/* SPDX-License-Identifier: GPL-2.0-only */

#include <acpi/acpigen.h>
#include <acpi/acpi_gnvs.h>
#include <southbridge/intel/i82801jx/nvs.h>

void acpi_create_gnvs(struct global_nvs *gnvs)
{
	gnvs->pwrs = 1;    /* Power state (AC = 1) */
	gnvs->osys = 2002; /* At least WINXP SP2 (HPET fix) */
	gnvs->apic = 1;    /* Enable APIC */
	gnvs->mpen = 1;    /* Enable Multi Processing */
	gnvs->cmap = 0x01; /* Enable COM 1 port */
}

/* TODO: Could work... */
int get_cst_entries(acpi_cstate_t **entries)
{
	return 0;
}
