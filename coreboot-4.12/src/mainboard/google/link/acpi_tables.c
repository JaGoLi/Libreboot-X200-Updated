/* SPDX-License-Identifier: GPL-2.0-only */

#include <stdint.h>
#include <southbridge/intel/bd82x6x/nvs.h>
#include <ec/google/chromeec/ec.h>
#include <vendorcode/google/chromeos/gnvs.h>
#include "thermal.h"

void acpi_create_gnvs(global_nvs_t *gnvs)
{
	/* Disable USB ports in S3 by default */
	gnvs->s3u0 = 0;
	gnvs->s3u1 = 0;

	/* Disable USB ports in S5 by default */
	gnvs->s5u0 = 0;
	gnvs->s5u1 = 0;

#if CONFIG(CHROMEOS)
	gnvs->chromeos.vbt2 = google_ec_running_ro() ?
		ACTIVE_ECFW_RO : ACTIVE_ECFW_RW;
#endif

	gnvs->tmps = CTDP_SENSOR_ID;

	gnvs->f1of = CTDP_NOMINAL_THRESHOLD_OFF;
	gnvs->f1on = CTDP_NOMINAL_THRESHOLD_ON;

	gnvs->f0of = CTDP_DOWN_THRESHOLD_OFF;
	gnvs->f0on = CTDP_DOWN_THRESHOLD_ON;

	gnvs->tcrt = CRITICAL_TEMPERATURE;
	gnvs->tpsv = PASSIVE_TEMPERATURE;
	gnvs->tmax = MAX_TEMPERATURE;
	gnvs->flvl = 1;

	// the lid is open by default.
	gnvs->lids = 1;
}
