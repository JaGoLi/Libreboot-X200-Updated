/* SPDX-License-Identifier: GPL-2.0-only */

#include "hostbridge.asl"

/* PCI Device Resource Consumption */
Device (PDRC)
{
	Name (_HID, EISAID("PNP0C02"))
	Name (_UID, 1)

	Name (PDRS, ResourceTemplate() {
		Memory32Fixed(ReadWrite, CONFIG_FIXED_RCBA_MMIO_BASE, CONFIG_RCBA_LENGTH)
		Memory32Fixed(ReadWrite, CONFIG_FIXED_MCHBAR_MMIO_BASE, 0x00004000)
		Memory32Fixed(ReadWrite, CONFIG_FIXED_DMIBAR_MMIO_BASE, 0x00001000)
		Memory32Fixed(ReadWrite, CONFIG_FIXED_EPBAR_MMIO_BASE,  0x00001000)
		Memory32Fixed(ReadWrite, CONFIG_MMCONF_BASE_ADDRESS, CONFIG_MMCONF_LENGTH)
		Memory32Fixed(ReadWrite, 0xfed20000, 0x00020000) // Misc ICH
		Memory32Fixed(ReadWrite, 0xfed40000, 0x00005000) // Misc ICH
		Memory32Fixed(ReadWrite, 0xfed45000, 0x0004b000) // Misc ICH
	})

	// Current Resource Settings
	Method (_CRS, 0, Serialized)
	{
		Return(PDRS)
	}
}

// PCIe graphics port 0:1.0
#include "peg.asl"

// Integrated graphics 0:2.0
#include <drivers/intel/gma/acpi/gfx.asl>
