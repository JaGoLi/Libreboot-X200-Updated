/* SPDX-License-Identifier: GPL-2.0-only */

#include <device/mmio.h>
#include <assert.h>
#include <spi_flash.h>
#include <soc/addressmap.h>
#include <soc/flash_controller.h>
#include <soc/gpio.h>
#include <soc/spi.h>

struct mtk_spi_bus spi_bus[SPI_BUS_NUMBER] = {
	{
		.regs = (void *)SPI_BASE,
		.cs_gpio = GPIO(MSDC2_CMD),
	}
};

void mtk_spi_set_gpio_pinmux(unsigned int bus,
			     enum spi_pad_mask pad_select)
{
	/* TODO: implement support for other pads when needed */
	assert(pad_select == SPI_PAD1_MASK);
	gpio_set_mode(GPIO(MSDC2_DAT2), PAD_MSDC2_DAT2_FUNC_SPI_CK_1);
	gpio_set_mode(GPIO(MSDC2_DAT3), PAD_MSDC2_DAT3_FUNC_SPI_MI_1);
	gpio_set_mode(GPIO(MSDC2_CLK), PAD_MSDC2_CLK_FUNC_SPI_MO_1);
	gpio_set_mode(GPIO(MSDC2_CMD), 0);
}

void mtk_spi_set_timing(struct mtk_spi_regs *regs, u32 sck_ticks, u32 cs_ticks,
			unsigned int tick_dly)
{
	write32(&regs->spi_cfg0_reg,
		((sck_ticks - 1) << SPI_CFG0_SCK_HIGH_SHIFT) |
		((sck_ticks - 1) << SPI_CFG0_SCK_LOW_SHIFT) |
		((cs_ticks - 1) << SPI_CFG0_CS_HOLD_SHIFT) |
		((cs_ticks - 1) << SPI_CFG0_CS_SETUP_SHIFT));
	clrsetbits32(&regs->spi_cfg1_reg, SPI_CFG1_CS_IDLE_MASK |
		     SPI_CFG1_TICK_DLY_MASK,
		     (tick_dly << SPI_CFG1_TICK_DLY_SHIFT) |
		     ((cs_ticks - 1) << SPI_CFG1_CS_IDLE_SHIFT));
}

static const struct spi_ctrlr spi_flash_ctrlr = {
	.max_xfer_size = 65535,
	.flash_probe = mtk_spi_flash_probe,
};

const struct spi_ctrlr_buses spi_ctrlr_bus_map[] = {
	{
		.ctrlr = &spi_ctrlr,
		.bus_start = 0,
		.bus_end = SPI_BUS_NUMBER - 1,
	},
	{
		.ctrlr = &spi_flash_ctrlr,
		.bus_start = CONFIG_BOOT_DEVICE_SPI_FLASH_BUS,
		.bus_end = CONFIG_BOOT_DEVICE_SPI_FLASH_BUS,
	},
};

const size_t spi_ctrlr_bus_map_count = ARRAY_SIZE(spi_ctrlr_bus_map);
