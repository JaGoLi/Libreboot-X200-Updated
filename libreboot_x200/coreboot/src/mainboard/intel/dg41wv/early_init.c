/* SPDX-License-Identifier: GPL-2.0-or-later */

#include <bootblock_common.h>
#include <device/pnp_ops.h>
#include <northbridge/intel/x4x/x4x.h>
#include <southbridge/intel/i82801gx/i82801gx.h>
#include <superio/winbond/common/winbond.h>
#include <superio/winbond/w83627dhg/w83627dhg.h>

#define SERIAL_DEV PNP_DEV(0x2e, W83627DHG_SP1)

void bootblock_mainboard_early_init(void)
{
	/* Set GPIOs on superio, enable UART */
	pnp_enter_ext_func_mode(SERIAL_DEV);
	pnp_set_logical_device(SERIAL_DEV);

	pnp_write_config(SERIAL_DEV, 0x2c, 0x13);

	pnp_exit_ext_func_mode(SERIAL_DEV);

	winbond_enable_serial(SERIAL_DEV, CONFIG_TTYS0_BASE);

	/* IRQ routing */
	RCBA16(D31IR) = 0x0132;
	RCBA16(D29IR) = 0x0237;
}

void mb_get_spd_map(u8 spd_map[4])
{
	spd_map[0] = 0x50;
	spd_map[2] = 0x52;
}
