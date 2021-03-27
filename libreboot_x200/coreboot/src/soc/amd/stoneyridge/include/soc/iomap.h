/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef AMD_STONEYRIDGE_IOMAP_H
#define AMD_STONEYRIDGE_IOMAP_H

/* MMIO Ranges */
#define PSP_MAILBOX_BAR3_BASE		0xf0a00000
#define SPI_BASE_ADDRESS		0xfec10000
#define IO_APIC2_ADDR			0xfec20000

#define ALINK_AHB_ADDRESS		0xfedc0000

/* I2C fixed address */
#define I2C_BASE_ADDRESS		0xfedc2000
#define I2C_DEVICE_SIZE			0x00001000
#define I2C_DEVICE_COUNT		4

#define I2C_BUS_ADDRESS(x)		(I2C_BASE_ADDRESS + I2C_DEVICE_SIZE * (x))
#define I2CA_BASE_ADDRESS		(I2C_BUS_ADDRESS(0))
#define I2CB_BASE_ADDRESS		(I2C_BUS_ADDRESS(1))
#define I2CC_BASE_ADDRESS		(I2C_BUS_ADDRESS(2))
#define I2CD_BASE_ADDRESS		(I2C_BUS_ADDRESS(3))

#if CONFIG(HPET_ADDRESS_OVERRIDE)
#error HPET address override is not allowed and must be fixed at 0xfed00000
#endif
#define HPET_BASE_ADDRESS		0xfed00000

#define APU_UART0_BASE			0xfedc6000
#define APU_UART1_BASE			0xfedc8000

#define FLASH_BASE_ADDR			((0xffffffff - CONFIG_ROM_SIZE) + 1)

/* I/O Ranges */
#define ACPI_IO_BASE			0x400
#define  ACPI_PM_EVT_BLK		(ACPI_IO_BASE + 0x00)		/* 4 bytes */
#define  ACPI_PM1_STS			(ACPI_PM_EVT_BLK + 0x00)	/* 2 bytes */
#define  ACPI_PM1_EN			(ACPI_PM_EVT_BLK + 0x02)	/* 2 bytes */
#define  ACPI_PM1_CNT_BLK		(ACPI_IO_BASE + 0x04)		/* 2 bytes */
#define  ACPI_CPU_CONTROL		(ACPI_IO_BASE + 0x08)		/* 6 bytes */
#define  ACPI_GPE0_BLK			(ACPI_IO_BASE + 0x10)		/* 8 bytes */
#define  ACPI_GPE0_STS			(ACPI_GPE0_BLK + 0x00)		/* 4 bytes */
#define  ACPI_GPE0_EN			(ACPI_GPE0_BLK + 0x04)		/* 4 bytes */
#define  ACPI_PM_TMR_BLK		(ACPI_IO_BASE + 0x18)		/* 4 bytes */
#define SMB_BASE_ADDR			0xb00
#define PM2_INDEX			0xcd0
#define PM2_DATA			0xcd1
#define BIOSRAM_INDEX			0xcd4
#define BIOSRAM_DATA			0xcd5
#define AB_INDX				0xcd8
#define AB_DATA				(AB_INDX+4)

#endif /* AMD_STONEYRIDGE_IOMAP_H */
