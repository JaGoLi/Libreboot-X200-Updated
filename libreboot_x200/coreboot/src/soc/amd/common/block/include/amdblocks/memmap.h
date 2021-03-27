/* SPDX-License-Identifier: GPL-2.0-or-later */

#ifndef AMD_BLOCK_MEMMAP_H
#define AMD_BLOCK_MEMMAP_H

#include <stdint.h>
#include <symbols.h>

DECLARE_REGION(early_reserved_dram)

struct memmap_early_dram {
	/* fixed size types, so the layout in CBMEM won't change for 32 vs. 64 bit stages */
	uint32_t base;
	uint32_t size;
};

void memmap_stash_early_dram_usage(void);
const struct memmap_early_dram *memmap_get_early_dram_usage(void);

#endif /* AMD_BLOCK_MEMMAP_H */
