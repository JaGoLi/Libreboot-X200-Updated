/* SPDX-License-Identifier: GPL-2.0-only */

#include <device/pci_ops.h>
#include <console/console.h>
#include <device/smbus_host.h>
#include "variants/baseboard/include/eeprom.h"

/*
 * Check Signature in EEPROM (M24C32-FMN6TP)
 * If signature is there we assume that that the content is valid
 */
int check_signature(u8 addr)
{
	u8 blob[8] = {0};

	if (!read_write_config(addr, blob, EEPROM_OFFSET_FSP_SIGNATURE, 0, ARRAY_SIZE(blob))) {
		// Check Signature
		if (*(uint64_t *)blob == FSP_UPD_SIGNATURE) {
			printk(BIOS_DEBUG, "CFG EEPROM: Signature valid.\n");
			return 1;
		}
		printk(BIOS_DEBUG, "CFG EEPROM: Signature invalid - skipping option write.\n");
		return 0;
	}
	return 0;
}

// Read data from offset and write it to offset in UPD
bool read_write_config(u8 addr, void *blob, size_t read_offset, size_t write_offset,
		size_t size)
{
	int ret = 0;

#if ENV_ROMSTAGE
	pci_devfn_t dev = PCI_DEV(0, PCH_DEV_SLOT_LPC, 4);
#else
	const struct device *dev = pcidev_on_root(PCH_DEV_SLOT_LPC, 4);
#endif

	u32 smb_ctrl_reg = pci_read_config32(dev, HOSTC);
	pci_write_config32(dev, HOSTC, smb_ctrl_reg | HOSTC_I2C_EN);

	printk(BIOS_SPEW, "%s\tOffset: %04zx\tSize: %02zx\n", __func__,
		read_offset, size);

	/* We can always read two bytes at a time */
	for (size_t i = 0; i < size; i = i + 2) {
		u8 tmp[2] = {0};

		ret = do_smbus_process_call(SMBUS_IO_BASE, addr, 0,
			swab16(read_offset + i), (uint16_t *)&tmp[0]);
		if (ret < 0)
			break;

		// Write to UPD
		uint8_t *writePointer = (uint8_t *)blob + write_offset + i;
		if (size > 1 && (size % 2 == 0))
			memcpy(writePointer, tmp, 2);
		else
			*writePointer = tmp[0];
	}

	/* Restore I2C_EN bit */
	pci_write_config32(dev, HOSTC, smb_ctrl_reg);

	return ret;
}
