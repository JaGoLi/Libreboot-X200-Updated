/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef __DIMMSPD_H__
#define __DIMMSPD_H__

#include <amdblocks/agesawrapper.h>
#include <stddef.h>
#include <stdint.h>

/*
 * Fill the buf and returns 0 on success.
 * Return -1 on failure and the caller tries sb_read_spd()
 * to get the SPD from I2C.
 */
int mainboard_read_spd(uint8_t spdAddress, char *buf, size_t len);
int sb_read_spd(uint8_t spdAddress, char *buf, size_t len);

#endif
