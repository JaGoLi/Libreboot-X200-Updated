/* SPDX-License-Identifier: GPL-2.0-only */

#include <ec/google/chromeec/ec.h>
#include <soc/pm.h>
#include <smbios.h>
#include <soc/romstage.h>
#include <variant/onboard.h>
#include <mainboard/google/auron/variant.h>

int variant_smbios_data(struct device *dev, int *handle, unsigned long *current)
{
	int len = 0;

	len += smbios_write_type41(
		current, handle,
		BOARD_TRACKPAD_NAME,		/* name */
		BOARD_TRACKPAD_IRQ,		/* instance */
		BOARD_TRACKPAD_I2C_BUS,		/* segment */
		BOARD_TRACKPAD_I2C_ADDR,	/* bus */
		0,				/* device */
		0,				/* function */
		SMBIOS_DEVICE_TYPE_OTHER);	/* device type */

	return len;
}

void variant_romstage_entry(struct romstage_params *rp)
{
	if (rp->power_state->prev_sleep_state != ACPI_S3)
		google_chromeec_kbbacklight(75);
}
