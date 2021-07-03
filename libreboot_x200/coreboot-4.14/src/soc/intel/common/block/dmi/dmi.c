/* SPDX-License-Identifier: GPL-2.0-only */

#include <console/console.h>
#include <intelblocks/dmi.h>
#include <intelblocks/pcr.h>
#include <soc/pcr_ids.h>

#define MAX_GPMR_REGS				3

#define GPMR_OFFSET(x)				(0x277c + (x) * 8)
#define  DMI_PCR_GPMR_LIMIT_MASK		0xffff0000
#define  DMI_PCR_GPMR_BASE_SHIFT		16
#define  DMI_PCR_GPMR_BASE_MASK			0xffff

#define GPMR_DID_OFFSET(x)			(0x2780 + (x) * 8)
#define  DMI_PCR_GPMR_EN			BIT(31)

/* GPMR Register read given offset */
static uint32_t gpmr_read32(uint16_t offset)
{
	return pcr_read32(PID_DMI, offset);
}

/* GPMR Register write given offset and val */
static void gpmr_write32(uint16_t offset, uint32_t val)
{
	return pcr_write32(PID_DMI, offset, val);
}

/* Check for available free gpmr */
static int get_available_gpmr(void)
{
	int i;
	uint32_t val;

	for (i = 0; i < MAX_GPMR_REGS; i++) {
		val = gpmr_read32(GPMR_DID_OFFSET(i));
		if (!(val & DMI_PCR_GPMR_EN))
			return i;
	}
	printk(BIOS_ERR, "%s: No available free gpmr found\n", __func__);
	return CB_ERR;
}

/* Configure GPMR for the given base and size of extended BIOS Region */
enum cb_err dmi_enable_gpmr(uint32_t base, uint32_t size, uint32_t dest_id)
{
	int gpmr_num;
	uint32_t limit;

	if (base & ~(DMI_PCR_GPMR_BASE_MASK << DMI_PCR_GPMR_BASE_SHIFT)) {
		printk(BIOS_ERR, "base is not 64-KiB aligned!\n");
		return CB_ERR;
	}

	limit = base + (size - 1);

	if (limit < base) {
		printk(BIOS_ERR, "Invalid limit: limit cannot be less than base!\n");
		return CB_ERR;
	}

	if ((limit & ~DMI_PCR_GPMR_LIMIT_MASK) != 0xffff) {
		printk(BIOS_ERR, "limit does not end on a 64-KiB boundary!\n");
		return CB_ERR;
	}

	/* Get available free GPMR */
	gpmr_num = get_available_gpmr();
	if (gpmr_num == CB_ERR)
		return CB_ERR;

	/* Program Range for the given decode window */
	gpmr_write32(GPMR_OFFSET(gpmr_num), (limit & DMI_PCR_GPMR_LIMIT_MASK) |
		((base >> DMI_PCR_GPMR_BASE_SHIFT) & DMI_PCR_GPMR_BASE_MASK));

	/* Program source decode enable bit and the Destination ID */
	gpmr_write32(GPMR_DID_OFFSET(gpmr_num), dest_id | DMI_PCR_GPMR_EN);

	return CB_SUCCESS;
}
