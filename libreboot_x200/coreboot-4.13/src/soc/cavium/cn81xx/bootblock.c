/* SPDX-License-Identifier: GPL-2.0-only */

/*
 * Derived from Cavium's BSD-3 Clause OCTEONTX-SDK-6.2.0.
 */

#include <commonlib/helpers.h>
#include <soc/bootblock.h>
#include <soc/sysreg.h>
#include <soc/timer.h>
#include <libbdk-arch/bdk-asm.h>

static void init_sysreg(void)
{
	/* The defaults for write buffer timeouts are poor */
	u64 cvmmemctl0;
	BDK_MRS(s3_0_c11_c0_4, cvmmemctl0);
	cvmmemctl0 |= AP_CVMMEMCTL0_EL1_WBFTONSHENA |
		AP_CVMMEMCTL0_EL1_WBFTOMRGCLRENA;
	BDK_MSR(s3_0_c11_c0_4, cvmmemctl0);
}

void bootblock_soc_early_init(void)
{
}

void bootblock_soc_init(void)
{
	/* initialize system registers */
	init_sysreg();

	/* Set watchdog to 5 seconds timeout */
	watchdog_set(0, 5000);
	watchdog_poke(0);

	/* TODO: additional clock init? */
}
