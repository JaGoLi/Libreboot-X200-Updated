/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef _IMPI_CHIP_H_
#define _IPMI_CHIP_H_

struct drivers_ipmi_config {
	u8 bmc_i2c_address;
	u8 have_nv_storage;
	u8 nv_storage_device_address;
	u8 have_gpe;
	u8 gpe_interrupt;
	u8 have_apic;
	u32 apic_interrupt;
	/*
	 * Wait for BMC to boot.
	 * This can be used if the BMC takes a long time to boot after PoR:
	 * AST2400 on Supermicro X11SSH: 34 s
	 */
	bool wait_for_bmc;
	/*
	 * The timeout in seconds to wait for the IPMI service to be loaded.
	 * Will be used if wait_for_bmc is true.
	 */
	u16 bmc_boot_timeout;
	unsigned int uid; /* Auto-filled by ipmi_ssdt() */
};

#endif /* _IMPI_CHIP_H_ */
