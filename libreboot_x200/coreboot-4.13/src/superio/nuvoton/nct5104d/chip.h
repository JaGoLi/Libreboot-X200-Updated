/* SPDX-License-Identifier: GPL-2.0-or-later */

#ifndef SUPERIO_NUVOTON_NCT5104D_CHIP_H
#define SUPERIO_NUVOTON_NCT5104D_CHIP_H

struct superio_nuvoton_nct5104d_config {
	u8 irq_trigger_type;
	u8 reset_gpios;
};

#endif
