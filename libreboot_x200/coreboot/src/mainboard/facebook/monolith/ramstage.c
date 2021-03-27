/* SPDX-License-Identifier: GPL-2.0-only */

#include <stdint.h>
#include <console/console.h>
#include <drivers/vpd/vpd.h>
#include <smbios.h>
#include <soc/ramstage.h>
#include <uuid.h>

#include "gpio.h"

void mainboard_silicon_init_params(FSP_SIL_UPD *params)
{
	/* Configure pads prior to SiliconInit() in case there's any
	 * dependencies during hardware initialization. */
	gpio_configure_pads(gpio_table, ARRAY_SIZE(gpio_table));
	params->CdClock = 3;
}

#define VPD_KEY_SERIAL			"serial_number"
#define VPD_KEY_UUID			"UUID"
#define VPD_SERIAL_LEN			17

const char *smbios_system_serial_number(void)
{
	static char serial[VPD_SERIAL_LEN];

	if (vpd_gets(VPD_KEY_SERIAL, serial, VPD_SERIAL_LEN, VPD_RO))
		return serial;

	printk(BIOS_ERR, "serial_number could not be read or invalid.\n");
	return "";
}

void smbios_system_set_uuid(u8 *uuid)
{
	static char vpd_uuid_string[UUID_STRLEN+1];

	if (vpd_gets(VPD_KEY_UUID, vpd_uuid_string, UUID_STRLEN+1, VPD_RO))
		if (!parse_uuid(uuid, vpd_uuid_string))
			return;

	memset(uuid, 0, UUID_LEN);
	printk(BIOS_ERR, "UUID could not be read or invalid.\n");
}
