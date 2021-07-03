/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef DPTF_CPU_PASSIVE
#define DPTF_CPU_PASSIVE	80
#endif

#ifndef DPTF_CPU_CRITICAL
#define DPTF_CPU_CRITICAL	90
#endif

#ifndef DPTF_CPU_ACTIVE_AC0
#define DPTF_CPU_ACTIVE_AC0	90
#endif

#ifndef DPTF_CPU_ACTIVE_AC1
#define DPTF_CPU_ACTIVE_AC1	80
#endif

#ifndef DPTF_CPU_ACTIVE_AC2
#define DPTF_CPU_ACTIVE_AC2	70
#endif

#ifndef DPTF_CPU_ACTIVE_AC3
#define DPTF_CPU_ACTIVE_AC3	60
#endif

#ifndef DPTF_CPU_ACTIVE_AC4
#define DPTF_CPU_ACTIVE_AC4	50
#endif

External (\_SB.CP00._TSS, MethodObj)
External (\_SB.CP00._TPC, MethodObj)
External (\_SB.CP00._PTC, PkgObj)
External (\_SB.CP00._TSD, PkgObj)
External (\_SB.CP00._PSS, MethodObj)

Device (B0DB)
{
	Name (_ADR, 0x000B0000)  /* Bus 0, Device B, Function 0 */

	Method (_STA)
	{
		If (\DPTE == 1) {
			Return (0xF)
		} Else {
			Return (0x0)
		}
	}

	/*
	 * Processor Throttling Controls
	 */

	Method (_TSS)
	{
		If (CondRefOf (\_SB.CP00._TSS)) {
			Return (\_SB.CP00._TSS)
		} Else {
			Return (Package ()
			{
				Package () { 0, 0, 0, 0, 0 }
			})
		}
	}

	Method (_TPC)
	{
		If (CondRefOf (\_SB.CP00._TPC)) {
			Return (\_SB.CP00._TPC)
		} Else {
			Return (0)
		}
	}

	Method (_PTC)
	{
		If (CondRefOf (\_SB.CP00._PTC)) {
			Return (\_SB.CP00._PTC)
		} Else {
			Return (Package ()
			{
				Buffer () { 0 },
				Buffer () { 0 }
			})
		}
	}

	Method (_TSD)
	{
		If (CondRefOf (\_SB.CP00._TSD)) {
			Return (\_SB.CP00._TSD)
		} Else {
			Return (Package ()
			{
				Package () { 5, 0, 0, 0, 0 }
			})
		}
	}

	Method (_TDL)
	{
		If (CondRefOf (\_SB.CP00._TSS)) {
			Local0 = SizeOf (\_SB.CP00._TSS ())
			Local0--
			Return (Local0)
		} Else {
			Return (0)
		}
	}

	/*
	 * Processor Performance Control
	 */

	Method (_PPC)
	{
		Return (0)
	}

	Method (SPPC, 1)
	{
		\PPCM = Arg0

		/* Notify OS to re-read _PPC limit on each CPU */
		\PPCN ()
	}

	Method (_PSS)
	{
		If (CondRefOf (\_SB.CP00._PSS)) {
			Return (\_SB.CP00._PSS)
		} Else {
			Return (Package ()
			{
				Package () { 0, 0, 0, 0, 0, 0 }
			})
		}
	}

	Method (_PDL)
	{
		/* Check for mainboard specific _PDL override */
		If (CondRefOf (\_SB.MPDL)) {
			Return (\_SB.MPDL)
		} ElseIf (CondRefOf (\_SB.CP00._PSS)) {
			Local0 = SizeOf (\_SB.CP00._PSS ())
			Local0--
			Return (Local0)
		} Else {
			Return (0)
		}
	}

	/* Return PPCC table defined by Terra2 or Terra3 mainboard */
	Method (PPCC)
	{
		If (\_SB.GPID == TERRA2_PROJECT_ID)
		{
			Return (\_SB.PPT2)
		} Else {
			Return (\_SB.PPT3)
		}
	}

	/* Return critical thermal point defined by Terra2 or Terra3 mainboard */
	Method (_CRT)
	{
		If (\_SB.GPID == TERRA2_PROJECT_ID)
		{
			Return (\_SB.DPTF.CTOK(DPTF_TERRA2_CPU_CRITICAL))
		} Else {
			Return (\_SB.DPTF.CTOK(DPTF_TERRA3_CPU_CRITICAL))
		}
	}

	/* Return passive thermal point defined by Terra2 or Terra3 mainboard */
	Method (_PSV)
	{
		If (\_SB.GPID == TERRA2_PROJECT_ID)
		{
			Return (\_SB.DPTF.CTOK(DPTF_TERRA2_CPU_PASSIVE))
		} Else {
			Return (\_SB.DPTF.CTOK(DPTF_TERRA3_CPU_PASSIVE))
		}
	}

	Method (_AC0)
	{
		Return (\_SB.DPTF.CTOK(DPTF_CPU_ACTIVE_AC0))
	}

	Method (_AC1)
	{
		Return (\_SB.DPTF.CTOK(DPTF_CPU_ACTIVE_AC1))
	}

	Method (_AC2)
	{
		Return (\_SB.DPTF.CTOK(DPTF_CPU_ACTIVE_AC2))
	}

	Method (_AC3)
	{
		Return (\_SB.DPTF.CTOK(DPTF_CPU_ACTIVE_AC3))
	}

	Method (_AC4)
	{
		Return (\_SB.DPTF.CTOK(DPTF_CPU_ACTIVE_AC4))
	}
}
