/** @file

VM/PE setup, load and VM breakdown functions

This program and the accompanying materials
are licensed and made available under the terms and conditions of the BSD License
which accompanies this distribution.  The full text of the license may be found at
http://opensource.org/licenses/bsd-license.php.

THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

**/

#define VMCALL_C 1

#include "StmRuntime.h"
#include "PeStm.h"
#include "PeLoadVm.h"
#include "StmApi.h" 
#include "CpuDef.h"

extern VOID InitCpuReadySync();
extern VOID CpuReadySync(UINT32 Index);
extern UINT32 GetVmcsSize (VOID);
extern VOID AsmHostEntrypointSmmPe (VOID);
extern RETURN_STATUS RegisterExceptionHandler(IN EFI_EXCEPTION_TYPE ExceptionType, 
	IN EFI_EXCEPTION_CALLBACK ExceptionCallback);
extern void AsmSendInt2();        // setup NMI
extern void PeEptFree(IN UINT64 EptPointer);
extern UINT32 GetVmcsOffset( UINT32 field_encoding);
extern UINT32 GetMPState;

static int CpuGetState = 0;

void SetEndOfSmi(void);
void StartTimer(void);
void StopTimer(void);
void ClearTimerSTS(void);
void SetMaxSwTimerInt(void);
void SetMinSwTimerInt(void);
void SetTimerRate(UINT16 value);

extern void MapVmcs();
void LaunchPeVm(UINT32 PeType, UINT32 CpuIndex);
void AckTimer(void);
UINT16 get_pmbase(void);

UINT32 save_Inter_PeVm(UINT32 CpuIndex);

UINT32 PeSmiHandler(UINT32 CpuIndex);

#define PER_SMI_SEL  (1<<0)    // selects timinf for periodic SMI - in GEN_PMCON_1 (offset A0-A1h)

// Periodic SMI rates

#define PeriodicSmi64Sec   0
#define PeriodicSmi32Sec   1
#define PeriodicSmi16Sec   2
#define PeriodicSmi8Sec    3

// need to add or modify

void     enable_nmi();              // turn on NMI
VOID EFIAPI NullExceptionHandler(IN EFI_EXCEPTION_TYPE InterruptType, IN EFI_SYSTEM_CONTEXT SystemContext);

UINT32 SetupProtExecVm(UINT32 CpuIndex, UINT32 VM_Configuration, UINT32 mode, UINT32 PeType);
//static UINT32 FreePE_PageTables(UINT32 PeType);
static void apic_wrmsr(UINT32 reg, UINT64 msr_content);
void print_region_list(UINT32 PeType, UINT32 CpuIndex);

extern int GetMultiProcessorState(UINT32 CpuIndex);

void InitPe();

typedef struct 
{
	UINT64 Reserved1:8;
	UINT64 MaxNonTurboRatio:8;
	UINT64 Reserved2:12;
	UINT64 ProgRatioLimitTM:1;
	UINT64 ProgTDPLimitTM:1;
	UINT64 Reserved3:10;
	UINT64 MaxEffRatio:8;
	UINT64 Reserved4:16;
}MSR_PLATFORM_INFO_BITS;

typedef union
{
	MSR_PLATFORM_INFO_BITS Bits;
	UINT64                 Uint64;
} MSR_PLATFORM_INFO_DATA;

extern PE_SMI_CONTROL PeSmiControl;
PE_VM_DATA PeVmData[4];   // right now support a max of 3 PE VM (VM 0 is the SMI_HANDLER)
static UINT64 StartPeTimeStamp = 0;
UINT64 EndTimeStamp = 0;

static unsigned int VmPeReady = 0;
static unsigned int NMIReceived = 0;

// This function launches the VM/PE for each "run" 

void LaunchPeVm(UINT32 PeType, UINT32 CpuIndex)
{
	UINTN Rflags;
	UINTN InitStackPointer = 0;         // Initial Stack pointer
	// load the shared page and region list addresses into the register save area
	// so that the PE module will access to those addresses

	mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register.Rbx =
		(UINT64)PeVmData[PeType].UserModule.SharedPage & 0xFFFFFFFF;
	mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register.Rcx =
		(UINT64)PeVmData[PeType].UserModule.SharedPage >> 32;
	mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register.Rdx =
		(UINT32) PeVmData[PeType].UserModule.SharedStmPage;

	// check and make aure that the heap is cleared as requested

	if((PeVmData[PeType].UserModule.VmConfig & PERM_VM_CLEAR_MEMORY) == PERM_VM_CLEAR_MEMORY)
	{

		// addess and size calculations from setupModulepages
		UINTN StartEndBlock = PeVmData[PeType].UserModule.DataRegionSmmLoc;
		UINTN EndSize = PeVmData[PeType].UserModule.DataRegionSize;

		StartEndBlock += PeVmData[PeType].UserModule.DoNotClearSize;
		EndSize -= PeVmData[PeType].UserModule.DoNotClearSize;

		if(0 >= EndSize)
		{
			DEBUG((EFI_D_ERROR,
				"%ld LaunchPeVM - VM/PE heap space not cleared because of DoNotClearSize too large\n",
				CpuIndex));
		}
		else
		{
			DEBUG((EFI_D_INFO,
				"%ld LaunchPeVm - Clearing VM/PE heap space: 0x%016llx:0x%016llx\n",
				CpuIndex,
				StartEndBlock,
				EndSize ));

			ZeroMem ((VOID *)(UINTN)StartEndBlock, EndSize);
		}
	}

	// setup the variables that are used in case an SMI is taken
	// while the PE VM is running

	// this needs to be fixed if more than one PE/VM is running

	// when 1, a NMI has been sent to break the thread in PE_APIC_id
	PeSmiControl.PeNmiBreak = 1;

	// APIC id of the thread that is executing the PE V<
	PeSmiControl.PeApicId = ReadLocalApicId ();
	PeSmiControl.PeCpuIndex = CpuIndex;
	PeSmiControl.PeExec = 0;         // when 1 PE_APIC_ID is executing a
	VmPeReady = 0;                   // set the ready gate

	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVm - before check PeSmiState: %ld\n",
		CpuIndex,
		PeSmiControl.PeSmiState));

	if(InterlockedCompareExchange32(&PeSmiControl.PeSmiState, PESMIHSMI, PESMIHSMI) ==
							PESMIHSMI)  // try to set the NMI
	{
		// if we know that the SMI handler is already active, then don't continue
		// save the state, process the SMI, then start the VM/PE afterwards

		DEBUG((EFI_D_INFO,
			"%ld LaunchPeVM - SMI being processed - faking NMI - PeSmiState: %ld\n",
			CpuIndex,
			PeSmiControl.PeSmiState));
	}
	else
	{
		PeSmiControl.PeNmiBreak = 0;
		PeSmiControl.PeExec = 1;
		enable_nmi(); // turn on NMI
		// make sure we setup the NMI first
	}

	// Set InitialStack pointer to the top of User memory...

	InitStackPointer = (UINTN) PeVmData[PeType].UserModule.AddressSpaceStart +
			(UINTN) PeVmData[PeType].UserModule.AddressSpaceSize - (UINTN) 16;
	VmWriteN (VMCS_N_GUEST_RSP_INDEX, InitStackPointer);

	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVm- IntialStackPointer: 0x%llx\n",
		CpuIndex,
		InitStackPointer));
	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVm- VMCS_N_GUEST_RFLAGS_INDEX: %08llx\n",
		CpuIndex,
		VmReadN(VMCS_N_GUEST_RFLAGS_INDEX)));
	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVm- IA32_EFER_MSR: 0x%llx\n",
		CpuIndex,
		AsmReadMsr64 (IA32_EFER_MSR_INDEX)));
	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVm- VMCS_32_CONTROL_PIN_BASED_VM_EXECUTION_INDEX: 0x%llx\n",
		CpuIndex,
		VmRead32(VMCS_32_CONTROL_PIN_BASED_VM_EXECUTION_INDEX)));

	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVm- guest parameter regs:\n        RBX: %p (shared page - low)\n        RCX: %p (shared page - high)\n        RDX: %p (shared STM)\n",
		CpuIndex,
		mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register.Rbx,
		mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register.Rcx,
		mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register.Rdx));

	PeVmData[PeType].UserModule.RunCount++;
	// set the runcount into the STM shared page

	*((UINT64 *)(PeVmData[PeType].SharedPageStm + sizeof(UINT64))) =
			PeVmData[PeType].UserModule.RunCount;

	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVM - Initiating PE/VM run number: %d\n",
		CpuIndex,
		PeVmData[PeType].UserModule.RunCount));

	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVM - SharedPageStm 0x%016llx  0x%016llx\n",
		CpuIndex,
		*((UINT64 *)(PeVmData[PeType].SharedPageStm)),
		*((UINT64 *)(PeVmData[PeType].SharedPageStm + sizeof(UINT64)))));

	// Make sure we take the correct path upon RSM
	mHostContextCommon.HostContextPerCpu[CpuIndex].GuestVmType = PeType;

	StartPeTimeStamp = AsmReadTsc(); // set start time

	AsmWbinvd ();

	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVm - VmPE ready for launch PeType %d registers-address: 0x%016llx\n",
		CpuIndex,
		PeType,
		&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register ));

	// need to check to see if an SMI happend during this period
	// first incidcate that the VM/PE is ready for launch

	// this will cause the interrupt handler to save the VM/PE and
	// launch the VM/PE once the SMI is handled
	VmPeReady = 1;

	if(InterlockedCompareExchange32(&PeSmiControl.PeSmiState, PESMIPNMI, PESMIHSMI) == PESMIHSMI)
	{
		// if we are here, then an SMI has come in and the system is processing it
		// we need to get out and let the system process the SMI and then restart

		// PeSmiState = PESIMHSMI (2) means that the other processors are waitng for us to sync up 
		// so synch and then save up the state for when the processors come out of the SMI
		
		// This will cause the current PE/VM state to be saved and fake a return to the MLE
		// which will cause the SMI for this processor to be fired

		DEBUG((EFI_D_INFO,
			"%ld LaunchPeVM - SMI detected during build - delaying launch to handle SMI\n",
			CpuIndex));
		save_Inter_PeVm(CpuIndex);
		DEBUG((EFI_D_ERROR,
			"%ld LaunchPeVM - Warning: Return from non-returnable function\n",
			CpuIndex));
	}

	// check to see if we received an NMI during the build proceess -
	// if so, handle the SMI then launch
	if(NMIReceived > 1)
	{
		DEBUG((EFI_D_INFO,
			"%ld LaunchPeVM - NMI detected during build - delaying launch to handle SMI\n",
			CpuIndex));
		
		// This will cause the current PE/VM state to be saved and fake a return to the MLE
		// which will cause the SMI for this processor to be fired.  Since the NMI has been fired from one of
		// the other processors, they are waiting this processor to join up.

		save_Inter_PeVm(CpuIndex);
		DEBUG((EFI_D_ERROR,
			"%ld LaunchPeVM - Warning: Return from non-returnable function\n",
			CpuIndex));
		// this function should not return
	}

	DEBUG((EFI_D_INFO,
		"%ld LaunchPeVM - Launching PE/VM - NMIReceived: %d\n",
		CpuIndex,
		NMIReceived));

	Rflags = AsmVmLaunch (&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register);
	DEBUG ((EFI_D_ERROR, "%ld LaunchPeVm - (STM):o(\n", (UINTN)CpuIndex));
	DEBUG ((EFI_D_ERROR,
		"%ld LaunchPeVm - !!!LaunchGuestSmm fail for PeVm!!!\n",
		CpuIndex));
	DEBUG ((EFI_D_ERROR,
		"%ld LaunchPeVm - Rflags: (UINTN)CpuIndex, %08llx\n",
		CpuIndex,
		Rflags));
	DEBUG ((EFI_D_ERROR, "%ld LaunchPeVm - VMCS_32_RO_VM_INSTRUCTION_ERROR: %08x\n",
			(UINTN)CpuIndex,
			(UINTN)VmRead32 (VMCS_32_RO_VM_INSTRUCTION_ERROR_INDEX)));
	Rflags = AsmVmResume (&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register);
	
	// returing here means that the launch has failed...

	PeSmiControl.PeExec = 0;   // not any more

	AcquireSpinLock (&mHostContextCommon.DebugLock);

	DEBUG ((EFI_D_ERROR,
		"%ld LaunchPeVm - !!!ResumeGuestSmm fail for PeVm!!! - %d\n",
		(UINTN)CpuIndex));
	DEBUG ((EFI_D_ERROR,
		"%ld LaunchPeVm - Rflags: %08llx\n",
		(UINTN) CpuIndex,
		Rflags));
	DEBUG ((EFI_D_ERROR,
		"%ld LaunchPeVm - VMCS_32_RO_VM_INSTRUCTION_ERROR: %08x\n",
		(UINTN) CpuIndex,
		(UINTN)VmRead32 (VMCS_32_RO_VM_INSTRUCTION_ERROR_INDEX)));
	DumpVmcsAllField (CpuIndex);
	DumpRegContext (&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register,
			CpuIndex);
	ReleaseSpinLock (&mHostContextCommon.DebugLock);
}

// this function restarts a perm PE/VM
// we always start with the same "state" as the first launch

STM_STATUS RunPermVM(UINT32 CpuIndex)
{
	UINT32 rc;
	UINT32 PeType = PE_PERM;   // can only restart perm vms...

	// (for now) start the VM...

	DEBUG((EFI_D_INFO,
		"%ld RunPermVM entered\n",
		CpuIndex));

	if((PeVmData[PeType].PeVmState != PE_VM_IDLE) &&
	   (PeVmData[PeType].PeVmState != PE_VM_WAIT_START))
	{
		DEBUG((EFI_D_ERROR,
			"%ld RunPermVM - Can not run a Perm PE/VM\n",
			CpuIndex));
		if((PeVmData[PeType].PeVmState == PE_VM_ACTIVE) ||
			(PeVmData[PeType].PeVmState == PE_VM_SUSPEND))
		{
			rc = PE_VM_EXECUTING;
			DEBUG((EFI_D_ERROR,
				"%ld RunPermVM - Attempting to execute an already running Perm PE/VM\n",
				CpuIndex));
		}
		else
		{
			rc = PE_VM_NO_PERM_VM;
			DEBUG((EFI_D_ERROR,
				"%ld RunPermVM - Attempt to execute a non-existant PE/VM state: %d\n",
				CpuIndex,
				PeVmData[PeType].PeVmState));
		}
		return rc;
	}

	PeVmData[PeType].PeVmState = PE_VM_ACTIVE;

	if(PeVmData[PeType].StartMode == PEVM_PRESTART_SMI)
	{
		PeVmData[PeType].StartMode = PEVM_START_SMI;
	}
	else
	{
		PeVmData[PeType].StartMode = PEVM_START_VMCALL;
	}

	// setup the return

	rc =  SetupProtExecVm(CpuIndex,
				PeVmData[PE_PERM].UserModule.VmConfig,
				RESTART_VM,
				PeType); // can only restart PERM_VM

	if(rc != PE_SUCCESS)   // did we have a problem
	{
		DEBUG((EFI_D_ERROR,
			"%ld - Error in configuring PE VM\n",
			CpuIndex));
		PeVmData[PeType].PeVmState = PE_VM_AVAIL;
		return(rc);
	}

	LaunchPeVm(PeType, CpuIndex);  // Launch the PE/VM

	PeVmData[PE_PERM].PeVmState = PE_VM_AVAIL;  //  not there anymore
	mHostContextCommon.HostContextPerCpu[CpuIndex].GuestVmType = SMI_HANDLER;
	return rc;
}

// used to cleanup a VM when we are done
// PRESERVE_VM - ensures that the structures needed for the perminate PE VM are retained
// SUSPEND_VM  - VM has been interrupted by an SMI
// RELEASE_VM  - used to release the resources associated with a PE VM
//               used in cases of temp PE VM's and VM's that encounter errors

#define MSR_HSW_PLATFORM_INFO                  0xCE     // not in cpudef.h

UINT32  PostPeVmProc(UINT32 rc, UINT32 CpuIndex, UINT32 mode)
{
	UINTN             Rflags;
	X86_REGISTER       *Reg;
	//UINT64 EndTimeStamp = AsmReadTsc();
	UINT64 TotalPeTime  = EndTimeStamp - StartPeTimeStamp;
	UINT32 PeType = mHostContextCommon.HostContextPerCpu[CpuIndex].GuestVmType;
	UINT64 Scale;
	UINT64 TotalScaleTime;
	MSR_PLATFORM_INFO_DATA PlatformData;

	PlatformData.Uint64 = AsmReadMsr64(MSR_HSW_PLATFORM_INFO);

	Scale = MultU64x32(PlatformData.Bits.MaxNonTurboRatio, 100000);

	TotalScaleTime = DivU64x32(TotalPeTime, (UINT32) Scale);
	DEBUG((EFI_D_INFO,
		"%ld PostPeVmProc - Platform Data - Max Ratio: %d\n",
		CpuIndex,
		PlatformData.Bits.MaxNonTurboRatio));
	DEBUG((EFI_D_INFO,
		"%ld PostPeVmProc - TSC Info - StartPeTimeStamp: %ld  EndTimeStamp: %ld\n",
		CpuIndex,
		StartPeTimeStamp,
		EndTimeStamp));
	DEBUG((EFI_D_INFO,
		"%ld PostPeVmProc - PeType: %d mode: %d PE clocktime: %ld runtime(scaled): %ldms\n",
		CpuIndex,
		PeType,
		mode,
		TotalPeTime,
		TotalScaleTime));

	switch (rc)
	{
	case PE_VM_ATTEMPTED_VMCALL:
	case PE_VMLAUNCH_ERROR:
	case PE_VM_PAGE_FAULT:
	case PE_VM_GP_FAULT:
	case PE_VM_NMI:
	case PE_VM_CPUID:
	case PE_VM_IO:
	case PE_VM_READ_MSR:
	case PE_VM_WRITE_MSR:
	case PE_VM_BAD_ACCESS:
	case PE_VM_TRIPLE_FAULT:
	case PE_VM_EXCEPTION:
		DumpVmcsAllField(CpuIndex);   //  temp debug
		DumpVmxCapabillityMsr(CpuIndex);
		DumpRegContext(&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register,
			CpuIndex);
		print_region_list(PeType, CpuIndex);

		if((PERM_VM_CRASH_BREAKDOWN & PeVmData[PeType].UserModule.VmConfig) ==
				PERM_VM_CRASH_BREAKDOWN)
		{
			// user wants perm vm released after crash
			mode = RELEASE_VM;
			DEBUG((EFI_D_INFO,
				"%ld PostPeVmProc - Perm VM configured to be released after crash\n",
				CpuIndex));
		}
		else
		{
			mode = PRESERVE_VM;
		}
		break;
	default:
		// print out vm state during debug
		{
#if EFI_D_ERROR == 1
			DumpVmcsAllField();
			print_region_list(PeType, CpuIndex);
#endif
		}
	}
	// indicate that we are not running

	PeSmiControl.PeExec = 0;
	// bug - think about this one....
	PeSmiControl.PeSmiState = PESMINULL;   // indicate that we are out of it

	if(mode == PRESERVE_VM)
	{
		if((PERM_VM_RUN_ONCE & PeVmData[PeType].UserModule.VmConfig) ==
			PERM_VM_RUN_ONCE)
		{
			// user wants perm vm released after crash
			mode = RELEASE_VM;
			DEBUG ((EFI_D_INFO,
				"%ld PostPeVmProc - Perm VM configured to run only once\n",
				CpuIndex));

			 // indicate none functioning at this momemnet
			PeSmiControl.PeCpuIndex = -1;
		}
		else
		{
			if((PERM_VM_RUN_PERIODIC & PeVmData[PeType].UserModule.VmConfig) ==
				PERM_VM_RUN_PERIODIC)
			{
				// the PE/VM is running in periodic mode
				DEBUG((EFI_D_INFO,
					"%ld PostPeVmProc - Perm VM being setup for Timer interrupt\n",
					CpuIndex));
				PeSmiControl.PeCpuIndex = CpuIndex;
				//
				PeSmiControl.PeWaitTimer = 1;
				PeVmData[PeType].PeVmState = PE_VM_IDLE;

				// turn on the timer

				SetTimerRate(PeriodicSmi16Sec);
				StartTimer();

				AckTimer();
			}
		}
	}

	// Suspend the PE/VM and start the SMI Handler.
	if(mode == SUSPEND_VM)
	{
		// suspending PE/VM so that SMI handler can run

		PeVmData[PeType].PeVmState = PE_VM_SUSPEND;
		DEBUG((EFI_D_INFO,
			"%ld PostPeVmProc - PE/VM suspended - PeType: %ld\n",
			CpuIndex,
			PeType));

		// we will fake a return to the MLE -
		// that will cause the pending SMI to fire allowing
		// the smiEvent handler to process it and release all
		// he processor threads
		// to handle the SMI

		AsmVmPtrLoad(&mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Vmcs);

		/// at this point we should return to the MLE as per the Intel method...

		AsmVmClear(&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Vmcs);

		DEBUG ((EFI_D_INFO,
			"%ld PostPeVmProc - !!exiting to allow SMI to fire to Enter SmiHandler\n",
			CpuIndex));

		mHostContextCommon.HostContextPerCpu[CpuIndex].GuestVmType = SMI_HANDLER;
		if (mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Launched) {
			Rflags = AsmVmResume (&mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Register);
			// BUGBUG: - AsmVmLaunch if AsmVmResume fail
			if (VmRead32 (VMCS_32_RO_VM_INSTRUCTION_ERROR_INDEX) ==
				VmxFailErrorVmResumeWithNonLaunchedVmcs) {
				    DEBUG ((EFI_D_ERROR, "%ld :-(\n", (UINTN)CpuIndex));
				Rflags = AsmVmLaunch (&mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Register);
			}
		} else {
			mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Launched = TRUE;
			Rflags = AsmVmLaunch (&mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Register);
			DEBUG ((EFI_D_ERROR, "PostPeVmProc - somehow we did not launch\n"));
			mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Launched = FALSE;
		}
		DEBUG ((EFI_D_ERROR, "%ld PostPeVmProc - Problem in SMI during VM/PE\n", CpuIndex));
	}
	else
	{
		// set the MLE VMCS into place

		AsmVmPtrLoad(&mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Vmcs);

		/// at this point we should return to the MLE as per the Intel method...

		AsmVmClear(&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Vmcs);

		if(PeVmData[PeType].StartMode == PEVM_START_VMCALL)
		{
			// fixup return address

			DEBUG((EFI_D_INFO,
				"%ld PostPeVmProc - PE/VM guest return address bumped\n",
				CpuIndex));
			VmWriteN (VMCS_N_GUEST_RIP_INDEX,
				VmReadN (VMCS_N_GUEST_RIP_INDEX) +
				VmRead32 (VMCS_32_RO_VMEXIT_INSTRUCTION_LENGTH_INDEX));
		}
	}
	// clear out the page table list
	if(mode == RELEASE_VM)
	{
		FreePE_DataStructures(PeType);
		// need to add code here in the instance a perm PE VM has crashed
		// so that in production someone cannot take advantange of this case
		PeVmData[PeType].PeVmState = PE_VM_AVAIL;  //  not there anymore
		PeSmiControl.PeCpuIndex = -1;    // indicate none functioning at this momemnet 
		DEBUG((EFI_D_INFO,
			"%ld PostPeVmProc - PE/VM Free (AVAIL) - PeType: %ld\n",
			CpuIndex,
			PeType));
	}
	else
	{
		// mark this VM as idle

		PeVmData[PeType].PeVmState = PE_VM_IDLE;  // Waiting for more action
		DEBUG((EFI_D_INFO,
			"%ld PostPeVmProc - PE/VM Idle - PeType: %ld\n",
			CpuIndex,
			PeType));
	}

	if(PeVmData[PeType].StartMode == PEVM_START_VMCALL)
	{
		// setup the return codes

		Reg = &mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Register;

		WriteUnaligned32 ((UINT32 *)&Reg->Rax, rc);
		if (rc == PE_SUCCESS) 
		{
			VmWriteN (VMCS_N_GUEST_RFLAGS_INDEX,
				VmReadN(VMCS_N_GUEST_RFLAGS_INDEX) & ~RFLAGS_CF);
		} 
		else 
		{
			DEBUG((EFI_D_INFO,
				"%ld PostPeVmProc - Unsucessful return noted in RFLAGS_CF\n",
				CpuIndex));
			VmWriteN (VMCS_N_GUEST_RFLAGS_INDEX,
				VmReadN(VMCS_N_GUEST_RFLAGS_INDEX) | RFLAGS_CF);
		}
	}

	mHostContextCommon.HostContextPerCpu[CpuIndex].GuestVmType = SMI_HANDLER;
	DEBUG((EFI_D_INFO,
		 "%ld PostPeVmProc - sucessfully completed - RC: 0x%x\n",
		CpuIndex,
		rc));
	CheckPendingMtf (CpuIndex);

	//
	// Launch back
	//
	Rflags = AsmVmResume (&mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Register);
	// BUGBUG: - AsmVmLaunch if AsmVmResume fail
	if (VmRead32 (VMCS_32_RO_VM_INSTRUCTION_ERROR_INDEX) ==
			VmxFailErrorVmResumeWithNonLaunchedVmcs) {
		DEBUG ((EFI_D_ERROR,
			"%ld PostPeVmProc - Rflags: %08x\n",
			CpuIndex,
			Rflags));
		DEBUG ((EFI_D_ERROR,
			"%ld PostPeVmProc - VMCS_32_RO_VM_INSTRUCTION_ERROR: %08x\n",
			CpuIndex,
			(UINTN)VmRead32 (VMCS_32_RO_VM_INSTRUCTION_ERROR_INDEX)));
		DEBUG ((EFI_D_ERROR,
			"%ld PostPeVmProc - (STM):o(\n",
			(UINTN)CpuIndex));
		Rflags = AsmVmLaunch (&mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Register);
	}

	AcquireSpinLock (&mHostContextCommon.DebugLock);
	DEBUG ((EFI_D_ERROR,
		"%ld PostPeVmProc - !!!PePostVmProcessing FAIL!!!\n",
		CpuIndex));
	DEBUG ((EFI_D_ERROR,
		"%ld PostPeVmProc - Rflags: %08x\n",
		CpuIndex,
		Rflags));
	DEBUG ((EFI_D_ERROR,
		"%ld PostPeVmProc - VMCS_32_RO_VM_INSTRUCTION_ERROR: %08x\n",
		CpuIndex,
		(UINTN)VmRead32 (VMCS_32_RO_VM_INSTRUCTION_ERROR_INDEX)));

	DumpVmcsAllField (CpuIndex);
	DumpRegContext (&mGuestContextCommonSmi.GuestContextPerCpu[CpuIndex].Register,
			CpuIndex);
	ReleaseSpinLock (&mHostContextCommon.DebugLock);
	DEBUG((EFI_D_ERROR, "%ld PostPeVmProc - CpuDeadLoop\n"));
	CpuDeadLoop ();  // crash here because we cannot get back to the MLE...

	// check to see if there is a path through the intel code
	// for going back to the MLE

	return rc;    // always succeed
}
// standard function used to free the memory, etc associated with a PE VM

UINT32 FreePE_DataStructures(UINT32 PeType)
{
	// first clear out the pages

	if(PeVmData[PeType].SmmBuffer != NULL)
	{
		FreePages(PeVmData[PeType].SmmBuffer, PeVmData[PeType].SmmBufferSize);
		PeVmData[PeType].SmmBuffer = 0;
		PeVmData[PeType].SmmBufferSize = 0;
	}
	if(mGuestContextCommonSmm[PeType].EptPointer.Uint64 != 0)
	{
		PeEptFree(mGuestContextCommonSmm[PeType].EptPointer.Uint64);
		mGuestContextCommonSmm[PeType].EptPointer.Uint64 = 0;
	}

	if(PeVmData[PeType].SharedPageStm != NULL)
	{
		FreePages(PeVmData[PeType].SharedPageStm, 1);
		PeVmData[PeType].SharedPageStm = 0;
	}

	return STM_SUCCESS;
}

//setup the  guest physical address space assigned for the module to be RWX
// the remainder of guest physical addrss space will be setup as RW.

UINT32 save_Inter_PeVm(UINT32 CpuIndex)
{
	// come here when the VM has been interrupted by an SMI
	// setup for the call to PostPeVmProc

	// which PT are we using
	UINT32 PeType = mHostContextCommon.HostContextPerCpu[CpuIndex].GuestVmType;

	// let the STM know that we are waiting to come back
	mHostContextCommon.HostContextPerCpu[CpuIndex].NonSmiHandler = PeType;

	EndTimeStamp = AsmReadTsc();
	
	DEBUG((EFI_D_INFO,
		"%ld save_Inter_PeVm - sucessfully completed\n",
		CpuIndex));

	PostPeVmProc(PE_SUCCESS, CpuIndex, SUSPEND_VM);

	return STM_SUCCESS;    // always succeed
}

UINT32 RestoreInterPeVm(UINT32 CpuIndex, UINT32 PeType)
{
	UINT32 rc = STM_SUCCESS;
	UINTN  Rflags;

	// restores a VM after an SMI

	if(GetMPState == 1)
	{
		// should only happen when the PEV/VM is initially loaded, otherwise
		// this informaition should be normally grabbed upon a smi timer interrupt
		// bug -
		//  need to consider the case of debug loading of a module for testing

		if(GetMultiProcessorState(CpuIndex) == -1)
		{
			// Indicate that we still need to get the processor state
			GetMPState = 1;

			// in this case there is an SMI in process and
			// we need to let it be processed.

			return 1;
		}
		else
		{
			//Success - got the processor state
			GetMPState = 0;
		}
	}

	if(InterlockedCompareExchange32(&PeSmiControl.PeSmiState,
					PESMIHSMI, PESMIHSMI) == PESMIHSMI)
	{
		DEBUG((EFI_D_INFO,
			"%ld RestoreInterPeVm - SMI in progress - aborting PE/VM restart\n",
			CpuIndex));
		return 1;
	}

	// need to think about locking here in case there are two smi's in a row...
	PeVmData[PeType].PeVmState = PE_VM_ACTIVE;

	// when 1, a NMI has been sent to break the thread in PE_APIC_id
	PeSmiControl.PeNmiBreak = 1;

	// APIC id of the thread that is executing the PE V<
	PeSmiControl.PeApicId   = ReadLocalApicId ();

	PeSmiControl.PeCpuIndex   = CpuIndex;
	
	// think about break code (BUG)

	// set the ready gate (for here do not get out
	// (BUG - Review this!!! for SMI in this interval)
	VmPeReady = 0;
	enable_nmi();              // turn on NMI

	// when 1, a NMI has been sent to break the thread in PE_APIC_id
	PeSmiControl.PeNmiBreak = 0;
	PeSmiControl.PeExec = 1;         // when 1 PE_APIC_ID is executing a 
	// setup the return

	AsmVmPtrLoad(&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Vmcs);
	mHostContextCommon.HostContextPerCpu[CpuIndex].GuestVmType = PeType;

	DEBUG((EFI_D_INFO,
		"%ld RestoreInterPeVm - setup done, launching PE/VM\n",
		CpuIndex));
	// Launch back
	//
	Rflags = AsmVmResume (&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register);
	// BUGBUG: - AsmVmLaunch if AsmVmResume fail
	if (VmRead32 (VMCS_32_RO_VM_INSTRUCTION_ERROR_INDEX) ==
		VmxFailErrorVmResumeWithNonLaunchedVmcs) {
		//    DEBUG ((EFI_D_ERROR, "(STM):o(\n", (UINTN)Index));
		Rflags = AsmVmLaunch (&mGuestContextCommonSmm[PeType].GuestContextPerCpu[0].Register);
	}

	return rc;
}

void print_region_list(UINT32 PeType, UINT32 CpuIndex)
{
	int counter;
	PE_REGION_LIST * rlist;
	UINT64 EndAddress;
	//UINT32 CpuIndex = (UINT32) GetCpuNumFromAcpi();

	rlist = PeVmData[PeType].UserModule.Segment;  // start the list

	if(rlist == NULL)
	{
		DEBUG((EFI_D_INFO, "%ld - No region list\n", CpuIndex));
		return;
	}

	DEBUG((EFI_D_INFO, "%ld --- Region List --- \n", CpuIndex));

	for(counter = 0; counter < (4096/sizeof(PE_REGION_LIST)); counter++)
	{
		if(rlist[counter].Address == (UINT64) 0)
		{ 
			DEBUG((EFI_D_INFO,
				"%ld Finish scanning Region List - %d elements found\n",
				CpuIndex,
				counter));
			break;  // done at end of list
		}

		EndAddress = rlist[counter].Address + rlist[counter].Size;
		DEBUG((EFI_D_INFO,
			"%ld region set at 0x%016llx:%016llx - size 0x%016lx\n",
			CpuIndex,
			rlist[counter].Address,
			EndAddress,
			rlist[counter].Size));
	}
}

void enable_nmi()
{
	UINT32 Index = 2;    // need to
	RegisterExceptionHandler (Index, NullExceptionHandler);
	NMIReceived = 0;
	AsmSendInt2();        // setup NMI
	// reset because we received an NMI because of the previous instruction
	// BUG - might have to review this to ensure that NMIReceived is set to zero after
	//       the interrupt is fired

	while(NMIReceived == 0) {} // wait for NMI interrupt
	DEBUG((EFI_D_INFO,
		"NMI handler active\n"));
}

VOID
	EFIAPI
	NullExceptionHandler (
	IN EFI_EXCEPTION_TYPE   InterruptType, 
	IN EFI_SYSTEM_CONTEXT   SystemContext
	)
{
	NMIReceived = NMIReceived + 1;   // increment
	//DEBUG((EFI_D_INFO, "***NMI***Happened****\n"));

	if(VmPeReady == 1)
	{

		UINT32 CpuIndex = ApicToIndex (ReadLocalApicId ());
		// in this instance, the VmPe is ready for launch,
		// but an SMI has appeared after the NMI has
		// been enabled, but during the iterval between
		// VM/PE setup complete and its launch
		// so we will hold the launch, service the SMI and
		// then launch the VM/PE once the
		// SMI is handled

		save_Inter_PeVm(CpuIndex);
		DEBUG((EFI_D_INFO,
			"%ld enable_nmi - Return from non-returnable function\n",
			CpuIndex));

		// this function should not return... 
	}
	return;   // basically we are ignoring NMI, but setting a flag that it occurred
}

// Initialization code goes here - ran everytime that StmInit is run

static STM_GUEST_CONTEXT_PER_CPU   GuestContext[3];
extern void PeInitStmHandlerSmm ();

void InitPe()
{
	unsigned int i;
	DEBUG((EFI_D_INFO,
		"InitPe - Starting PE initiaization\n"));
	mGuestContextCommonSmm[1].GuestContextPerCpu   = &GuestContext[0];
	mGuestContextCommonSmm[2].GuestContextPerCpu   = &GuestContext[1];
	mGuestContextCommonSmm[3].GuestContextPerCpu   = &GuestContext[2];

	// initialize the VM/PE memory pointer to null

	for(i = 0; i < 4; i++)
	{
		PeVmData[i].SharedPageStm = 0;
		PeVmData[i].SmmBuffer = 0;
		PeVmData[i].SmmBufferSize = 0;
		PeVmData[i].PeVmState = PE_VM_AVAIL;
	}

	PeSmiControl.PeExec     = 0;
	PeSmiControl.PeNmiBreak = 0;
	PeSmiControl.PeCpuIndex = -1;
	PeSmiControl.PeSmiState = 0;
	PeSmiControl.PeWaitTimer = 0;   // non-zero reflect timer length and active

	PeInitStmHandlerSmm ();

	InitializeSpinLock (&PeSmiControl.PeSmiControlLock);

	DEBUG((EFI_D_INFO, "InitPe - PE initialization complete\n"));
}
