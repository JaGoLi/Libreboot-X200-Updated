/* SPDX-License-Identifier: GPL-2.0-only */

/*
 * This file is created based on Intel Alder Lake Processor PCH Datasheet
 * Document number: 621483
 * Chapter number: 2
 */

#include <device/pci.h>
#include <pc80/isa-dma.h>
#include <pc80/i8259.h>
#include <arch/ioapic.h>
#include <intelblocks/itss.h>
#include <intelblocks/lpc_lib.h>
#include <intelblocks/pcr.h>
#include <soc/espi.h>
#include <soc/iomap.h>
#include <soc/irq.h>
#include <soc/pci_devs.h>
#include <soc/pcr_ids.h>
#include <soc/soc_chip.h>

void soc_get_gen_io_dec_range(uint32_t *gen_io_dec)
{
	const config_t *config = config_of_soc();

	gen_io_dec[0] = config->gen1_dec;
	gen_io_dec[1] = config->gen2_dec;
	gen_io_dec[2] = config->gen3_dec;
	gen_io_dec[3] = config->gen4_dec;
}

#if ENV_RAMSTAGE
void lpc_soc_init(struct device *dev)
{
	/* Legacy initialization */
	isa_dma_init();
	pch_misc_init();

	/* Enable CLKRUN_EN for power gating ESPI */
	lpc_enable_pci_clk_cntl();

	/* Set ESPI Serial IRQ mode */
	if (CONFIG(SERIRQ_CONTINUOUS_MODE))
		lpc_set_serirq_mode(SERIRQ_CONTINUOUS);
	else
		lpc_set_serirq_mode(SERIRQ_QUIET);

	/* Interrupt configuration */
	pch_enable_ioapic();
	pch_pirq_init();
	setup_i8259();
	i8259_configure_irq_trigger(9, 1);
}
#endif
