/* SPDX-License-Identifier: GPL-2.0-only */

// Intel PCI to PCI bridge 0:1e.0

Device (PCIB)
{
	Name (_ADR, 0x001E0000)  // _ADR: Address
	Name (_PRW, Package(){ 13, 4 }) // Power Resources for Wake

	Method (_PRT)  // _PRT: PCI Interrupt Routing Table
	{
		If (PICM) {
			Return (Package() {
				Package() { 0x0001ffff, 0, 0, 0x13 },
				Package() { 0x0001ffff, 1, 0, 0x12 },
				Package() { 0x0001ffff, 2, 0, 0x10 },
				Package() { 0x0001ffff, 3, 0, 0x14 },
#if CONFIG(BOARD_GIGABYTE_GA_B75_D3V)
				Package() { 0x0002ffff, 0, 0, 0x12 },
				Package() { 0x0002ffff, 1, 0, 0x10 },
				Package() { 0x0002ffff, 2, 0, 0x14 },
				Package() { 0x0002ffff, 3, 0, 0x13 },
#endif
			})
		}
		Return (Package() {
			Package() { 0x0001ffff, 0, \_SB.PCI0.LPCB.LNKD, 0 },
			Package() { 0x0001ffff, 1, \_SB.PCI0.LPCB.LNKC, 0 },
			Package() { 0x0001ffff, 2, \_SB.PCI0.LPCB.LNKA, 0 },
			Package() { 0x0001ffff, 3, \_SB.PCI0.LPCB.LNKE, 0 },
#if CONFIG(BOARD_GIGABYTE_GA_B75_D3V)
			Package() { 0x0002ffff, 0, \_SB.PCI0.LPCB.LNKC, 0 },
			Package() { 0x0002ffff, 1, \_SB.PCI0.LPCB.LNKA, 0 },
			Package() { 0x0002ffff, 2, \_SB.PCI0.LPCB.LNKE, 0 },
			Package() { 0x0001ffff, 3, \_SB.PCI0.LPCB.LNKD, 0 },
#endif
		})
	}
}
