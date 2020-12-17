/* SPDX-License-Identifier: GPL-2.0-only */

#include <stdint.h>
#include <northbridge/intel/haswell/haswell.h>
#include <northbridge/intel/haswell/raminit.h>
#include <southbridge/intel/lynxpoint/pch.h>
#include <option.h>
#include <ec/lenovo/pmh7/pmh7.h>
#include <device/pci_ops.h>

void mainboard_config_rcba(void)
{
	RCBA16(D31IR) = DIR_ROUTE(PIRQA, PIRQD, PIRQC, PIRQA);
	RCBA16(D29IR) = DIR_ROUTE(PIRQH, PIRQD, PIRQA, PIRQC);
	RCBA16(D28IR) = DIR_ROUTE(PIRQA, PIRQA, PIRQA, PIRQA);
	RCBA16(D27IR) = DIR_ROUTE(PIRQG, PIRQB, PIRQC, PIRQD);
	RCBA16(D26IR) = DIR_ROUTE(PIRQA, PIRQF, PIRQC, PIRQD);
	RCBA16(D25IR) = DIR_ROUTE(PIRQE, PIRQF, PIRQG, PIRQH);
	RCBA16(D22IR) = DIR_ROUTE(PIRQA, PIRQB, PIRQC, PIRQD);
	RCBA16(D20IR) = DIR_ROUTE(PIRQA, PIRQB, PIRQC, PIRQD);
}

void mb_late_romstage_setup(void)
{
	u8 enable_peg;
	if (get_option(&enable_peg, "enable_dual_graphics") != CB_SUCCESS)
		enable_peg = 0;

	bool power_en = pmh7_dgpu_power_state();

	if (enable_peg != power_en)
		pmh7_dgpu_power_enable(!power_en);

	if (!enable_peg) {
		// Hide disabled dGPU device
		u32 reg32 = pci_read_config32(PCI_DEV(0, 0, 0), DEVEN);
		reg32 &= ~DEVEN_D1F0EN;

		pci_write_config32(PCI_DEV(0, 0, 0), DEVEN, reg32);
	}
}

void mb_get_spd_map(uint8_t spd_map[4])
{
	spd_map[0] = 0xa0;
	spd_map[2] = 0xa2;
}

void mainboard_fill_pei_data(struct pei_data *pei_data)
{
	struct usb2_port_setting usb2_ports[MAX_USB2_PORTS] = {
		/* Length, Enable, OCn#, Location */
		{ 0x0040, 1, 0, USB_PORT_BACK_PANEL }, /* USB3 */
		{ 0x0040, 1, 0, USB_PORT_BACK_PANEL }, /* USB3 */
		{ 0x0110, 1, 1, USB_PORT_BACK_PANEL }, /* USB2 charge */
		{ 0x0040, 1, USB_OC_PIN_SKIP, USB_PORT_BACK_PANEL },
		{ 0x0080, 1, USB_OC_PIN_SKIP, USB_PORT_DOCK },
		{ 0x0080, 1, 2, USB_PORT_BACK_PANEL }, /* USB2 */
		{ 0x0040, 1, 3, USB_PORT_BACK_PANEL },
		{ 0x0040, 1, 3, USB_PORT_BACK_PANEL },
		{ 0x0040, 1, 4, USB_PORT_BACK_PANEL },
		{ 0x0110, 1, 4, USB_PORT_BACK_PANEL }, /* WWAN */
		{ 0x0040, 1, 5, USB_PORT_INTERNAL }, /* WLAN */
		{ 0x0040, 1, 5, USB_PORT_BACK_PANEL }, /* webcam */
		{ 0x0080, 1, 6, USB_PORT_BACK_PANEL },
		{ 0x0040, 1, 6, USB_PORT_BACK_PANEL },
	};

	struct usb3_port_setting usb3_ports[MAX_USB3_PORTS] = {
		{ 1, 0 },
		{ 1, 0 },
		{ 1, USB_OC_PIN_SKIP },
		{ 1, USB_OC_PIN_SKIP },
		{ 1, 1 },
		{ 1, 1 }, /* WWAN */
	};

	memcpy(pei_data->usb2_ports, usb2_ports, sizeof(usb2_ports));
	memcpy(pei_data->usb3_ports, usb3_ports, sizeof(usb3_ports));
}
