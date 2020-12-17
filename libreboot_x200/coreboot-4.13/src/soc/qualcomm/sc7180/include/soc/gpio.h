/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef _SOC_QUALCOMM_SC7180_GPIO_H_
#define _SOC_QUALCOMM_SC7180_GPIO_H_

#include <types.h>
#include <soc/addressmap.h>

typedef struct {
	u32 addr;
} gpio_t;

#define TLMM_TILE_SIZE	0x00400000
#define TLMM_GPIO_OFF_DELTA	0x00001000
#define TLMM_GPIO_TILE_NUM	3

#define TLMM_GPIO_IN_OUT_OFF	0x4
#define TLMM_GPIO_ID_STATUS_OFF	0x10

#define GPIO_FUNC_GPIO	0

/* GPIO INTR CFG MASK */
#define GPIO_INTR_DECT_CTL_MASK		0x3
#define GPIO_INTR_RAW_STATUS_EN_MASK	0x1

/* GPIO INTR CFG SHIFT */
#define GPIO_INTR_DECT_CTL_SHIFT	2
#define GPIO_INTR_RAW_STATUS_EN_SHIFT	4

/* GPIO INTR STATUS MASK */
#define GPIO_INTR_STATUS_MASK	0x1

/* GPIO INTR RAW STATUS */
#define GPIO_INTR_RAW_STATUS_ENABLE	1
#define GPIO_INTR_RAW_STATUS_DISABLE	0

/* GPIO INTR STATUS */
#define GPIO_INTR_STATUS_ENABLE		1
#define GPIO_INTR_STATUS_DISABLE	0

/* GPIO INTR CFG MASK */
#define GPIO_INTR_DECT_CTL_MASK		0x3
#define GPIO_INTR_RAW_STATUS_EN_MASK	0x1

/* GPIO INTR CFG SHIFT */
#define GPIO_INTR_DECT_CTL_SHIFT	2
#define GPIO_INTR_RAW_STATUS_EN_SHIFT	4

/* GPIO INTR STATUS MASK */
#define GPIO_INTR_STATUS_MASK	0x1

/* GPIO INTR RAW STATUS */
#define GPIO_INTR_RAW_STATUS_ENABLE	1
#define GPIO_INTR_RAW_STATUS_DISABLE	0

/* GPIO INTR STATUS */
#define GPIO_INTR_STATUS_ENABLE		1
#define GPIO_INTR_STATUS_DISABLE	0

/* GPIO TLMM: Direction */
#define GPIO_INPUT	0
#define GPIO_OUTPUT	1

/* GPIO TLMM: Pullup/Pulldown */
#define GPIO_NO_PULL	0
#define GPIO_PULL_DOWN	1
#define GPIO_KEEPER	2
#define GPIO_PULL_UP	3

/* GPIO TLMM: Drive Strength */
#define GPIO_2MA	0
#define GPIO_4MA	1
#define GPIO_6MA	2
#define GPIO_8MA	3
#define GPIO_10MA	4
#define GPIO_12MA	5
#define GPIO_14MA	6
#define GPIO_16MA	7

/* GPIO TLMM: Status */
#define GPIO_OUTPUT_DISABLE	0
#define GPIO_OUTPUT_ENABLE	1

/* GPIO TLMM: Mask */
#define GPIO_CFG_PULL_BMSK	0x3
#define GPIO_CFG_FUNC_BMSK	0xF
#define GPIO_CFG_DRV_BMSK	0x7
#define GPIO_CFG_OE_BMSK	0x1

/* GPIO TLMM: Shift */
#define GPIO_CFG_PULL_SHFT	0
#define GPIO_CFG_FUNC_SHFT	2
#define GPIO_CFG_DRV_SHFT	6
#define GPIO_CFG_OE_SHFT	9

/* GPIO IO: Mask */
#define GPIO_IO_IN_BMSK		0x1
#define GPIO_IO_OUT_BMSK	0x1

/* GPIO IO: Shift */
#define GPIO_IO_IN_SHFT		0
#define GPIO_IO_OUT_SHFT	1

/* GPIO ID STATUS: Mask */
#define GPIO_ID_STATUS_BMSK	0x1

/* GPIO MAX Valid # */
#define GPIO_NUM_MAX	118

#define GPIO(num) ((gpio_t){.addr = GPIO##num##_ADDR})

#define PIN(index, tlmm, func1, func2, func3, func4, func5, func6, func7) \
GPIO##index##_ADDR = TLMM_##tlmm##_TILE_BASE + index * TLMM_GPIO_OFF_DELTA, \
GPIO##index##_FUNC_##func1 = 1,	\
GPIO##index##_FUNC_##func2 = 2, \
GPIO##index##_FUNC_##func3 = 3, \
GPIO##index##_FUNC_##func4 = 4, \
GPIO##index##_FUNC_##func5 = 5, \
GPIO##index##_FUNC_##func6 = 6, \
GPIO##index##_FUNC_##func7 = 7

enum {
	PIN(0, SOUTH, QUP0_L0, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(1, SOUTH, QUP0_L1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(2, SOUTH, QUP0_L2, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(3, SOUTH, QUP0_L3, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(4, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(5, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(6, NORTH, QUP1_L0, QUP1_L2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(7, NORTH, QUP1_L1, QUP1_L3, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(8, NORTH, GP_PDM_MIRB, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(9, NORTH, RES1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(10, NORTH, MDP_VSYNC_P_MIRA, RES_2, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(11, NORTH, MDP_VSYNC_S_MIRA, RES_2, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(12, SOUTH, MDP_VSYNC_E, RES_2, QUP0_L4, RES_4, RES_5, RES_6, RES_7),
	PIN(13, SOUTH, CAM_MCLK0, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(14, SOUTH, CAM_MCLK1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(15, SOUTH, CAM_MCLK2, QUP0_L0, QUP0_L2, RES_4, RES_5, RES_6, RES_7),
	PIN(16, SOUTH, CAM_MCLK3, QUP0_L1, QUP0_L3, RES_4, RES_5, RES_6, RES_7),
	PIN(17, SOUTH, CCI_I2C_SDA0, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(18, SOUTH, CCI_I2C_SCL0, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(19, SOUTH, CCI_I2C_SDA1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(20, SOUTH, CCI_I2C_SCL1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(21, NORTH, CCI_TIMER0, GCC_GP2_CLK_MIRB, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(22, NORTH, CCI_TIMER1, GCC_GP3_CLK_MIRB, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(23, SOUTH, CCI_TIMER2, CAM_MCLK4, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(24, SOUTH, CCI_TIMER3, CCI_ASYNC_IN1, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(25, SOUTH, CCI_TIMER4, CCI_ASYNC_IN2, QUP0_L0, RES_4, RES_5, RES_6,
									RES_7),
	PIN(26, SOUTH, CCI_ASYNC_IN0, QUP0_L1, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(27, SOUTH, CCI_I2C_SDA2, QUP0_L2, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(28, SOUTH, CCI_I2C_SCL2, QUP0_L3, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(29, NORTH, GP_MN, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(30, SOUTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(31, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(32, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(33, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(34, SOUTH, QUP0_L0, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(35, SOUTH, QUP0_L1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(36, SOUTH, QUP0_L2, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(37, SOUTH, QUP0_L3, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(38, SOUTH, QUP0_L0, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(39, SOUTH, QUP0_L1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(40, SOUTH, QUP0_L2, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(41, SOUTH, QUP0_L3, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(42, NORTH, QUP1_L0, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(43, NORTH, QUP1_L1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(44, NORTH, QUP1_L2, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(45, NORTH, QUP1_L3, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(46, NORTH, QUP1_L0, QUP1_L2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(47, NORTH, QUP1_L1, QUP1_L3, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(48, NORTH, GCC_GP1_CLK_MIRA, RES_2, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(49, WEST, MI2S_1_SCK, BTFM_SLIMBUS_CLK, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(50, WEST, MI2S_1_WS, BTFM_SLIMBUS_DATA0, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(51, WEST, MI2S_1_DATA0, BTFM_SLIMBUS_DATA1, RES_3, RES_4, RES_5,
								RES_6, RES_7),
	PIN(52, WEST, MI2S_1_DATA1, BTFM_SLIMBUS_DATA2, RES_3, RES_4, RES_5,
								RES_6, RES_7),
	PIN(53, WEST, MI2S_0_SCK, QUP1_L0, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(54, WEST, MI2S_0_WS, QUP1_L1, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(55, WEST, MI2S_0_DATA0, QUP1_L2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(56, WEST, MI2S_0_DATA1, QUP1_L3, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(57, WEST, LPASS_EXT_MCLK0, RES_2, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(58, WEST, LPASS_EXT_MCLK1, RES_2, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(59, NORTH, QUP1_L0, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(60, NORTH, QUP1_L1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(61, NORTH, QUP1_L2, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(62, NORTH, QUP1_L3, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(63, NORTH, QSPI_CLK, MDP_VSYNC0_OUT, MI2S_2_SCK, MDP_VSYNC1_OUT,
					MDP_VSYNC2_OUT, MDP_VSYNC3_OUT, RES_7),
	PIN(64, NORTH, QSPI_DATA_0, MI2S_2_WS, RES_3, RES_4, RES_5, RES_6,
									RES_7),
	PIN(65, NORTH, QSPI_DATA_1, MI2S_2_DATA0, RES_3, RES_4, RES_5,
		RES_6, RES_7),
	PIN(66, NORTH, QSPI_DATA_2, MI2S_2_DATA1, RES_3, RES_4, RES_5,
		RES_6, RES_7),
	PIN(67, NORTH, QSPI_DATA_3, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(68, NORTH, QSPI_CS_N_0, QUP1_L4, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(69, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(70, NORTH, RES_1, RES_2, MDP_VSYNC_P_MIRB, LDO_EN, RES_5, RES_6,
									RES_7),
	PIN(71, NORTH, RES_1, MDP_VSYNC_S_MIRB, LDO_UPDATE, RES_4, RES_5, RES_6,
									RES_7),
	PIN(72, NORTH, QSPI_CS_N_1, QUP1_L5, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(73, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(74, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(75, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(76, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(77, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(78, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(79, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(80, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(81, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(82, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(83, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(84, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(85, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(86, NORTH, QUP1_L0, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(87, NORTH, QUP1_L1, ADSP_EXT_VFR_IRQ, RES_3, RES_4, RES_5,
								 RES_6, RES_7),
	PIN(88, NORTH, QUP1_L2, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(89, NORTH, QUP1_L3, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(90, NORTH, QUP1_L4, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(91, NORTH, QUP1_L5, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(92, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(93, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(94, SOUTH, QUP0_L5, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(95, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(96, WEST, QLINK_REQUEST, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(97, WEST, QLINK_ENABLE, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(98, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(99, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(100, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(101, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(102, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(103, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(104, WEST, USB_PHY_PS, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(105, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(106, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(107, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(108, SOUTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(109, SOUTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(110, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(111, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(112, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(113, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(114, NORTH, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(115, WEST, QUP0_L0, QUP0_L2, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(116, WEST, QUP0_L1, QUP0_L3, RES_3, RES_4, RES_5, RES_6, RES_7),
	PIN(117, WEST, DP_HOT_PLUG_DETECT_MIRB, RES_2, RES_3, RES_4, RES_5,
								 RES_6, RES_7),
	PIN(118, WEST, RES_1, RES_2, RES_3, RES_4, RES_5, RES_6, RES_7),
};

enum gpio_irq_type {
	IRQ_TYPE_LEVEL = 0,
	IRQ_TYPE_RISING_EDGE = 1,
	IRQ_TYPE_FALLING_EDGE = 2,
	IRQ_TYPE_DUAL_EDGE = 3,
};

struct tlmm_gpio {
	uint32_t cfg;
	uint32_t in_out;
	uint32_t intr_cfg;
	uint32_t intr_status;
};

void gpio_configure(gpio_t gpio, uint32_t func, uint32_t pull,
				uint32_t drive_str, uint32_t enable);
void gpio_input_irq(gpio_t gpio, enum gpio_irq_type type, uint32_t pull);
int gpio_irq_status(gpio_t gpio);

#endif /* _SOC_QUALCOMM_SC7180_GPIO_H_ */