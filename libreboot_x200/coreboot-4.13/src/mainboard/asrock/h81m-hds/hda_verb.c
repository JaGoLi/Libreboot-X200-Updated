/* SPDX-License-Identifier: GPL-2.0-or-later */

#include <stdint.h>
#include <device/azalia_device.h>

const u32 cim_verb_data[] = {
	0x10ec0662,	/* Realtek ALC662 rev1 */
	0x18497662,	/* Subsystem ID */
	11,		/* Number of entries */
	AZALIA_SUBVENDOR(1, 0x18497662),
	AZALIA_PIN_CFG(1, 0x14, 0x01014010),
	AZALIA_PIN_CFG(1, 0x15, 0x40000000),
	AZALIA_PIN_CFG(1, 0x16, 0x411111f0),
	AZALIA_PIN_CFG(1, 0x18, 0x01a19040),
	AZALIA_PIN_CFG(1, 0x19, 0x02a19050),
	AZALIA_PIN_CFG(1, 0x1a, 0x0181304f),
	AZALIA_PIN_CFG(1, 0x1b, 0x02214020),
	AZALIA_PIN_CFG(1, 0x1c, 0x411111f0),
	AZALIA_PIN_CFG(1, 0x1d, 0x40a4c601),
	AZALIA_PIN_CFG(1, 0x1e, 0x411111f0),
};

const u32 pc_beep_verbs[] = {};

AZALIA_ARRAY_SIZES;
