/* SPDX-License-Identifier: GPL-2.0-or-later */

#ifndef _SOC_PCI_DEVS_H_
#define _SOC_PCI_DEVS_H_

#include <console/console.h>
#include <device/device.h>
#include <device/pci_def.h>
#include <hob_iiouds.h>
#include <soc/pch_pci_devs.h>

#define dump_csr(fmt, dev, reg) \
	printk(BIOS_SPEW, "%s%x:%x:%x reg: %s (0x%x), data: 0x%x\n", \
		fmt, ((uint32_t)dev >> 20) & 0xfff, ((uint32_t)dev >> 15) & 0x1f, \
		((uint32_t)dev >> 12) & 0x07, \
		#reg, reg, pci_mmio_read_config32(dev, reg))

#define dump_csr64(fmt, dev, reg) \
	printk(BIOS_SPEW, "%s%x:%x:%x reg: %s (0x%x), data: 0x%x%x\n", \
		fmt, ((uint32_t)dev >> 20) & 0xfff, ((uint32_t)dev >> 15) & 0x1f, \
		((uint32_t)dev >> 12) & 0x07, #reg, reg, \
		pci_mmio_read_config32(dev, reg+4), pci_mmio_read_config32(dev, reg))

#define SAD_ALL_DEV			29
#define SAD_ALL_FUNC			0
#define SAD_ALL_PAM0123_CSR		0x40
#define   PAM_LOCK			BIT(0)
#define SAD_ALL_PAM456_CSR		0x44

#if !defined(__SIMPLE_DEVICE__)
#define _PCU_DEV(bus, func)		pcidev_path_on_bus(bus, PCI_DEVFN(PCU_DEV, func))
#else
#define _PCU_DEV(bus, func)		PCI_DEV(bus, PCU_DEV, func)
#endif

#define PCU_IIO_STACK                   1
#define PCU_DEV                         30
#define PCU_CR1_FUN                     1

#define PCU_CR0_FUN                     0
#define PCU_DEV_CR0(bus)                _PCU_DEV(bus, PCU_CR0_FUN)
#define PCU_CR0_PLATFORM_INFO           0xa8
#define PCU_CR0_P_STATE_LIMITS          0xd8
#define P_STATE_LIMITS_LOCK_SHIFT       31
#define P_STATE_LIMITS_LOCK             (1 << P_STATE_LIMITS_LOCK_SHIFT)
#define PCU_CR0_TEMPERATURE_TARGET      0xe4
#define PCU_CR0_PACKAGE_RAPL_LIMIT      0xe8
#define PCU_CR0_CURRENT_CONFIG          0xf8
#define MAX_NON_TURBO_LIM_RATIO_SHIFT   8 /* 8:15 */
#define MAX_NON_TURBO_LIM_RATIO_MASK    (0xff << MAX_NON_TURBO_LIM_RATIO_SHIFT)
#define PCU_CR0_PMAX                    0xf0
#define   PMAX_LOCK                     BIT(31)

#define PCU_CR1_BIOS_MB_DATA_REG                           0x8c

#define PCU_CR1_BIOS_MB_INTERFACE_REG                      0x90
#define   BIOS_MB_RUN_BUSY_MASK                            BIT(31)
#define   BIOS_MB_CMD_MASK                                 0xff
#define   BIOS_CMD_READ_PCU_MISC_CFG                       0x5
#define   BIOS_CMD_WRITE_PCU_MISC_CFG                      0x6
#define   BIOS_ERR_INVALID_CMD                             0x01

#define PCU_CR1_BIOS_RESET_CPL_REG                         0x94
#define   RST_CPL1_MASK                                    BIT(1)
#define   RST_CPL2_MASK                                    BIT(2)
#define   RST_CPL3_MASK                                    BIT(3)
#define   RST_CPL4_MASK                                    BIT(4)
#define   PCODE_INIT_DONE1_MASK                            BIT(9)
#define   PCODE_INIT_DONE2_MASK                            BIT(10)
#define   PCODE_INIT_DONE3_MASK                            BIT(11)
#define   PCODE_INIT_DONE4_MASK                            BIT(12)

#define PCU_CR1_DESIRED_CORES_CFG2_REG                     0xa0
#define PCU_CR1_DESIRED_CORES_CFG2_REG_LOCK_MASK           BIT(31)

#if !defined(__SIMPLE_DEVICE__)
#define _UBOX_DEV(func)		pcidev_path_on_root_debug(PCI_DEVFN(UBOX_DEV, func), __func__)
#else
#define _UBOX_DEV(func)		PCI_DEV(0, UBOX_DEV, func)
#endif

#define UBOX_DEV			8

#define UBOX_PMON_BUS			0
#define UBOX_PMON_DEV			8
#define UBOX_PMON_FUNC			1
#define UBOX_DEV_PMON			_UBOX_DEV(UBOX_PMON_FUNC)
#define SMM_FEATURE_CONTROL		0x7c
#define SMM_CODE_CHK_EN			BIT(2)
#define SMM_FEATURE_CONTROL_LOCK	BIT(0)

#define UBOX_DECS_BUS			0
#define UBOX_DECS_DEV			8
#define UBOX_DECS_FUNC			2
#define UBOX_DECS_CPUBUSNO_CSR		0xcc
#define UBOX_DECS_CPUBUSNO1_CSR		0xd0

#define VTD_TOLM_CSR			0xd0
#define VTD_TSEG_BASE_CSR		0xa8
#define VTD_TSEG_LIMIT_CSR		0xac
#define VTD_EXT_CAP_LOW			0x10
#define VTD_MMCFG_BASE_CSR		0x90
#define VTD_MMCFG_LIMIT_CSR		0x98
#define VTD_TOHM_CSR			0xd4
#define VTD_MMIOL_CSR			0xdc
#define VTD_ME_BASE_CSR			0xf0
#define VTD_ME_LIMIT_CSR		0xf8
#define VTD_VERSION			0x00
#define VTD_CAP				0x08
#define VTD_CAP_LOW			0x08
#define VTD_CAP_HIGH			0x0C
#define VTD_EXT_CAP_HIGH		0x14
#define VTD_LTDPR			0x290

#define PCU_CR1_C2C3TT_REG                                 0xdc
#define PCU_CR1_PCIE_ILTR_OVRD                             0xfc
#define PCU_CR1_SAPMCTL                                    0xb0
#define SAPMCTL_LOCK_SHIFT                                 31
#define SAPMCTL_LOCK_MASK                                  (1 << SAPMCTL_LOCK_SHIFT)
#define PCU_CR1_MC_BIOS_REQ                                0x98

#define PCU_CR2_FUN                                        2
#define PCU_CR2_PKG_CST_ENTRY_CRITERIA_MASK                0x8c
#define PCIE_IN_PKGCSTATE_L1_MASK                          0xFFFFFF /* 23:0 bits */
#define PCU_CR2_PKG_CST_ENTRY_CRITERIA_MASK2               0x90
#define KTI_IN_PKGCSTATE_L1_MASK                           0x7 /* 2:0 bits */
#define PCU_CR2_DYNAMIC_PERF_POWER_CTL                     0xdc
#define UNCORE_PLIMIT_OVERRIDE_BIT                         20
#define UNOCRE_PLIMIT_OVERRIDE_SHIFT                       (1 << UNCORE_PLIMIT_OVERRIDE_BIT)
#define PCU_CR2_PROCHOT_RESPONSE_RATIO_REG                 0xb0
#define PROCHOT_RATIO                                      0xa /* bits 0:7 */

#define CHA_UTIL_ALL_DEV                                   29
#define CHA_UTIL_ALL_FUNC                                  1
#define CHA_UTIL_ALL_MMCFG_CSR                             0xc0

#define MMAP_VTD_CFG_REG_DEVID		0x2024
#define MMAP_VTD_STACK_CFG_REG_DEVID	0x2034
#define VTD_DEV_NUM			0x5
#define VTD_FUNC_NUM			0x0

#if !defined(__SIMPLE_DEVICE__)
#define VTD_DEV(bus)		pcidev_path_on_bus((bus), PCI_DEVFN(VTD_DEV_NUM, VTD_FUNC_NUM))
#else
#define VTD_DEV(bus)		PCI_DEV((bus), VTD_DEV_NUM, VTD_FUNC_NUM)
#endif

#define CBDMA_DEV_NUM           0x04
#define IIO_CBDMA_MMIO_SIZE     0x10000 //64kB for one CBDMA function
#define IIO_CBDMA_MMIO_ALIGNMENT 14 //2^14 - 16kB

#define VMD_DEV_NUM             0x05
#define VMD_FUNC_NUM            0x05

#define APIC_DEV_NUM            0x05
#define APIC_FUNC_NUM           0x00

// DMI3 B0D0F0 registers
#define DMI3_DEVID		0x2020
#define DMIRCBAR		0x50
#define ERRINJCON		0x1d8

// IIO DFX Global D7F7 registers
#define IIO_DFX_TSWCTL0		0x30c
#define IIO_DFX_LCK_CTL		0x504

#endif /* _SOC_PCI_DEVS_H_ */
