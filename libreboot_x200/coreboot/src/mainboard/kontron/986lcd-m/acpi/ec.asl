/* SPDX-License-Identifier: GPL-2.0-only */

Device(EC0)
{
	Name (_HID, EISAID("PNP0C09"))
	Name (_UID, 1)

	// _REG method requires that an operation region is defined.
	OperationRegion (ERAM, EmbeddedControl, 0x00, 0xff)
	Field (ERAM, ByteAcc, Lock, Preserve)
	{
	}

	Method (_CRS, 0, Serialized)
	{
		Name (ECMD, ResourceTemplate()
		{
			IO (Decode16, 0x62, 0x62, 0, 1)
			IO (Decode16, 0x66, 0x66, 0, 1)
		})

		Return (ECMD)
	}

	Method (_REG, 2)
	{
		// This method is needed by Windows XP/2000
		// for EC initialization before a driver
		// is loaded
	}

	Name (_GPE, 23)	// GPI07 / GPE23 -> Runtime SCI

	// TODO EC Query methods

	// TODO Scope _SB devices for AC power, LID, Power button

}
