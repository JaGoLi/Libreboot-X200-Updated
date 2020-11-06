/* SPDX-License-Identifier: GPL-2.0-only */

Device (GFX0)
{
	Name (_ADR, 0x00020000)

	Name (BRIG, Package (0x12)
	{
		0xf,
		0xf,
		0x0,
		0x1,
		0x2,
		0x3,
		0x4,
		0x5,
		0x6,
		0x7,
		0x8,
		0x9,
		0xa,
		0xb,
		0xc,
		0xd,
		0xe,
		0xf,
	})

	Method (XBCM, 1, NotSerialized)
	{
		Store (Or(ShiftLeft (Arg0, 4), 0xf), ^^DSPC.BRTC)
#ifdef SMI_SAVE_CMOS
		Trap(SMI_SAVE_CMOS)
#endif
	}

	Method (XBQC, 0, NotSerialized)
	{
		Store (^^DSPC.BRTC, Local0)
		ShiftRight (Local0, 4, Local0)
		Return (Local0)
	}
#include <drivers/intel/gma/acpi/common.asl>
}

Device (DSPC)
{
	Name (_ADR, 0x00020001)
	OperationRegion (DSPC, PCI_Config, 0x00, 0x100)
	Field (DSPC, ByteAcc, NoLock, Preserve)
	{
		Offset (0xf4),
		       BRTC, 8
	}
}
