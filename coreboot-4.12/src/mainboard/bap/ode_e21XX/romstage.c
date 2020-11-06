/* SPDX-License-Identifier: GPL-2.0-only */

#include <stdint.h>
#include <amdblocks/acpimmio.h>
#include <device/pci_def.h>
#include <arch/io.h>
#include <arch/cpu.h>
#include <cpu/x86/lapic.h>
#include <console/console.h>
#include <northbridge/amd/agesa/state_machine.h>
#include <southbridge/amd/pi/hudson/hudson.h>
#include <superio/fintek/common/fintek.h>
#include <superio/fintek/f81866d/f81866d.h>

#define SERIAL_DEV1 PNP_DEV(0x4e, F81866D_SP1)

static void romstage_main_template(void)
{
	u32 val;

	/*
	 *  In Hudson RRG, PMIOxD2[5:4] is "Drive strength control for
	 *  LpcClk[1:0]".  This following register setting has been
	 *  replicated in every reference design since Parmer, so it is
	 *  believed to be required even though it is not documented in
	 *  the SoC BKDGs.  Without this setting, there is no serial
	 *  output.
	 */
	pm_io_write8(0xd2, 0);

	if (!cpu_init_detectedx && boot_cpu()) {
		post_code(0x30);
		fintek_enable_serial(SERIAL_DEV1, CONFIG_TTYS0_BASE);
		post_code(0x31);
		console_init();
	}
}

void agesa_postcar(struct sysinfo *cb)
{
	/* After AMD_INIT_ENV -> move to ramstage ? */
	pm_io_write8(0xea, 1);
}
