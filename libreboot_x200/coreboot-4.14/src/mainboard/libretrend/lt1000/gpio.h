/* SPDX-License-Identifier: GPL-2.0-or-later */

#ifndef LT1000_GPIO_H
#define LT1000_GPIO_H

#include <soc/gpe.h>
#include <soc/gpio.h>

#ifndef __ACPI__

/* Pad configuration in ramstage. */
static const struct pad_config gpio_table[] = {
/* RCIN# */		PAD_CFG_NF(GPP_A0, NONE, DEEP, NF1),
/* LAD0 */		PAD_CFG_NF(GPP_A1, NONE, DEEP, NF1),
/* LAD1 */		PAD_CFG_NF(GPP_A2, NONE, DEEP, NF1),
/* LAD2 */		PAD_CFG_NF(GPP_A3, NONE, DEEP, NF1),
/* LAD3 */		PAD_CFG_NF(GPP_A4, NONE, DEEP, NF1),
/* LFRAME# */		PAD_CFG_NF(GPP_A5, NONE, DEEP, NF1),
/* SERIRQ */		PAD_CFG_NF(GPP_A6, NONE, DEEP, NF1),
/* PIRQA# */		PAD_NC(GPP_A7, NONE),
/* CLKRUN# */		PAD_CFG_NF(GPP_A8, NONE, DEEP, NF1),
/* CLKOUT_LPC0 */	PAD_CFG_NF(GPP_A9, NONE, DEEP, NF1),
/* CLKOUT_LPC1 */	PAD_CFG_NF(GPP_A10, NONE, DEEP, NF1),
/* PME# */		PAD_NC(GPP_A11, NONE),
/* BM_BUSY# */		PAD_NC(GPP_A12, NONE),
/* SUSWARN# */		PAD_CFG_NF(GPP_A13, NONE, DEEP, NF1),
/* SUS_STAT# */		PAD_CFG_NF(GPP_A14, NONE, DEEP, NF1),
/* SUSACK# */		PAD_CFG_NF(GPP_A15, DN_20K, DEEP, NF1),
/* SD_1P8_SEL */	PAD_NC(GPP_A16, NONE),
/* SD_PWR_EN# */	PAD_CFG_NF(GPP_A17, NONE, DEEP, NF1),
/* ISH_GP0 */		PAD_CFG_GPI(GPP_A18, NONE, DEEP),
/* ISH_GP1 */		PAD_CFG_GPI(GPP_A19, NONE, DEEP),
/* ISH_GP2 */		PAD_CFG_GPI(GPP_A20, NONE, DEEP),
/* ISH_GP3 */		PAD_NC(GPP_A21, NONE),
/* ISH_GP4 */		PAD_NC(GPP_A22, NONE),
/* ISH_GP5 */		PAD_NC(GPP_A23, NONE),

/* CORE_VID0 */		PAD_NC(GPP_B0, NONE),
/* CORE_VID1 */		PAD_NC(GPP_B1, NONE),
/* VRALERT# */		PAD_NC(GPP_B2, NONE),
/* CPU_GP2 */		PAD_NC(GPP_B3, NONE),
/* CPU_GP3 */		PAD_NC(GPP_B4, NONE),
/* SRCCLKREQ0# */	PAD_CFG_NF(GPP_B5, NONE, DEEP, NF1),
/* SRCCLKREQ1# */	PAD_CFG_NF(GPP_B6, NONE, DEEP, NF1),
/* SRCCLKREQ2# */	PAD_CFG_NF(GPP_B7, NONE, DEEP, NF1),
/* SRCCLKREQ3# */	PAD_CFG_NF(GPP_B8, NONE, DEEP, NF1),
/* SRCCLKREQ4# */	PAD_CFG_NF(GPP_B9, NONE, DEEP, NF1),
/* SRCCLKREQ5# */	PAD_CFG_NF(GPP_B10, NONE, DEEP, NF1),
/* EXT_PWR_GATE# */	PAD_NC(GPP_B11, NONE),
/* SLP_S0# */		PAD_CFG_NF(GPP_B12, NONE, DEEP, NF1),
/* PLTRST# */		PAD_CFG_NF(GPP_B13, NONE, DEEP, NF1),
/* SPKR */		PAD_CFG_NF(GPP_B14, NONE, DEEP, NF1),
/* GSPI0_CS# */		PAD_NC(GPP_B15, NONE),
/* GSPI0_CLK */		PAD_NC(GPP_B16, NONE),
/* GSPI0_MISO */	PAD_NC(GPP_B17, NONE),
/* GSPI0_MOSI */	PAD_CFG_GPI_SCI(GPP_B18, UP_20K, PLTRST, LEVEL, INVERT),
/* GSPI1_CS# */		PAD_NC(GPP_B19, NONE),
/* GSPI1_CLK */		PAD_NC(GPP_B20, NONE),
/* GSPI1_MISO */	PAD_NC(GPP_B21, NONE),
/* GSPI1_MOSI */	PAD_CFG_NF(GPP_B22, DN_20K, DEEP, NF1),
/* SM1ALERT# */		PAD_CFG_TERM_GPO(GPP_B23, 1, DN_20K, DEEP),

/* SMBCLK */		PAD_CFG_NF(GPP_C0, NONE, DEEP, NF1),
/* SMBDATA */		PAD_CFG_NF(GPP_C1, DN_20K, DEEP, NF1),
/* SMBALERT# */		PAD_CFG_TERM_GPO(GPP_C2, 1, DN_20K, DEEP),
/* SML0CLK */		PAD_CFG_NF(GPP_C3, NONE, DEEP, NF1),
/* SML0DATA */		PAD_CFG_NF(GPP_C4, NONE, DEEP, NF1),
/* SML0ALERT# */	PAD_CFG_GPI_APIC_LOW(GPP_C5, DN_20K, DEEP),
/* SML1CLK */		PAD_NC(GPP_C6, NONE), /* RESERVED */
/* SML1DATA */		PAD_NC(GPP_C7, NONE), /* RESERVED */
/* UART0_RXD */		PAD_CFG_NF(GPP_C8, NONE, DEEP, NF1),
/* UART0_TXD */		PAD_CFG_NF(GPP_C9, NONE, DEEP, NF1),
/* UART0_RTS# */	PAD_CFG_NF(GPP_C10, NONE, DEEP, NF1),
/* UART0_CTS# */	PAD_CFG_NF(GPP_C11, NONE, DEEP, NF1),
/* UART1_RXD */		PAD_NC(GPP_C12, NONE),
/* UART1_TXD */		PAD_NC(GPP_C13, NONE),
/* UART1_RTS# */	PAD_NC(GPP_C14, NONE),
/* UART1_CTS# */	PAD_NC(GPP_C15, NONE),
/* I2C0_SDA */		PAD_CFG_GPI(GPP_C16, NONE, DEEP),
/* I2C0_SCL */		PAD_CFG_GPI(GPP_C17, NONE, DEEP),
/* I2C1_SDA */		PAD_CFG_GPI(GPP_C18, NONE, DEEP),
/* I2C1_SCL */		PAD_NC(GPP_C19, NONE),
/* UART2_RXD */		PAD_NC(GPP_C20, NONE),
/* UART2_TXD */		PAD_NC(GPP_C21, NONE),
/* UART2_RTS# */	PAD_NC(GPP_C22, NONE),
/* UART2_CTS# */	PAD_NC(GPP_C23, NONE),

/* SPI1_CS# */		PAD_NC(GPP_D0, NONE),
/* SPI1_CLK */		PAD_NC(GPP_D1, NONE),
/* SPI1_MISO */		PAD_NC(GPP_D2, NONE),
/* SPI1_MOSI */		PAD_NC(GPP_D3, NONE),
/* FASHTRIG */		PAD_NC(GPP_D4, NONE),
/* ISH_I2C0_SDA */	PAD_NC(GPP_D5, NONE),
/* ISH_I2C0_SCL */	PAD_NC(GPP_D6, NONE),
/* ISH_I2C1_SDA */	PAD_NC(GPP_D7, NONE),
/* ISH_I2C1_SCL */	PAD_NC(GPP_D8, NONE),
/* ISH_SPI_CS# */	PAD_CFG_TERM_GPO(GPP_D9, 0, NONE, DEEP),
/* ISH_SPI_CLK */	PAD_CFG_GPI(GPP_D10, NONE, DEEP),
/* ISH_SPI_MISO */	PAD_CFG_TERM_GPO(GPP_D11, 1, NONE, DEEP),
/* ISH_SPI_MOSI */	PAD_NC(GPP_D12, NONE),
/* ISH_UART0_RXD */	PAD_NC(GPP_D13, NONE),
/* ISH_UART0_TXD */	PAD_NC(GPP_D14, NONE),
/* ISH_UART0_RTS# */	PAD_NC(GPP_D15, NONE),
/* ISH_UART0_CTS# */	PAD_NC(GPP_D16, NONE),
/* DMIC_CLK1 */		PAD_CFG_NF(GPP_D17, NONE, DEEP, NF1),
/* DMIC_DATA1 */	PAD_CFG_NF(GPP_D18, NONE, DEEP, NF1),
/* DMIC_CLK0 */		PAD_CFG_NF(GPP_D19, NONE, DEEP, NF1),
/* DMIC_DATA0 */	PAD_CFG_NF(GPP_D20, NONE, DEEP, NF1),
/* SPI1_IO2 */		PAD_NC(GPP_D21, NONE),
/* SPI1_IO3 */		PAD_NC(GPP_D22, NONE),
/* I2S_MCLK */		PAD_NC(GPP_D23, NONE),

/* SATAXPCI0 */		PAD_CFG_NF(GPP_E0, UP_20K, DEEP, NF1),
/* SATAXPCIE1 */	PAD_CFG_NF(GPP_E1, UP_20K, DEEP, NF1),
/* SATAXPCIE2 */	PAD_CFG_NF(GPP_E2, UP_20K, DEEP, NF1),
/* CPU_GP0 */		PAD_NC(GPP_E3, NONE),
/* SATA_DEVSLP0 */	PAD_NC(GPP_E4, NONE),
/* SATA_DEVSLP1 */	PAD_NC(GPP_E5, NONE),
/* SATA_DEVSLP2 */	PAD_NC(GPP_E6, NONE),
/* CPU_GP1 */		PAD_NC(GPP_E7, NONE),
/* SATALED# */		PAD_CFG_NF(GPP_E8, NONE, DEEP, NF1),
/* USB2_OCO# */		PAD_CFG_NF(GPP_E9, NONE, DEEP, NF1),
/* USB2_OC1# */		PAD_CFG_NF(GPP_E10, NONE, DEEP, NF1),
/* USB2_OC2# */		PAD_CFG_NF(GPP_E11, NONE, DEEP, NF1),
/* USB2_OC3# */		PAD_NC(GPP_E12, NONE),
/* DDPB_HPD0 */		PAD_CFG_NF(GPP_E13, NONE, DEEP, NF1),
/* DDPC_HPD1 */		PAD_CFG_NF(GPP_E14, NONE, DEEP, NF1),
/* DDPD_HPD2 */		PAD_NC(GPP_E15, NONE),
/* DDPE_HPD3 */		PAD_CFG_GPI_SCI(GPP_E16, NONE, PLTRST, EDGE_SINGLE, NONE),
/* EDP_HPD */		PAD_CFG_NF(GPP_E17, NONE, DEEP, NF1),
/* DDPB_CTRLCLK */	PAD_CFG_NF(GPP_E18, NONE, DEEP, NF1),
/* DDPB_CTRLDATA */	PAD_CFG_NF(GPP_E19, DN_20K, DEEP, NF1),
/* DDPC_CTRLCLK */	PAD_CFG_NF(GPP_E20, NONE, DEEP, NF1),
/* DDPC_CTRLDATA */	PAD_CFG_NF(GPP_E21, DN_20K, DEEP, NF1),
/* DDPD_CTRLCLK */	PAD_CFG_GPI_APIC_HIGH(GPP_E22, NONE, DEEP),
/* DDPD_CTRLDATA */	PAD_CFG_TERM_GPO(GPP_E23, 1, DN_20K, DEEP),

/* I2S2_SCLK */		PAD_NC(GPP_F0, NONE),
/* I2S2_SFRM */		PAD_NC(GPP_F1, NONE),
/* I2S2_TXD */		PAD_NC(GPP_F2, NONE),
/* I2S2_RXD */		PAD_NC(GPP_F3, NONE),
/* I2C2_SDA */		PAD_NC(GPP_F4, NONE),
/* I2C2_SCL */		PAD_NC(GPP_F5, NONE),
/* I2C3_SDA */		PAD_NC(GPP_F6, NONE),
/* I2C3_SCL */		PAD_NC(GPP_F7, NONE),
/* I2C4_SDA */		PAD_CFG_NF_1V8(GPP_F8, NONE, DEEP, NF1),
/* I2C4_SCL */		PAD_CFG_NF_1V8(GPP_F9, NONE, DEEP, NF1),
/* I2C5_SDA */		PAD_NC(GPP_F10, NONE),
/* I2C5_SCL */		PAD_NC(GPP_F11, NONE),
/* EMMC_CMD */		PAD_NC(GPP_F12, NONE),
/* EMMC_DATA0 */	PAD_NC(GPP_F13, NONE),
/* EMMC_DATA1 */	PAD_NC(GPP_F14, NONE),
/* EMMC_DATA2 */	PAD_NC(GPP_F15, NONE),
/* EMMC_DATA3 */	PAD_NC(GPP_F16, NONE),
/* EMMC_DATA4 */	PAD_NC(GPP_F17, NONE),
/* EMMC_DATA5 */	PAD_NC(GPP_F18, NONE),
/* EMMC_DATA6 */	PAD_NC(GPP_F19, NONE),
/* EMMC_DATA7 */	PAD_NC(GPP_F20, NONE),
/* EMMC_RCLK */		PAD_NC(GPP_F21, NONE),
/* EMMC_CLK */		PAD_NC(GPP_F22, NONE),
/* RSVD */		PAD_NC(GPP_F23, NONE),

/* SD_CMD */		PAD_CFG_NF(GPP_G0, NONE, DEEP, NF1),
/* SD_DATA0 */		PAD_CFG_NF(GPP_G1, NONE, DEEP, NF1),
/* SD_DATA1 */		PAD_CFG_NF(GPP_G2, NONE, DEEP, NF1),
/* SD_DATA2 */		PAD_CFG_NF(GPP_G3, NONE, DEEP, NF1),
/* SD_DATA3 */		PAD_CFG_NF(GPP_G4, NONE, DEEP, NF1),
/* SD_CD# */		PAD_CFG_NF(GPP_G5, NONE, DEEP, NF1),
/* SD_CLK */		PAD_CFG_NF(GPP_G6, NONE, DEEP, NF1),
/* SD_WP */		PAD_CFG_NF(GPP_G7, UP_20K, DEEP, NF1),

/* BATLOW# */		PAD_NC(GPD0, NONE),
/* ACPRESENT */		PAD_CFG_NF(GPD1, NONE, PWROK, NF1),
/* LAN_WAKE# */		PAD_NC(GPD2, NONE),
/* PWRBTN# */		PAD_CFG_NF(GPD3, UP_20K, PWROK, NF1),
/* SLP_S3# */		PAD_CFG_NF(GPD4, NONE, PWROK, NF1),
/* SLP_S4# */		PAD_CFG_NF(GPD5, NONE, PWROK, NF1),
/* SLP_A# */		PAD_CFG_NF(GPD6, NONE, PWROK, NF1),
/* RSVD */		PAD_NC(GPD7, NONE),
/* SUSCLK */		PAD_CFG_NF(GPD8, NONE, PWROK, NF1),
/* SLP_WLAN# */		PAD_CFG_NF(GPD9, NONE, PWROK, NF1),
/* SLP_S5# */		PAD_CFG_NF(GPD10, NONE, PWROK, NF1),
/* LANPHYC */		PAD_CFG_NF(GPD11, NONE, DEEP, NF1),
};

#endif

#endif