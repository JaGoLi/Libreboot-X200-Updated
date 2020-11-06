/* SPDX-License-Identifier: GPL-2.0-or-later */

#ifndef X4X_IOMAP_H
#define X4X_IOMAP_H

#define DEFAULT_MCHBAR		0xfed14000	/* 16 KB */
#define DEFAULT_DMIBAR		0xfed18000	/* 4 KB */
#define DEFAULT_EPBAR		0xfed19000	/* 4 KB */
#define DEFAULT_HECIBAR		0xfed10000

#define TPMBASE 0xfed40000
#define TPM32(x) (*((volatile u32 *)(TPMBASE + (x))))

#endif /* X4X_IOMAP_H */
