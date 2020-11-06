/* SPDX-License-Identifier: GPL-2.0-only */

#include <smbios.h>

/* Set the board version */
const char *smbios_mainboard_version(void)
{
	if (CONFIG(GALILEO_GEN2))
		return "Gen 2";
	return "1.0";
}
