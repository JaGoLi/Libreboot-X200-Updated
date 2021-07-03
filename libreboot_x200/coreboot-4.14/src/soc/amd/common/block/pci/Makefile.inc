ifeq ($(CONFIG_SOC_AMD_COMMON_BLOCK_PCI),y)

ramstage-y += amd_pci_util.c
ramstage-y += pci_routing_info.c
ramstage-$(CONFIG_HAVE_ACPI_TABLES) += acpi_prt.c

endif # CONFIG_SOC_AMD_COMMON_BLOCK_PCI

ifeq ($(CONFIG_SOC_AMD_COMMON_BLOCK_PCI_MMCONF),y)

bootblock-y += amd_pci_mmconf.c
verstage_x86-y += amd_pci_mmconf.c
romstage-y += amd_pci_mmconf.c
postcar-y += amd_pci_mmconf.c
ramstage-y += amd_pci_mmconf.c

endif # CONFIG_SOC_AMD_COMMON_BLOCK_PCI_MMCONF