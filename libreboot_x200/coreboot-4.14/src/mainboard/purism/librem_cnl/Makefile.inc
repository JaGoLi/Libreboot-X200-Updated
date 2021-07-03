## SPDX-License-Identifier: GPL-2.0-only

romstage-y += variants/$(VARIANT_DIR)/variant.c

ramstage-y += variants/$(VARIANT_DIR)/gpio.c
ramstage-y += variants/$(VARIANT_DIR)/hda_verb.c
ramstage-y += ramstage.c
ramstage-$(CONFIG_MAINBOARD_USE_LIBGFXINIT) += variants/$(VARIANT_DIR)/gma-mainboard.ads

CPPFLAGS_common += -I$(src)/mainboard/$(MAINBOARDDIR)/variants/$(VARIANT_DIR)/include

subdirs-y += variants/$(VARIANT_DIR)/
