/* SPDX-License-Identifier: GPL-2.0-only */
	Device (PS2K)		// Keyboard
	{
		Name(_HID, EISAID(CONFIG_PS2K_EISAID))
		Name(_CID, EISAID("PNP030B"))

		Name(_CRS, ResourceTemplate()
		{
			IO (Decode16, 0x60, 0x60, 0x01, 0x01)
			IO (Decode16, 0x64, 0x64, 0x01, 0x01)
			IRQ (Edge, ActiveHigh, Exclusive) { 0x01 } // IRQ 1
		})

		Method (_STA, 0)
		{
			Return (0xf)
		}
	}

	Device (PS2M)		// Mouse
	{
		Name(_HID, EISAID(CONFIG_PS2M_EISAID))
		Name(_CID, EISAID("PNP0F13"))
		Name(_CRS, ResourceTemplate()
		{
			IRQ (Edge, ActiveHigh, Exclusive) { 0x0c } // IRQ 12
		})

		Method(_STA, 0)
		{
			Return (0xf)
		}
	}
