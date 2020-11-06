/* SPDX-License-Identifier: GPL-2.0-only */

#include <arch/cpu.h>
#include <baseboard/variants.h>
#include <intelblocks/mp_init.h>

size_t __weak variant_memory_sku(void)
{
	return 0;
}

static const struct lpddr4x_cfg mem_config = {
	/* DQ byte map */
	.dq_map = {
		[0] = {
			{  0,  1,  6,  7,  3,  2,  5,  4, }, /* DDR0_DQ0[7:0] */
			{ 15,  8,  9, 14, 12, 11, 10, 13, }, /* DDR1_DQ1[7:0] */
		},
		[1] = {
			{ 11, 12,  8, 15,  9, 14, 10, 13, }, /* DDR1_DQ0[7:0] */
			{  3,  4,  7,  0,  6,  1,  5,  2, }, /* DDR1_DQ1[7:0] */
		},
		[2] = {
			{  4,  5,  3,  2,  7,  1,  0,  6, }, /* DDR2_DQ0[7:0] */
			{ 11, 10, 12, 13,  8,  9, 14, 15, }, /* DDR2_DQ1[7:0] */
		},
		[3] = {
			{ 12, 11,  8, 13, 14, 15,  9, 10, }, /* DDR3_DQ0[7:0] */
			{  4,  7,  3,  2,  1,  6,  0,  5, }, /* DDR3_DQ1[7:0] */
		},
		[4] = {
			{ 11, 10,  9,  8, 12, 13, 15, 14, }, /* DDR4_DQ0[7:0] */
			{  4,  5,  6,  7,  3,  2,  0,  1, }, /* DDR4_DQ1[7:0] */
		},
		[5] = {
			{ 0,  7,  1,  6,  3,  5,  2,  4, }, /* DDR5_DQ0[7:0] */
			{ 9,  8, 10, 11, 14, 15, 13, 12, }, /* DDR5_DQ1[7:0] */
		},
		[6] = {
			{  4,  5,  6,  1,  3,  2,  7,  0, }, /* DDR6_DQ0[7:0] */
			{ 10, 13, 12, 11, 14,  9, 15,  8, }, /* DDR6_DQ1[7:0] */
		},
		[7] = {
			{ 10, 12,  9, 15,  8, 11, 13, 14, }, /* DDR7_DQ0[7:0] */
			{  3,  4,  1,  2,  6,  0,  5,  7, }, /* DDR7_DQ1[7:0] */
		},
	},

	/* DQS CPU<>DRAM map */
	.dqs_map = {
		[0] = { 0, 1 }, /* DDR0_DQS[1:0] */
		[1] = { 1, 0 }, /* DDR1_DQS[1:0] */
		[2] = { 0, 1 }, /* DDR2_DQS[1:0] */
		[3] = { 1, 0 }, /* DDR3_DQS[1:0] */
		[4] = { 1, 0 }, /* DDR4_DQS[1:0] */
		[5] = { 0, 1 }, /* DDR5_DQS[1:0] */
		[6] = { 0, 1 }, /* DDR6_DQS[1:0] */
		[7] = { 1, 0 }, /* DDR7_DQS[1:0] */
	},

	.ect = 1, /* Early Command Training */
};

const struct lpddr4x_cfg *__weak variant_memory_params(void)
{
	return &mem_config;
}
