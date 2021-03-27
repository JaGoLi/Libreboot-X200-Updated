/* Copyright 2016 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Virtual USB mux driver for host-controlled USB muxes.
 */

#include "common.h"
#include "console.h"
#include "host_command.h"
#include "task.h"
#include "timer.h"
#include "usb_mux.h"
#include "util.h"

/*
 * USB PD protocol configures the USB & DP mux state and USB PD policy
 * configures the HPD mux state. Both states are independent of each other
 * may differ when the PD role changes when in dock mode.
 */
#define USB_PD_MUX_HPD_STATE	(USB_PD_MUX_HPD_LVL | USB_PD_MUX_HPD_IRQ)
#define USB_PD_MUX_USB_DP_STATE	(USB_PD_MUX_USB_ENABLED | \
			USB_PD_MUX_DP_ENABLED | USB_PD_MUX_POLARITY_INVERTED | \
			USB_PD_MUX_SAFE_MODE | USB_PD_MUX_TBT_COMPAT_ENABLED | \
			USB_PD_MUX_USB4_ENABLED)

static mux_state_t virtual_mux_state[CONFIG_USB_PD_PORT_MAX_COUNT];

static inline void virtual_mux_update_state(int port, mux_state_t mux_state)
{
	mux_state_t previous_mux_state = virtual_mux_state[port];

	virtual_mux_state[port] = mux_state;

	if (!IS_ENABLED(CONFIG_HOSTCMD_EVENTS))
		return;

	host_set_single_event(EC_HOST_EVENT_USB_MUX);

	if (!IS_ENABLED(CONFIG_USB_MUX_AP_ACK_REQUEST))
		return;

	/* This should only be called from the PD task */
	assert(port == TASK_ID_TO_PD_PORT(task_get_current()));

	/*
	 * EC waits for the ACK from kernel indicating that TCSS Mux
	 * configuration is completed. This mechanism is implemented for
	 * entering and exiting the safe mode. This is needed to remove
	 * timing senstivity between BB retimer and TCSS Mux to allow better
	 * synchronization between them and thereby remain in the same state
	 * for achieving proper safe state terminations.
	 *
	 * Note: While the EC waits for the ACK, the value of usb_mux_get
	 * won't match the most recently set value with usb_mux_set.
	 */
	if ((!(previous_mux_state & USB_PD_MUX_SAFE_MODE) &&
	     (mux_state & USB_PD_MUX_SAFE_MODE)) ||
	   ((previous_mux_state & USB_PD_MUX_SAFE_MODE) &&
	    !(mux_state & USB_PD_MUX_SAFE_MODE))) {
		task_wait_event_mask(PD_EVENT_AP_MUX_DONE, 100*MSEC);
		usleep(12.5 * MSEC);
	}
}

static int virtual_init(const struct usb_mux *me)
{
	return EC_SUCCESS;
}

/*
 * Set the state of our 'virtual' mux. The EC does not actually control this
 * mux, so update the desired state, then notify the host of the update.
 */
static int virtual_set_mux(const struct usb_mux *me, mux_state_t mux_state)
{
	int port = me->usb_port;

	/* Current USB & DP mux status + existing HPD related mux status */
	mux_state_t new_mux_state = (mux_state & ~USB_PD_MUX_HPD_STATE) |
		(virtual_mux_state[port] & USB_PD_MUX_HPD_STATE);

	virtual_mux_update_state(port, new_mux_state);

	return EC_SUCCESS;
}

/*
 * Get the state of our 'virtual' mux. Since we the EC does not actually
 * control this mux, and the EC has no way of knowing its actual status,
 * we return the desired state here.
 */
static int virtual_get_mux(const struct usb_mux *me, mux_state_t *mux_state)
{
	int port = me->usb_port;

	*mux_state = virtual_mux_state[port];

	return EC_SUCCESS;
}

void virtual_hpd_update(const struct usb_mux *me, int hpd_lvl, int hpd_irq)
{
	int port = me->usb_port;

	/* Current HPD related mux status + existing USB & DP mux status */
	mux_state_t new_mux_state = (hpd_lvl ? USB_PD_MUX_HPD_LVL : 0) |
			(hpd_irq ? USB_PD_MUX_HPD_IRQ : 0) |
			(virtual_mux_state[port] & USB_PD_MUX_USB_DP_STATE);

	virtual_mux_update_state(port, new_mux_state);
}

const struct usb_mux_driver virtual_usb_mux_driver = {
	.init = virtual_init,
	.set = virtual_set_mux,
	.get = virtual_get_mux,
};
