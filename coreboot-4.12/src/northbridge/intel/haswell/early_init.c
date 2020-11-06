/* SPDX-License-Identifier: GPL-2.0-only */

#include <stdint.h>
#include <console/console.h>
#include <device/mmio.h>
#include <device/pci_def.h>
#include <device/pci_ops.h>

#include "haswell.h"

static bool peg_hidden[3];

static void haswell_setup_bars(void)
{
	printk(BIOS_DEBUG, "Setting up static northbridge registers...");
	/* Set up all hardcoded northbridge BARs */
	pci_write_config32(HOST_BRIDGE, EPBAR,  DEFAULT_EPBAR  | 1);
	pci_write_config32(HOST_BRIDGE, EPBAR  + 4, (0LL + DEFAULT_EPBAR)  >> 32);
	pci_write_config32(HOST_BRIDGE, MCHBAR, DEFAULT_MCHBAR | 1);
	pci_write_config32(HOST_BRIDGE, MCHBAR + 4, (0LL + DEFAULT_MCHBAR) >> 32);
	pci_write_config32(HOST_BRIDGE, DMIBAR, DEFAULT_DMIBAR | 1);
	pci_write_config32(HOST_BRIDGE, DMIBAR + 4, (0LL + DEFAULT_DMIBAR) >> 32);

	/* Set C0000-FFFFF to access RAM on both reads and writes */
	pci_write_config8(HOST_BRIDGE, PAM0, 0x30);
	pci_write_config8(HOST_BRIDGE, PAM1, 0x33);
	pci_write_config8(HOST_BRIDGE, PAM2, 0x33);
	pci_write_config8(HOST_BRIDGE, PAM3, 0x33);
	pci_write_config8(HOST_BRIDGE, PAM4, 0x33);
	pci_write_config8(HOST_BRIDGE, PAM5, 0x33);
	pci_write_config8(HOST_BRIDGE, PAM6, 0x33);

	printk(BIOS_DEBUG, " done.\n");
}

static void haswell_setup_igd(void)
{
	bool igd_enabled;
	u16 ggc;
	u8 reg8;

	printk(BIOS_DEBUG, "Initializing IGD...\n");

	igd_enabled = !!(pci_read_config32(HOST_BRIDGE, DEVEN) & DEVEN_D2EN);

	ggc = pci_read_config16(HOST_BRIDGE, GGC);
	ggc &= ~0x3f8;
	if (igd_enabled) {
		ggc |= GGC_GTT_2MB | GGC_IGD_MEM_IN_32MB_UNITS(1);
		ggc &= ~GGC_DISABLE_VGA_IO_DECODE;
	} else {
		ggc |= GGC_GTT_0MB | GGC_IGD_MEM_IN_32MB_UNITS(0) | GGC_DISABLE_VGA_IO_DECODE;
	}
	pci_write_config16(HOST_BRIDGE, GGC, ggc);

	if (!igd_enabled) {
		printk(BIOS_DEBUG, "IGD is disabled.\n");
		return;
	}

	/* Enable 256MB aperture */
	reg8 = pci_read_config8(PCI_DEV(0, 2, 0), MSAC);
	reg8 &= ~0x06;
	reg8 |= 0x02;
	pci_write_config8(PCI_DEV(0, 2, 0), MSAC, reg8);
}

static void start_peg2_link_training(const pci_devfn_t dev)
{
	u32 mask;

	switch (dev) {
	case PCI_DEV(0, 1, 2):
		mask = DEVEN_D1F2EN;
		break;
	case PCI_DEV(0, 1, 1):
		mask = DEVEN_D1F1EN;
		break;
	case PCI_DEV(0, 1, 0):
		mask = DEVEN_D1F0EN;
		break;
	default:
		printk(BIOS_ERR, "Link training tried on a non-PEG device!\n");
		return;
	}

	pci_update_config32(dev, 0xc24, ~(1 << 16), 1 << 5);
	printk(BIOS_DEBUG, "Started PEG1%d link training.\n", PCI_FUNC(PCI_DEV2DEVFN(dev)));

	/*
	 * Hide the PEG device while the MRC runs. This is because the MRC makes
	 * configurations that are not ideal if it sees a VGA device in a PEG slot,
	 * and it locks registers preventing changes to these configurations.
	 */
	pci_update_config32(HOST_BRIDGE, DEVEN, ~mask, 0);
	peg_hidden[PCI_FUNC(PCI_DEV2DEVFN(dev))] = true;
	printk(BIOS_DEBUG, "Temporarily hiding PEG1%d.\n", PCI_FUNC(PCI_DEV2DEVFN(dev)));
}

void haswell_unhide_peg(void)
{
	u32 deven = pci_read_config32(HOST_BRIDGE, DEVEN);

	for (u8 fn = 0; fn <= 2; fn++) {
		if (peg_hidden[fn]) {
			deven |= DEVEN_D1F0EN >> fn;
			peg_hidden[fn] = false;
			printk(BIOS_DEBUG, "Unhiding PEG1%d.\n", fn);
		}
	}

	pci_write_config32(HOST_BRIDGE, DEVEN, deven);
}

static void haswell_setup_peg(void)
{
	u32 deven = pci_read_config32(HOST_BRIDGE, DEVEN);

	if (deven & DEVEN_D1F2EN)
		start_peg2_link_training(PCI_DEV(0, 1, 2));

	if (deven & DEVEN_D1F1EN)
		start_peg2_link_training(PCI_DEV(0, 1, 1));

	if (deven & DEVEN_D1F0EN)
		start_peg2_link_training(PCI_DEV(0, 1, 0));
}

static void haswell_setup_misc(void)
{
	u32 reg32;

	/* Erratum workarounds */
	reg32 = MCHBAR32(SAPMCTL);
	reg32 |= (1 << 9) | (1 << 10);
	MCHBAR32(SAPMCTL) = reg32;

	/* Enable SA Clock Gating */
	reg32 = MCHBAR32(SAPMCTL);
	MCHBAR32(SAPMCTL) = reg32 | 1;

	/* GPU RC6 workaround for sighting 366252 */
	reg32 = MCHBAR32(SSKPD + 4);
	reg32 |= (1UL << 31);
	MCHBAR32(SSKPD + 4) = reg32;

	/* VLW (Virtual Legacy Wire?) */
	reg32 = MCHBAR32(0x6120);
	reg32 &= ~(1 << 0);
	MCHBAR32(0x6120) = reg32;

	reg32 = MCHBAR32(INTRDIRCTL);
	reg32 |= (1 << 4) | (1 << 5);
	MCHBAR32(INTRDIRCTL) = reg32;
}

static void haswell_setup_iommu(void)
{
	const u32 capid0_a = pci_read_config32(HOST_BRIDGE, CAPID0_A);

	if (capid0_a & VTD_DISABLE)
		return;

	/* Setup BARs: zeroize top 32 bits; set enable bit */
	MCHBAR32(GFXVTBAR + 4) = GFXVT_BASE_ADDRESS >> 32;
	MCHBAR32(GFXVTBAR)     = GFXVT_BASE_ADDRESS | 1;
	MCHBAR32(VTVC0BAR + 4) = VTVC0_BASE_ADDRESS >> 32;
	MCHBAR32(VTVC0BAR)     = VTVC0_BASE_ADDRESS | 1;

	/* Set L3HIT2PEND_DIS, lock GFXVTBAR policy config registers */
	u32 reg32;
	reg32 = read32((void *)(GFXVT_BASE_ADDRESS + ARCHDIS));
	write32((void *)(GFXVT_BASE_ADDRESS + ARCHDIS), reg32 | DMAR_LCKDN | L3HIT2PEND_DIS);

	/* Clear SPCAPCTRL */
	reg32 = read32((void *)(VTVC0_BASE_ADDRESS + ARCHDIS)) & ~SPCAPCTRL;

	/* Set GLBIOTLBINV, GLBCTXTINV; lock VTVC0BAR policy config registers */
	write32((void *)(VTVC0_BASE_ADDRESS + ARCHDIS),
			reg32 | DMAR_LCKDN | GLBIOTLBINV | GLBCTXTINV);
}

void haswell_early_initialization(int chipset_type)
{
	/* Setup all BARs required for early PCIe and raminit */
	haswell_setup_bars();

	/* Setup IOMMU BARs */
	haswell_setup_iommu();

	haswell_setup_peg();
	haswell_setup_igd();

	haswell_setup_misc();
}
