/* SPDX-License-Identifier: GPL-2.0-or-later */

/*
 * Datasheet:
 *  - Name: F81866D/A-I, Release Date: Jan 2012, Version: V0.12P
 *  - Link: http://www.alldatasheet.com/datasheet-pdf/pdf/459085/FINTEK/F81866AD-I.html
 */

#ifndef SUPERIO_FINTEK_F81866_H
#define SUPERIO_FINTEK_F81866_H

/* Logical Device Numbers (LDN) */
#define F81866D_FDC	0x00	/* Floppy */
#define F81866D_SP1	0x10	/* UART1 */
#define F81866D_SP2	0x11	/* UART2 */
#define F81866D_SP3	0x12	/* UART3 */
#define F81866D_SP4	0x13	/* UART4 */
#define F81866D_SP5	0x14	/* UART3 */
#define F81866D_SP6	0x15	/* UART4 */
#define F81866D_PP	0x03	/* Parallel Port */
#define F81866D_HWM	0x04	/* Hardware Monitor */
#define F81866D_KBC	0x05	/* Keyboard/Mouse */
#define F81866D_GPIO	0x06	/* General Purpose I/O (GPIO) */
#define F81866D_WDT	0x07	/* Watchdog */
#define F81866D_PME	0x0a	/* Power Management Events (PME) */

#endif /* SUPERIO_FINTEK_F81866_H */
