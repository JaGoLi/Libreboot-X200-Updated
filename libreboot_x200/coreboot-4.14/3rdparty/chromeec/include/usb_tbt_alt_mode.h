/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

/*
 * Thunderbolt alternate mode support
 * Refer to USB Type-C Cable and Connector Specification Release 2.0 Section F
 */

#ifndef __CROS_EC_USB_TBT_ALT_MODE_H
#define __CROS_EC_USB_TBT_ALT_MODE_H

#include <stdint.h>

#include "tcpm.h"

/*
 * Initialize Thunderbolt state for the specified port.
 *
 * @param port USB-C port number
 */
void tbt_init(int port);

/*
 * Requests to exit the Thunderbolt alternate mode
 *
 * @param port USB-C port number
 */
void tbt_exit_mode_request(int port);

/*
 * Checks whether the mode entry sequence for Thunderbolt alternate mode is
 * done for a port.
 *
 * @param port      USB-C port number
 * @return          True if entry sequence for Thunderbolt mode is completed
 *                  False otherwise
 */
bool tbt_entry_is_done(int port);

/*
 * Checks if the cable entry into Thunderbolt alternate mode is done
 *
 * @param port      USB-C port number
 * @return          True if TBT_FLAG_CABLE_ENTRY_DONE is set
 *                  False otherwise
 */
bool tbt_cable_entry_is_done(int port);

/*
 * Returns True if Thunderbolt mode is not in inactive state
 *
 * @param port      USB-C port number
 * @return          True if Thunderbolt mode is not in inactive state
 *                  False otherwise
 */
bool tbt_is_active(int port);

/*
 * Handles received Thunderbolt VDM ACKs.
 *
 * @param port      USB-C port number
 * @param type      Transmit type (SOP, SOP') for received ACK
 * @param vdo_count The number of VDOs in the ACK VDM
 * @param vdm       VDM from ACK
 */
void intel_vdm_acked(int port, enum tcpm_transmit_type type, int vdo_count,
		uint32_t *vdm);

/*
 * Handles NAKed (or Not Supported or timed out) Thunderbolt VDM requests.
 *
 * @param port    USB-C port number
 * @param type    Transmit type (SOP, SOP') for request
 * @param svid    The SVID of the request
 * @param vdm_cmd The VDM command of the request
 */
void intel_vdm_naked(int port, enum tcpm_transmit_type type, uint8_t vdm_cmd);

/*
 * Construct the next Thunderbolt VDM that should be sent.
 *
 * @param port      USB-C port number
 * @param vdo_count The number of VDOs in vdm; must be at least VDO_MAX_SIZE
 * @param vdm       The VDM payload to be sent; output; must point to at least
 *                  VDO_MAX_SIZE elements
 * @param tx_type   Transmit type(SOP, SOP', SOP'') for next VDM to be sent
 * @return          The number of VDOs written to VDM or -1 to indicate error
 */
int tbt_setup_next_vdm(int port, int vdo_count, uint32_t *vdm,
		enum tcpm_transmit_type *tx_type);

#endif
