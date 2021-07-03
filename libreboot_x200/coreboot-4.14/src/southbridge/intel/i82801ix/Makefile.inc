## SPDX-License-Identifier: GPL-2.0-only

ifeq ($(CONFIG_SOUTHBRIDGE_INTEL_I82801IX),y)

bootblock-y += bootblock.c
bootblock-y += early_init.c

romstage-y += dmi_setup.c
romstage-y += early_init.c

ramstage-y += azalia.c
ramstage-y += fadt.c
ramstage-y += i82801ix.c
ramstage-y += lpc.c
ramstage-y += pci.c
ramstage-y += pcie.c
ramstage-y += sata.c
ramstage-y += smbus.c
ramstage-y += thermal.c
ramstage-y += usb_ehci.c
ramstage-y += ../common/pciehp.c

ramstage-srcs += src/mainboard/$(MAINBOARDDIR)/hda_verb.c

smm-y += smihandler.c

ifneq ($(CONFIG_BOARD_EMULATION_QEMU_X86_Q35),y)
ramstage-y += madt.c
endif

ifeq ($(CONFIG_SMM_ASEG),y)
ramstage-$(CONFIG_HAVE_SMI_HANDLER) += smi.c
ramstage-$(CONFIG_HAVE_SMI_HANDLER) += ../../../cpu/x86/smm/smmrelocate.S
endif

CPPFLAGS_common += -I$(src)/southbridge/intel/i82801ix/include

endif