## SPDX-License-Identifier: GPL-2.0-only

ifeq ($(CONFIG_SOUTHBRIDGE_INTEL_I82801JX),y)

bootblock-y += bootblock.c
bootblock-y += early_init.c

romstage-y += early_init.c

ramstage-y += azalia.c
ramstage-y += fadt.c
ramstage-y += i82801jx.c
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

CPPFLAGS_common += -I$(src)/southbridge/intel/i82801jx/include

endif