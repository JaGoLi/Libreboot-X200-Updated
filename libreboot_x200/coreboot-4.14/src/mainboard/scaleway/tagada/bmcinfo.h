/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef MAINBOARD_BMCINFO_H
#define MAINBOARD_BMCINFO_H

// Do not place disks in boot order
#define BOOT_OPTION_NIC_ONLY 0
// Boot to disk first (before network)
#define BOOT_OPTION_DISK_FIRST 1
// Boot to disk second (after network)
#define BOOT_OPTION_DISK_SECOND 2
// Boot order mask
#define BOOT_OPTION_ORDER_MASK 3
// Reset after boot sequence (don't go to EFI shell)
#define BOOT_OPTION_NO_EFISHELL 0x80

char *bmcinfo_serial(void);
u8 *bmcinfo_uuid(void);
int bmcinfo_slot(void);
int bmcinfo_hwrev(void);
u32 bmcinfo_baudrate(void);
int bmcinfo_coreboot_verbosity_level(void);
int bmcinfo_fsp_verbosity_level(void);
int bmcinfo_relax_security(void);
int bmcinfo_boot_option(void);
int bmcinfo_disable_nic1(void);

#endif	/* MAINBOARD_BMCINFO_H */
