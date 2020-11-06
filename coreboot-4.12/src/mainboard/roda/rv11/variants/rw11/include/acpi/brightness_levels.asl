/* SPDX-License-Identifier: GPL-2.0-only */

#include <drivers/intel/gma/acpi/gma.asl>

Scope (GFX0)
{
	Name (BRIG, Package (13)
	{
		 74, /* default AC */
		 74, /* default Battery */
		  9, /*  439 / 4882 */
		 11, /*  537 / 4882 */
		 14, /*  683 / 4882 */
		 18, /*  878 / 4882 */
		 22, /* 1074 / 4882 */
		 28, /* 1366 / 4882 */
		 36, /* 1757 / 4882 */
		 46, /* 2245 / 4882 */
		 58, /* 2831 / 4882 */
		 74, /* 3612 / 4882 */
		100, /* 4882 / 4882 */
	})
}
