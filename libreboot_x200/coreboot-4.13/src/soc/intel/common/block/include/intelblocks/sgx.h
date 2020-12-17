/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef SOC_INTEL_COMMON_BLOCK_SGX_H
#define SOC_INTEL_COMMON_BLOCK_SGX_H

#include <soc/nvs.h>

/*
 * Configure core PRMRR.
 * PRMRR needs to configured first on all cores and then
 * call sgx_configure() for all cores to init SGX.
 */
void prmrr_core_configure(void);

/*
 * Configure SGX.
 */
void sgx_configure(void *unused);

/* Fill GNVS data with SGX status, EPC base and length */
void sgx_fill_gnvs(struct global_nvs *gnvs);

#endif	/* SOC_INTEL_COMMON_BLOCK_SGX_H */
