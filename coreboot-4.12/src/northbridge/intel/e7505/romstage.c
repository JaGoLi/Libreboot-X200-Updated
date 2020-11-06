/* SPDX-License-Identifier: GPL-2.0-only */

#include <cbmem.h>
#include <arch/romstage.h>

#include <southbridge/intel/i82801dx/i82801dx.h>
#include <northbridge/intel/e7505/raminit.h>

void mainboard_romstage_entry(void)
{
	/* Perform some early chipset initialization required
	 * before RAM initialization can work
	 */
	i82801dx_early_init();

	sdram_initialize();

	cbmem_recovery(0);
}
