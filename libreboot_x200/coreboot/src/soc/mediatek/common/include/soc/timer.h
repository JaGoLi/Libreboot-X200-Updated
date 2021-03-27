/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef SOC_MEDIATEK_COMMON_TIMER_H
#define SOC_MEDIATEK_COMMON_TIMER_H

#include <soc/addressmap.h>
#include <types.h>

#define GPT_MHZ	13

struct mtk_gpt_regs {
	u32 reserved1[24];
	u32 gpt6_con;
	u32 gpt6_clk;
	u32 gpt6_cnt_l;
	u32 reserved2[3];
	u32 gpt6_cnt_h;
};

check_member(mtk_gpt_regs, gpt6_con, 0x0060);
check_member(mtk_gpt_regs, gpt6_clk, 0x0064);
check_member(mtk_gpt_regs, gpt6_cnt_l, 0x0068);
check_member(mtk_gpt_regs, gpt6_cnt_h, 0x0078);

enum {
	GPT_CON_EN        = 0x01,
	GPT_CON_CLR       = 0x02,
	GPT_MODE_FREERUN  = 0x30,
	GPT_SYS_CLK       = 0x00,
	GPT_CLK_DIV1      = 0x00,
};

/*
 * This is defined as weak no-ops that can be overridden by legacy SOCs. Some
 * legacy SOCs need specific settings before init timer. And we expect future
 * SOCs will not need it.
 */
void timer_prepare(void);

#endif
