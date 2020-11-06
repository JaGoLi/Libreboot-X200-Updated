/* SPDX-License-Identifier: GPL-2.0-only */

#include <crc_byte.h>

uint8_t crc7_byte(uint8_t prev_crc, uint8_t data)
{
	const uint8_t g = 0x89;
	prev_crc ^= data;
	for (int i = 0; i < 8; i++) {
		if (prev_crc & 0x80)
			prev_crc ^= g;
		prev_crc <<= 1;
	}
	return prev_crc;
}

uint16_t crc16_byte(uint16_t prev_crc, uint8_t data)
{
	prev_crc  = (uint8_t)(prev_crc >> 8)|(prev_crc << 8);
	prev_crc ^=  data;
	prev_crc ^= (uint8_t)(prev_crc & 0xff) >> 4;
	prev_crc ^= (prev_crc << 8) << 4;
	prev_crc ^= ((prev_crc & 0xff) << 4) << 1;
	return prev_crc;
}

uint32_t crc32_byte(uint32_t prev_crc, uint8_t data)
{
	prev_crc ^= (uint32_t)data << 24;

	for (int i = 0; i < 8; i++) {
		if ((prev_crc & 0x80000000UL) != 0)
			prev_crc = ((prev_crc << 1) ^ 0x04C11DB7UL);
		else
			prev_crc <<= 1;
	}

	return prev_crc;
}
