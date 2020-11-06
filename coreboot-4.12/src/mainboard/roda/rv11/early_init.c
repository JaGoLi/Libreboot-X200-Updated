/* SPDX-License-Identifier: GPL-2.0-only */

#include <northbridge/intel/sandybridge/sandybridge.h>
#include <southbridge/intel/bd82x6x/pch.h>

int mainboard_should_reset_usb(int s3resume)
{
	return !s3resume;
}
