/* SPDX-License-Identifier: GPL-2.0-only */

#include <stdint.h>
#include <device/pci_ops.h>
#include <device/smbus_host.h>
#include <northbridge/intel/ironlake/ironlake.h>
#include <southbridge/intel/ibexpeak/pch.h>
#include <southbridge/intel/common/gpio.h>

static void early_gpio_init(void)
{
	pci_write_config32(PCH_LPC_DEV, GPIO_BASE, DEFAULT_GPIOBASE | 1);
	pci_write_config8(PCH_LPC_DEV, GPIO_CNTL, 0x10);

	setup_pch_gpios(&mainboard_gpio_map);
}

static void pch_default_disable(void)
{
	/* Must set BIT0 (hides performance counters PCI device).
	   coreboot enables the Rate Matching Hub which makes the UHCI PCI
	   devices disappear, so BIT5-12 and BIT28 can be set to hide those. */
	RCBA32(FD) = (1 << 28) | (0xff << 5) | 1;

	/* Set reserved bit to 1 */
	RCBA32(FD2) = 1;
}

void early_pch_init(void)
{
	early_gpio_init();
	enable_smbus();
	/* TODO, make this configurable */
	pch_setup_cir(IRONLAKE_MOBILE);
	southbridge_configure_default_intmap();
	pch_default_disable();
	early_usb_init(mainboard_usb_ports);
}
