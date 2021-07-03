/* SPDX-License-Identifier: GPL-2.0-only */

#include <variant/gpio.h>

static const struct pad_config gpio_table[] = {
	/* SPI */
	PAD_CFG_NF(GPIO_97, NATIVE, DEEP, NF1),
	PAD_CFG_NF(GPIO_98, NATIVE, DEEP, NF1),
	PAD_CFG_NF(GPIO_99, NATIVE, DEEP, NF1),
	PAD_CFG_NF(GPIO_100, NATIVE, DEEP, NF1),
	PAD_CFG_NF(GPIO_101, NATIVE, DEEP, NF1),
	PAD_CFG_NF(GPIO_102, NATIVE, DEEP, NF1),
	PAD_CFG_NF(GPIO_103, NATIVE, DEEP, NF1),
	PAD_CFG_NF(FST_SPI_CLK_FB, NATIVE, DEEP, NF1),

	/* SMBUS */
	PAD_CFG_NF_IOSTANDBY_IGNORE(SMB_ALERTB, NONE, DEEP, NF1),
	PAD_CFG_NF_IOSTANDBY_IGNORE(SMB_CLK, UP_20K, DEEP, NF1),
	PAD_CFG_NF_IOSTANDBY_IGNORE(SMB_DATA, UP_20K, DEEP, NF1),

	/* LPC */
	PAD_CFG_NF_IOSTANDBY_IGNORE(LPC_ILB_SERIRQ, UP_20K, DEEP, NF1),
	PAD_CFG_NF_IOSSTATE_IOSTERM(LPC_CLKOUT0, NONE, DEEP, NF1, HIZCRx1, DISPUPD),
	PAD_CFG_NF_IOSSTATE_IOSTERM(LPC_CLKOUT1, NONE, DEEP, NF1, HIZCRx1, DISPUPD),
	PAD_CFG_NF_IOSSTATE_IOSTERM(LPC_AD0, UP_20K, DEEP, NF1, HIZCRx1, DISPUPD),
	PAD_CFG_NF_IOSSTATE_IOSTERM(LPC_AD1, UP_20K, DEEP, NF1, HIZCRx1, DISPUPD),
	PAD_CFG_NF_IOSSTATE_IOSTERM(LPC_AD2, UP_20K, DEEP, NF1, HIZCRx1, DISPUPD),
	PAD_CFG_NF_IOSSTATE_IOSTERM(LPC_AD3, UP_20K, DEEP, NF1, HIZCRx1, DISPUPD),
	PAD_CFG_NF_IOSSTATE_IOSTERM(LPC_CLKRUNB, UP_20K, DEEP, NF1, HIZCRx1, DISPUPD),
	PAD_CFG_NF_IOSSTATE_IOSTERM(LPC_FRAMEB, UP_20K, DEEP, NF1, HIZCRx1, DISPUPD),
};

void variant_early_gpio_configure(void)
{
	gpio_configure_pads(gpio_table, ARRAY_SIZE(gpio_table));
}