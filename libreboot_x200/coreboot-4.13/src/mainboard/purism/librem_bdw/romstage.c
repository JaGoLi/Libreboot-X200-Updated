/* SPDX-License-Identifier: GPL-2.0-only */

#include <soc/pei_data.h>
#include <soc/pei_wrapper.h>
#include <soc/romstage.h>

void mainboard_pre_raminit(struct romstage_params *rp)
{
	/* Fill out PEI DATA */
	mainboard_fill_pei_data(&rp->pei_data);
}

void mainboard_post_raminit(struct romstage_params *rp)
{
}
