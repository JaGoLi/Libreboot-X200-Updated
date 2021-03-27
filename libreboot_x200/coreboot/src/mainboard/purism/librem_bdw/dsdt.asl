/* SPDX-License-Identifier: GPL-2.0-only */

#include <acpi/acpi.h>
DefinitionBlock(
	"dsdt.aml",
	"DSDT",
	ACPI_DSDT_REV_2,
	OEM_ID,
	ACPI_TABLE_CREATOR,
	0x20160115	/* OEM revision */
)
{
	#include <acpi/dsdt_top.asl>
	#include <soc/intel/broadwell/acpi/platform.asl>

	/* Global NVS and variables */
	#include <soc/intel/broadwell/pch/acpi/globalnvs.asl>

	/* CPU */
	#include <cpu/intel/common/acpi/cpu.asl>

	Scope (\_SB) {
		Device (PCI0)
		{
			#include <soc/intel/broadwell/acpi/hostbridge.asl>
			#include <soc/intel/broadwell/pch/acpi/pch.asl>
		}
	}

	#include <southbridge/intel/common/acpi/sleepstates.asl>

	/* Mainboard specific */
	#include "acpi/mainboard.asl"
}
