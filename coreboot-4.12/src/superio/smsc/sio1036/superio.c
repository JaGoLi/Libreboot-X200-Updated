/* SPDX-License-Identifier: GPL-2.0-only */

/* RAM driver for the SMSC SIO1036 Super I/O chip */

#include <device/device.h>
#include <device/pnp.h>
#include <superio/conf_mode.h>

#include "sio1036.h"

static void sio1036_init(struct device *dev)
{
	if (!dev->enabled)
		return;
}

static struct device_operations ops = {
	.read_resources   = pnp_read_resources,
	.set_resources    = pnp_set_resources,
	.enable_resources = pnp_enable_resources,
	.enable           = pnp_alt_enable,
	.init             = sio1036_init,
	.ops_pnp_mode     = &pnp_conf_mode_55_aa,
};

static struct pnp_info pnp_dev_info[] = {
	{ NULL, SIO1036_SP1,  PNP_IO0 | PNP_IRQ0, 0x07f8, },
};

static void enable_dev(struct device *dev)
{
	pnp_enable_devices(dev, &ops, ARRAY_SIZE(pnp_dev_info), pnp_dev_info);
}

struct chip_operations superio_smsc_sio1036_ops = {
	CHIP_NAME("SMSC SIO1036 Super I/O")
	.enable_dev = enable_dev
};
