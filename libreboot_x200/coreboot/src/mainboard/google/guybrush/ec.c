/* SPDX-License-Identifier: GPL-2.0-or-later */

#include <acpi/acpi.h>
#include <amdblocks/gpio_banks.h>
#include <amdblocks/smi.h>
#include <ec/google/chromeec/ec.h>
#include <soc/smi.h>
#include <variant/ec.h>

static const struct sci_source espi_sci_sources[] = {
	{
		.scimap = SMITYPE_ESPI_SYS,
		.gpe = GEVENT_24,
		.direction = SMI_SCI_LVL,
		.level = SMI_SCI_LVL_HIGH
	}
};

void mainboard_ec_init(void)
{
	const struct google_chromeec_event_info info = {
		.log_events = MAINBOARD_EC_LOG_EVENTS,
		.sci_events = MAINBOARD_EC_SCI_EVENTS,
		.s3_wake_events = MAINBOARD_EC_S3_WAKE_EVENTS,
		.s5_wake_events = MAINBOARD_EC_S5_WAKE_EVENTS,
		.s0ix_wake_events = MAINBOARD_EC_S0IX_WAKE_EVENTS,
	};

	google_chromeec_events_init(&info, acpi_is_wakeup_s3());

	/* Configure eSPI VW SCI events */
	gpe_configure_sci(espi_sci_sources, ARRAY_SIZE(espi_sci_sources));
}
