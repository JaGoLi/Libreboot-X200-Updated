/* SPDX-License-Identifier: GPL-2.0-only */

/* The APM port can be used for generating software SMIs */

OperationRegion (APMP, SystemIO, 0xb2, 2)
Field (APMP, ByteAcc, NoLock, Preserve)
{
	APMC, 8,	// APM command
	APMS, 8		// APM status
}

/* Port 80 POST */

OperationRegion (POST, SystemIO, 0x80, 1)
Field (POST, ByteAcc, Lock, Preserve)
{
	DBG0, 8
}

/* SMI I/O Trap */
Method(TRAP, 1, Serialized)
{
	SMIF = Arg0	// SMI Function
	TRP0 = 0		// Generate trap
	Return (SMIF)		// Return value of SMI handler
}

/* The _PIC method is called by the OS to choose between interrupt
 * routing via the i8259 interrupt controller or the APIC.
 *
 * _PIC is called with a parameter of 0 for i8259 configuration and
 * with a parameter of 1 for Local Apic/IOAPIC configuration.
 */

Method(_PIC, 1)
{
	// Remember the OS' IRQ routing choice.
	PICM = Arg0
}

Method(GOS, 0)
{
	/* Determine the Operating System and save the value in OSYS.
	 * We have to do this in order to be able to work around
	 * certain windows bugs.
	 *
	 *    OSYS value | Operating System
	 *    -----------+------------------
	 *       2000    | Windows 2000
	 *       2001    | Windows XP(+SP1)
	 *       2002    | Windows XP SP2
	 *       2006    | Windows Vista
	 *       ????    | Windows 7
	 */

	/* Let's assume we're running at least Windows 2000 */
	OSYS = 2000

	If (CondRefOf(_OSI)) {
		If (_OSI("Windows 2001")) {
			OSYS = 2001
		}

		If (_OSI("Windows 2001 SP1")) {
			OSYS = 2001
		}

		If (_OSI("Windows 2001 SP2")) {
			OSYS = 2002
		}

		If (_OSI("Windows 2006")) {
			OSYS = 2006
		}
	}
}
