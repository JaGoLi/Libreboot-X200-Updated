/* SPDX-License-Identifier: GPL-2.0-only */

#include <baseboard/variants.h>
#include <variant/sku.h>
#include <sar.h>
#include <ec/google/chromeec/ec.h>

const char *get_wifi_sar_cbfs_filename(void)
{
	const char *filename = NULL;
	uint32_t sku_id = google_chromeec_get_board_sku();

	switch (sku_id) {
	case SKU_21_DRAGONAIR:
	case SKU_22_DRAGONAIR:
	case SKU_23_DRAGONAIR:
	case SKU_24_DRAGONAIR:
		filename = "wifi_sar-dragonair.hex";
		break;
	}
	return filename;
}
