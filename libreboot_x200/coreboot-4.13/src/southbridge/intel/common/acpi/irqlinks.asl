/* SPDX-License-Identifier: GPL-2.0-only */

Device (LNKA)
{
	Name (_HID, EISAID("PNP0C0F"))
	Name (_UID, 1)

	// Disable method
	Method (_DIS, 0, Serialized)
	{
		PRTA = 0x80
	}

	// Possible Resource Settings for this Link
	Name (_PRS, ResourceTemplate()
	{
		IRQ (Level, ActiveLow, Shared)
			{ 3, 4, 5, 6, 7, 10, 11, 12, 14, 15 }
	})

	// Current Resource Settings for this link
	Method (_CRS, 0, Serialized)
	{
		Name (RTLA, ResourceTemplate()
		{
			IRQ (Level, ActiveLow, Shared) {}
		})
		CreateWordField (RTLA, 1, IRQ0)

		// Clear the WordField
		IRQ0 = 0

		// Set the bit from PRTA
		IRQ0 = 1 << (PRTA & 0x0f)

		Return (RTLA)
	}

	// Set Resource Setting for this IRQ link
	Method (_SRS, 1, Serialized)
	{
		CreateWordField (Arg0, 1, IRQ0)

		// Which bit is set?
		FindSetRightBit (IRQ0, Local0)

		Local0--
		PRTA = Local0
	}

	// Status
	Method (_STA, 0, Serialized)
	{
		If (PRTA & 0x80) {
			Return (0x9)
		} Else {
			Return (0xb)
		}
	}
}

Device (LNKB)
{
	Name (_HID, EISAID("PNP0C0F"))
	Name (_UID, 2)

	// Disable method
	Method (_DIS, 0, Serialized)
	{
		PRTB = 0x80
	}

	// Possible Resource Settings for this Link
	Name (_PRS, ResourceTemplate()
	{
		IRQ (Level, ActiveLow, Shared)
			{ 3, 4, 5, 6, 7, 10, 11, 12, 14, 15 }
	})

	// Current Resource Settings for this link
	Method (_CRS, 0, Serialized)
	{
		Name (RTLB, ResourceTemplate()
		{
			IRQ (Level, ActiveLow, Shared) {}
		})
		CreateWordField (RTLB, 1, IRQ0)

		// Clear the WordField
		IRQ0 = 0

		// Set the bit from PRTB
		IRQ0 = 1 << (PRTB & 0x0f)

		Return (RTLB)
	}

	// Set Resource Setting for this IRQ link
	Method (_SRS, 1, Serialized)
	{
		CreateWordField (Arg0, 1, IRQ0)

		// Which bit is set?
		FindSetRightBit (IRQ0, Local0)

		Local0--
		PRTB = Local0
	}

	// Status
	Method (_STA, 0, Serialized)
	{
		If (PRTB & 0x80) {
			Return (0x9)
		} Else {
			Return (0xb)
		}
	}
}

Device (LNKC)
{
	Name (_HID, EISAID("PNP0C0F"))
	Name (_UID, 3)

	// Disable method
	Method (_DIS, 0, Serialized)
	{
		PRTC = 0x80
	}

	// Possible Resource Settings for this Link
	Name (_PRS, ResourceTemplate()
	{
		IRQ (Level, ActiveLow, Shared)
			{ 3, 4, 5, 6, 7, 10, 11, 12, 14, 15 }
	})

	// Current Resource Settings for this link
	Method (_CRS, 0, Serialized)
	{
		Name (RTLC, ResourceTemplate()
		{
			IRQ (Level, ActiveLow, Shared) {}
		})
		CreateWordField (RTLC, 1, IRQ0)

		// Clear the WordField
		IRQ0 = 0

		// Set the bit from PRTC
		IRQ0 = 1 << (PRTC & 0x0f)

		Return (RTLC)
	}

	// Set Resource Setting for this IRQ link
	Method (_SRS, 1, Serialized)
	{
		CreateWordField (Arg0, 1, IRQ0)

		// Which bit is set?
		FindSetRightBit (IRQ0, Local0)

		Local0--
		PRTC = Local0
	}

	// Status
	Method (_STA, 0, Serialized)
	{
		If (PRTC & 0x80) {
			Return (0x9)
		} Else {
			Return (0xb)
		}
	}
}

Device (LNKD)
{
	Name (_HID, EISAID("PNP0C0F"))
	Name (_UID, 4)

	// Disable method
	Method (_DIS, 0, Serialized)
	{
		PRTD = 0x80
	}

	// Possible Resource Settings for this Link
	Name (_PRS, ResourceTemplate()
	{
		IRQ (Level, ActiveLow, Shared)
			{ 3, 4, 5, 6, 7, 10, 11, 12, 14, 15 }
	})

	// Current Resource Settings for this link
	Method (_CRS, 0, Serialized)
	{
		Name (RTLD, ResourceTemplate()
		{
			IRQ (Level, ActiveLow, Shared) {}
		})
		CreateWordField (RTLD, 1, IRQ0)

		// Clear the WordField
		IRQ0 = 0

		// Set the bit from PRTD
		IRQ0 = 1 << (PRTD & 0x0f)

		Return (RTLD)
	}

	// Set Resource Setting for this IRQ link
	Method (_SRS, 1, Serialized)
	{
		CreateWordField (Arg0, 1, IRQ0)

		// Which bit is set?
		FindSetRightBit (IRQ0, Local0)

		Local0--
		PRTD = Local0
	}

	// Status
	Method (_STA, 0, Serialized)
	{
		If (PRTD & 0x80) {
			Return (0x9)
		} Else {
			Return (0xb)
		}
	}
}

Device (LNKE)
{
	Name (_HID, EISAID("PNP0C0F"))
	Name (_UID, 5)

	// Disable method
	Method (_DIS, 0, Serialized)
	{
		PRTE = 0x80
	}

	// Possible Resource Settings for this Link
	Name (_PRS, ResourceTemplate()
	{
		IRQ (Level, ActiveLow, Shared)
			{ 3, 4, 5, 6, 7, 10, 11, 12, 14, 15 }
	})

	// Current Resource Settings for this link
	Method (_CRS, 0, Serialized)
	{
		Name (RTLE, ResourceTemplate()
		{
			IRQ (Level, ActiveLow, Shared) {}
		})
		CreateWordField (RTLE, 1, IRQ0)

		// Clear the WordField
		IRQ0 = 0

		// Set the bit from PRTE
		IRQ0 = 1 << (PRTE & 0x0f)

		Return (RTLE)
	}

	// Set Resource Setting for this IRQ link
	Method (_SRS, 1, Serialized)
	{
		CreateWordField (Arg0, 1, IRQ0)

		// Which bit is set?
		FindSetRightBit (IRQ0, Local0)

		Local0--
		PRTE = Local0
	}

	// Status
	Method (_STA, 0, Serialized)
	{
		If (PRTE & 0x80) {
			Return (0x9)
		} Else {
			Return (0xb)
		}
	}
}

Device (LNKF)
{
	Name (_HID, EISAID("PNP0C0F"))
	Name (_UID, 6)

	// Disable method
	Method (_DIS, 0, Serialized)
	{
		PRTF = 0x80
	}

	// Possible Resource Settings for this Link
	Name (_PRS, ResourceTemplate()
	{
		IRQ (Level, ActiveLow, Shared)
			{ 3, 4, 5, 6, 7, 10, 11, 12, 14, 15 }
	})

	// Current Resource Settings for this link
	Method (_CRS, 0, Serialized)
	{
		Name (RTLF, ResourceTemplate()
		{
			IRQ (Level, ActiveLow, Shared) {}
		})
		CreateWordField (RTLF, 1, IRQ0)

		// Clear the WordField
		IRQ0 = 0

		// Set the bit from PRTF
		IRQ0 = 1 << (PRTF & 0x0f)

		Return (RTLF)
	}

	// Set Resource Setting for this IRQ link
	Method (_SRS, 1, Serialized)
	{
		CreateWordField (Arg0, 1, IRQ0)

		// Which bit is set?
		FindSetRightBit (IRQ0, Local0)

		Local0--
		PRTF = Local0
	}

	// Status
	Method (_STA, 0, Serialized)
	{
		If (PRTF & 0x80) {
			Return (0x9)
		} Else {
			Return (0xb)
		}
	}
}

Device (LNKG)
{
	Name (_HID, EISAID("PNP0C0F"))
	Name (_UID, 7)

	// Disable method
	Method (_DIS, 0, Serialized)
	{
		PRTG = 0x80
	}

	// Possible Resource Settings for this Link
	Name (_PRS, ResourceTemplate()
	{
		IRQ (Level, ActiveLow, Shared)
			{ 3, 4, 5, 6, 7, 10, 11, 12, 14, 15 }
	})

	// Current Resource Settings for this link
	Method (_CRS, 0, Serialized)
	{
		Name (RTLG, ResourceTemplate()
		{
			IRQ (Level, ActiveLow, Shared) {}
		})
		CreateWordField (RTLG, 1, IRQ0)

		// Clear the WordField
		IRQ0 = 0

		// Set the bit from PRTG
		IRQ0 = 1 << (PRTG & 0x0f)

		Return (RTLG)
	}

	// Set Resource Setting for this IRQ link
	Method (_SRS, 1, Serialized)
	{
		CreateWordField (Arg0, 1, IRQ0)

		// Which bit is set?
		FindSetRightBit (IRQ0, Local0)

		Local0--
		PRTG = Local0
	}

	// Status
	Method (_STA, 0, Serialized)
	{
		If (PRTG & 0x80) {
			Return (0x9)
		} Else {
			Return (0xb)
		}
	}
}

Device (LNKH)
{
	Name (_HID, EISAID("PNP0C0F"))
	Name (_UID, 8)

	// Disable method
	Method (_DIS, 0, Serialized)
	{
		PRTH = 0x80
	}

	// Possible Resource Settings for this Link
	Name (_PRS, ResourceTemplate()
	{
		IRQ (Level, ActiveLow, Shared)
			{ 3, 4, 5, 6, 7, 10, 11, 12, 14, 15 }
	})

	// Current Resource Settings for this link
	Method (_CRS, 0, Serialized)
	{
		Name (RTLH, ResourceTemplate()
		{
			IRQ (Level, ActiveLow, Shared) {}
		})
		CreateWordField (RTLH, 1, IRQ0)

		// Clear the WordField
		IRQ0 = 0

		// Set the bit from PRTH
		IRQ0 = 1 << (PRTH & 0x0f)

		Return (RTLH)
	}

	// Set Resource Setting for this IRQ link
	Method (_SRS, 1, Serialized)
	{
		CreateWordField (Arg0, 1, IRQ0)

		// Which bit is set?
		FindSetRightBit (IRQ0, Local0)

		Local0--
		PRTH = Local0
	}

	// Status
	Method (_STA, 0, Serialized)
	{
		If (PRTH & 0x80) {
			Return (0x9)
		} Else {
			Return (0xb)
		}
	}
}
