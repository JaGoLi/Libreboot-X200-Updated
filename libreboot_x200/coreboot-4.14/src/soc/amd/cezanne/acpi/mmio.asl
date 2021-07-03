/* SPDX-License-Identifier: GPL-2.0-only */

#include <soc/amd/common/acpi/aoac.asl>
#include <soc/gpio.h>
#include <soc/iomap.h>
#include <amdblocks/acpimmio_map.h>

Device (AAHB)
{
	Name (_HID, "AAHB0000")
	Name (_UID, 0x0)
	Name (_CRS, ResourceTemplate()
	{
		Memory32Fixed (ReadWrite, ALINK_AHB_ADDRESS, 0x2000)
	})

	Method (_STA, 0x0, NotSerialized)
	{
		Return (0x0F)
	}
}

Device (GPIO)
{
	Name (_HID, GPIO_DEVICE_NAME)
	Name (_CID, GPIO_DEVICE_NAME)
	Name (_UID, 0)
	Name (_DDN, GPIO_DEVICE_DESC)

	Method (_CRS, 0) {
		Local0 = ResourceTemplate() {
			Interrupt (
				ResourceConsumer,
				Level,
				ActiveLow,
				Exclusive, , , IRQR)
			{ 0 }
			Memory32Fixed (ReadWrite, ACPIMMIO_GPIO0_BASE, 0x400)
		}
		CreateDWordField (Local0, IRQR._INT, IRQN)
		If (PICM) {
			IRQN = IGPI
		} Else {
			IRQN = PGPI
		}
		If (IRQN == 0x1f) {
			Return (ResourceTemplate() {
				Memory32Fixed (ReadWrite, ACPIMMIO_GPIO0_BASE, 0x400)
			})
		} Else {
			Return (Local0)
		}
	}

	Method (_STA, 0x0, NotSerialized)
	{
		Return (0x0F)
	}
}

Device (FUR0)
{
	Name (_HID, "AMDI0020")
	Name (_UID, 0x0)
	Method (_CRS, 0) {
		Local0 = ResourceTemplate() {
			Interrupt (
				ResourceConsumer,
				Edge,
				ActiveHigh,
				Exclusive, , , IRQR)
			{ 0 }
			Memory32Fixed (ReadWrite, APU_UART0_BASE, 0x1000)
		}
		CreateDWordField (Local0, IRQR._INT, IRQN)
		If (PICM) {
			IRQN = IUA0
		} Else {
			IRQN = PUA0
		}
		If (IRQN == 0x1f) {
			Return (ResourceTemplate() {
				Memory32Fixed (ReadWrite, APU_UART0_BASE, 0x1000)
			})
		} Else {
			Return (Local0)
		}
	}

	// TODO(b/183983959): Enable the AOAC register access later.
	// AOAC_DEVICE(11, 0)
}

Device (FUR1) {
	Name (_HID, "AMDI0020")
	Name (_UID, 0x1)
	Method (_CRS, 0) {
		Local0 = ResourceTemplate() {
			Interrupt (
				ResourceConsumer,
				Edge,
				ActiveHigh,
				Exclusive, , , IRQR)
			{ 0 }
			Memory32Fixed (ReadWrite, APU_UART1_BASE, 0x1000)
		}
		CreateDWordField (Local0, IRQR._INT, IRQN)
		If (PICM) {
			IRQN = IUA1
		} Else {
			IRQN = PUA1
		}
		If (IRQN == 0x1f) {
			Return (ResourceTemplate() {
				Memory32Fixed (ReadWrite, APU_UART1_BASE, 0x1000)
			})
		} Else {
			Return (Local0)
		}
	}

	// TODO(b/183983959): Enable the AOAC register access later.
	// AOAC_DEVICE(12, 0)
}

Device (I2C0) {
	Name (_HID, "AMDI0010")
	Name (_UID, 0x0)
	Method (_CRS, 0) {
		Local0 = ResourceTemplate() {
			Interrupt (
				ResourceConsumer,
				Edge,
				ActiveHigh,
				Exclusive, , , IRQR)
			{ 0 }
			Memory32Fixed (ReadWrite, APU_I2C0_BASE, 0x1000)
		}
		CreateDWordField (Local0, IRQR._INT, IRQN)
		If (PICM) {
			IRQN = II20
		} Else {
			IRQN = PI20
		}
		If (IRQN == 0x1f) {
			Return (ResourceTemplate() {
				Memory32Fixed (ReadWrite, APU_I2C0_BASE, 0x1000)
			})
		} Else {
			Return (Local0)
		}
	}

	Method (_STA, 0x0, NotSerialized)
	{
		Return (0x0F)
	}

	// TODO(b/183983959): Enable the AOAC register access later.
	// AOAC_DEVICE(5, 0)
}

Device (I2C1) {
	Name (_HID, "AMDI0010")
	Name (_UID, 0x1)
	Method (_CRS, 0) {
		Local0 = ResourceTemplate() {
			Interrupt (
				ResourceConsumer,
				Edge,
				ActiveHigh,
				Exclusive, , , IRQR)
			{ 0 }
			Memory32Fixed (ReadWrite, APU_I2C1_BASE, 0x1000)
		}
		CreateDWordField (Local0, IRQR._INT, IRQN)
		If (PICM) {
			IRQN = II21
		} Else {
			IRQN = PI21
		}
		If (IRQN == 0x1f) {
			Return (ResourceTemplate() {
				Memory32Fixed (ReadWrite, APU_I2C1_BASE, 0x1000)
			})
		} Else {
			Return (Local0)
		}
	}

	Method (_STA, 0x0, NotSerialized)
	{
		Return (0x0F)
	}

	// TODO(b/183983959): Enable the AOAC register access later.
	// AOAC_DEVICE(6, 0)
}

Device (I2C2) {
	Name (_HID, "AMDI0010")
	Name (_UID, 0x2)
	Method (_CRS, 0) {
		Local0 = ResourceTemplate() {
			Interrupt (
				ResourceConsumer,
				Edge,
				ActiveHigh,
				Exclusive, , , IRQR)
			{ 0 }
			Memory32Fixed (ReadWrite, APU_I2C2_BASE, 0x1000)
		}
		CreateDWordField (Local0, IRQR._INT, IRQN)
		If (PICM) {
			IRQN = II22
		} Else {
			IRQN = PI22
		}
		If (IRQN == 0x1f) {
			Return (ResourceTemplate() {
				Memory32Fixed (ReadWrite, APU_I2C2_BASE, 0x1000)
			})
		} Else {
			Return (Local0)
		}
	}

	Method (_STA, 0x0, NotSerialized)
	{
		Return (0x0F)
	}

	// TODO(b/183983959): Enable the AOAC register access later.
	// AOAC_DEVICE(7, 0)
}

Device (I2C3)
{
	Name (_HID, "AMDI0010")
	Name (_UID, 0x3)
	Method (_CRS, 0) {
		Local0 = ResourceTemplate() {
			Interrupt (
				ResourceConsumer,
				Edge,
				ActiveHigh,
				Exclusive, , , IRQR)
			{ 0 }
			Memory32Fixed (ReadWrite, APU_I2C3_BASE, 0x1000)
		}
		CreateDWordField (Local0, IRQR._INT, IRQN)
		If (PICM) {
			IRQN = II23
		} Else {
			IRQN = PI23
		}
		If (IRQN == 0x1f) {
			Return (ResourceTemplate() {
				Memory32Fixed (ReadWrite, APU_I2C3_BASE, 0x1000)
			})
		} Else {
			Return (Local0)
		}
	}
	Method (_STA, 0x0, NotSerialized)
	{
		Return (0x0F)
	}

	// TODO(b/183983959): Enable the AOAC register access later.
	// AOAC_DEVICE(8, 0)
}

Device (MISC)
{
	Name (_HID, "AMD0040")
	Name (_UID, 0x3)
	Name (_CRS, ResourceTemplate() {
		Memory32Fixed (ReadWrite, ACPIMMIO_MISC_BASE, 0x100)
	})
	Name (_DSD, Package ()
	{
		ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
		Package ()
		{
			Package () { "is-rv", 1 },
		},
	})
	Method (_STA, 0x0, NotSerialized)
	{
		Return (0x0F)
	}
}
