/*
 * Copyright (c) 2019, Intel Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#ifndef SOCFPGA_SIP_SVC_H
#define SOCFPGA_SIP_SVC_H


/* SiP status response */
#define INTEL_SIP_SMC_STATUS_OK				0
#define INTEL_SIP_SMC_STATUS_BUSY			0x1
#define INTEL_SIP_SMC_STATUS_REJECTED			0x2
#define INTEL_SIP_SMC_STATUS_ERROR			0x4
#define INTEL_SIP_SMC_RSU_ERROR				0x7


/* SMC SiP service function identifier */
#define INTEL_SIP_SMC_FPGA_CONFIG_START			0xC2000001
#define INTEL_SIP_SMC_FPGA_CONFIG_WRITE			0x42000002
#define INTEL_SIP_SMC_FPGA_CONFIG_COMPLETED_WRITE	0xC2000003
#define INTEL_SIP_SMC_FPGA_CONFIG_ISDONE		0xC2000004
#define INTEL_SIP_SMC_FPGA_CONFIG_GET_MEM		0xC2000005
#define INTEL_SIP_SMC_REG_READ				0xC2000007
#define INTEL_SIP_SMC_REG_WRITE				0xC2000008
#define INTEL_SIP_SMC_REG_UPDATE			0xC2000009
#define INTEL_SIP_SMC_RSU_STATUS			0xC200000B
#define INTEL_SIP_SMC_RSU_UPDATE			0xC200000C
#define INTEL_SIP_LEGACY_SMC_ECC_DBE			0xC200000D
#define INTEL_SIP_SMC_RSU_NOTIFY			0xC200000E
#define INTEL_SIP_SMC_RSU_RETRY_COUNTER			0xC200000F
#define INTEL_SIP_SMC_MBOX_SEND_CMD			0xC200001E

/* FPGA config helpers */
#define INTEL_SIP_SMC_FPGA_CONFIG_ADDR			0x400000
#define INTEL_SIP_SMC_FPGA_CONFIG_SIZE			16777216

/* SMC function IDs for SiP Service queries */
#define SIP_SVC_CALL_COUNT	0x8200ff00
#define SIP_SVC_UID		0x8200ff01
#define SIP_SVC_VERSION		0x8200ff03

/* SiP Service Calls version numbers */
#define SIP_SVC_VERSION_MAJOR	0
#define SIP_SVC_VERSION_MINOR	1

#endif /* SOCFPGA_SIP_SVC_H */