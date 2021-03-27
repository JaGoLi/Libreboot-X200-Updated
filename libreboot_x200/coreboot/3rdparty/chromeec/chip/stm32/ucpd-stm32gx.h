/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
#ifndef __CROS_EC_UCPD_STM32GX_H
#define __CROS_EC_UCPD_STM32GX_H

/* STM32 UCPD driver for Chrome EC */

#include "usb_pd_tcpm.h"

/*
 * K-codes and ordered set defines. These codes and sets are used to encode
 * which type of USB-PD message is being sent. This information can be found in
 * the USB-PD spec section 5.4 - 5.6. This info is also included in the STM32G4
 * TRM (RM0440) 45.4.3
 */
#define UCPD_SYNC1 0x18u
#define UCPD_SYNC2 0x11u
#define UCPD_SYNC3 0x06u
#define UCPD_RST1  0x07u
#define UCPD_RST2  0x19u
#define UCPD_EOP   0x0Du

/* This order of this enum matches tcpm_transmit_type */
enum ucpd_tx_ordset {
	TX_ORDERSET_SOP =	(UCPD_SYNC1 |
				(UCPD_SYNC1<<5u) |
				(UCPD_SYNC1<<10u) |
				(UCPD_SYNC2<<15u)),

	TX_ORDERSET_SOP_PRIME =	(UCPD_SYNC1 |
				(UCPD_SYNC1<<5u) |
				(UCPD_SYNC3<<10u) |
				(UCPD_SYNC3<<15u)),

	TX_ORDERSET_SOP_PRIME_PRIME =	(UCPD_SYNC1 |
				(UCPD_SYNC3<<5u) |
				(UCPD_SYNC1<<10u) |
				(UCPD_SYNC3<<15u)),

	TX_ORDERSET_SOP_PRIME_DEBUG =	(UCPD_SYNC1 |
					(UCPD_RST2<<5u) |
					(UCPD_RST2<<10u) |
					(UCPD_SYNC3<<15u)),

	TX_ORDERSET_SOP_PRIME_PRIME_DEBUG =	(UCPD_SYNC1 |
					(UCPD_RST2<<5u) |
					(UCPD_SYNC3<<10u) |
					(UCPD_SYNC2<<15u)),

	TX_ORDERSET_HARD_RESET =	(UCPD_RST1  |
					(UCPD_RST1<<5u) |
					(UCPD_RST1<<10u)  |
					(UCPD_RST2<<15u)),

	TX_ORDERSET_CABLE_RESET =	(UCPD_RST1 |
					(UCPD_SYNC1<<5u) |
					(UCPD_RST1<<10u)  |
					(UCPD_SYNC3<<15u)),
};


/**
 * STM32Gx UCPD implementation of tcpci .init method
 *
 * @param usbc_port -> USB-C Port number
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_init(int usbc_port);

/**
 * STM32Gx UCPD implementation of tcpci .release method
 *
 * @param usbc_port -> USB-C Port number
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_release(int usbc_port);

/**
 * STM32Gx UCPD implementation of tcpci .get_cc method
 *
 * @param usbc_port -> USB-C Port number
 * @param *cc1 -> pointer to cc1 result
 * @param *cc2 -> pointer to cc2 result
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_get_cc(int usbc_port, enum tcpc_cc_voltage_status *cc1,
			enum tcpc_cc_voltage_status *cc2);

/**
 * STM32Gx equivalent for TCPCI role_control register
 *
 * @param usbc_port -> USB-C Port number
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_get_role_control(int usbc_port);

/**
 * STM32Gx UCPD implementation of tcpci .set_cc method
 *
 * @param usbc_port -> USB-C Port number
 * @param cc_pull -> Rp or Rd selection
 * @param rp -> value of Rp (if cc_pull == Rp)
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_set_cc(int usbc_port, int cc_pull, int rp);

/**
 * STM32Gx UCPD implementation of tcpci .set_cc method
 *
 * @param usbc_port -> USB-C Port number
 * @param polarity -> CC1 or CC2 selection
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_set_polarity(int usbc_port, enum tcpc_cc_polarity polarity);

/**
 * STM32Gx UCPD implementation of tcpci .set_rx_enable method
 *
 * @param usbc_port -> USB-C Port number
 * @param enable -> on/off for USB-PD messages
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_set_rx_enable(int port, int enable);

/**
 * STM32Gx UCPD implementation of tcpci .set_msg_header method
 *
 * @param usbc_port -> USB-C Port number
 * @param power_role -> port's current power role
 * @param data_role -> port's current data role
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_set_msg_header(int port, int power_role, int data_role);

/**
 * STM32Gx UCPD implementation of tcpci .transmit method
 *
 * @param usbc_port -> USB-C Port number
 * @param type -> SOP/SOP'/SOP'' etc
 * @param header -> usb pd message header
 * @param *data -> pointer to message contents
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_transmit(int port,
			enum tcpm_transmit_type type,
			uint16_t header,
			  const uint32_t *data);

/**
 * STM32Gx UCPD implementation of tcpci .get_message_raw method
 *
 * @param usbc_port -> USB-C Port number
 * @param *payload -> pointer to where message should be written
 * @param *head -> pointer to message header
 * @return EC_SUCCESS
 */
int stm32gx_ucpd_get_message_raw(int port, uint32_t *payload, int *head);

#endif /* __CROS_EC_UCPD_STM32GX_H */
