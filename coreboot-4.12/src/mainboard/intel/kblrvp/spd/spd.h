/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef MAINBOARD_SPD_H
#define MAINBOARD_SPD_H

#include <gpio.h>
#include <variant/gpio.h>

void mainboard_fill_dq_map_data(void *dq_map_ch0, void *dq_map_ch1);
void mainboard_fill_dqs_map_data(void *dqs_map_ch0, void *dqs_map_ch1);
void mainboard_fill_rcomp_res_data(void *rcomp_ptr);
void mainboard_fill_rcomp_strength_data(void *rcomp_strength_ptr);
#endif
