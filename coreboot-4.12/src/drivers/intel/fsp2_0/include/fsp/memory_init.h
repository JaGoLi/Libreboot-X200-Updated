/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef _FSP2_0_MEMORY_INIT_H_
#define _FSP2_0_MEMORY_INIT_H_

#include <types.h>

/*
 * Updates mrc cache hash if it differs.
 */
void mrc_cache_update_hash(const uint8_t *data, size_t size);

/*
 * Verifies mrc cache hash which is stored somewhere.
 * return 1 verification was successful and 0 for error.
 */
int mrc_cache_verify_hash(const uint8_t *data, size_t size);

#endif /* _FSP2_0_MEMORY_INIT_H_ */
