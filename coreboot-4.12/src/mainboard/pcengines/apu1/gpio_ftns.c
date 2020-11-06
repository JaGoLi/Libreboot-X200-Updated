/* SPDX-License-Identifier: GPL-2.0-only */

#include <stdint.h>
#include <amdblocks/acpimmio.h>
#include <southbridge/amd/cimx/sb800/SBPLATFORM.h>
#include "gpio_ftns.h"

uintptr_t find_gpio_base(void)
{
	uintptr_t base_addr;
	/* Get the ACPIMMIO base address */
	base_addr = pm_read32(0x24);
	base_addr &= 0xFFFFF000;
	return base_addr;
}

void configure_gpio(uintptr_t base_addr, u8 gpio, u8 iomux_ftn, u8 setting)
{
	u8 bdata;

	iomux_write8(gpio, iomux_ftn);

	bdata = gpio_100_read8(gpio);
	bdata &= 0x07;
	bdata |= setting; /* set direction and data value */
	gpio_100_write8(gpio, bdata);
}

u8 read_gpio(uintptr_t base_addr, u8 gpio)
{
	return (gpio_100_read8(gpio) & GPIO_DATA_IN) ? 1 : 0;
}

int get_spd_offset(void)
{
	uintptr_t base_addr = find_gpio_base();
	u8 spd_offset = read_gpio(base_addr, GPIO_16);
	return spd_offset;
}
