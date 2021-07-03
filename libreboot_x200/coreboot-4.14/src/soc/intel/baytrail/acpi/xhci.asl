/* SPDX-License-Identifier: GPL-2.0-only */

Device (XHCI)
{
	Name (_ADR, 0x00140000)
	Name (_PRW, Package () { 0x0d, 3 })
	Name (_S3D, 3) /* Highest D state in S3 state */

	Device (RHUB)
	{
		Name (_ADR, 0x00000000)

		// GPLD: Generate Port Location Data (PLD)
		Method (GPLD, 1, Serialized) {
			Name (PCKG, Package (0x01) {
				Buffer (0x10) {}
			})

			// REV: Revision 0x02 for ACPI 5.0
			CreateField (DerefOf (Index (PCKG, Zero)), Zero, 0x07, REV)
			Store (0x02, REV)

			// VISI: Port visibility to user per port
			CreateField (DerefOf (Index (PCKG, Zero)), 0x40, One, VISI)
			Store (Arg0, VISI)
			Return (PCKG)
		}

		Device (PRT1) { Name (_ADR, 1) }
		Device (PRT2) { Name (_ADR, 2) }
		Device (PRT3) { Name (_ADR, 3) }
		Device (PRT4) { Name (_ADR, 4) }
		Device (SSP1) { Name (_ADR, 7) }
	}
}
