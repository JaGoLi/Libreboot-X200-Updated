/* Copyright 2019 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

/* USB Protocol Layer module */

#ifndef __CROS_EC_USB_PRL_H
#define __CROS_EC_USB_PRL_H
#include "common.h"
#include "usb_pd.h"
#include "usb_pd_tcpm.h"
#include "usb_sm.h"


/**
 * Returns true if Protocol Layer State Machine is in run mode
 *
 * @param port USB-C port number
 * @return 1 if state machine is running, else 0
 */
int prl_is_running(int port);

/**
 * Returns true if the Protocol Layer State Machine is in the
 * process of transmitting or receiving chunked messages.
 *
 * @param port USB-C port number
 * @return true if sending or receiving a chunked message, else false
 */
bool prl_is_busy(int port);

/**
 * Sets the debug level for the PRL layer
 *
 * @param level debug level
 */
void prl_set_debug_level(enum debug_level level);

/**
 * Resets the Protocol Layer State Machine
 *
 * @param port USB-C port number
 */
void prl_reset(int port);

/**
 * Resets the Protocol Layer State Machine (softly)
 *
 * @param port USB-C port number
 */
void prl_reset_soft(int port);

/**
 * Runs the Protocol Layer State Machine
 *
 * @param port USB-C port number
 * @param evt  system event, ie: PD_EVENT_RX
 * @param en   0 to disable the machine, 1 to enable the machine
 */
void prl_run(int port, int evt, int en);

/**
 * Set the PD revision
 *
 * @param port USB-C port number
 * @param type port address
 * @param rev revision
 */
void prl_set_rev(int port, enum tcpm_transmit_type type,
					enum pd_rev_type rev);

/**
 * Get the PD revision
 *
 * @param port USB-C port number
 * @param type port address
 * @return pd rev
 */
enum pd_rev_type prl_get_rev(int port, enum tcpm_transmit_type type);

/**
 * Sends a PD control message
 *
 * @param port USB-C port number
 * @param type Transmit type
 * @param msg  Control message type
 */
void prl_send_ctrl_msg(int port, enum tcpm_transmit_type type,
	enum pd_ctrl_msg_type msg);

/**
 * Sends a PD data message
 *
 * @param port USB-C port number
 * @param type Transmit type
 * @param msg  Data message type
 */
void prl_send_data_msg(int port, enum tcpm_transmit_type type,
	enum pd_data_msg_type msg);

/**
 * Sends a PD extended data message
 *
 * @param port USB-C port number
 * @param type Transmit type
 * @param msg  Extended data message type
 */
void prl_send_ext_data_msg(int port, enum tcpm_transmit_type type,
	enum pd_ext_msg_type msg);

/**
 * Informs the Protocol Layer that a hard reset has completed
 *
 * @param port USB-C port number
 */
void prl_hard_reset_complete(int port);

/**
 * Policy Engine calls this function to execute a hard reset.
 *
 * @param port USB-C port number
 */
void prl_execute_hard_reset(int port);

#endif /* __CROS_EC_USB_PRL_H */
