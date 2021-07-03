/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef AMD_CEZANNE_IOMAP_H
#define AMD_CEZANNE_IOMAP_H

#define I2C_MASTER_DEV_COUNT		4
#define I2C_MASTER_START_INDEX		0
#define I2C_PERIPHERAL_DEV_COUNT	0 /* TODO: Only master for now. */
#define I2C_CTRLR_COUNT			(I2C_MASTER_DEV_COUNT + I2C_PERIPHERAL_DEV_COUNT)

#if ENV_X86

/* MMIO Ranges */
/* IO_APIC_ADDR defined in arch/x86	0xfec00000 */
#define GNB_IO_APIC_ADDR		0xfec01000
#define SPI_BASE_ADDRESS		0xfec10000

#if CONFIG(HPET_ADDRESS_OVERRIDE)
#error HPET address override is not allowed and must be fixed at 0xfed00000
#endif
#define HPET_BASE_ADDRESS		0xfed00000

/* FCH AL2AHB Registers */
#define ALINK_AHB_ADDRESS		0xfedc0000

#define APU_I2C0_BASE			0xfedc2000
#define APU_I2C1_BASE			0xfedc3000
#define APU_I2C2_BASE			0xfedc4000
#define APU_I2C3_BASE			0xfedc5000

/* I2C parameters for lpc_read_resources */
#define I2C_BASE_ADDRESS		APU_I2C2_BASE
#define I2C_DEVICE_SIZE			0x00001000
#define I2C_DEVICE_COUNT		(I2C_MASTER_DEV_COUNT \
					 - I2C_MASTER_START_INDEX)

#define APU_DMAC0_BASE			0xfedc7000
#define APU_DMAC1_BASE			0xfedc8000
#define APU_UART0_BASE			0xfedc9000
#define APU_UART1_BASE			0xfedca000

#define FLASH_BASE_ADDR			((0xffffffff - CONFIG_ROM_SIZE) + 1)

#endif /* ENV_X86 */

/* I/O Ranges */
#define NCP_ERR				0x00f0
#define ACPI_IO_BASE		0x0400
#define  ACPI_PM_EVT_BLK		(ACPI_IO_BASE + 0x00)
#define   ACPI_PM1_STS			(ACPI_PM_EVT_BLK + 0x00)
#define   ACPI_PM1_EN			(ACPI_PM_EVT_BLK + 0x02)
#define  ACPI_PM1_CNT_BLK		(ACPI_IO_BASE + 0x04)
#define  ACPI_PM_TMR_BLK		(ACPI_IO_BASE + 0x08)
#define  ACPI_CPU_CONTROL		(ACPI_IO_BASE + 0x10)
#define  ACPI_GPE0_BLK			(ACPI_IO_BASE + 0x20)
#define   ACPI_GPE0_STS			(ACPI_GPE0_BLK + 0x00)
#define   ACPI_GPE0_EN			(ACPI_GPE0_BLK + 0x04)
#define SMB_BASE_ADDR			0x0b00

#endif /* AMD_CEZANNE_IOMAP_H */
