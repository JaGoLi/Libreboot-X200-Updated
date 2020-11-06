/* SPDX-License-Identifier: GPL-2.0-only */

#include <stdint.h>
#include <console/console.h>
#include <device/smbus_host.h>
#include <amdblocks/acpimmio.h>
#include <soc/southbridge.h>

/*
 * Between 1-10 seconds, We should never timeout normally
 * Longer than this is just painful when a timeout condition occurs.
 */
#define SMBUS_TIMEOUT (100 * 1000 * 10)

static u8 controller_read8(uintptr_t base, u8 reg)
{
	switch (base) {
	case ACPIMMIO_SMBUS_BASE:
		return smbus_read8(reg);
	case ACPIMMIO_ASF_BASE:
		return asf_read8(reg);
	default:
		printk(BIOS_ERR, "Error attempting to read SMBus at address 0x%lx\n",
				base);
	}
	return 0xff;
}

static void controller_write8(uintptr_t base, u8 reg, u8 val)
{
	switch (base) {
	case ACPIMMIO_SMBUS_BASE:
		smbus_write8(reg, val);
		break;
	case ACPIMMIO_ASF_BASE:
		asf_write8(reg, val);
		break;
	default:
		printk(BIOS_ERR, "Error attempting to write SMBus at address 0x%lx\n",
				base);
	}
}

static int smbus_wait_until_ready(uintptr_t mmio)
{
	u32 loops;
	loops = SMBUS_TIMEOUT;
	do {
		u8 val;
		val = controller_read8(mmio, SMBHSTSTAT);
		val &= SMBHST_STAT_VAL_BITS;
		if (val == 0) {	/* ready now */
			return 0;
		}
		controller_write8(mmio, SMBHSTSTAT, val);
	} while (--loops);
	return -2;		/* time out */
}

static int smbus_wait_until_done(uintptr_t mmio)
{
	u32 loops;
	loops = SMBUS_TIMEOUT;
	do {
		u8 val;

		val = controller_read8(mmio, SMBHSTSTAT);
		val &= SMBHST_STAT_VAL_BITS;	/* mask off reserved bits */
		if (val & SMBHST_STAT_ERROR_BITS)
			return -5;	/* error */
		if (val == SMBHST_STAT_NOERROR) {
			controller_write8(mmio, SMBHSTSTAT, val); /* clr sts */
			return 0;
		}
	} while (--loops);
	return -3;		/* timeout */
}

int do_smbus_recv_byte(uintptr_t mmio, u8 device)
{
	u8 byte;

	if (smbus_wait_until_ready(mmio) < 0)
		return -2;	/* not ready */

	/* set the device I'm talking to */
	controller_write8(mmio, SMBHSTADDR, ((device & 0x7f) << 1) | 1);

	byte = controller_read8(mmio, SMBHSTCTRL);
	byte &= ~SMBHST_CTRL_MODE_BITS;			/* Clear [4:2] */
	byte |= SMBHST_CTRL_STRT | SMBHST_CTRL_BTE_RW;	/* set mode, start */
	controller_write8(mmio, SMBHSTCTRL, byte);

	/* poll for transaction completion */
	if (smbus_wait_until_done(mmio) < 0)
		return -3;	/* timeout or error */

	/* read results of transaction */
	byte = controller_read8(mmio, SMBHSTDAT0);

	return byte;
}

int do_smbus_send_byte(uintptr_t mmio, u8 device, u8 val)
{
	u8 byte;

	if (smbus_wait_until_ready(mmio) < 0)
		return -2;	/* not ready */

	/* set the command... */
	controller_write8(mmio, SMBHSTDAT0, val);

	/* set the device I'm talking to */
	controller_write8(mmio, SMBHSTADDR, ((device & 0x7f) << 1) | 0);

	byte = controller_read8(mmio, SMBHSTCTRL);
	byte &= ~SMBHST_CTRL_MODE_BITS;			/* Clear [4:2] */
	byte |= SMBHST_CTRL_STRT | SMBHST_CTRL_BTE_RW;	/* set mode, start */
	controller_write8(mmio, SMBHSTCTRL, byte);

	/* poll for transaction completion */
	if (smbus_wait_until_done(mmio) < 0)
		return -3;	/* timeout or error */

	return 0;
}

int do_smbus_read_byte(uintptr_t mmio, u8 device, u8 address)
{
	u8 byte;

	if (smbus_wait_until_ready(mmio) < 0)
		return -2;	/* not ready */

	/* set the command/address... */
	controller_write8(mmio, SMBHSTCMD, address & 0xff);

	/* set the device I'm talking to */
	controller_write8(mmio, SMBHSTADDR, ((device & 0x7f) << 1) | 1);

	byte = controller_read8(mmio, SMBHSTCTRL);
	byte &= ~SMBHST_CTRL_MODE_BITS;			/* Clear [4:2] */
	byte |= SMBHST_CTRL_STRT | SMBHST_CTRL_BDT_RW;	/* set mode, start */
	controller_write8(mmio, SMBHSTCTRL, byte);

	/* poll for transaction completion */
	if (smbus_wait_until_done(mmio) < 0)
		return -3;	/* timeout or error */

	/* read results of transaction */
	byte = controller_read8(mmio, SMBHSTDAT0);

	return byte;
}

int do_smbus_write_byte(uintptr_t mmio, u8 device, u8 address, u8 val)
{
	u8 byte;

	if (smbus_wait_until_ready(mmio) < 0)
		return -2;	/* not ready */

	/* set the command/address... */
	controller_write8(mmio, SMBHSTCMD, address & 0xff);

	/* set the device I'm talking to */
	controller_write8(mmio, SMBHSTADDR, ((device & 0x7f) << 1) | 0);

	/* output value */
	controller_write8(mmio, SMBHSTDAT0, val);

	byte = controller_read8(mmio, SMBHSTCTRL);
	byte &= ~SMBHST_CTRL_MODE_BITS;			/* Clear [4:2] */
	byte |= SMBHST_CTRL_STRT | SMBHST_CTRL_BDT_RW;	/* set mode, start */
	controller_write8(mmio, SMBHSTCTRL, byte);

	/* poll for transaction completion */
	if (smbus_wait_until_done(mmio) < 0)
		return -3;	/* timeout or error */

	return 0;
}
