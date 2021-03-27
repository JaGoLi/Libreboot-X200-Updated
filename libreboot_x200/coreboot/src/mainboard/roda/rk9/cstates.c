/* SPDX-License-Identifier: GPL-2.0-only */

#include <acpi/acpigen.h>

static acpi_cstate_t cst_entries[] = {
	{
		/* ACPI C1 / CPU C1 */
		1, 0x01, 1000,
		{ ACPI_ADDRESS_SPACE_FIXED, 1, 2, 1, 0, 0 }
	},
	{
		/* ACPI C2 / CPU C2 */
		2, 0x01,  500,
		{ ACPI_ADDRESS_SPACE_FIXED, 1, 2, 1, 0x10, 0 }
	},
};

int get_cst_entries(acpi_cstate_t **entries)
{
	*entries = cst_entries;
	return ARRAY_SIZE(cst_entries);
}
