## SPDX-License-Identifier: GPL-2.0-only

bootblock-y += bootblock.c
bootblock-y += chromeos.c
bootblock-y += boardid.c
bootblock-$(CONFIG_OAK_HAS_TPM2) += tpm_tis.c

verstage-y += chromeos.c
verstage-$(CONFIG_OAK_HAS_TPM2) += tpm_tis.c

romstage-y += chromeos.c
romstage-y += romstage.c sdram_configs.c
romstage-y += boardid.c
romstage-$(CONFIG_OAK_HAS_TPM2) += tpm_tis.c

ramstage-y += mainboard.c
ramstage-y += chromeos.c
ramstage-y += boardid.c
ramstage-$(CONFIG_OAK_HAS_TPM2) += tpm_tis.c
