/** @file

PE PCI Handler

This program and the accompanying materials
are licensed and made available under the terms and conditions of the BSD License
which accompanies this distribution.  The full text of the license may be found at
http://opensource.org/licenses/bsd-license.php.

THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

**/

#include "StmRuntime.h"
#include "PeStm.h"

void SetTimerRate(UINT16 value);

// interval timer support

//#define CONFIG_MMCONF_BASE_ADDRESS 0xF8000000///
//#define DEFAULT_PCIEXBAR CONFIG_MMCONF_BASE_ADDRESS     // frm sandybridge.h


// from pci_devs.h
#define PCU_DEV 0x1F

// from lcp.h

/* D30:F0 LPC bridge */
#define D31F0_PMBASE       0x40
#define D31F0_GEN_PMCON_1  0xA0
#define D31F0_GEN_PMCON_3  0xA4

#define SMI_EN   0x30         /* SMI Control and Enable Register */
#define SWSMI_TMR_EN  (1<<6)  // start software timer on bit set
#define PERIODIC_EN   (1<<14)
#define EOS_EN        (1<<1)  /* End of SMI  */

#define SMI_STS  0x34		/* SMI Status Register  */

// SMI STATUS BITS

#define SWSMI_TMR_STS (1<<6) 
#define PERIODIC_STS  (1<<14)


// from arch/io.h
#define PCI_DEV(SEGBUS, DEV, FN) ( \
	(((SEGBUS) & 0xFFF) << 20) | \
	(((DEV) & 0x1F) << 15) | \
	(((FN) & 0x07) <<12))

void PrintSmiEnRegister(UINT32 Index);
extern STM_GUEST_CONTEXT_COMMON        mGuestContextCommonSmm[];

typedef int device_t;

static UINT16 pmbase = 0x0;

static UINT16 read16(UINTN addr)
{
	return *((volatile UINT16 *) (addr));
}

static void write16(UINTN addr, UINT16 Reg16)
{
	*((volatile UINT16 *) (addr)) = Reg16;
}

static UINT32 read32(UINTN addr)
{
	return *((volatile UINT32 *) (addr));
}

static UINT16 pcie_read_config16(device_t dev, unsigned int whereat)
{
	UINTN addr;

	addr = ((UINTN) mHostContextCommon.PciExpressBaseAddress) | dev | whereat;
	//DEBUG((EFI_D_DEBUG, "pcie_read_config16 %x\n", addr));
	return read16(addr);
}

static UINT32 pcie_read_config32(device_t dev, unsigned int whereat)
{
	UINTN addr;

	addr = ((UINTN) mHostContextCommon.PciExpressBaseAddress) | dev | whereat;
	//DEBUG((EFI_D_DEBUG, "pcie_read_config32 %x\n", addr));
	return read32(addr);
}

static void pcie_write_config16(device_t dev, unsigned int whereat, UINT16 Reg16)
{
	UINTN addr;

	addr = ((UINTN) mHostContextCommon.PciExpressBaseAddress) | dev | whereat;
	write16(addr, Reg16);
	return;
}

static device_t get_pcu_dev(void)
{
	//DEBUG((EFI_D_DEBUG, "get_pcu_dev - return %x\n", PCI_DEV(0, PCU_DEV, 0)));
	return PCI_DEV(0, PCU_DEV, 0);
}

UINT16 get_pmbase(void)
{
	if (pmbase == 0)
	{
		// find the pmbase in the BIOS resource list

		STM_RSC *Resource;

		// the pmbase is the first IO resource
		Resource = GetStmFirstResource (
				(STM_RSC *)mGuestContextCommonSmm[SMI_HANDLER].BiosHwResourceRequirementsPtr,
				IO_RANGE);
		if(Resource == NULL)
			DEBUG((EFI_D_ERROR,
				"get_pmbase - Error pmbase not found in resource list\n"));
		else
		{
			pmbase = Resource->Io.Base;
			DEBUG((EFI_D_INFO,
				"get_pmbase - pmbase set at 0x%x\n", pmbase));
		}
	}
	return pmbase;
} 

void StartTimer(void)
{
	UINT16 pmbase = get_pmbase();
	UINT32 smi_en = IoRead32(pmbase + SMI_EN);
	UINT32 smi_sts = IoRead32(pmbase + SMI_STS);

	smi_en |= PERIODIC_EN;
#if 0
	DEBUG((EFI_D_INFO,
		"StartTimer - smi_en: 0x%08lx smi_sts: 0x%08lx\n",
		smi_en,
		smi_sts));
#endif
	IoWrite32(pmbase + SMI_STS, PERIODIC_STS);
	IoWrite32(pmbase + SMI_EN, smi_en);
}

void SetEndOfSmi(void)
{

	UINT16 pmbase = get_pmbase();
	UINT32 smi_en = IoRead32(pmbase + SMI_EN);
	smi_en |= EOS_EN;  // set the bit
#if 0
	DEBUG((EFI_D_INFO,
		"-- SetEndOfSmi pmbase: %x smi_en: %x \n",
		pmbase,
		smi_en));
#endif
	IoWrite32(pmbase + SMI_EN, smi_en);
#if 0
	DEBUG((EFI_D_INFO,
		"SetEndOfSmi smi_en: 0x%08lx smi_sts: 0x%08lx\n",
		IoRead32(pmbase + SMI_EN),
		IoRead32(pmbase + SMI_STS)));
#endif
}

void PrintSmiEnRegister(UINT32 Index)
{
	UINT16 pmbase = get_pmbase();
	DEBUG((EFI_D_INFO,
		"%ld PrintSmiEnRegister smi_en: 0x%08x smi_sts: 0x%08x\n",
		Index,
		IoRead32(pmbase + SMI_EN),
		IoRead32(pmbase + SMI_STS)));
}

void AckTimer(void)
{
	UINT16 pmbase = get_pmbase();
	
	IoWrite32(pmbase + SMI_STS, PERIODIC_STS);
#if 0
	DEBUG((EFI_D_INFO,
		"AckTimer - smi_en: 0x%08lx smi_sts: 0x%08lx\n",
		IoRead32(pmbase + SMI_EN),
		IoRead32(pmbase + SMI_STS)));
#endif
}

void StopSwTimer(void)
{
	UINT16 pmbase = get_pmbase();
	UINT32 smi_en = IoRead32(pmbase + SMI_EN);

	smi_en &= ~PERIODIC_EN;
	IoWrite32(pmbase + SMI_EN, smi_en);
}

/*
 *  CheckTimerSTS
 *   Input:
 *     Index - cpu number
 *
 *   Output:
 *     0 - No timer interrupt detected
 *     1 - Timer interrupt detected
 *     2 - Timer interrupt plus additional SMI
 */

int CheckTimerSTS(UINT32 Index)
{
	UINT16 pmbase = get_pmbase();
	UINT32 smi_sts = IoRead32(pmbase + SMI_STS);
#if 0
	DEBUG((EFI_D_ERROR, "%ld CheckTimerSTS - 0x%08lx\n", Index, smi_sts));
#endif
	if((smi_sts & PERIODIC_STS) == PERIODIC_STS)
	{
		UINT32 smi_en = IoRead32(pmbase + SMI_EN);
		UINT32 other_smi = (smi_en & smi_sts) & ~PERIODIC_STS;

		if(other_smi == 0)
		{ 
			DEBUG((EFI_D_INFO,
				"%ld CheckTimerSTS - Timer Interrupt Detected\n",
				Index,
				smi_sts));
			return 1;
		}
		else
		{
			DEBUG((EFI_D_INFO,
				"%ld CheckTimerSTS - Timer + other SMI found\n",
				Index,
				smi_sts));
			return 2;
		}
	}
	else
	{
#if 0
		DEBUG((EFI_D_INFO,
			"%ld CheckTimerSTS - No Timer Interrupt Detected\n",
			Index,
			smi_sts));
#endif
		return 0;
	}
}

void ClearTimerSTS()
{
	UINT16 pmbase = get_pmbase();
	
	// just want to clear the  status - do not touch the rest
	IoWrite32(pmbase + SMI_STS, PERIODIC_STS);
}

void SetMaxSwTimerInt()
{
	SetTimerRate(3);
}

void SetMinSwTimerInt()
{
	SetTimerRate(0);
}

void SetTimerRate(UINT16 value)
{
	UINT16 Reg16;
	UINT16 TimeOut;
	device_t PcuDev = get_pcu_dev();

	if( value > 3)
	{
		value = 3;
	}
	TimeOut = (value << 0);

	Reg16 = pcie_read_config16(PcuDev, D31F0_GEN_PMCON_1);
	pcie_write_config16(PcuDev, D31F0_GEN_PMCON_1, Reg16|TimeOut);
}
