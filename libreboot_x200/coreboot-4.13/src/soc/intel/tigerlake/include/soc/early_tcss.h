/* SPDX-License-Identifier: GPL-2.0-only */

/* PMC IPC related offsets and commands */
#define PMC_IPC_USBC_CMD_ID		0xA7
#define PMC_IPC_USBC_SUBCMD_ID		0x0
#define PMC_IPC_CMD			0x0
#define PMC_IPC_TCSS_CONN_REQ_RES	0x0
#define PMC_IPC_TCSS_SAFE_MODE_REQ_RES	0x2
#define PMC_IPC_TCSS_ALTMODE_REQ_RES	0x3
#define PMC_IPC_TCSS_HPD_REQ_RES	0x4
#define PMC_IPC_CONN_REQ_SIZE		2
#define PMC_IPC_ALT_REQ_SIZE		8
#define PMC_IPC_SAFE_REQ_SIZE		1
#define PMC_IPC_HPD_REQ_SIZE		2
#define PMC_IPC_DP_MODE			1

#define TCSS_CD_USAGE_SHIFT		0
#define TCSS_CD_USAGE_MASK		0x0f
#define TCSS_CD_USB3_SHIFT		4
#define TCSS_CD_USB3_MASK		0x0f
#define TCSS_CD_USB2_SHIFT		8
#define TCSS_CD_USB2_MASK		0x0f
#define TCSS_CD_UFP_SHIFT		12
#define TCSS_CD_UFP_MASK		0x01
#define TCSS_CD_HSL_SHIFT		13
#define TCSS_CD_HSL_MASK		0x01
#define TCSS_CD_SBU_SHIFT		14
#define TCSS_CD_SBU_MASK		0x01
#define TCSS_CD_ACC_SHIFT		15
#define TCSS_CD_ACC_MASK		0x01
#define TCSS_CD_FAILED_SHIFT		16
#define TCSS_CD_FAILED_MASK		0x01
#define TCSS_CD_FATAL_SHIFT		17
#define TCSS_CD_FATAL_MASK		0x01

#define TCSS_ALT_USAGE_SHIFT		0
#define TCSS_ALT_USAGE_MASK		0x0f
#define TCSS_ALT_USB3_SHIFT		4
#define TCSS_ALT_USB3_MASK		0x0f
#define TCSS_ALT_MODE_SHIFT		12
#define TCSS_ALT_MODE_MASK		0x0f
#define TCSS_ALT_POLARITY_SHIFT		1
#define TCSS_ALT_POLARITY_MASK		0x01
#define TCSS_ALT_CABLE_SHIFT		2
#define TCSS_ALT_CABLE_MASK		0x01
#define TCSS_ALT_UFP_SHIFT		3
#define TCSS_ALT_UFP_MASK		0x01
#define TCSS_ALT_DP_MODE_SHIFT		8
#define TCSS_ALT_DP_MODE_MASK		0x0f
#define TCSS_ALT_FAILED_SHIFT		8
#define TCSS_ALT_FAILED_MASK		0x01
#define TCSS_ALT_FATAL_SHIFT		9
#define TCSS_ALT_FATAL_MASK		0x01

#define TCSS_HPD_USAGE_SHIFT		0
#define TCSS_HPD_USAGE_MASK		0x0f
#define TCSS_HPD_USB3_SHIFT		4
#define TCSS_HPD_USB3_MASK		0x0f
#define TCSS_HPD_LVL_SHIFT		12
#define TCSS_HPD_LVL_MASK		0x01
#define TCSS_HPD_IRQ_SHIFT		13
#define TCSS_HPD_IRQ_MASK		0x01

#define TCSS_CD_FIELD(name, val) \
	(((val) & TCSS_CD_##name##_MASK) << TCSS_CD_##name##_SHIFT)

#define GET_TCSS_CD_FIELD(name, val) \
	(((val) >> TCSS_CD_##name##_SHIFT) & TCSS_CD_##name##_MASK)


#define TCSS_ALT_FIELD(name, val) \
	(((val) & TCSS_ALT_##name##_MASK) << TCSS_ALT_##name##_SHIFT)

#define TCSS_HPD_FIELD(name, val) \
	(((val) & TCSS_HPD_##name##_MASK) << TCSS_HPD_##name##_SHIFT)

#define GET_TCSS_ALT_FIELD(name, val) \
	(((val) >> TCSS_ALT_##name##_SHIFT) & TCSS_ALT_##name##_MASK)

#define TCSS_CONN_STATUS_HAS_FAILED(s)	GET_TCSS_CD_FIELD(FAILED, s)
#define TCSS_STATUS_HAS_FAILED(s)	GET_TCSS_ALT_FIELD(FAILED, s)
/* !fatal means retry */
#define TCSS_CONN_STATUS_IS_FATAL(s)	GET_TCSS_CD_FIELD(FATAL, s)
#define TCSS_STATUS_IS_FATAL(s)		GET_TCSS_ALT_FIELD(FATAL, s)

#define USB_2_PORT_MASK			0x0f
#define USB_3_PORT_MASK			0xf0

/* TCSS connection modes for PMC */
enum pmc_ipc_conn_mode {
	PMC_IPC_TCSS_DISCONNECT_MODE,
	PMC_IPC_TCSS_USB_MODE,
	PMC_IPC_TCSS_ALTERNATE_MODE,
	PMC_IPC_TCSS_SAFE_MODE,
	PMC_IPC_TCSS_HPD_MODE,
	PMC_IPC_TCSS_TOTAL_MODES,
};

enum pmc_ipc_command_type {
	CONNECT_REQ,
	SAFE_REQ,
	DP_REQ,
	HPD_REQ,
};

/* DP Mode pin definitions */
#define MODE_DP_PIN_A BIT(0)
#define MODE_DP_PIN_B BIT(1)
#define MODE_DP_PIN_C BIT(2)
#define MODE_DP_PIN_D BIT(3)
#define MODE_DP_PIN_E BIT(4)
#define MODE_DP_PIN_F BIT(5)

/* struct to hold all tcss_mux related variables */
struct tcss_mux {
	bool dp; /* DP connected */
	bool usb; /* USB connected */
	bool cable; /* Activ/Passive Cable */
	bool polarity; /* polarity of connected device */
	bool hpd_lvl; /* HPD Level assert */
	bool hpd_irq; /* HPD IRQ assert */
	bool ufp;
	bool acc;
	uint8_t dp_mode; /* DP Operation Mode */
	uint8_t usb3_port; /* USB2 Port Number */
	uint8_t usb2_port; /* USB3 Port Number */
};

void update_tcss_mux(int port, struct tcss_mux mux_data);

/*
 * Weak mainboard method to setup any mux configuration needed for early TCSS operations.
 * This function will need to obtain any mux data needed to forward to IOM/PMC and call
 * the update_tcss_mux method which will call any PMC commands needed to connect the
 * ports. Since the mux data may be stored differently by different mainboards this
 * must be overridden by the mainboard with its specific mux data stored in a struct tcss_mux
 * struct as defined above.
 */
void mainboard_early_tcss_enable(void);
