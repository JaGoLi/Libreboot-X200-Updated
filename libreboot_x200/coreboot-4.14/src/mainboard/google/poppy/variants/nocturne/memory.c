/* SPDX-License-Identifier: GPL-2.0-only */

#include <baseboard/variants.h>

/* DQ byte map */
static const u8 dq_map[][12] = {
	{ 0x0F, 0xF0, 0x00, 0xF0, 0x0F, 0xF0,
	  0x0F, 0x00, 0xFF, 0x00, 0xFF, 0x00 },
	{ 0x33, 0xCC, 0x00, 0xCC, 0x33, 0xCC,
	  0x33, 0x00, 0xFF, 0x00, 0xFF, 0x00 }
};

/* DQS CPU<>DRAM map */
static const u8 dqs_map[][8] = {
	{ 0, 1, 3, 2, 4, 5, 6, 7 },
	{ 3, 2, 6, 7, 0, 1, 4, 5 },
};

/* Rcomp resistor */
static const u16 rcomp_resistor[] = { 200, 81, 162 };

/* Rcomp target */
static const u16 rcomp_target[] = { 100, 30, 40, 23, 40 };

void variant_memory_params(struct memory_params *p)
{
	p->type = MEMORY_LPDDR3;
	p->dq_map = dq_map;
	p->dq_map_size = sizeof(dq_map);
	p->dqs_map = dqs_map;
	p->dqs_map_size = sizeof(dqs_map);
	p->rcomp_resistor = rcomp_resistor;
	p->rcomp_resistor_size = sizeof(rcomp_resistor);
	p->rcomp_target = rcomp_target;
	p->rcomp_target_size = sizeof(rcomp_target);
}
