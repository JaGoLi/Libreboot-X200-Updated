/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef _RANDOM_H_
#define _RANDOM_H_

#include <stdint.h>

/*
 * Generates a 32/64 bit random number respectively.
 * return 0 on success and -1 on error.
 */
int get_random_number_32(uint32_t *rand);
int get_random_number_64(uint64_t *rand);

#endif /* _RANDOM_H_ */
