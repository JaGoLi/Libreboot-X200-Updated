DefinitionBlock(
 "dsdt.aml",
 "DSDT",
 0x02,
 "COREv4",
 "COREBOOT",
 0x20090419
)
{
Method(_PTS,1)
{
 \_SB.PCI0.LPCB.EC.MUTE(1)
 \_SB.PCI0.LPCB.EC.USBP(0)
 \_SB.PCI0.LPCB.EC.RADI(0)
}
Method(_WAK,1)
{
 \_SB.PCI0.LPCB.EC.HKEY.WAKE (Arg0)
 If (LEqual(Arg0, 3)) {
 }
 If (LEqual(Arg0, 4)) {
 }
 Return(Package(){0,0})
}
Scope(\_SB)
{
 Method(_INI, 0)
 {
  \GOS()
  If (LAnd(LEqual(OSYS, 2001), MPEN)) {
  }
 }
}
Name(\PICM, 0)
External(NVSA)
OperationRegion (GNVS, SystemMemory, NVSA, 0x100)
Field (GNVS, ByteAcc, NoLock, Preserve)
{
 Offset (0x00),
 OSYS, 16,
 SMIF, 8,
 PRM0, 8,
 PRM1, 8,
 SCIF, 8,
 PRM2, 8,
 PRM3, 8,
 LCKF, 8,
 PRM4, 8,
 PRM5, 8,
 P80D, 32,
 LIDS, 8,
 PWRS, 8,
 DBGS, 8,
 LINX, 8,
 DCKN, 8,
 Offset (0x14),
 ACTT, 8,
 TPSV, 8,
 TC1V, 8,
 TC2V, 8,
 TSPV, 8,
 TCRT, 8,
 DTSE, 8,
 DTS1, 8,
 FLVL, 8,
 Offset (0x1e),
 BNUM, 8,
 B0SC, 8,
 B1SC, 8,
 B2SC, 8,
 B0SS, 8,
 B1SS, 8,
 B2SS, 8,
 Offset (0x28),
 APIC, 8,
 MPEN, 8,
 PCP0, 8,
 PCP1, 8,
 PPCM, 8,
 Offset (0x32),
 NATP, 8,
 CMAP, 8,
 CMBP, 8,
 LPTP, 8,
 FDCP, 8,
 RFDV, 8,
 HOTK, 8,
 RTCF, 8,
 UTIL, 8,
 ACIN, 8,
 Offset (0x3c),
 IGDS, 8,
 TLST, 8,
 CADL, 8,
 PADL, 8,
 Offset (0x64),
 BLCS, 8,
 BRTL, 8,
 ODDS, 8,
 Offset (0x6e),
 ALSE, 8,
 ALAF, 8,
 LLOW, 8,
 LHIH, 8,
 Offset (0x78),
 EMAE, 8,
 EMAP, 16,
 EMAL, 16,
 Offset (0x82),
 MEFE, 8,
 Offset (0x8c),
 TPMP, 8,
 TPME, 8,
 Offset (0x96),
 GTF0, 56,
 GTF1, 56,
 GTF2, 56,
 IDEM, 8,
 IDET, 8,
 Offset (0xb4),
 ASLB, 32,
 IBTT, 8,
 IPAT, 8,
 ITVF, 8,
 ITVM, 8,
 IPSC, 8,
 IBLC, 8,
 IBIA, 8,
 ISSC, 8,
 I409, 8,
 I509, 8,
 I609, 8,
 I709, 8,
 IDMM, 8,
 IDMS, 8,
 IF1E, 8,
 HVCO, 8,
 NXD1, 32,
 NXD2, 32,
 NXD3, 32,
 NXD4, 32,
 NXD5, 32,
 NXD6, 32,
 NXD7, 32,
 NXD8, 32,
 Offset (0xf0),
 DOCK, 8,
 BTEN, 8,
}
OperationRegion (APMP, SystemIO, 0xb2, 2)
Field (APMP, ByteAcc, NoLock, Preserve)
{
 APMC, 8,
 APMS, 8
}
OperationRegion (POST, SystemIO, 0x80, 1)
Field (POST, ByteAcc, Lock, Preserve)
{
 DBG0, 8
}
Method(TRAP, 1, Serialized)
{
 Store (Arg0, SMIF)
 Store (0, TRP0)
 Return (SMIF)
}
Method(_PIC, 1)
{
 Store(Arg0, PICM)
}
Method(GOS, 0)
{
 Store (2000, OSYS)
 If (CondRefOf(_OSI)) {
  If (_OSI("Windows 2001")) {
   Store (2001, OSYS)
  }
  If (_OSI("Windows 2001 SP1")) {
   Store (2001, OSYS)
  }
  If (_OSI("Windows 2001.1")) {
   Store (2001, OSYS)
  }
  If (_OSI("Windows 2001.1 SP1")) {
   Store (2001, OSYS)
  }
  If (_OSI("Windows 2001 SP2")) {
   Store (2002, OSYS)
  }
  If (_OSI("Windows 2006")) {
   Store (2006, OSYS)
  }
  If (_OSI("Windows 2006 SP1")) {
   Store (2006, OSYS)
  }
  If (_OSI("Windows 2006.1")) {
   Store (2006, OSYS)
  }
  If (_OSI("Windows 2009")) {
   Store (2009, OSYS)
  }
  If (_OSI("Windows 2012")) {
   Store (2012, OSYS)
  }
 }
}
Scope (\_GPE)
{
 Method(_L18, 0, NotSerialized)
 {
  Store(\_SB.PCI0.LPCB.EC.WAKE, Local0)
  Increment (Local0)
 }
}
External (\_SB.CNOT, MethodObj)
External (\_SB_.CP00, DeviceObj)
External (\_SB_.CP00._PPC)
External (\_SB_.CP01._PPC)
Method (PNOT)
{
 If (MPEN) {
  \_SB.CNOT (0x80)
  Sleep(100)
  \_SB.CNOT (0x81)
 } Else {
  Notify (\_SB_.CP00, 0x80)
  Sleep(0x64)
  Notify(\_SB_.CP00, 0x81)
 }
}
 Scope (\_SB) {
  Device (PCI0)
  {
Name(_HID,EISAID("PNP0A08"))
Name(_CID,EISAID("PNP0A03"))
Name(_BBN, 0)
Device (MCHC)
{
 Name(_ADR, 0x00000000)
 OperationRegion(MCHP, PCI_Config, 0x00, 0x100)
 Field (MCHP, DWordAcc, NoLock, Preserve)
 {
  Offset (0x40),
  EPEN, 1,
  , 11,
  EPBR, 24,
  Offset (0x48),
  MHEN, 1,
  , 13,
  MHBR, 22,
  Offset (0x60),
  PXEN, 1,
  PXSZ, 2,
  , 23,
  PXBR, 10,
  Offset (0x68),
  DMEN, 1,
  , 11,
  DMBR, 24,
  Offset (0x90),
  , 4,
  PM0H, 2,
  , 2,
  Offset (0x91),
  PM1L, 2,
  , 2,
  PM1H, 2,
  , 2,
  Offset (0x92),
  PM2L, 2,
  , 2,
  PM2H, 2,
  , 2,
  Offset (0x93),
  PM3L, 2,
  , 2,
  PM3H, 2,
  , 2,
  Offset (0x94),
  PM4L, 2,
  , 2,
  PM4H, 2,
  , 2,
  Offset (0x95),
  PM5L, 2,
  , 2,
  PM5H, 2,
  , 2,
  Offset (0x96),
  PM6L, 2,
  , 2,
  PM6H, 2,
  , 2,
  Offset (0xa0),
  TOM, 8,
  Offset (0xb0),
  , 4,
  TLUD, 12,
 }
}
Name (MCRS, ResourceTemplate()
{
 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
   0x0000, 0x0000, 0x00ff, 0x0000, 0x0100,,, PB00)
 DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
   0x0000, 0x0000, 0x0cf7, 0x0000, 0x0cf8,,, PI00)
 Io (Decode16, 0x0cf8, 0x0cf8, 0x0001, 0x0008)
 DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
   0x0000, 0x0d00, 0xffff, 0x0000, 0xf300,,, PI01)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000a0000, 0x000bffff, 0x00000000,
   0x00020000,,, ASEG)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000c0000, 0x000c3fff, 0x00000000,
   0x00004000,,, OPR0)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000c4000, 0x000c7fff, 0x00000000,
   0x00004000,,, OPR1)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000c8000, 0x000cbfff, 0x00000000,
   0x00004000,,, OPR2)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000cc000, 0x000cffff, 0x00000000,
   0x00004000,,, OPR3)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000d0000, 0x000d3fff, 0x00000000,
   0x00004000,,, OPR4)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000d4000, 0x000d7fff, 0x00000000,
   0x00004000,,, OPR5)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000d8000, 0x000dbfff, 0x00000000,
   0x00004000,,, OPR6)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000dc000, 0x000dffff, 0x00000000,
   0x00004000,,, OPR7)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000e0000, 0x000e3fff, 0x00000000,
   0x00004000,,, ESG0)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000e4000, 0x000e7fff, 0x00000000,
   0x00004000,,, ESG1)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000e8000, 0x000ebfff, 0x00000000,
   0x00004000,,, ESG2)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000ec000, 0x000effff, 0x00000000,
   0x00004000,,, ESG3)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x000f0000, 0x000fffff, 0x00000000,
   0x00010000,,, FSEG)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0x00000000, 0xfebfffff, 0x00000000,
   0xfec00000,,, PM01)
 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
   Cacheable, ReadWrite,
   0x00000000, 0xfed40000, 0xfed44fff, 0x00000000,
   0x00005000,,, TPMR)
})
Method (_CRS, 0, Serialized)
{
 CreateDwordField(MCRS, ^PM01._MIN, PMIN)
 CreateDwordField(MCRS, ^PM01._MAX, PMAX)
 CreateDwordField(MCRS, ^PM01._LEN, PLEN)
 ShiftLeft (^MCHC.TLUD, 20, PMIN)
 Add(Subtract(PMAX, PMIN), 1, PLEN)
 Return (MCRS)
}
Device (PDRC)
{
 Name (_HID, EISAID("PNP0C02"))
 Name (_UID, 1)
 Name (PDRS, ResourceTemplate() {
  Memory32Fixed(ReadWrite, 0xfed1c000, 0x00004000)
  Memory32Fixed(ReadWrite, 0xfed14000, 0x00004000)
  Memory32Fixed(ReadWrite, 0xfed18000, 0x00001000)
  Memory32Fixed(ReadWrite, 0xfed19000, 0x00001000)
  Memory32Fixed(ReadWrite, 0xf0000000, 0x04000000)
  Memory32Fixed(ReadWrite, 0xfed20000, 0x00020000)
  Memory32Fixed(ReadWrite, 0xfed40000, 0x00005000)
  Memory32Fixed(ReadWrite, 0xfed45000, 0x0004b000)
 })
 Method (_CRS, 0, Serialized)
 {
  Return(PDRS)
 }
}
Device (PEGP)
{
 Name (_ADR, 0x00010000)
 Method (_PRT)
 {
  If (PICM) {
   Return (Package() {
    Package() { 0x0000ffff, 0, 0, 16 },
    Package() { 0x0000ffff, 1, 0, 17 },
    Package() { 0x0000ffff, 2, 0, 18 },
    Package() { 0x0000ffff, 3, 0, 19 }
   })
  } Else {
   Return (Package() {
    Package() { 0x0000ffff, 0, \_SB.PCI0.LPCB.LNKA, 0 },
    Package() { 0x0000ffff, 1, \_SB.PCI0.LPCB.LNKB, 0 },
    Package() { 0x0000ffff, 2, \_SB.PCI0.LPCB.LNKC, 0 },
    Package() { 0x0000ffff, 3, \_SB.PCI0.LPCB.LNKD, 0 }
   })
  }
 }
}
Scope(\)
{
 OperationRegion(IO_T, SystemIO, 0x800, 0x10)
 Field(IO_T, ByteAcc, NoLock, Preserve)
 {
  Offset(0x8),
  TRP0, 8
 }
 OperationRegion(PMIO, SystemIO, 0x00000500, 0x80)
 Field(PMIO, ByteAcc, NoLock, Preserve)
 {
  Offset(0x11),
  THRO, 1,
  Offset(0x42),
  , 1,
  GPEC, 1,
  Offset(0x64),
  , 9,
  SCIS, 1
 }
 OperationRegion(GPIO, SystemIO, 0x00000580, 0x3c)
 Field(GPIO, ByteAcc, NoLock, Preserve)
 {
  Offset(0x00),
  GU00, 8,
  GU01, 8,
  GU02, 8,
  GU03, 8,
  Offset(0x04),
  GIO0, 8,
  GIO1, 8,
  GIO2, 8,
  GIO3, 8,
  Offset(0x0c),
  GP00, 1,
  GP01, 1,
  GP02, 1,
  GP03, 1,
  GP04, 1,
  GP05, 1,
  GP06, 1,
  GP07, 1,
  GP08, 1,
  GP09, 1,
  GP10, 1,
  GP11, 1,
  GP12, 1,
  GP13, 1,
  GP14, 1,
  GP15, 1,
  GP16, 1,
  GP17, 1,
  GP18, 1,
  GP19, 1,
  GP20, 1,
  GP21, 1,
  GP22, 1,
  GP23, 1,
  GP24, 1,
  GP25, 1,
  GP26, 1,
  GP27, 1,
  GP28, 1,
  GP29, 1,
  GP30, 1,
  GP31, 1,
  Offset(0x18),
  GB00, 8,
  GB01, 8,
  GB02, 8,
  GB03, 8,
  Offset(0x2c),
  GIV0, 8,
  GIV1, 8,
  GIV2, 8,
  GIV3, 8,
  Offset(0x30),
  GU04, 8,
  GU05, 8,
  GU06, 8,
  GU07, 8,
  Offset(0x34),
  GIO4, 8,
  GIO5, 8,
  GIO6, 8,
  GIO7, 8,
  Offset(0x38),
  GP32, 1,
  GP33, 1,
  GP34, 1,
  GP35, 1,
  GP36, 1,
  GP37, 1,
  GP38, 1,
  GP39, 1,
  GL05, 8,
  GL06, 8,
  GL07, 8
 }
 OperationRegion(RCRB, SystemMemory, 0xfed1c000, 0x4000)
 Field(RCRB, DWordAcc, Lock, Preserve)
 {
  Offset(0x0000),
  Offset(0x1000),
  Offset(0x3000),
  Offset(0x3404),
  HPAS, 2,
  , 5,
  HPTE, 1,
  Offset(0x3418),
  , 2,
  SA1D, 1,
  SMBD, 1,
  HDAD, 1,
  , 2,
  US6D, 1,
  US1D, 1,
  US2D, 1,
  US3D, 1,
  US4D, 1,
  US5D, 1,
  EH2D, 1,
  LPBD, 1,
  EH1D, 1,
  Offset(0x341a),
  RP1D, 1,
  RP2D, 1,
  RP3D, 1,
  RP4D, 1,
  RP5D, 1,
  RP6D, 1,
  , 2,
  THRD, 1,
  SA2D, 1,
 }
}
Device (HDEF)
{
 Name (_ADR, 0x001b0000)
 Name (_PRW, Package(){
  5,
  4
 })
}
Method (IRQM, 1, Serialized) {
 Name (IQAA, Package() {
  Package() { 0x0000ffff, 0, 0, 16 },
  Package() { 0x0000ffff, 1, 0, 17 },
  Package() { 0x0000ffff, 2, 0, 18 },
  Package() { 0x0000ffff, 3, 0, 19 } })
 Name (IQAP, Package() {
  Package() { 0x0000ffff, 0, \_SB.PCI0.LPCB.LNKA, 0 },
  Package() { 0x0000ffff, 1, \_SB.PCI0.LPCB.LNKB, 0 },
  Package() { 0x0000ffff, 2, \_SB.PCI0.LPCB.LNKC, 0 },
  Package() { 0x0000ffff, 3, \_SB.PCI0.LPCB.LNKD, 0 } })
 Name (IQBA, Package() {
  Package() { 0x0000ffff, 0, 0, 17 },
  Package() { 0x0000ffff, 1, 0, 18 },
  Package() { 0x0000ffff, 2, 0, 19 },
  Package() { 0x0000ffff, 3, 0, 16 } })
 Name (IQBP, Package() {
  Package() { 0x0000ffff, 0, \_SB.PCI0.LPCB.LNKB, 0 },
  Package() { 0x0000ffff, 1, \_SB.PCI0.LPCB.LNKC, 0 },
  Package() { 0x0000ffff, 2, \_SB.PCI0.LPCB.LNKD, 0 },
  Package() { 0x0000ffff, 3, \_SB.PCI0.LPCB.LNKA, 0 } })
 Name (IQCA, Package() {
  Package() { 0x0000ffff, 0, 0, 18 },
  Package() { 0x0000ffff, 1, 0, 19 },
  Package() { 0x0000ffff, 2, 0, 16 },
  Package() { 0x0000ffff, 3, 0, 17 } })
 Name (IQCP, Package() {
  Package() { 0x0000ffff, 0, \_SB.PCI0.LPCB.LNKC, 0 },
  Package() { 0x0000ffff, 1, \_SB.PCI0.LPCB.LNKD, 0 },
  Package() { 0x0000ffff, 2, \_SB.PCI0.LPCB.LNKA, 0 },
  Package() { 0x0000ffff, 3, \_SB.PCI0.LPCB.LNKB, 0 } })
 Name (IQDA, Package() {
  Package() { 0x0000ffff, 0, 0, 19 },
  Package() { 0x0000ffff, 1, 0, 16 },
  Package() { 0x0000ffff, 2, 0, 17 },
  Package() { 0x0000ffff, 3, 0, 18 } })
 Name (IQDP, Package() {
  Package() { 0x0000ffff, 0, \_SB.PCI0.LPCB.LNKD, 0 },
  Package() { 0x0000ffff, 1, \_SB.PCI0.LPCB.LNKA, 0 },
  Package() { 0x0000ffff, 2, \_SB.PCI0.LPCB.LNKB, 0 },
  Package() { 0x0000ffff, 3, \_SB.PCI0.LPCB.LNKC, 0 } })
 Switch (ToInteger (Arg0)) {
  Case (Package() { 1, 5 }) {
   If (PICM) {
    Return (IQAA)
   } Else {
    Return (IQAP)
   }
  }
  Case (Package() { 2, 6 }) {
   If (PICM) {
    Return (IQBA)
   } Else {
    Return (IQBP)
   }
  }
  Case (Package() { 3, 7 }) {
   If (PICM) {
    Return (IQCA)
   } Else {
    Return (IQCP)
   }
  }
  Case (Package() { 4, 8 }) {
   If (PICM) {
    Return (IQDA)
   } Else {
    Return (IQDP)
   }
  }
  Default {
   If (PICM) {
    Return (IQDA)
   } Else {
    Return (IQDP)
   }
  }
 }
}
Device (RP01)
{
 Name (_ADR, 0x001c0000)
OperationRegion (RPCS, PCI_Config, 0x00, 0xFF)
Field (RPCS, AnyAcc, NoLock, Preserve)
{
 Offset (0x4c),
 , 24,
 RPPN, 8,
 Offset (0x5A),
 , 3,
 PDC, 1,
 Offset (0xDF),
 , 6,
 HPCS, 1,
}
 Method (_PRT)
 {
  Return (IRQM (RPPN))
 }
}
Device (RP02)
{
 Name (_ADR, 0x001c0001)
OperationRegion (RPCS, PCI_Config, 0x00, 0xFF)
Field (RPCS, AnyAcc, NoLock, Preserve)
{
 Offset (0x4c),
 , 24,
 RPPN, 8,
 Offset (0x5A),
 , 3,
 PDC, 1,
 Offset (0xDF),
 , 6,
 HPCS, 1,
}
 Method (_PRT)
 {
  Return (IRQM (RPPN))
 }
}
Device (RP03)
{
 Name (_ADR, 0x001c0002)
OperationRegion (RPCS, PCI_Config, 0x00, 0xFF)
Field (RPCS, AnyAcc, NoLock, Preserve)
{
 Offset (0x4c),
 , 24,
 RPPN, 8,
 Offset (0x5A),
 , 3,
 PDC, 1,
 Offset (0xDF),
 , 6,
 HPCS, 1,
}
 Method (_PRT)
 {
  Return (IRQM (RPPN))
 }
}
Device (RP04)
{
 Name (_ADR, 0x001c0003)
OperationRegion (RPCS, PCI_Config, 0x00, 0xFF)
Field (RPCS, AnyAcc, NoLock, Preserve)
{
 Offset (0x4c),
 , 24,
 RPPN, 8,
 Offset (0x5A),
 , 3,
 PDC, 1,
 Offset (0xDF),
 , 6,
 HPCS, 1,
}
 Method (_PRT)
 {
  Return (IRQM (RPPN))
 }
}
Device (RP05)
{
 Name (_ADR, 0x001c0004)
OperationRegion (RPCS, PCI_Config, 0x00, 0xFF)
Field (RPCS, AnyAcc, NoLock, Preserve)
{
 Offset (0x4c),
 , 24,
 RPPN, 8,
 Offset (0x5A),
 , 3,
 PDC, 1,
 Offset (0xDF),
 , 6,
 HPCS, 1,
}
 Method (_PRT)
 {
  Return (IRQM (RPPN))
 }
}
Device (RP06)
{
 Name (_ADR, 0x001c0005)
OperationRegion (RPCS, PCI_Config, 0x00, 0xFF)
Field (RPCS, AnyAcc, NoLock, Preserve)
{
 Offset (0x4c),
 , 24,
 RPPN, 8,
 Offset (0x5A),
 , 3,
 PDC, 1,
 Offset (0xDF),
 , 6,
 HPCS, 1,
}
 Method (_PRT)
 {
  Return (IRQM (RPPN))
 }
}
Device (RP07)
{
 Name (_ADR, 0x001c0006)
OperationRegion (RPCS, PCI_Config, 0x00, 0xFF)
Field (RPCS, AnyAcc, NoLock, Preserve)
{
 Offset (0x4c),
 , 24,
 RPPN, 8,
 Offset (0x5A),
 , 3,
 PDC, 1,
 Offset (0xDF),
 , 6,
 HPCS, 1,
}
 Method (_PRT)
 {
  Return (IRQM (RPPN))
 }
}
Device (RP08)
{
 Name (_ADR, 0x001c0007)
OperationRegion (RPCS, PCI_Config, 0x00, 0xFF)
Field (RPCS, AnyAcc, NoLock, Preserve)
{
 Offset (0x4c),
 , 24,
 RPPN, 8,
 Offset (0x5A),
 , 3,
 PDC, 1,
 Offset (0xDF),
 , 6,
 HPCS, 1,
}
 Method (_PRT)
 {
  Return (IRQM (RPPN))
 }
}
Device (USB1)
{
 Name(_ADR, 0x001d0000)
 OperationRegion(U01P, PCI_Config, 0, 256)
 Field(U01P, DWordAcc, NoLock, Preserve)
 {
  Offset(0xc4),
  U1WE, 2
 }
 Name (_PRW, Package(){ 3, 4 })
 Method (_PSW, 1)
 {
  If (Arg0) {
   Store (3, U1WE)
  } Else {
   Store (0, U1WE)
  }
 }
 Method(_S3D,0)
 {
  Return (2)
 }
 Method(_S4D,0)
 {
  Return (2)
 }
}
Device (USB2)
{
 Name(_ADR, 0x001d0001)
 OperationRegion(U02P, PCI_Config, 0, 256)
 Field(U02P, DWordAcc, NoLock, Preserve)
 {
  Offset(0xc4),
  U2WE, 2
 }
 Name (_PRW, Package(){ 3, 4 })
 Method (_PSW, 1)
 {
  If (Arg0) {
   Store (3, U2WE)
  } Else {
   Store (0, U2WE)
  }
 }
 Method(_S3D,0)
 {
  Return (2)
 }
 Method(_S4D,0)
 {
  Return (2)
 }
}
Device (USB3)
{
 Name(_ADR, 0x001d0002)
 OperationRegion(U03P, PCI_Config, 0, 256)
 Field(U03P, DWordAcc, NoLock, Preserve)
 {
  Offset(0xc4),
  U3WE, 2
 }
 Name (_PRW, Package(){ 3, 4 })
 Method (_PSW, 1)
 {
  If (Arg0) {
   Store (3, U3WE)
  } Else {
   Store (0, U3WE)
  }
 }
 Method(_S3D,0)
 {
  Return (2)
 }
 Method(_S4D,0)
 {
  Return (2)
 }
}
Device (EHC1)
{
 Name(_ADR, 0x001d0007)
 Name (_PRW, Package(){ 13, 4 })
 Method(_S3D,0)
 {
  Return (2)
 }
 Method(_S4D,0)
 {
  Return (2)
 }
 Device (HUB7)
 {
  Name (_ADR, 0x00000000)
  Device (PRT1) { Name (_ADR, 1) }
  Device (PRT2) { Name (_ADR, 2) }
  Device (PRT3) { Name (_ADR, 3) }
  Device (PRT4) { Name (_ADR, 4) }
  Device (PRT5) { Name (_ADR, 5) }
  Device (PRT6) { Name (_ADR, 6) }
 }
}
Device (USB4)
{
 Name(_ADR, 0x001a0000)
 OperationRegion(U01P, PCI_Config, 0, 256)
 Field(U01P, DWordAcc, NoLock, Preserve)
 {
  Offset(0xc4),
  U1WE, 2
 }
 Name (_PRW, Package(){ 3, 4 })
 Method (_PSW, 1)
 {
  If (Arg0) {
   Store (3, U1WE)
  } Else {
   Store (0, U1WE)
  }
 }
 Method(_S3D,0)
 {
  Return (2)
 }
 Method(_S4D,0)
 {
  Return (2)
 }
}
Device (USB5)
{
 Name(_ADR, 0x001a0001)
 OperationRegion(U02P, PCI_Config, 0, 256)
 Field(U02P, DWordAcc, NoLock, Preserve)
 {
  Offset(0xc4),
  U2WE, 2
 }
 Name (_PRW, Package(){ 3, 4 })
 Method (_PSW, 1)
 {
  If (Arg0) {
   Store (3, U2WE)
  } Else {
   Store (0, U2WE)
  }
 }
 Method(_S3D,0)
 {
  Return (2)
 }
 Method(_S4D,0)
 {
  Return (2)
 }
}
Device (USB6)
{
 Name(_ADR, 0x001a0002)
 OperationRegion(U03P, PCI_Config, 0, 256)
 Field(U03P, DWordAcc, NoLock, Preserve)
 {
  Offset(0xc4),
  U3WE, 2
 }
 Name (_PRW, Package(){ 3, 4 })
 Method (_PSW, 1)
 {
  If (Arg0) {
   Store (3, U3WE)
  } Else {
   Store (0, U3WE)
  }
 }
 Method(_S3D,0)
 {
  Return (2)
 }
 Method(_S4D,0)
 {
  Return (2)
 }
}
Device (EHC2)
{
 Name(_ADR, 0x001a0007)
 Name (_PRW, Package(){ 13, 4 })
 Method(_S3D,0)
 {
  Return (2)
 }
 Method(_S4D,0)
 {
  Return (2)
 }
 Device (HUB7)
 {
  Name (_ADR, 0x00000000)
  Device (PRT1) { Name (_ADR, 1) }
  Device (PRT2) { Name (_ADR, 2) }
  Device (PRT3) { Name (_ADR, 3) }
  Device (PRT4) { Name (_ADR, 4) }
  Device (PRT5) { Name (_ADR, 5) }
  Device (PRT6) { Name (_ADR, 6) }
 }
}
Device (PCIB)
{
 Name (_ADR, 0x001e0000)
 Device (SLT1)
 {
  Name (_ADR, 0x00000000)
  Name (_PRW, Package(){ 11, 4 })
 }
 Device (SLT2)
 {
  Name (_ADR, 0x00010000)
  Name (_PRW, Package(){ 11, 4 })
 }
 Device (SLT3)
 {
  Name (_ADR, 0x00020000)
  Name (_PRW, Package(){ 11, 4 })
 }
 Device (SLT6)
 {
  Name (_ADR, 0x00050000)
  Name (_PRW, Package(){ 11, 4 })
 }
 Device (LANC)
 {
  Name (_ADR, 0x00080000)
  Name (_PRW, Package(){ 11, 3 })
 }
 Device (LANR)
 {
  Name (_ADR, 0x00000000)
  Name (_PRW, Package(){ 11, 3 })
 }
 Method (_PRT)
 {
If (PICM) {
 Return (Package() {
  Package() { 0x0000ffff, 0, 0, 16},
  Package() { 0x0000ffff, 1, 0, 17},
  Package() { 0x0000ffff, 2, 0, 18},
  Package() { 0x0000ffff, 3, 0, 19},
  Package() { 0x0001ffff, 0, 0, 17},
  Package() { 0x0001ffff, 1, 0, 18},
  Package() { 0x0001ffff, 2, 0, 19},
  Package() { 0x0001ffff, 3, 0, 16},
  Package() { 0x0002ffff, 0, 0, 18},
  Package() { 0x0002ffff, 1, 0, 19},
  Package() { 0x0002ffff, 2, 0, 16},
  Package() { 0x0002ffff, 3, 0, 17},
  Package() { 0x0003ffff, 0, 0, 16},
  Package() { 0x0003ffff, 1, 0, 17},
  Package() { 0x0003ffff, 2, 0, 18},
  Package() { 0x0003ffff, 3, 0, 19},
  Package() { 0x0004ffff, 0, 0, 16},
  Package() { 0x0004ffff, 1, 0, 17},
  Package() { 0x0004ffff, 2, 0, 18},
  Package() { 0x0004ffff, 3, 0, 19},
  Package() { 0x0005ffff, 0, 0, 17},
  Package() { 0x0005ffff, 1, 0, 18},
  Package() { 0x0005ffff, 2, 0, 19},
  Package() { 0x0005ffff, 3, 0, 16},
 })
} Else {
 Return (Package() {
  Package() { 0x0000ffff, 0, \_SB.PCI0.LPCB.LNKA, 0},
  Package() { 0x0000ffff, 1, \_SB.PCI0.LPCB.LNKB, 0},
  Package() { 0x0000ffff, 2, \_SB.PCI0.LPCB.LNKC, 0},
  Package() { 0x0000ffff, 3, \_SB.PCI0.LPCB.LNKD, 0},
  Package() { 0x0001ffff, 0, \_SB.PCI0.LPCB.LNKB, 0},
  Package() { 0x0001ffff, 1, \_SB.PCI0.LPCB.LNKC, 0},
  Package() { 0x0001ffff, 2, \_SB.PCI0.LPCB.LNKD, 0},
  Package() { 0x0001ffff, 3, \_SB.PCI0.LPCB.LNKA, 0},
  Package() { 0x0002ffff, 0, \_SB.PCI0.LPCB.LNKC, 0},
  Package() { 0x0002ffff, 1, \_SB.PCI0.LPCB.LNKD, 0},
  Package() { 0x0002ffff, 2, \_SB.PCI0.LPCB.LNKA, 0},
  Package() { 0x0002ffff, 3, \_SB.PCI0.LPCB.LNKB, 0},
  Package() { 0x0003ffff, 0, \_SB.PCI0.LPCB.LNKA, 0},
  Package() { 0x0003ffff, 1, \_SB.PCI0.LPCB.LNKB, 0},
  Package() { 0x0003ffff, 2, \_SB.PCI0.LPCB.LNKC, 0},
  Package() { 0x0003ffff, 3, \_SB.PCI0.LPCB.LNKD, 0},
  Package() { 0x0004ffff, 0, \_SB.PCI0.LPCB.LNKA, 0},
  Package() { 0x0004ffff, 1, \_SB.PCI0.LPCB.LNKB, 0},
  Package() { 0x0004ffff, 2, \_SB.PCI0.LPCB.LNKC, 0},
  Package() { 0x0004ffff, 3, \_SB.PCI0.LPCB.LNKD, 0},
  Package() { 0x0005ffff, 0, \_SB.PCI0.LPCB.LNKB, 0},
  Package() { 0x0005ffff, 1, \_SB.PCI0.LPCB.LNKC, 0},
  Package() { 0x0005ffff, 2, \_SB.PCI0.LPCB.LNKD, 0},
  Package() { 0x0005ffff, 3, \_SB.PCI0.LPCB.LNKA, 0},
 })
}
 }
}
Device (LPCB)
{
 Name(_ADR, 0x001f0000)
 OperationRegion(LPC0, PCI_Config, 0x00, 0x100)
 Field (LPC0, AnyAcc, NoLock, Preserve)
 {
  Offset (0x40),
  PMBS, 16,
  Offset (0x60),
  PRTA, 8,
  PRTB, 8,
  PRTC, 8,
  PRTD, 8,
  Offset (0x68),
  PRTE, 8,
  PRTF, 8,
  PRTG, 8,
  PRTH, 8,
  Offset (0x80),
  IOD0, 8,
  IOD1, 8,
  Offset (0xf0),
  RCEN, 1,
  , 13,
  RCBA, 18,
 }
Device (LNKA)
{
 Name (_HID, EISAID("PNP0C0F"))
 Name (_UID, 1)
 Method (_DIS, 0, Serialized)
 {
  Store (0x80, PRTA)
 }
 Name (_PRS, ResourceTemplate()
 {
  IRQ(Level, ActiveLow, Shared)
   { 3, 4, 5, 6, 7, 10, 12, 14, 15 }
 })
 Method (_CRS, 0, Serialized)
 {
  Name (RTLA, ResourceTemplate()
  {
   IRQ(Level, ActiveLow, Shared) {}
  })
  CreateWordField(RTLA, 1, IRQ0)
  Store (Zero, IRQ0)
  ShiftLeft(1, And(PRTA, 0x0f), IRQ0)
  Return (RTLA)
 }
 Method (_SRS, 1, Serialized)
 {
  CreateWordField(Arg0, 1, IRQ0)
  FindSetRightBit(IRQ0, Local0)
  Decrement(Local0)
  Store(Local0, PRTA)
 }
 Method (_STA, 0, Serialized)
 {
  If(And(PRTA, 0x80)) {
   Return (0x9)
  } Else {
   Return (0xb)
  }
 }
}
Device (LNKB)
{
 Name (_HID, EISAID("PNP0C0F"))
 Name (_UID, 2)
 Method (_DIS, 0, Serialized)
 {
  Store (0x80, PRTB)
 }
 Name (_PRS, ResourceTemplate()
 {
  IRQ(Level, ActiveLow, Shared)
   { 3, 4, 5, 6, 7, 11, 12, 14, 15 }
 })
 Method (_CRS, 0, Serialized)
 {
  Name (RTLB, ResourceTemplate()
  {
   IRQ(Level, ActiveLow, Shared) {}
  })
  CreateWordField(RTLB, 1, IRQ0)
  Store (Zero, IRQ0)
  ShiftLeft(1, And(PRTB, 0x0f), IRQ0)
  Return (RTLB)
 }
 Method (_SRS, 1, Serialized)
 {
  CreateWordField(Arg0, 1, IRQ0)
  FindSetRightBit(IRQ0, Local0)
  Decrement(Local0)
  Store(Local0, PRTB)
 }
 Method (_STA, 0, Serialized)
 {
  If(And(PRTB, 0x80)) {
   Return (0x9)
  } Else {
   Return (0xb)
  }
 }
}
Device (LNKC)
{
 Name (_HID, EISAID("PNP0C0F"))
 Name (_UID, 3)
 Method (_DIS, 0, Serialized)
 {
  Store (0x80, PRTC)
 }
 Name (_PRS, ResourceTemplate()
 {
  IRQ(Level, ActiveLow, Shared)
   { 3, 4, 5, 6, 7, 10, 12, 14, 15 }
 })
 Method (_CRS, 0, Serialized)
 {
  Name (RTLC, ResourceTemplate()
  {
   IRQ(Level, ActiveLow, Shared) {}
  })
  CreateWordField(RTLC, 1, IRQ0)
  Store (Zero, IRQ0)
  ShiftLeft(1, And(PRTC, 0x0f), IRQ0)
  Return (RTLC)
 }
 Method (_SRS, 1, Serialized)
 {
  CreateWordField(Arg0, 1, IRQ0)
  FindSetRightBit(IRQ0, Local0)
  Decrement(Local0)
  Store(Local0, PRTC)
 }
 Method (_STA, 0, Serialized)
 {
  If(And(PRTC, 0x80)) {
   Return (0x9)
  } Else {
   Return (0xb)
  }
 }
}
Device (LNKD)
{
 Name (_HID, EISAID("PNP0C0F"))
 Name (_UID, 4)
 Method (_DIS, 0, Serialized)
 {
  Store (0x80, PRTD)
 }
 Name (_PRS, ResourceTemplate()
 {
  IRQ(Level, ActiveLow, Shared)
   { 3, 4, 5, 6, 7, 11, 12, 14, 15 }
 })
 Method (_CRS, 0, Serialized)
 {
  Name (RTLD, ResourceTemplate()
  {
   IRQ(Level, ActiveLow, Shared) {}
  })
  CreateWordField(RTLD, 1, IRQ0)
  Store (Zero, IRQ0)
  ShiftLeft(1, And(PRTD, 0x0f), IRQ0)
  Return (RTLD)
 }
 Method (_SRS, 1, Serialized)
 {
  CreateWordField(Arg0, 1, IRQ0)
  FindSetRightBit(IRQ0, Local0)
  Decrement(Local0)
  Store(Local0, PRTD)
 }
 Method (_STA, 0, Serialized)
 {
  If(And(PRTD, 0x80)) {
   Return (0x9)
  } Else {
   Return (0xb)
  }
 }
}
Device (LNKE)
{
 Name (_HID, EISAID("PNP0C0F"))
 Name (_UID, 5)
 Method (_DIS, 0, Serialized)
 {
  Store (0x80, PRTE)
 }
 Name (_PRS, ResourceTemplate()
 {
  IRQ(Level, ActiveLow, Shared)
   { 3, 4, 5, 6, 7, 10, 12, 14, 15 }
 })
 Method (_CRS, 0, Serialized)
 {
  Name (RTLE, ResourceTemplate()
  {
   IRQ(Level, ActiveLow, Shared) {}
  })
  CreateWordField(RTLE, 1, IRQ0)
  Store (Zero, IRQ0)
  ShiftLeft(1, And(PRTE, 0x0f), IRQ0)
  Return (RTLE)
 }
 Method (_SRS, 1, Serialized)
 {
  CreateWordField(Arg0, 1, IRQ0)
  FindSetRightBit(IRQ0, Local0)
  Decrement(Local0)
  Store(Local0, PRTE)
 }
 Method (_STA, 0, Serialized)
 {
  If(And(PRTE, 0x80)) {
   Return (0x9)
  } Else {
   Return (0xb)
  }
 }
}
Device (LNKF)
{
 Name (_HID, EISAID("PNP0C0F"))
 Name (_UID, 6)
 Method (_DIS, 0, Serialized)
 {
  Store (0x80, PRTF)
 }
 Name (_PRS, ResourceTemplate()
 {
  IRQ(Level, ActiveLow, Shared)
   { 3, 4, 5, 6, 7, 11, 12, 14, 15 }
 })
 Method (_CRS, 0, Serialized)
 {
  Name (RTLF, ResourceTemplate()
  {
   IRQ(Level, ActiveLow, Shared) {}
  })
  CreateWordField(RTLF, 1, IRQ0)
  Store (Zero, IRQ0)
  ShiftLeft(1, And(PRTF, 0x0f), IRQ0)
  Return (RTLF)
 }
 Method (_SRS, 1, Serialized)
 {
  CreateWordField(Arg0, 1, IRQ0)
  FindSetRightBit(IRQ0, Local0)
  Decrement(Local0)
  Store(Local0, PRTF)
 }
 Method (_STA, 0, Serialized)
 {
  If(And(PRTF, 0x80)) {
   Return (0x9)
  } Else {
   Return (0xb)
  }
 }
}
Device (LNKG)
{
 Name (_HID, EISAID("PNP0C0F"))
 Name (_UID, 7)
 Method (_DIS, 0, Serialized)
 {
  Store (0x80, PRTG)
 }
 Name (_PRS, ResourceTemplate()
 {
  IRQ(Level, ActiveLow, Shared)
   { 3, 4, 5, 6, 7, 10, 12, 14, 15 }
 })
 Method (_CRS, 0, Serialized)
 {
  Name (RTLG, ResourceTemplate()
  {
   IRQ(Level, ActiveLow, Shared) {}
  })
  CreateWordField(RTLG, 1, IRQ0)
  Store (Zero, IRQ0)
  ShiftLeft(1, And(PRTG, 0x0f), IRQ0)
  Return (RTLG)
 }
 Method (_SRS, 1, Serialized)
 {
  CreateWordField(Arg0, 1, IRQ0)
  FindSetRightBit(IRQ0, Local0)
  Decrement(Local0)
  Store(Local0, PRTG)
 }
 Method (_STA, 0, Serialized)
 {
  If(And(PRTG, 0x80)) {
   Return (0x9)
  } Else {
   Return (0xb)
  }
 }
}
Device (LNKH)
{
 Name (_HID, EISAID("PNP0C0F"))
 Name (_UID, 8)
 Method (_DIS, 0, Serialized)
 {
  Store (0x80, PRTH)
 }
 Name (_PRS, ResourceTemplate()
 {
  IRQ(Level, ActiveLow, Shared)
   { 3, 4, 5, 6, 7, 11, 12, 14, 15 }
 })
 Method (_CRS, 0, Serialized)
 {
  Name (RTLH, ResourceTemplate()
  {
   IRQ(Level, ActiveLow, Shared) {}
  })
  CreateWordField(RTLH, 1, IRQ0)
  Store (Zero, IRQ0)
  ShiftLeft(1, And(PRTH, 0x0f), IRQ0)
  Return (RTLH)
 }
 Method (_SRS, 1, Serialized)
 {
  CreateWordField(Arg0, 1, IRQ0)
  FindSetRightBit(IRQ0, Local0)
  Decrement(Local0)
  Store(Local0, PRTH)
 }
 Method (_STA, 0, Serialized)
 {
  If(And(PRTH, 0x80)) {
   Return (0x9)
  } Else {
   Return (0xb)
  }
 }
}
Device(EC)
{
 Name (_HID, EISAID("PNP0C09"))
 Name (_UID, 0)
 Name (_GPE, 17)
 Mutex (ECLK, 0)
 OperationRegion(ERAM, EmbeddedControl, 0x00, 0x100)
 Field (ERAM, ByteAcc, NoLock, Preserve)
 {
  Offset (0x02),
    DKR1, 1,
  Offset (0x05),
    HSPA, 1,
  Offset (0x0C),
    LEDS, 8,
  Offset (0x0F),
        , 7,
    TBSW, 1,
  Offset (0x1a),
    DKR2, 1,
  Offset (0x2a),
    EVNT, 8,
  Offset (0x2f),
        , 6,
    FAND, 1,
    FANA, 1,
  Offset (0x30),
        , 6,
    ALMT, 1,
  Offset (0x31),
        , 2,
    UWBE, 1,
  Offset (0x3a),
    AMUT, 1,
        , 3,
    BTEB, 1,
    WLEB, 1,
    WWEB, 1,
  Offset (0x3B),
        , 1,
    KBLT, 1,
        , 2,
    USPW, 1,
  Offset (0x48),
    HPPI, 1,
    GSTS, 1,
  Offset (0x4e),
    WAKE, 16,
  Offset (0x78),
    TMP0, 8,
    TMP1, 8,
  Offset (0x81),
    PAGE, 8,
  Offset (0xfe),
        , 4,
    DKR3, 1
 }
 Method (_REG, 2, NotSerialized)
 {
  if (LEqual(Arg1, One)) {
   if (LEqual(^HKEY.INIT, Zero)) {
    Store (BTEB, ^HKEY.WBDC)
    Store (WWEB, ^HKEY.WWAN)
    Store (One, ^HKEY.INIT)
   }
  }
 }
 Method (_CRS, 0, Serialized)
 {
  Name (ECMD, ResourceTemplate()
  {
   IO (Decode16, 0x62, 0x62, 1, 1)
   IO (Decode16, 0x66, 0x66, 1, 1)
  })
  Return (ECMD)
 }
 Method (TLED, 1, NotSerialized)
 {
  Store(Arg0, LEDS)
 }
 Method (LED, 2, NotSerialized)
 {
  TLED(Or(Arg0, Arg1))
 }
 Method (_INI, 0, NotSerialized)
 {
 }
 Method (MUTE, 1, NotSerialized)
 {
  Store(Arg0, AMUT)
 }
 Method (RADI, 1, NotSerialized)
 {
  Store(Arg0, WLEB)
  Store(Arg0, WWEB)
  Store(Arg0, BTEB)
 }
 Method (USBP, 1, NotSerialized)
 {
  Store(Arg0, USPW)
 }
 Method (LGHT, 1, NotSerialized)
 {
  Store(Arg0, KBLT)
 }
 Method(_Q13, 0, NotSerialized)
 {
  Notify(^SLPB, 0x80)
 }
 Method(_Q14, 0, NotSerialized)
 {
  \_SB.PCI0.GFX0.INCB()
 }
 Method(_Q15, 0, NotSerialized)
 {
  \_SB.PCI0.GFX0.DECB()
 }
 Method(_Q16, 0, NotSerialized)
 {
  Notify (\_SB.PCI0.GFX0, 0x82)
 }
 Method(_Q26, 0, NotSerialized)
 {
  Notify (AC, 0x80)
  \PNOT()
 }
 Method(_Q27, 0, NotSerialized)
 {
  Notify (AC, 0x80)
  Store(0x50, EVNT)
  \PNOT()
 }
 Method(_Q2A, 0, NotSerialized)
 {
  Notify(^LID, 0x80)
 }
 Method(_Q2B, 0, NotSerialized)
 {
  Notify(^LID, 0x80)
 }
 Method (_Q10, 0, NotSerialized)
 {
  ^HKEY.RHK (0x01)
 }
 Method (_Q11, 0, NotSerialized)
 {
  ^HKEY.RHK (0x02)
 }
 Method (_Q12, 0, NotSerialized)
 {
  ^HKEY.RHK (0x03)
 }
 Method (_Q64, 0, NotSerialized)
 {
  ^HKEY.RHK (0x05)
 }
 Method (_Q65, 0, NotSerialized)
 {
  ^HKEY.RHK (0x06)
 }
 Method (_Q17, 0, NotSerialized)
 {
  ^HKEY.RHK (0x08)
 }
 Method (_Q66, 0, NotSerialized)
 {
  ^HKEY.RHK (0x0A)
 }
 Method (_Q6A, 0, NotSerialized)
 {
  ^HKEY.RHK (0x1B)
 }
 Method (_Q1A, 0, NotSerialized)
 {
  ^HKEY.RHK (0x0B)
 }
 Method (_Q1B, 0, NotSerialized)
 {
  ^HKEY.RHK (0x0C)
 }
 Method (_Q62, 0, NotSerialized)
 {
  ^HKEY.RHK (0x0D)
 }
 Method (_Q60, 0, NotSerialized)
 {
  ^HKEY.RHK (0x0E)
 }
 Method (_Q61, 0, NotSerialized)
 {
  ^HKEY.RHK (0x0F)
 }
 Method (_Q1F, 0, NotSerialized)
 {
  ^HKEY.RHK (0x12)
 }
 Method (_Q67, 0, NotSerialized)
 {
  ^HKEY.RHK (0x13)
 }
 Method (_Q63, 0, NotSerialized)
 {
  ^HKEY.RHK (0x14)
 }
 Method (_Q19, 0, NotSerialized)
 {
  ^HKEY.RHK (0x18)
 }
 Method (_Q1C, 0, NotSerialized)
 {
  ^HKEY.RHK (0x19)
 }
 Method (_Q1D, 0, NotSerialized)
 {
  ^HKEY.RHK (0x1A)
 }
 Method (_Q5C, 0, NotSerialized)
 {
  ^HKEY.RTAB (0xB)
 }
 Method (_Q5D, 0, NotSerialized)
 {
  ^HKEY.RTAB (0xC)
 }
 Method (_Q5E, 0, NotSerialized)
 {
  ^HKEY.RTAB (0x9)
 }
 Method (_Q5F, 0, NotSerialized)
 {
  ^HKEY.RTAB (0xA)
 }
 Method (FANE, 1, Serialized)
 {
  If (Arg0) {
   Store (One, FAND)
   Store (Zero, FANA)
  } Else {
   Store (Zero, FAND)
   Store (One, FANA)
  }
 }
Field(ERAM, ByteAcc, NoLock, Preserve)
{
  Offset (0x46),
    , 4,
       HPAC, 1
}
Device(AC)
{
 Name(_HID, "ACPI0003")
 Name(_UID, 0x00)
 Name(_PCL, Package() { \_SB } )
 Method(_PSR, 0, NotSerialized)
 {
  Store(HPAC, Local0)
  Store(Local0, \PWRS)
  \PNOT()
  return (Local0)
 }
 Method(_STA, 0, NotSerialized)
 {
  Return (0x0f)
 }
}
Field(ERAM, ByteAcc, NoLock, Preserve)
{
 Offset (0x38),
   B0ST, 4,
       , 1,
   B0CH, 1,
   B0DI, 1,
   B0PR, 1,
 Offset (0x39),
   B1ST, 4,
       , 1,
   B1CH, 1,
   B1DI, 1,
   B1PR, 1
}
Field (ERAM, ByteAcc, NoLock, Preserve)
{
 Offset(0xa0),
   BARC, 16,
   BAFC, 16,
 Offset(0xa8),
   BAPR, 16,
   BAVO, 16,
}
Field (ERAM, ByteAcc, NoLock, Preserve)
{
 Offset(0xa0),
       , 15,
   BAMA, 1,
}
Field (ERAM, ByteAcc, NoLock, Preserve)
{
 Offset(0xa0),
   BADC, 16,
   BADV, 16,
       , 16,
       , 16,
       , 16,
   BASN, 16,
}
Field (ERAM, ByteAcc, NoLock, Preserve)
{
 Offset(0xa0),
   BATY, 32
}
Field (ERAM, ByteAcc, NoLock, Preserve)
{
 Offset(0xa0),
   BAOE, 128
}
Field (ERAM, ByteAcc, NoLock, Preserve)
{
 Offset(0xa0),
   BANA, 128
}
Method(BPAG, 1, NotSerialized)
{
 Store(Arg0, PAGE)
}
Method(BSTA, 4, NotSerialized)
{
 Acquire(ECLK, 0xffff)
 Store(0, Local0)
 ^BPAG(Or(1, Arg0))
 Store(BAMA, Local1)
 ^BPAG(Arg0)
 Store(BAPR, Local2)
 If (Arg2)
 {
  Or(2, Local0, Local0)
 }
 Else
 {
  If (Arg3)
  {
   Or(1, Local0, Local0)
   Subtract(0x10000, Local2, Local2)
  }
  Else
  {
   Store(0, Local2)
  }
 }
 If (LGreaterEqual (Local2, 0x8000)) {
  Store(0, Local2)
 }
 Store(Local0, Index(Arg1, 0x00))
 if (Local1) {
  Multiply (BARC, 10, Index(Arg1, 2))
  Multiply (Local2, BAVO, Local2)
  Divide (Local2, 1000, , Index(Arg1, 1))
 } else {
  Store(BARC, Index(Arg1, 2))
  Store(Local2, Index(Arg1, 1))
 }
 Store(BAVO, Index(Arg1, 3))
 Release(ECLK)
 Return (Arg1)
}
Method(BINF, 2, Serialized)
{
 Acquire(ECLK, 0xffff)
 ^BPAG(Or(1, Arg1))
 Xor(BAMA, 1, Index(Arg0, 0))
 Store(BAMA, Local0)
 ^BPAG(Arg1)
 Store(BAFC, Local2)
 ^BPAG(Or(2, Arg1))
 Store(BADC, Local1)
 if (Local0)
 {
  Multiply (Local1, 10, Local1)
  Multiply (Local2, 10, Local2)
 }
 Store(Local1, Index(Arg0, 1))
 Store(Local2, Index(Arg0, 2))
 Store(BADV, Index(Arg0, 4))
 Divide (Local2, 20, Local0, Index(Arg0, 5))
 Store (BASN, Local0)
 Name (SERN, Buffer (0x06) { "     " })
 Store (4, Local1)
 While (Local0)
 {
  Divide (Local0, 0x0A, Local2, Local0)
  Add (Local2, 48, Index (SERN, Local1))
  Decrement (Local1)
 }
 Store (SERN, Index (Arg0, 10))
 ^BPAG(Or(4, Arg1))
 Name (TYPE, Buffer() { 0, 0, 0, 0, 0 })
 Store(BATY, TYPE)
 Store(TYPE, Index (Arg0, 11))
 ^BPAG(Or(5, Arg1))
 Store(BAOE, Index (Arg0, 12))
 ^BPAG(Or(6, Arg1))
 Store(BANA, Index (Arg0, 9))
 Release(ECLK)
 Return (Arg0)
}
Device (BAT0)
{
 Name (_HID, EisaId ("PNP0C0A"))
 Name (_UID, 0x00)
 Name (_PCL, Package () { \_SB })
 Name (BATS, Package ()
 {
  0x00,
  0xFFFFFFFF,
  0xFFFFFFFF,
  0x01,
  10800,
  0x00,
  200,
  1,
  1,
  "",
  "",
  "",
  ""
 })
 Method (_BIF, 0, NotSerialized)
 {
  Return (BINF(BATS, 0))
 }
 Name (BATI, Package ()
 {
  0,
  0,
  0,
  0
 })
 Method (_BST, 0, NotSerialized)
 {
  if (B0PR) {
   Return (BSTA(0, BATI, B0CH, B0DI))
  } else {
   Return (Package () { 0, 0, 0, 0 })
  }
 }
 Method (_STA, 0, NotSerialized)
 {
  if (B0PR) {
   Return (0x1f)
  } else {
   Return (0x0f)
  }
 }
}
Device (BAT1)
{
 Name (_HID, EisaId ("PNP0C0A"))
 Name (_UID, 0x00)
 Name (_PCL, Package () { \_SB })
 Name (BATS, Package ()
 {
  0x00,
  0xFFFFFFFF,
  0xFFFFFFFF,
  0x01,
  10800,
  0x00,
  200,
  1,
  1,
  "",
  "",
  "",
  ""
 })
 Method (_BIF, 0, NotSerialized)
 {
  Return (BINF(BATS, 0x10))
 }
 Name (BATI, Package ()
 {
  0,
  0,
  0,
  0
 })
 Method (_BST, 0, NotSerialized)
 {
  if (B1PR) {
   Return (BSTA(0x10, BATI, B1CH, B1DI))
  } else {
   Return (Package () { 0, 0, 0, 0 })
  }
 }
 Method (_STA, 0, NotSerialized)
 {
  if (B1PR) {
   Return (0x1f)
  } else {
   Return (0x0f)
  }
 }
}
Method(_Q24, 0, NotSerialized)
{
 Notify(BAT0, 0x80)
}
Method(_Q25, 0, NotSerialized)
{
 Notify(BAT1, 0x80)
}
Method(_Q4A, 0, NotSerialized)
{
 Notify(BAT0, 0x81)
}
Method(_Q4B, 0, NotSerialized)
{
 Notify(BAT0, 0x80)
}
Method(_Q4C, 0, NotSerialized)
{
 Notify(BAT1, 0x81)
}
Method(_Q4D, 0, NotSerialized)
{
 Notify(BAT1, 0x80)
}
Field(ERAM, ByteAcc, NoLock, Preserve)
{
  Offset (0x32),
       , 4,
   WKFN, 1,
  Offset(0x83),
   FNKY, 8
}
Device(SLPB)
{
 Name (_HID, EisaId ("PNP0C0E"))
 Method(_PRW, 0, NotSerialized)
 {
  Return (Package() { 0x18, 0x03 })
 }
 Method(_PSW, 1, NotSerialized)
 {
  if (Arg0) {
   Store(6, FNKY)
   Store(1, WKFN)
  } else {
   Store(0, FNKY)
   Store(0, WKFN)
  }
 }
}
Field(ERAM, ByteAcc, NoLock, Preserve)
{
  Offset (0x32),
       , 2,
   WKLD, 1,
  Offset (0x46),
       , 2,
   LIDS, 1
}
Device(LID)
{
 Name(_HID, "PNP0C0D")
 Method(_LID, 0, NotSerialized)
 {
  return (LIDS)
 }
 Method(_PRW, 0, NotSerialized)
 {
  Return (Package() { 0x18, 0x03 })
 }
 Method(_PSW, 1, NotSerialized)
 {
  if (Arg0) {
   Store(1, WKLD)
  } else {
   Store(0, WKLD)
  }
 }
}
Field(ERAM, ByteAcc, NoLock, Preserve)
{
  Offset (0x06),
   SNDS, 8
}
Method(BEEP, 1, NotSerialized)
{
 Store (Arg0, SNDS)
}
Scope(\_TZ)
{
 Method(C2K, 1, NotSerialized)
 {
  Multiply(Arg0, 10, Local0)
  Add (Local0, 2732, Local0)
  if (LLessEqual(Local0, 2732)) {
   Return (3000)
  }
  if (LGreater(Local0, 4012)) {
   Return (3000)
  }
  Return (Local0)
 }
 ThermalZone(THM0)
 {
  Name (_TZP, 100)
  Name (_TSP, 100)
  Name (_TC1, 0x02)
  Name (_TC2, 0x05)
External (\PPKG, MethodObj)
  Method (_PSL, 0, Serialized)
  {
   Return (\PPKG ())
  }
  Method (GCRT, 0, NotSerialized) {
   Store (\TCRT, Local0)
   if (LGreater (Local0, 0)) {
    Return (Local0)
   }
   Return (127)
  }
  Method (GPSV, 0, NotSerialized) {
   Store (\TPSV, Local0)
   if (LGreater (Local0, 0)) {
    Return (Local0)
   }
   Return (95)
  }
  Method (_CRT, 0, NotSerialized) {
   Return (C2K (GCRT ()))
  }
  Method (_PSV, 0, NotSerialized) {
   Return (C2K (GPSV ()))
  }
  Method(_TMP) {
   Return (C2K(\_SB.PCI0.LPCB.EC.TMP0))
  }
  Method (_AC0) {
   Store (GPSV (), Local0)
   Subtract (Local0, 10, Local0)
   If (\FLVL) {
    Subtract (Local0, 5, Local0)
   }
   Return (C2K (Local0))
  }
  Name (_AL0, Package () { FAN })
  PowerResource (FPwR, 0, 0)
  {
   Method (_STA) {
    Return (\FLVL)
   }
   Method (_ON) {
    \_SB.PCI0.LPCB.EC.FANE(One)
    Store (One, \FLVL)
    Notify (\_TZ.THM0, 0x81)
   }
   Method (_OFF) {
    \_SB.PCI0.LPCB.EC.FANE(Zero)
    Store (Zero, \FLVL)
    Notify (\_TZ.THM0, 0x81)
   }
  }
  Device (FAN)
  {
   Name (_HID, EISAID ("PNP0C0B"))
   Name (_PR0, Package () { FPwR })
  }
 }
 ThermalZone(THM1)
 {
  Name (_TZP, 100)
  Name (_TSP, 100)
  Name (_TC1, 0x02)
  Name (_TC2, 0x05)
  Method (_PSL, 0, Serialized)
  {
   Return (\PPKG ())
  }
  Method (_CRT, 0, NotSerialized) {
   Return (C2K (99))
  }
  Method (_PSV, 0, NotSerialized) {
   Return (C2K (94))
  }
  Method(_TMP) {
   Return (C2K(\_SB.PCI0.LPCB.EC.TMP1))
  }
 }
}
Scope (\_SI)
{
 Method(_SST, 1, NotSerialized)
 {
  If (LEqual (Arg0, 0)) {
   \_SB.PCI0.LPCB.EC.TLED(0x00)
   \_SB.PCI0.LPCB.EC.TLED(0x07)
  }
  If (LEqual (Arg0, 1)) {
   \_SB.PCI0.LPCB.EC.TLED(0x80)
   \_SB.PCI0.LPCB.EC.TLED(0x07)
  }
  If (LEqual (Arg0, 2)) {
   \_SB.PCI0.LPCB.EC.TLED(0x80)
   \_SB.PCI0.LPCB.EC.TLED(0xc7)
  }
  If (LEqual (Arg0, 3)) {
   \_SB.PCI0.LPCB.EC.TLED(0xa0)
   \_SB.PCI0.LPCB.EC.TLED(0x87)
  }
 }
}
Device (HKEY)
{
 External (\HBDC, IntObj)
 External (\HWAN, IntObj)
 External (\HKBL, IntObj)
 External (\HUWB, IntObj)
 Name (_HID, EisaId ("IBM0068"))
 Name (BTN, 0)
 Name (BTAB, 0)
 Name (DHKN, 0x080C)
 Name (EMSK, 0)
 Name (ETAB, 0)
 Name (EN, 0)
 Method (_STA, 0, NotSerialized)
 {
  Return (0x0F)
 }
 Method (MHKP, 0, NotSerialized)
 {
  Store (BTN, Local0)
  If (LNotEqual (Local0, Zero)) {
   Store (Zero, BTN)
   Add (Local0, 0x1000, Local0)
   Return (Local0)
  }
  Store (BTAB, Local0)
  If (LNotEqual (Local0, Zero)) {
   Store (Zero, BTAB)
   Add (Local0, 0x5000, Local0)
   Return (Local0)
  }
  Return (Zero)
 }
 Method (RHK, 1, NotSerialized) {
  ShiftLeft (One, Subtract (Arg0, 1), Local0)
  If (And (EMSK, Local0)) {
   Store (Arg0, BTN)
   Notify (HKEY, 0x80)
  }
 }
 Method (RTAB, 1, NotSerialized) {
  ShiftLeft (One, Subtract (Arg0, 1), Local0)
  If (And (ETAB, Local0)) {
   Store (Arg0, BTAB)
   Notify (HKEY, 0x80)
  }
 }
 Method (MHKC, 1, NotSerialized) {
  If (Arg0) {
   Store (DHKN, EMSK)
   Store (Ones, ETAB)
  }
  Else
  {
   Store (Zero, EMSK)
   Store (Zero, ETAB)
  }
  Store (Arg0, EN)
 }
 Method (MHKM, 2, NotSerialized) {
  If (LLessEqual (Arg0, 0x20)) {
   ShiftLeft (One, Subtract (Arg0, 1), Local0)
   If (Arg1)
   {
    Or (DHKN, Local0, DHKN)
   }
   Else
   {
    And (DHKN, Not (Local0), DHKN)
   }
   If (EN)
   {
    Store (DHKN, EMSK)
   }
  }
 }
 Method (MHKA, 0, NotSerialized)
 {
  Return (0x07FFFFFF)
 }
 Method (MHKG, 0, NotSerialized)
 {
  Return (ShiftLeft(TBSW, 3))
 }
 Method (SSMS, 1, NotSerialized)
 {
  Store(Arg0, ALMT)
 }
 Method (MMTS, 1, NotSerialized)
 {
  If (Arg0)
  {
   TLED(0x8E)
  }
  Else
  {
   TLED(0x0E)
  }
 }
 Method (MHKV, 0, NotSerialized)
 {
  Return (0x0100)
 }
 Method (WLSW, 0, NotSerialized)
 {
  Return (\_SB.PCI0.LPCB.EC.GSTS)
 }
 Name (INIT, 0)
 Name (HAST, 0)
 Name (WBDC, 0)
 Method (GBDC, 0)
 {
  Store (One, HAST)
  If (HBDC) {
   Store(One, Local0)
   If(\_SB.PCI0.LPCB.EC.BTEB)
   {
    Or(Local0, 2, Local0)
   }
   Or(Local0, ShiftLeft(WBDC, 2), Local0)
   Return (Local0)
  } Else {
   Return (0)
  }
 }
 Method (SBDC, 1)
 {
  Store (One, HAST)
  If (HBDC) {
   ShiftRight (And(Arg0, 2), 1, Local0)
   Store (Local0, \_SB.PCI0.LPCB.EC.BTEB)
   ShiftRight (And(Arg0, 4), 2, Local0)
   Store (Local0, WBDC)
  }
 }
 Name (WWAN, 0)
 Method (GWAN, 0)
 {
  Store (One, HAST)
  If (HWAN) {
   Store(One, Local0)
   If(\_SB.PCI0.LPCB.EC.WWEB)
   {
    Or(Local0, 2, Local0)
   }
   Or(Local0, ShiftLeft(WWAN, 2), Local0)
   Return (Local0)
  } Else {
   Return (0)
  }
 }
 Method (SWAN, 1)
 {
  Store (One, HAST)
  If (HWAN) {
   ShiftRight (And(Arg0, 2), 1, Local0)
   Store (Local0, \_SB.PCI0.LPCB.EC.WWEB)
   ShiftRight (And(Arg0, 4), 2, WWAN)
  }
 }
 Method (MLCG, 1)
 {
  If (HKBL) {
   Store (0x200, Local0)
   Or (Local0, \_SB.PCI0.LPCB.EC.KBLT, Local0)
   Return (Local0)
  } Else {
   Return (0)
  }
 }
 Method (MLCS, 1)
 {
  If (HKBL) {
   Store (And(Arg0, 1), \_SB.PCI0.LPCB.EC.WWEB)
  }
 }
 Method (GUWB, 0)
 {
  If (HUWB) {
   Store (One, Local0)
   If(\_SB.PCI0.LPCB.EC.UWBE)
   {
    Or(Local0, 2, Local0)
   }
   Return (Local0)
  } Else {
   Return (0)
  }
 }
 Method (SUWB, 1)
 {
  If (HUWB) {
   ShiftRight (And(Arg0, 2), 1, Local0)
   Store (Local0, \_SB.PCI0.LPCB.EC.UWBE)
  }
 }
 Method (WAKE, 1)
 {
  If (HAST) {
   Store (WBDC, \_SB.PCI0.LPCB.EC.BTEB)
   Store (WWAN, \_SB.PCI0.LPCB.EC.WWEB)
  }
 }
Method (BCSS, 1, NotSerialized)
{
 Local0 = Arg0 & 0xff
 Local1 = (Arg0 >> 8) & 0x3
 If (Local1 == 0)
 {
  \_SB.PCI0.LPCB.EC.BAT0.SETT(1, Local0)
  \_SB.PCI0.LPCB.EC.BAT1.SETT(1, Local0)
  Local2 = Local0 != \_SB.PCI0.LPCB.EC.BAT0.GETT(1)
  Local3 = Local0 != \_SB.PCI0.LPCB.EC.BAT1.GETT(1)
  Return ((Local2 && Local3) << 31)
 }
 If (Local1 == 1)
 {
  \_SB.PCI0.LPCB.EC.BAT0.SETT(1, Local0)
  Return ((Local0 !=
   \_SB.PCI0.LPCB.EC.BAT0.GETT(1)) << 31)
 }
 If (Local1 == 2)
 {
  \_SB.PCI0.LPCB.EC.BAT1.SETT(1, Local0)
  Return ((Local0 !=
   \_SB.PCI0.LPCB.EC.BAT1.GETT(1)) << 31)
 }
 Return (1 << 31)
}
Method (BCCS, 1, NotSerialized)
{
 Local0 = Arg0 & 0xff
 Local1 = (Arg0 >> 8) & 0x3
 If (Local1 == 0)
 {
  \_SB.PCI0.LPCB.EC.BAT0.SETT(0, Local0)
  \_SB.PCI0.LPCB.EC.BAT1.SETT(0, Local0)
  Local2 = Local0 != \_SB.PCI0.LPCB.EC.BAT0.GETT(0)
  Local3 = Local0 != \_SB.PCI0.LPCB.EC.BAT1.GETT(0)
  Return ((Local2 && Local3) << 31)
 }
 If (Local1 == 1)
 {
  \_SB.PCI0.LPCB.EC.BAT0.SETT(0, Local0)
  Return ((Local0 !=
   \_SB.PCI0.LPCB.EC.BAT0.GETT(0)) << 31)
 }
 If (Local1 == 2)
 {
  \_SB.PCI0.LPCB.EC.BAT1.SETT(0, Local0)
  Return ((Local0 !=
   \_SB.PCI0.LPCB.EC.BAT1.GETT(0)) << 31)
 }
 Return (1 << 31)
}
Method (BCSG, 1, NotSerialized)
{
 If (Arg0 == 1)
 {
  Return (0x300 | \_SB.PCI0.LPCB.EC.BAT0.GETT(1))
 }
 If (Arg0 == 2)
 {
  Return (0x300 | \_SB.PCI0.LPCB.EC.BAT1.GETT(1))
 }
 Return (1 << 31)
}
Method (BCTG, 1, NotSerialized)
{
 If (Arg0 == 1)
 {
  Return (0x300 | \_SB.PCI0.LPCB.EC.BAT0.GETT(0))
 }
 If (Arg0 == 2)
 {
  Return (0x300 | \_SB.PCI0.LPCB.EC.BAT1.GETT(0))
 }
 Return (1 << 31)
}
}
}
Scope(\_SB.PCI0.LPCB.EC)
{
 Field (ERAM, ByteAcc, NoLock, Preserve)
 {
  Offset (0x03),
    , 2,
    BSTP, 1,
  Offset (0x24),
    TSH0, 8,
  Offset (0x25),
    TSH1, 8,
 }
}
Scope(\_SB.PCI0.LPCB.EC.BAT0)
{
 Method (SETT, 2, NotSerialized)
 {
  if (Arg0 <= 1 && Arg1 <= 100)
  {
   BSTP = Arg0
   TSH0 = Arg1 | 0x80
  }
 }
 Method (GETT, 1, NotSerialized)
 {
  if (Arg0 <= 1)
  {
   BSTP = Arg0
   Return (TSH0 & ~0x80)
  }
  Return (0)
 }
}
Scope(\_SB.PCI0.LPCB.EC.BAT1)
{
 Method (SETT, 2, NotSerialized)
 {
  if (Arg0 <= 1 && Arg1 <= 100)
  {
   BSTP = Arg0
   TSH1 = Arg1 | 0x80
  }
 }
 Method (GETT, 1, NotSerialized)
 {
  if (Arg0 <= 1)
  {
   BSTP = Arg0
   Return (TSH1 & ~0x80)
  }
  Return (0)
 }
}
 Device (DMAC)
 {
  Name(_HID, EISAID("PNP0200"))
  Name(_CRS, ResourceTemplate()
  {
   IO (Decode16, 0x00, 0x00, 0x01, 0x20)
   IO (Decode16, 0x81, 0x81, 0x01, 0x11)
   IO (Decode16, 0x93, 0x93, 0x01, 0x0d)
   IO (Decode16, 0xc0, 0xc0, 0x01, 0x20)
   DMA (Compatibility, NotBusMaster, Transfer8_16) { 4 }
  })
 }
 Device (FWH)
 {
  Name (_HID, EISAID("INT0800"))
  Name (_CRS, ResourceTemplate()
  {
   Memory32Fixed(ReadOnly, 0xff000000, 0x01000000)
  })
 }
 Device (HPET)
 {
  Name (_HID, EISAID("PNP0103"))
  Name (_CID, 0x010CD041)
  Name(BUF0, ResourceTemplate()
  {
   Memory32Fixed(ReadOnly, 0xfed00000, 0x400, FED0)
  })
  Method (_STA, 0)
  {
   If (HPTE) {
    If (LGreaterEqual(OSYS, 2001)) {
     Return (0xf)
    } Else {
     Return (0xb)
    }
   }
   Return (0x0)
  }
  Method (_CRS, 0, Serialized)
  {
   If (HPTE) {
    CreateDWordField(BUF0, \_SB.PCI0.LPCB.HPET.FED0._BAS, HPT0)
    If (Lequal(HPAS, 1)) {
     Add(0xfed00000, 0x1000, HPT0)
    }
    If (Lequal(HPAS, 2)) {
     Add(0xfed00000, 0x2000, HPT0)
    }
    If (Lequal(HPAS, 3)) {
     Add(0xfed00000, 0x3000, HPT0)
    }
   }
   Return (BUF0)
  }
 }
 Device(PIC)
 {
  Name(_HID,EISAID("PNP0000"))
  Name(_CRS, ResourceTemplate()
  {
   IO (Decode16, 0x20, 0x20, 0x01, 0x02)
   IO (Decode16, 0x24, 0x24, 0x01, 0x02)
   IO (Decode16, 0x28, 0x28, 0x01, 0x02)
   IO (Decode16, 0x2c, 0x2c, 0x01, 0x02)
   IO (Decode16, 0x30, 0x30, 0x01, 0x02)
   IO (Decode16, 0x34, 0x34, 0x01, 0x02)
   IO (Decode16, 0x38, 0x38, 0x01, 0x02)
   IO (Decode16, 0x3c, 0x3c, 0x01, 0x02)
   IO (Decode16, 0xa0, 0xa0, 0x01, 0x02)
   IO (Decode16, 0xa4, 0xa4, 0x01, 0x02)
   IO (Decode16, 0xa8, 0xa8, 0x01, 0x02)
   IO (Decode16, 0xac, 0xac, 0x01, 0x02)
   IO (Decode16, 0xb0, 0xb0, 0x01, 0x02)
   IO (Decode16, 0xb4, 0xb4, 0x01, 0x02)
   IO (Decode16, 0xb8, 0xb8, 0x01, 0x02)
   IO (Decode16, 0xbc, 0xbc, 0x01, 0x02)
   IO (Decode16, 0x4d0, 0x4d0, 0x01, 0x02)
   IRQNoFlags () { 2 }
  })
 }
 Device(MATH)
 {
  Name (_HID, EISAID("PNP0C04"))
  Name (_CRS, ResourceTemplate()
  {
   IO (Decode16, 0xf0, 0xf0, 0x01, 0x01)
   IRQNoFlags() { 13 }
  })
 }
 Device(LDRC)
 {
  Name (_HID, EISAID("PNP0C02"))
  Name (_UID, 2)
  Name (_CRS, ResourceTemplate()
  {
   IO (Decode16, 0x2e, 0x2e, 0x1, 0x02)
   IO (Decode16, 0x4e, 0x4e, 0x1, 0x02)
   IO (Decode16, 0x61, 0x61, 0x1, 0x01)
   IO (Decode16, 0x63, 0x63, 0x1, 0x01)
   IO (Decode16, 0x65, 0x65, 0x1, 0x01)
   IO (Decode16, 0x67, 0x67, 0x1, 0x01)
   IO (Decode16, 0x80, 0x80, 0x1, 0x01)
   IO (Decode16, 0x92, 0x92, 0x1, 0x01)
   IO (Decode16, 0xb2, 0xb2, 0x1, 0x02)
   IO (Decode16, 0x800, 0x800, 0x1, 0x10)
   IO (Decode16, 0x00000500, 0x00000500, 0x1, 0x80)
   IO (Decode16, 0x00000580, 0x00000580, 0x1, 0x40)
  })
 }
 Device (RTC)
 {
  Name (_HID, EISAID("PNP0B00"))
  Name (_CRS, ResourceTemplate()
  {
   IO (Decode16, 0x70, 0x70, 1, 8)
  })
 }
 Device (TIMR)
 {
  Name(_HID, EISAID("PNP0100"))
  Name(_CRS, ResourceTemplate()
  {
   IO (Decode16, 0x40, 0x40, 0x01, 0x04)
   IO (Decode16, 0x50, 0x50, 0x10, 0x04)
   IRQNoFlags() {0}
  })
 }
 Device (PS2K)
 {
  Name(_HID, EISAID("PNP0303"))
  Name(_CID, EISAID("PNP030B"))
  Name(_CRS, ResourceTemplate()
  {
   IO (Decode16, 0x60, 0x60, 0x01, 0x01)
   IO (Decode16, 0x64, 0x64, 0x01, 0x01)
   IRQ (Edge, ActiveHigh, Exclusive) { 0x01 }
  })
  Method (_STA, 0)
  {
   Return (0xf)
  }
 }
 Device (PS2M)
 {
  Name(_HID, EISAID("PNP0F13"))
  Name(_CRS, ResourceTemplate()
  {
   IRQ (Edge, ActiveHigh, Exclusive) { 0x0c }
  })
  Method(_STA, 0)
  {
   Return (0xf)
  }
 }
}
Device (AHC1)
{
 Name (_ADR, 0x001f0002)
 Device (PRID)
 {
  Name (_ADR, 0)
  Method (_GTM, 0, Serialized)
  {
   Name(PBUF, Buffer(20) {
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00 })
   CreateDwordField (PBUF, 0, PIO0)
   CreateDwordField (PBUF, 4, DMA0)
   CreateDwordField (PBUF, 8, PIO1)
   CreateDwordField (PBUF, 12, DMA1)
   CreateDwordField (PBUF, 16, FLAG)
   Return (PBUF)
  }
  Method (_STM, 3)
  {
   CreateDwordField (Arg0, 0, PIO0)
   CreateDwordField (Arg0, 4, DMA0)
   CreateDwordField (Arg0, 8, PIO1)
   CreateDwordField (Arg0, 12, DMA1)
   CreateDwordField (Arg0, 16, FLAG)
  }
  Device (DSK0)
  {
   Name (_ADR, 0)
  }
  Device (DSK1)
  {
   Name (_ADR, 1)
  }
 }
}
Device (AHC2)
{
 Name (_ADR, 0x001f0005)
 Device (PRID)
 {
  Name (_ADR, 0)
  Method (_GTM, 0, Serialized)
  {
   Name(PBUF, Buffer(20) {
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00 })
   CreateDwordField (PBUF, 0, PIO0)
   CreateDwordField (PBUF, 4, DMA0)
   CreateDwordField (PBUF, 8, PIO1)
   CreateDwordField (PBUF, 12, DMA1)
   CreateDwordField (PBUF, 16, FLAG)
   Return (PBUF)
  }
  Method (_STM, 3)
  {
   CreateDwordField (Arg0, 0, PIO0)
   CreateDwordField (Arg0, 4, DMA0)
   CreateDwordField (Arg0, 8, PIO1)
   CreateDwordField (Arg0, 12, DMA1)
   CreateDwordField (Arg0, 16, FLAG)
  }
  Device (DSK0)
  {
   Name (_ADR, 0)
  }
  Device (DSK1)
  {
   Name (_ADR, 1)
  }
 }
}
Device (SBUS)
{
 Name (_ADR, 0x001f0003)
}
Method (_OSC, 4)
{
 If (LEqual (Arg0, ToUUID("33DB4D5B-1FF7-401C-9657-7441C03DD766")))
 {
  Return (Arg3)
 }
 Else
 {
  CreateDWordField (Arg3, 0, CDW1)
  Or (CDW1, 4, CDW1)
  Return (Arg3)
 }
}
Device (GFX0)
{
 Name (_ADR, 0x00020000)
 OperationRegion (GFXC, PCI_Config, 0x00, 0x0100)
 Field (GFXC, DWordAcc, NoLock, Preserve)
 {
  Offset (0x10),
  BAR0, 64,
  Offset (0xe4),
  ASLE, 32,
  Offset (0xfc),
  ASLS, 32,
 }
 OperationRegion (GFRG, SystemMemory, And (BAR0, 0xfffffffffffffff0), 0x400000)
 Field (GFRG, DWordAcc, NoLock, Preserve)
 {
  Offset (0x61254),
  BCLV, 16,
  Offset (0x61256),
  BCLM, 16
 }
 Device (BOX3)
 {
  Name (_ADR, 0)
  OperationRegion (OPRG, SystemMemory, ASLS, 0x2000)
  Field (OPRG, DWordAcc, NoLock, Preserve)
  {
   Offset (0x58),
   MBOX, 32,
   Offset (0x300),
   ARDY, 1,
   , 31,
   ASLC, 32,
   TCHE, 32,
   ALSI, 32,
   BCLP, 32,
   PFIT, 32,
   CBLV, 32,
  }
  Method (XBCM, 1, Serialized)
  {
   If (LEqual(ASLS, Zero))
   {
    Return (Ones)
   }
   If (LEqual(And(MBOX, 0x4), Zero))
   {
    Return (Ones)
   }
   Store (Divide (Multiply (Arg0, 255), 100), Local1)
   If (LGreater(Local1, 255)) {
    Store (255, Local1)
   }
   Store (Or (Local1, 0x80000000), BCLP)
   If (LEqual(ARDY, Zero))
   {
    Return (Ones)
   }
   Store (0x2, ASLC)
   Store (0x1, ASLE)
   Store (0x20, Local0)
   While (LGreater(Local0, Zero))
   {
    Sleep (1)
    If (LEqual (And (ASLC, 0x2), 0)) {
     And (ShiftRight (ASLC, 12), 0x3, Local1)
     If (LEqual (Local1, 0)) {
      Return (Zero)
     } Else {
      Return (Ones)
     }
    }
    Decrement (Local0)
   }
   Return (Ones)
  }
 }
 Device (LEGA)
 {
  Name (_ADR, 0)
  Method (DRCL, 2)
  {
   Return (Divide (Add (Arg0, Divide (Arg1, 2)), Arg1))
  }
  Method (XBCM, 1, NotSerialized)
  {
   Store (DRCL (Multiply (Arg0, BCLM), 100), BCLV)
  }
  Method (XBQC, 0, NotSerialized)
  {
   If (BCLM == 0)
   {
    Return (Zero)
   }
   Store (DRCL (Multiply (BCLV, 100), BCLM), Local0)
   Store (2, Local1)
   While (LLess (Local1, Subtract (SizeOf (BRIG), 1))) {
    Store (DeRefOf (Index (BRIG, Local1)), Local2)
    Store (DeRefOf (Index (BRIG, Add (Local1, 1))), Local3)
    If (LLess (Local0, Local3)) {
     If (LOr (LLess (Local0, Local2),
       LLess (Subtract (Local0, Local2),
       Subtract (Local3, Local0)))) {
      Return (Local2)
     } Else {
      Return (Local3)
     }
    }
    Increment (Local1)
   }
   Return (Local3)
  }
 }
 Method (XBCM, 1, NotSerialized)
 {
  If (LEqual(^BOX3.XBCM (Arg0), Ones))
  {
   ^LEGA.XBCM (Arg0)
  }
 }
 Method (XBQC, 0, NotSerialized)
 {
  Return (^LEGA.XBQC ())
 }
 External(LCD0, DeviceObj)
 Name (BRCT, 0)
 Method(BRID, 1, NotSerialized)
 {
  Store (Match (BRIG, MEQ, Arg0, MTR, Zero, 2), Local0)
  If (LEqual (Local0, Ones))
  {
   Return (Subtract(SizeOf(BRIG), One))
  }
  Return (Local0)
 }
 Method (XBCL, 0, NotSerialized)
 {
  Store (1, BRCT)
  Return (BRIG)
 }
 Method (_DOS, 1)
 {
 }
 Method (DECB, 0, NotSerialized)
 {
  If (BRCT)
  {
   Notify (LCD0, 0x87)
  } Else {
   Store (BRID (XBQC ()), Local0)
   If (LNotEqual (Local0, 2))
   {
    Decrement (Local0)
   }
   XBCM (DerefOf (Index (BRIG, Local0)))
  }
 }
 Method (INCB, 0, NotSerialized)
 {
  If (BRCT)
  {
   Notify (LCD0, 0x86)
  } Else {
   Store (BRID (XBQC ()), Local0)
   If (LNotEqual (Local0, Subtract(SizeOf(BRIG), One)))
   {
    Increment (Local0)
   }
   XBCM (DerefOf (Index (BRIG, Local0)))
  }
 }
}
Scope (GFX0)
{
 Name (BRIG, Package (0x12)
 {
  100,
  100,
    2,
    4,
    5,
    7,
    9,
   11,
   13,
   18,
   20,
   24,
   29,
   33,
   40,
   50,
   67,
  100,
 })
}
  }
 }
Name(\_S0, Package(){0x0,0x0,0x0,0x0})
Name(\_S3, Package(){0x5,0x0,0x0,0x0})
Name(\_S4, Package(){0x6,0x0,0x0,0x0})
Name(\_S5, Package(){0x7,0x0,0x0,0x0})
Scope (\_SB)
{
 Device(DOCK)
 {
  Name(_HID, "ACPI0003")
  Name(_UID, 0x00)
  Name(_PCL, Package() { \_SB } )
  Method(_DCK, 1, NotSerialized)
  {
   if (Arg0) {
      Store (1, \GP28)
      Store (1, \_SB.PCI0.LPCB.EC.DKR1)
   } else {
      Store (0, \GP28)
      Store (0, \_SB.PCI0.LPCB.EC.DKR1)
   }
   Xor(Arg0, \_SB.PCI0.LPCB.EC.DKR1, Local0)
   Return (Local0)
  }
  Method(_STA, 0, NotSerialized)
  {
   Return (\_SB.PCI0.LPCB.EC.DKR1)
  }
  Name (G_ID, 0xFFFFFFFF)
  Method(GGID, 0, NotSerialized)
  {
   Store(G_ID, Local0)
   if (LEqual(Local0, 0xFFFFFFFF))
   {
    Store(Or (Or (GP02, ShiftLeft(GP03, 1)),
      ShiftLeft(GP04, 2)), Local0)
    If (LEqual(Local0, 0x00))
    {
     Store(0x03, Local0)
    }
    Store(Local0, G_ID)
   }
   return (Local0)
  }
 }
}
Scope(\_SB.PCI0.LPCB.EC)
{
 Method(_Q18, 0, NotSerialized)
 {
  Notify(\_SB.DOCK, 3)
 }
 Method(_Q37, 0, NotSerialized)
 {
  Notify(\_SB.DOCK, 0)
 }
 Method(_Q45, 0, NotSerialized)
 {
  Notify(\_SB.DOCK, 3)
 }
 Method(_Q50, 0, NotSerialized)
 {
  Store(\_SB.DOCK.GGID (), Local0)
  if (LNotEqual(Local0, 0x07))
  {
   Notify(\_SB.DOCK, 3)
  }
 }
 Method(_Q58, 0, NotSerialized)
 {
  Notify(\_SB.DOCK, 0)
 }
 Method(_Q5A, 0, NotSerialized)
 {
  Store(\_SB.DOCK.GGID (), Local0)
  if (LEqual(Local0, 0x07))
  {
   Notify(\_SB.DOCK, 3)
  }
  if (LEqual(Local0, 0x03))
  {
   Sleep(0x64)
   Store(DKR1, Local1)
   if (LEqual(Local1, 1))
   {
    Notify(\_SB.DOCK, 0)
   }
  }
 }
}
Method(UCMS, 1, Serialized)
{
 Switch(ToInteger(Arg0))
 {
  Case (0x0c)
  {
   \_SB.PCI0.LPCB.EC.LGHT(1)
  }
  Case (0x0d)
  {
   \_SB.PCI0.LPCB.EC.LGHT(0)
  }
 }
}
}
