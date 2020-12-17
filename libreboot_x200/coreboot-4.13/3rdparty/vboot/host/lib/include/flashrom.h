/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Host utilites to execute flashrom command.
 */

#include <stdint.h>

#include "2return_codes.h"

#define FLASHROM_PROGRAMMER_INTERNAL_AP "host"
#define FLASHROM_PROGRAMMER_INTERNAL_EC "ec"

/**
 * Read using flashrom into an allocated buffer.
 *
 * @param programmer	The name of the programmer to use.  There are
 *			named constants FLASHROM_PROGRAMMER_INTERNAL_AP
 *			and FLASHROM_PROGRAMMER_INTERNAL_EC available
 *			for the AP and EC respectively, or a custom
 *			programmer string can be provided.
 * @param region	The name of the fmap region to read, or NULL to
 *			read the entire flash chip.
 * @param data_out	Output parameter of allocated buffer to read into.
 *			The caller should free the buffer.
 * @param size_out	Output parameter of buffer size.
 *
 * @return VB2_SUCCESS on success, or a relevant error.
 */
vb2_error_t flashrom_read(const char *programmer, const char *region,
			  uint8_t **data_out, uint32_t *size_out);

/**
 * Write using flashrom from a buffer.
 *
 * @param programmer	The name of the programmer to use.  There are
 *			named constants FLASHROM_PROGRAMMER_INTERNAL_AP
 *			and FLASHROM_PROGRAMMER_INTERNAL_EC available
 *			for the AP and EC respectively, or a custom
 *			programmer string can be provided.
 * @param region	The name of the fmap region to write, or NULL to
 *			write the entire flash chip.
 * @param data		The buffer to write.
 * @param size		The size of the buffer to write.
 *
 * @return VB2_SUCCESS on success, or a relevant error.
 */
vb2_error_t flashrom_write(const char *programmer, const char *region,
			   uint8_t *data, uint32_t size);
