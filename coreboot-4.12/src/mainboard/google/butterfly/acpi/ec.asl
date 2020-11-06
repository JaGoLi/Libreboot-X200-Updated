/* SPDX-License-Identifier: GPL-2.0-only */

/* mainboard configuration */
#include "../ec.h"

#define EC_SCI  13	// GPIO13 -> Runtime SCI

/* ACPI code for EC functions */
#include <ec/quanta/ene_kb3940q/acpi/ec.asl>
