/* SPDX-License-Identifier: GPL-2.0-only */
/* This file is part of the coreboot project. */

#ifndef _METADATA_HASH_H_
#define _METADATA_HASH_H_

#include <commonlib/bsd/metadata_hash.h>

/* Verify the an FMAP data structure with the FMAP hash that is stored together with the CBFS
   metadata hash in the bootblock's metadata hash anchor (when CBFS verification is enabled). */
vb2_error_t metadata_hash_verify_fmap(const void *fmap_base, size_t fmap_size);

#if CONFIG(CBFS_VERIFICATION)
/* Get the (RO) CBFS metadata hash for this CBFS image, which forms the root of trust for CBFS
   verification. This function is only available in the bootblock. */
struct vb2_hash *metadata_hash_get(void);
#else
static inline struct vb2_hash *metadata_hash_get(void) { return NULL; }
#endif

#endif
