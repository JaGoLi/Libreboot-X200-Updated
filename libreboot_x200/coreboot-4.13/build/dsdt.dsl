/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200717 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of build/dsdt.aml, Thu Dec 17 16:12:31 2020
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x000039D4 (14804)
 *     Revision         0x02
 *     Checksum         0xBE
 *     OEM ID           "COREv4"
 *     OEM Table ID     "COREBOOT"
 *     OEM Revision     0x20090419 (537461785)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200717 (538969879)
 */
DefinitionBlock ("", "DSDT", 2, "COREv4", "COREBOOT", 0x20090419)
{
    External (_SB_.CNOT, MethodObj)    // 1 Arguments
    External (_SB_.CP00, DeviceObj)
    External (_SB_.CP00._PPC, UnknownObj)
    External (_SB_.CP01._PPC, UnknownObj)
    External (_SB_.PCI0.GFX0.LCD0, DeviceObj)
    External (HBDC, IntObj)
    External (HKBL, IntObj)
    External (HUWB, IntObj)
    External (HWAN, IntObj)
    External (NVSA, UnknownObj)
    External (PPKG, MethodObj)    // 0 Arguments

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        \_SB.PCI0.LPCB.EC.MUTE (One)
        \_SB.PCI0.LPCB.EC.USBP (Zero)
        \_SB.PCI0.LPCB.EC.RADI (Zero)
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        \_SB.PCI0.LPCB.EC.HKEY.WAKE (Arg0)
        If ((Arg0 == 0x03)){}
        If ((Arg0 == 0x04)){}
        Return (Package (0x02)
        {
            Zero, 
            Zero
        })
    }

    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            GOS ()
            If (((OSYS == 0x07D1) && MPEN)){}
        }
    }

    Name (PICM, Zero)
    OperationRegion (GNVS, SystemMemory, NVSA, 0x0100)
    Field (GNVS, ByteAcc, NoLock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        SCIF,   8, 
        PRM2,   8, 
        PRM3,   8, 
        LCKF,   8, 
        PRM4,   8, 
        PRM5,   8, 
        P80D,   32, 
        LIDS,   8, 
        PWRS,   8, 
        DBGS,   8, 
        LINX,   8, 
        DCKN,   8, 
        ACTT,   8, 
        TPSV,   8, 
        TC1V,   8, 
        TC2V,   8, 
        TSPV,   8, 
        TCRT,   8, 
        DTSE,   8, 
        DTS1,   8, 
        FLVL,   8, 
        Offset (0x1E), 
        BNUM,   8, 
        B0SC,   8, 
        B1SC,   8, 
        B2SC,   8, 
        B0SS,   8, 
        B1SS,   8, 
        B2SS,   8, 
        Offset (0x28), 
        APIC,   8, 
        MPEN,   8, 
        PCP0,   8, 
        PCP1,   8, 
        PPCM,   8, 
        Offset (0x32), 
        NATP,   8, 
        CMAP,   8, 
        CMBP,   8, 
        LPTP,   8, 
        FDCP,   8, 
        RFDV,   8, 
        HOTK,   8, 
        RTCF,   8, 
        UTIL,   8, 
        ACIN,   8, 
        IGDS,   8, 
        TLST,   8, 
        CADL,   8, 
        PADL,   8, 
        Offset (0x64), 
        BLCS,   8, 
        BRTL,   8, 
        ODDS,   8, 
        Offset (0x6E), 
        ALSE,   8, 
        ALAF,   8, 
        LLOW,   8, 
        LHIH,   8, 
        Offset (0x78), 
        EMAE,   8, 
        EMAP,   16, 
        EMAL,   16, 
        Offset (0x82), 
        MEFE,   8, 
        Offset (0x8C), 
        TPMP,   8, 
        TPME,   8, 
        Offset (0x96), 
        GTF0,   56, 
        GTF1,   56, 
        GTF2,   56, 
        IDEM,   8, 
        IDET,   8, 
        Offset (0xF0), 
        DOCK,   8, 
        BTEN,   8
    }

    OperationRegion (APMP, SystemIO, 0xB2, 0x02)
    Field (APMP, ByteAcc, NoLock, Preserve)
    {
        APMC,   8, 
        APMS,   8
    }

    OperationRegion (POST, SystemIO, 0x80, One)
    Field (POST, ByteAcc, Lock, Preserve)
    {
        DBG0,   8
    }

    Method (TRAP, 1, Serialized)
    {
        SMIF = Arg0
        TRP0 = Zero
        Return (SMIF) /* \SMIF */
    }

    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        PICM = Arg0
    }

    Method (GOS, 0, NotSerialized)
    {
        OSYS = 0x07D0
        If (CondRefOf (_OSI))
        {
            If (_OSI ("Windows 2001"))
            {
                OSYS = 0x07D1
            }

            If (_OSI ("Windows 2001 SP1"))
            {
                OSYS = 0x07D1
            }

            If (_OSI ("Windows 2001 SP2"))
            {
                OSYS = 0x07D2
            }

            If (_OSI ("Windows 2006"))
            {
                OSYS = 0x07D6
            }
        }
    }

    Scope (_GPE)
    {
        Method (_L18, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Local0 = \_SB.PCI0.LPCB.EC.WAKE
            Local0++
        }
    }

    Method (PNOT, 0, NotSerialized)
    {
        If (MPEN)
        {
            \_SB.CNOT (0x80)
            Sleep (0x64)
            \_SB.CNOT (0x81)
        }
        Else
        {
            Notify (\_SB.CP00, 0x80) // Status Change
            Sleep (0x64)
            Notify (\_SB.CP00, 0x81) // Information Change
        }
    }

    Scope (_SB)
    {
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_BBN, Zero)  // _BBN: BIOS Bus Number
            Device (MCHC)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (MCHP, PCI_Config, Zero, 0x0100)
                Field (MCHP, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x40), 
                    EPEN,   1, 
                        ,   11, 
                    EPBR,   24, 
                    Offset (0x48), 
                    MHEN,   1, 
                        ,   13, 
                    MHBR,   22, 
                    Offset (0x60), 
                    PXEN,   1, 
                    PXSZ,   2, 
                        ,   23, 
                    PXBR,   10, 
                    Offset (0x68), 
                    DMEN,   1, 
                        ,   11, 
                    DMBR,   24, 
                    Offset (0x90), 
                        ,   4, 
                    PM0H,   2, 
                    Offset (0x91), 
                    PM1L,   2, 
                        ,   2, 
                    PM1H,   2, 
                    Offset (0x92), 
                    PM2L,   2, 
                        ,   2, 
                    PM2H,   2, 
                    Offset (0x93), 
                    PM3L,   2, 
                        ,   2, 
                    PM3H,   2, 
                    Offset (0x94), 
                    PM4L,   2, 
                        ,   2, 
                    PM4H,   2, 
                    Offset (0x95), 
                    PM5L,   2, 
                        ,   2, 
                    PM5H,   2, 
                    Offset (0x96), 
                    PM6L,   2, 
                        ,   2, 
                    PM6H,   2, 
                    Offset (0x97), 
                    Offset (0xA0), 
                    TOM,    8, 
                    Offset (0xB0), 
                        ,   4, 
                    TLUD,   12
                }
            }

            Name (MCRS, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000CF7,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000CF8,         // Length
                    ,, , TypeStatic, DenseTranslation)
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000D00,         // Range Minimum
                    0x0000FFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0000F300,         // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000F0000,         // Range Minimum
                    0x000FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00010000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0xFEBFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0xFEC00000,         // Length
                    ,, _Y00, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFED40000,         // Range Minimum
                    0xFED44FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00005000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                CreateDWordField (MCRS, \_SB.PCI0._Y00._MIN, PMIN)  // _MIN: Minimum Base Address
                CreateDWordField (MCRS, \_SB.PCI0._Y00._MAX, PMAX)  // _MAX: Maximum Base Address
                CreateDWordField (MCRS, \_SB.PCI0._Y00._LEN, PLEN)  // _LEN: Length
                PMIN = (^MCHC.TLUD << 0x14)
                PLEN = ((PMAX - PMIN) + One)
                Return (MCRS) /* \_SB_.PCI0.MCRS */
            }

            Device (PDRC)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (PDRS, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0xFED1C000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED14000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED18000,         // Address Base
                        0x00001000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED19000,         // Address Base
                        0x00001000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xF0000000,         // Address Base
                        0x04000000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED20000,         // Address Base
                        0x00020000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED40000,         // Address Base
                        0x00005000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED45000,         // Address Base
                        0x0004B000,         // Address Length
                        )
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Return (PDRS) /* \_SB_.PCI0.PDRC.PDRS */
                }
            }

            Device (PEGP)
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKD, 
                                Zero
                            }
                        })
                    }
                }
            }

            Scope (\)
            {
                OperationRegion (IO_T, SystemIO, 0x0800, 0x10)
                Field (IO_T, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x08), 
                    TRP0,   8
                }

                OperationRegion (PMIO, SystemIO, 0x0500, 0x80)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x11), 
                    THRO,   1, 
                    Offset (0x42), 
                        ,   1, 
                    GPEC,   1, 
                    Offset (0x64), 
                        ,   9, 
                    SCIS,   1
                }

                OperationRegion (GPIO, SystemIO, 0x0580, 0x3C)
                Field (GPIO, ByteAcc, NoLock, Preserve)
                {
                    GU00,   8, 
                    GU01,   8, 
                    GU02,   8, 
                    GU03,   8, 
                    GIO0,   8, 
                    GIO1,   8, 
                    GIO2,   8, 
                    GIO3,   8, 
                    Offset (0x0C), 
                    GP00,   1, 
                    GP01,   1, 
                    GP02,   1, 
                    GP03,   1, 
                    GP04,   1, 
                    GP05,   1, 
                    GP06,   1, 
                    GP07,   1, 
                    GP08,   1, 
                    GP09,   1, 
                    GP10,   1, 
                    GP11,   1, 
                    GP12,   1, 
                    GP13,   1, 
                    GP14,   1, 
                    GP15,   1, 
                    GP16,   1, 
                    GP17,   1, 
                    GP18,   1, 
                    GP19,   1, 
                    GP20,   1, 
                    GP21,   1, 
                    GP22,   1, 
                    GP23,   1, 
                    GP24,   1, 
                    GP25,   1, 
                    GP26,   1, 
                    GP27,   1, 
                    GP28,   1, 
                    GP29,   1, 
                    GP30,   1, 
                    GP31,   1, 
                    Offset (0x18), 
                    GB00,   8, 
                    GB01,   8, 
                    GB02,   8, 
                    GB03,   8, 
                    Offset (0x2C), 
                    GIV0,   8, 
                    GIV1,   8, 
                    GIV2,   8, 
                    GIV3,   8, 
                    GU04,   8, 
                    GU05,   8, 
                    GU06,   8, 
                    GU07,   8, 
                    GIO4,   8, 
                    GIO5,   8, 
                    GIO6,   8, 
                    GIO7,   8, 
                    GP32,   1, 
                    GP33,   1, 
                    GP34,   1, 
                    GP35,   1, 
                    GP36,   1, 
                    GP37,   1, 
                    GP38,   1, 
                    GP39,   1, 
                    GL05,   8, 
                    GL06,   8, 
                    GL07,   8
                }

                OperationRegion (RCRB, SystemMemory, 0xFED1C000, 0x4000)
                Field (RCRB, DWordAcc, Lock, Preserve)
                {
                    Offset (0x1000), 
                    Offset (0x3000), 
                    Offset (0x3404), 
                    HPAS,   2, 
                        ,   5, 
                    HPTE,   1, 
                    Offset (0x3418), 
                        ,   2, 
                    SA1D,   1, 
                    SMBD,   1, 
                    HDAD,   1, 
                        ,   2, 
                    US6D,   1, 
                    US1D,   1, 
                    US2D,   1, 
                    US3D,   1, 
                    US4D,   1, 
                    US5D,   1, 
                    EH2D,   1, 
                    LPBD,   1, 
                    EH1D,   1, 
                    RP1D,   1, 
                    RP2D,   1, 
                    RP3D,   1, 
                    RP4D,   1, 
                    RP5D,   1, 
                    RP6D,   1, 
                    Offset (0x341B), 
                    THRD,   1, 
                    SA2D,   1
                }
            }

            Device (HDEF)
            {
                Name (_ADR, 0x001B0000)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x05, 
                    0x04
                })
            }

            Method (IRQM, 1, Serialized)
            {
                Name (IQAA, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }
                })
                Name (IQAP, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        ^LPCB.LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        ^LPCB.LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        ^LPCB.LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        ^LPCB.LNKD, 
                        Zero
                    }
                })
                Name (IQBA, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x10
                    }
                })
                Name (IQBP, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        ^LPCB.LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        ^LPCB.LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        ^LPCB.LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        ^LPCB.LNKA, 
                        Zero
                    }
                })
                Name (IQCA, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x11
                    }
                })
                Name (IQCP, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        ^LPCB.LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        ^LPCB.LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        ^LPCB.LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        ^LPCB.LNKB, 
                        Zero
                    }
                })
                Name (IQDA, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x12
                    }
                })
                Name (IQDP, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        ^LPCB.LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        ^LPCB.LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        ^LPCB.LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        ^LPCB.LNKC, 
                        Zero
                    }
                })
                Switch (ToInteger (Arg0))
                {
                    Case (Package (0x02)
                        {
                            One, 
                            0x05
                        }

)
                    {
                        If (PICM)
                        {
                            Return (IQAA) /* \_SB_.PCI0.IRQM.IQAA */
                        }
                        Else
                        {
                            Return (IQAP) /* \_SB_.PCI0.IRQM.IQAP */
                        }
                    }
                    Case (Package (0x02)
                        {
                            0x02, 
                            0x06
                        }

)
                    {
                        If (PICM)
                        {
                            Return (IQBA) /* \_SB_.PCI0.IRQM.IQBA */
                        }
                        Else
                        {
                            Return (IQBP) /* \_SB_.PCI0.IRQM.IQBP */
                        }
                    }
                    Case (Package (0x02)
                        {
                            0x03, 
                            0x07
                        }

)
                    {
                        If (PICM)
                        {
                            Return (IQCA) /* \_SB_.PCI0.IRQM.IQCA */
                        }
                        Else
                        {
                            Return (IQCP) /* \_SB_.PCI0.IRQM.IQCP */
                        }
                    }
                    Case (Package (0x02)
                        {
                            0x04, 
                            0x08
                        }

)
                    {
                        If (PICM)
                        {
                            Return (IQDA) /* \_SB_.PCI0.IRQM.IQDA */
                        }
                        Else
                        {
                            Return (IQDP) /* \_SB_.PCI0.IRQM.IQDP */
                        }
                    }
                    Default
                    {
                        If (PICM)
                        {
                            Return (IQDA) /* \_SB_.PCI0.IRQM.IQDA */
                        }
                        Else
                        {
                            Return (IQDP) /* \_SB_.PCI0.IRQM.IQDP */
                        }
                    }

                }
            }

            Device (RP01)
            {
                Name (_ADR, 0x001C0000)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, Zero, 0xFF)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x4C), 
                    Offset (0x4F), 
                    RPPN,   8, 
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP02)
            {
                Name (_ADR, 0x001C0001)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, Zero, 0xFF)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x4C), 
                    Offset (0x4F), 
                    RPPN,   8, 
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP03)
            {
                Name (_ADR, 0x001C0002)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, Zero, 0xFF)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x4C), 
                    Offset (0x4F), 
                    RPPN,   8, 
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP04)
            {
                Name (_ADR, 0x001C0003)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, Zero, 0xFF)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x4C), 
                    Offset (0x4F), 
                    RPPN,   8, 
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP05)
            {
                Name (_ADR, 0x001C0004)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, Zero, 0xFF)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x4C), 
                    Offset (0x4F), 
                    RPPN,   8, 
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP06)
            {
                Name (_ADR, 0x001C0005)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, Zero, 0xFF)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x4C), 
                    Offset (0x4F), 
                    RPPN,   8, 
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP07)
            {
                Name (_ADR, 0x001C0006)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, Zero, 0xFF)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x4C), 
                    Offset (0x4F), 
                    RPPN,   8, 
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP08)
            {
                Name (_ADR, 0x001C0007)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, Zero, 0xFF)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x4C), 
                    Offset (0x4F), 
                    RPPN,   8, 
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0000)  // _ADR: Address
                OperationRegion (U01P, PCI_Config, Zero, 0x0100)
                Field (U01P, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xC4), 
                    U1WE,   2
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x03, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        U1WE = 0x03
                    }
                    Else
                    {
                        U1WE = Zero
                    }
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0001)  // _ADR: Address
                OperationRegion (U02P, PCI_Config, Zero, 0x0100)
                Field (U02P, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xC4), 
                    U2WE,   2
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x03, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        U2WE = 0x03
                    }
                    Else
                    {
                        U2WE = Zero
                    }
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0002)  // _ADR: Address
                OperationRegion (U03P, PCI_Config, Zero, 0x0100)
                Field (U03P, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xC4), 
                    U3WE,   2
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x03, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        U3WE = 0x03
                    }
                    Else
                    {
                        U3WE = Zero
                    }
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }
            }

            Device (EHC1)
            {
                Name (_ADR, 0x001D0007)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0D, 
                    0x04
                })
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }

                Device (HUB7)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (PRT1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                    }

                    Device (PRT3)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                    }

                    Device (PRT4)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                    }

                    Device (PRT5)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                    }

                    Device (PRT6)
                    {
                        Name (_ADR, 0x06)  // _ADR: Address
                    }
                }
            }

            Device (USB4)
            {
                Name (_ADR, 0x001A0000)  // _ADR: Address
                OperationRegion (U01P, PCI_Config, Zero, 0x0100)
                Field (U01P, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xC4), 
                    U1WE,   2
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x03, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        U1WE = 0x03
                    }
                    Else
                    {
                        U1WE = Zero
                    }
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }
            }

            Device (USB5)
            {
                Name (_ADR, 0x001A0001)  // _ADR: Address
                OperationRegion (U02P, PCI_Config, Zero, 0x0100)
                Field (U02P, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xC4), 
                    U2WE,   2
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x03, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        U2WE = 0x03
                    }
                    Else
                    {
                        U2WE = Zero
                    }
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }
            }

            Device (USB6)
            {
                Name (_ADR, 0x001A0002)  // _ADR: Address
                OperationRegion (U03P, PCI_Config, Zero, 0x0100)
                Field (U03P, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xC4), 
                    U3WE,   2
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x03, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        U3WE = 0x03
                    }
                    Else
                    {
                        U3WE = Zero
                    }
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }
            }

            Device (EHC2)
            {
                Name (_ADR, 0x001A0007)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0D, 
                    0x04
                })
                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }

                Device (HUB7)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (PRT1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                    }

                    Device (PRT3)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                    }

                    Device (PRT4)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                    }

                    Device (PRT5)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                    }

                    Device (PRT6)
                    {
                        Name (_ADR, 0x06)  // _ADR: Address
                    }
                }
            }

            Device (PCIB)
            {
                Name (_ADR, 0x001E0000)  // _ADR: Address
                Device (SLT1)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x0B, 
                        0x04
                    })
                }

                Device (SLT2)
                {
                    Name (_ADR, 0x00010000)  // _ADR: Address
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x0B, 
                        0x04
                    })
                }

                Device (SLT3)
                {
                    Name (_ADR, 0x00020000)  // _ADR: Address
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x0B, 
                        0x04
                    })
                }

                Device (SLT6)
                {
                    Name (_ADR, 0x00050000)  // _ADR: Address
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x0B, 
                        0x04
                    })
                }

                Device (LANC)
                {
                    Name (_ADR, 0x00080000)  // _ADR: Address
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x0B, 
                        0x03
                    })
                }

                Device (LANR)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x0B, 
                        0x03
                    })
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (Package (0x18)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                Zero, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                One, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                0x02, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                0x03, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                Zero, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                One, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                0x02, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                0x03, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0x0004FFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0x0004FFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0x0004FFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0x0004FFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                Zero, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                One, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x02, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x03, 
                                Zero, 
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x18)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                Zero, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                One, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                0x02, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0001FFFF, 
                                0x03, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                Zero, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                One, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                0x02, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0002FFFF, 
                                0x03, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                Zero, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                One, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x02, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x03, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0004FFFF, 
                                Zero, 
                                ^^LPCB.LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0004FFFF, 
                                One, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0004FFFF, 
                                0x02, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0004FFFF, 
                                0x03, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                Zero, 
                                ^^LPCB.LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                One, 
                                ^^LPCB.LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x02, 
                                ^^LPCB.LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x03, 
                                ^^LPCB.LNKA, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)  // _ADR: Address
                OperationRegion (LPC0, PCI_Config, Zero, 0x0100)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x40), 
                    PMBS,   16, 
                    Offset (0x60), 
                    PRTA,   8, 
                    PRTB,   8, 
                    PRTC,   8, 
                    PRTD,   8, 
                    Offset (0x68), 
                    PRTE,   8, 
                    PRTF,   8, 
                    PRTG,   8, 
                    PRTH,   8, 
                    Offset (0x80), 
                    IOD0,   8, 
                    IOD1,   8
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                    {
                        PRTA = 0x80
                    }

                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (RTLA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLA, One, IRQ0)
                        IRQ0 = Zero
                        IRQ0 = (One << (PRTA & 0x0F))
                        Return (RTLA) /* \_SB_.PCI0.LPCB.LNKA._CRS.RTLA */
                    }

                    Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PRTA = Local0
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        If ((PRTA & 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID
                    Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                    {
                        PRTB = 0x80
                    }

                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (RTLB, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLB, One, IRQ0)
                        IRQ0 = Zero
                        IRQ0 = (One << (PRTB & 0x0F))
                        Return (RTLB) /* \_SB_.PCI0.LPCB.LNKB._CRS.RTLB */
                    }

                    Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PRTB = Local0
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        If ((PRTB & 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x03)  // _UID: Unique ID
                    Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                    {
                        PRTC = 0x80
                    }

                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (RTLC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLC, One, IRQ0)
                        IRQ0 = Zero
                        IRQ0 = (One << (PRTC & 0x0F))
                        Return (RTLC) /* \_SB_.PCI0.LPCB.LNKC._CRS.RTLC */
                    }

                    Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PRTC = Local0
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        If ((PRTC & 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x04)  // _UID: Unique ID
                    Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                    {
                        PRTD = 0x80
                    }

                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (RTLD, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLD, One, IRQ0)
                        IRQ0 = Zero
                        IRQ0 = (One << (PRTD & 0x0F))
                        Return (RTLD) /* \_SB_.PCI0.LPCB.LNKD._CRS.RTLD */
                    }

                    Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PRTD = Local0
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        If ((PRTD & 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x05)  // _UID: Unique ID
                    Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                    {
                        PRTE = 0x80
                    }

                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (RTLE, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLE, One, IRQ0)
                        IRQ0 = Zero
                        IRQ0 = (One << (PRTE & 0x0F))
                        Return (RTLE) /* \_SB_.PCI0.LPCB.LNKE._CRS.RTLE */
                    }

                    Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PRTE = Local0
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        If ((PRTE & 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x06)  // _UID: Unique ID
                    Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                    {
                        PRTF = 0x80
                    }

                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (RTLF, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLF, One, IRQ0)
                        IRQ0 = Zero
                        IRQ0 = (One << (PRTF & 0x0F))
                        Return (RTLF) /* \_SB_.PCI0.LPCB.LNKF._CRS.RTLF */
                    }

                    Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PRTF = Local0
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        If ((PRTF & 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x07)  // _UID: Unique ID
                    Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                    {
                        PRTG = 0x80
                    }

                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (RTLG, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLG, One, IRQ0)
                        IRQ0 = Zero
                        IRQ0 = (One << (PRTG & 0x0F))
                        Return (RTLG) /* \_SB_.PCI0.LPCB.LNKG._CRS.RTLG */
                    }

                    Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PRTG = Local0
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        If ((PRTG & 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                    Name (_UID, 0x08)  // _UID: Unique ID
                    Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                    {
                        PRTH = 0x80
                    }

                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (RTLH, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (RTLH, One, IRQ0)
                        IRQ0 = Zero
                        IRQ0 = (One << (PRTH & 0x0F))
                        Return (RTLH) /* \_SB_.PCI0.LPCB.LNKH._CRS.RTLH */
                    }

                    Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Local0--
                        PRTH = Local0
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        If ((PRTH & 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (EC)
                {
                    Name (_HID, EisaId ("PNP0C09") /* Embedded Controller Device */)  // _HID: Hardware ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (_GPE, 0x11)  // _GPE: General Purpose Events
                    Mutex (ECLK, 0x00)
                    OperationRegion (ERAM, EmbeddedControl, Zero, 0x0100)
                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x02), 
                        DKR1,   1, 
                        Offset (0x05), 
                        HSPA,   1, 
                        Offset (0x0C), 
                        LEDS,   8, 
                        Offset (0x0F), 
                            ,   7, 
                        TBSW,   1, 
                        Offset (0x1A), 
                        DKR2,   1, 
                        Offset (0x2A), 
                        EVNT,   8, 
                        Offset (0x2F), 
                            ,   6, 
                        FAND,   1, 
                        FANA,   1, 
                            ,   6, 
                        ALMT,   1, 
                        Offset (0x31), 
                            ,   2, 
                        UWBE,   1, 
                        Offset (0x3A), 
                        AMUT,   1, 
                            ,   3, 
                        BTEB,   1, 
                        WLEB,   1, 
                        WWEB,   1, 
                        Offset (0x3B), 
                            ,   1, 
                        KBLT,   1, 
                            ,   2, 
                        USPW,   1, 
                        Offset (0x48), 
                        HPPI,   1, 
                        GSTS,   1, 
                        Offset (0x4E), 
                        WAKE,   16, 
                        Offset (0x78), 
                        TMP0,   8, 
                        TMP1,   8, 
                        Offset (0x81), 
                        PAGE,   8, 
                        Offset (0xFE), 
                            ,   4, 
                        DKR3,   1
                    }

                    Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                    {
                        If ((Arg1 == One))
                        {
                            If ((^HKEY.INIT == Zero))
                            {
                                ^HKEY.WBDC = BTEB /* \_SB_.PCI0.LPCB.EC__.BTEB */
                                ^HKEY.WWAN = WWEB /* \_SB_.PCI0.LPCB.EC__.WWEB */
                                ^HKEY.INIT = One
                            }
                        }
                    }

                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (ECMD, ResourceTemplate ()
                        {
                            IO (Decode16,
                                0x0062,             // Range Minimum
                                0x0062,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                            IO (Decode16,
                                0x0066,             // Range Minimum
                                0x0066,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                        })
                        Return (ECMD) /* \_SB_.PCI0.LPCB.EC__._CRS.ECMD */
                    }

                    Method (TLED, 1, NotSerialized)
                    {
                        LEDS = Arg0
                    }

                    Method (LED, 2, NotSerialized)
                    {
                        TLED ((Arg0 | Arg1))
                    }

                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                    }

                    Method (MUTE, 1, NotSerialized)
                    {
                        AMUT = Arg0
                    }

                    Method (RADI, 1, NotSerialized)
                    {
                        WLEB = Arg0
                        WWEB = Arg0
                        BTEB = Arg0
                    }

                    Method (USBP, 1, NotSerialized)
                    {
                        USPW = Arg0
                    }

                    Method (LGHT, 1, NotSerialized)
                    {
                        KBLT = Arg0
                    }

                    Method (_Q13, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (SLPB, 0x80) // Status Change
                    }

                    Method (_Q14, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^^^GFX0.INCB ()
                    }

                    Method (_Q15, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^^^GFX0.DECB ()
                    }

                    Method (_Q16, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (GFX0, 0x82) // Device-Specific Change
                    }

                    Method (_Q26, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (AC, 0x80) // Status Change
                        PNOT ()
                    }

                    Method (_Q27, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (AC, 0x80) // Status Change
                        EVNT = 0x50
                        PNOT ()
                    }

                    Method (_Q2A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (LID, 0x80) // Status Change
                    }

                    Method (_Q2B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (LID, 0x80) // Status Change
                    }

                    Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (One)
                    }

                    Method (_Q11, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x02)
                    }

                    Method (_Q12, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x03)
                    }

                    Method (_Q64, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x05)
                    }

                    Method (_Q65, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x06)
                    }

                    Method (_Q17, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x08)
                    }

                    Method (_Q66, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x0A)
                    }

                    Method (_Q6A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x1B)
                    }

                    Method (_Q1A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x0B)
                    }

                    Method (_Q1B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x0C)
                    }

                    Method (_Q62, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x0D)
                    }

                    Method (_Q60, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x0E)
                    }

                    Method (_Q61, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x0F)
                    }

                    Method (_Q1F, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x12)
                    }

                    Method (_Q67, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x13)
                    }

                    Method (_Q63, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x14)
                    }

                    Method (_Q19, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x18)
                    }

                    Method (_Q1C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x19)
                    }

                    Method (_Q1D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RHK (0x1A)
                    }

                    Method (_Q5C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RTAB (0x0B)
                    }

                    Method (_Q5D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RTAB (0x0C)
                    }

                    Method (_Q5E, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RTAB (0x09)
                    }

                    Method (_Q5F, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        ^HKEY.RTAB (0x0A)
                    }

                    Method (FANE, 1, Serialized)
                    {
                        If (Arg0)
                        {
                            FAND = One
                            FANA = Zero
                        }
                        Else
                        {
                            FAND = Zero
                            FANA = One
                        }
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x46), 
                            ,   4, 
                        HPAC,   1
                    }

                    Device (AC)
                    {
                        Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
                        Name (_UID, Zero)  // _UID: Unique ID
                        Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
                        {
                            _SB
                        })
                        Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
                        {
                            Local0 = HPAC /* \_SB_.PCI0.LPCB.EC__.HPAC */
                            PWRS = Local0
                            PNOT ()
                            Return (Local0)
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x38), 
                        B0ST,   4, 
                            ,   1, 
                        B0CH,   1, 
                        B0DI,   1, 
                        B0PR,   1, 
                        B1ST,   4, 
                            ,   1, 
                        B1CH,   1, 
                        B1DI,   1, 
                        B1PR,   1
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        BARC,   16, 
                        BAFC,   16, 
                        Offset (0xA8), 
                        BAPR,   16, 
                        BAVO,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                            ,   15, 
                        BAMA,   1
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        BADC,   16, 
                        BADV,   16, 
                        Offset (0xA6), 
                        Offset (0xA8), 
                        Offset (0xAA), 
                        BASN,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        BATY,   32
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        BAOE,   128
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        BANA,   128
                    }

                    Method (BPAG, 1, NotSerialized)
                    {
                        PAGE = Arg0
                    }

                    Method (BSTA, 4, NotSerialized)
                    {
                        Acquire (ECLK, 0xFFFF)
                        Local0 = Zero
                        BPAG ((One | Arg0))
                        Local1 = BAMA /* \_SB_.PCI0.LPCB.EC__.BAMA */
                        BPAG (Arg0)
                        Local2 = BAPR /* \_SB_.PCI0.LPCB.EC__.BAPR */
                        If (Arg2)
                        {
                            Local0 |= 0x02
                        }
                        ElseIf (Arg3)
                        {
                            Local0 |= One
                            Local2 = (0x00010000 - Local2)
                        }
                        Else
                        {
                            Local2 = Zero
                        }

                        If ((Local2 >= 0x8000))
                        {
                            Local2 = Zero
                        }

                        Arg1 [Zero] = Local0
                        If (Local1)
                        {
                            Arg1 [0x02] = (BARC * 0x0A)
                            Local2 *= BAVO /* \_SB_.PCI0.LPCB.EC__.BAVO */
                            Arg1 [One] = (Local2 / 0x03E8)
                        }
                        Else
                        {
                            Arg1 [0x02] = BARC /* \_SB_.PCI0.LPCB.EC__.BARC */
                            Arg1 [One] = Local2
                        }

                        Arg1 [0x03] = BAVO /* \_SB_.PCI0.LPCB.EC__.BAVO */
                        Release (ECLK)
                        Return (Arg1)
                    }

                    Method (BINF, 2, Serialized)
                    {
                        Acquire (ECLK, 0xFFFF)
                        BPAG ((One | Arg1))
                        Arg0 [Zero] = (BAMA ^ One)
                        Local0 = BAMA /* \_SB_.PCI0.LPCB.EC__.BAMA */
                        BPAG (Arg1)
                        Local2 = BAFC /* \_SB_.PCI0.LPCB.EC__.BAFC */
                        BPAG ((0x02 | Arg1))
                        Local1 = BADC /* \_SB_.PCI0.LPCB.EC__.BADC */
                        If (Local0)
                        {
                            Local1 *= 0x0A
                            Local2 *= 0x0A
                        }

                        Arg0 [One] = Local1
                        Arg0 [0x02] = Local2
                        Arg0 [0x04] = BADV /* \_SB_.PCI0.LPCB.EC__.BADV */
                        Divide (Local2, 0x14, Local0, Arg0 [0x05])
                        Local0 = BASN /* \_SB_.PCI0.LPCB.EC__.BASN */
                        Name (SERN, Buffer (0x06)
                        {
                            "     "
                        })
                        Local1 = 0x04
                        While (Local0)
                        {
                            Divide (Local0, 0x0A, Local2, Local0)
                            SERN [Local1] = (Local2 + 0x30)
                            Local1--
                        }

                        Arg0 [0x0A] = SERN /* \_SB_.PCI0.LPCB.EC__.BINF.SERN */
                        BPAG ((0x04 | Arg1))
                        Name (TYPE, Buffer (0x05)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                        })
                        TYPE = BATY /* \_SB_.PCI0.LPCB.EC__.BATY */
                        Arg0 [0x0B] = TYPE /* \_SB_.PCI0.LPCB.EC__.BINF.TYPE */
                        BPAG ((0x05 | Arg1))
                        Arg0 [0x0C] = BAOE /* \_SB_.PCI0.LPCB.EC__.BAOE */
                        BPAG ((0x06 | Arg1))
                        Arg0 [0x09] = BANA /* \_SB_.PCI0.LPCB.EC__.BANA */
                        Release (ECLK)
                        Return (Arg0)
                    }

                    Device (BAT0)
                    {
                        Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
                        Name (_UID, Zero)  // _UID: Unique ID
                        Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
                        {
                            _SB
                        })
                        Name (BATS, Package (0x0D)
                        {
                            Zero, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            One, 
                            0x2A30, 
                            Zero, 
                            0xC8, 
                            One, 
                            One, 
                            "", 
                            "", 
                            "", 
                            ""
                        })
                        Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
                        {
                            Return (BINF (BATS, Zero))
                        }

                        Name (BATI, Package (0x04)
                        {
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                        Method (_BST, 0, NotSerialized)  // _BST: Battery Status
                        {
                            If (B0PR)
                            {
                                Return (BSTA (Zero, BATI, B0CH, B0DI))
                            }
                            Else
                            {
                                Return (Package (0x04)
                                {
                                    Zero, 
                                    Zero, 
                                    Zero, 
                                    Zero
                                })
                            }
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (B0PR)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }
                    }

                    Device (BAT1)
                    {
                        Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
                        Name (_UID, Zero)  // _UID: Unique ID
                        Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
                        {
                            _SB
                        })
                        Name (BATS, Package (0x0D)
                        {
                            Zero, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            One, 
                            0x2A30, 
                            Zero, 
                            0xC8, 
                            One, 
                            One, 
                            "", 
                            "", 
                            "", 
                            ""
                        })
                        Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
                        {
                            Return (BINF (BATS, 0x10))
                        }

                        Name (BATI, Package (0x04)
                        {
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                        Method (_BST, 0, NotSerialized)  // _BST: Battery Status
                        {
                            If (B1PR)
                            {
                                Return (BSTA (0x10, BATI, B1CH, B1DI))
                            }
                            Else
                            {
                                Return (Package (0x04)
                                {
                                    Zero, 
                                    Zero, 
                                    Zero, 
                                    Zero
                                })
                            }
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (B1PR)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }
                    }

                    Method (_Q24, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (BAT0, 0x80) // Status Change
                    }

                    Method (_Q25, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (BAT1, 0x80) // Status Change
                    }

                    Method (_Q4A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (BAT0, 0x81) // Information Change
                    }

                    Method (_Q4B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (BAT0, 0x80) // Status Change
                    }

                    Method (_Q4C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (BAT1, 0x81) // Information Change
                    }

                    Method (_Q4D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
                    {
                        Notify (BAT1, 0x80) // Status Change
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x32), 
                            ,   4, 
                        WKFN,   1, 
                        Offset (0x83), 
                        FNKY,   8
                    }

                    Device (SLPB)
                    {
                        Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
                        Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                        {
                            Return (Package (0x02)
                            {
                                0x18, 
                                0x03
                            })
                        }

                        Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                        {
                            If (Arg0)
                            {
                                FNKY = 0x06
                                WKFN = One
                            }
                            Else
                            {
                                FNKY = Zero
                                WKFN = Zero
                            }
                        }
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x32), 
                            ,   2, 
                        WKLD,   1, 
                        Offset (0x46), 
                            ,   2, 
                        LIDS,   1
                    }

                    Device (LID)
                    {
                        Name (_HID, "PNP0C0D" /* Lid Device */)  // _HID: Hardware ID
                        Method (_LID, 0, NotSerialized)  // _LID: Lid Status
                        {
                            Return (LIDS) /* \_SB_.PCI0.LPCB.EC__.LIDS */
                        }

                        Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                        {
                            Return (Package (0x02)
                            {
                                0x18, 
                                0x03
                            })
                        }

                        Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                        {
                            If (Arg0)
                            {
                                WKLD = One
                            }
                            Else
                            {
                                WKLD = Zero
                            }
                        }
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x06), 
                        SNDS,   8
                    }

                    Method (BEEP, 1, NotSerialized)
                    {
                        SNDS = Arg0
                    }

                    Scope (\_TZ)
                    {
                        Method (C2K, 1, NotSerialized)
                        {
                            Local0 = (Arg0 * 0x0A)
                            Local0 += 0x0AAC
                            If ((Local0 <= 0x0AAC))
                            {
                                Return (0x0BB8)
                            }

                            If ((Local0 > 0x0FAC))
                            {
                                Return (0x0BB8)
                            }

                            Return (Local0)
                        }

                        ThermalZone (THM0)
                        {
                            Name (_TZP, 0x64)  // _TZP: Thermal Zone Polling
                            Name (_TSP, 0x64)  // _TSP: Thermal Sampling Period
                            Name (_TC1, 0x02)  // _TC1: Thermal Constant 1
                            Name (_TC2, 0x05)  // _TC2: Thermal Constant 2
                            Method (_PSL, 0, Serialized)  // _PSL: Passive List
                            {
                                Return (PPKG ())
                            }

                            Method (GCRT, 0, NotSerialized)
                            {
                                Local0 = TCRT /* \TCRT */
                                If ((Local0 > Zero))
                                {
                                    Return (Local0)
                                }

                                Return (0x7F)
                            }

                            Method (GPSV, 0, NotSerialized)
                            {
                                Local0 = TPSV /* \TPSV */
                                If ((Local0 > Zero))
                                {
                                    Return (Local0)
                                }

                                Return (0x5F)
                            }

                            Method (_CRT, 0, NotSerialized)  // _CRT: Critical Temperature
                            {
                                Return (C2K (GCRT ()))
                            }

                            Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
                            {
                                Return (C2K (GPSV ()))
                            }

                            Method (_TMP, 0, NotSerialized)  // _TMP: Temperature
                            {
                                Return (C2K (\_SB.PCI0.LPCB.EC.TMP0))
                            }

                            Method (_AC0, 0, NotSerialized)  // _ACx: Active Cooling, x=0-9
                            {
                                Local0 = GPSV ()
                                Local0 -= 0x0A
                                If (FLVL)
                                {
                                    Local0 -= 0x05
                                }

                                Return (C2K (Local0))
                            }

                            Name (_AL0, Package (0x01)  // _ALx: Active List, x=0-9
                            {
                                FAN
                            })
                            PowerResource (FPWR, 0x00, 0x0000)
                            {
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (FLVL) /* \FLVL */
                                }

                                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                                {
                                    \_SB.PCI0.LPCB.EC.FANE (One)
                                    FLVL = One
                                    Notify (THM0, 0x81) // Thermal Trip Point Change
                                }

                                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                                {
                                    \_SB.PCI0.LPCB.EC.FANE (Zero)
                                    FLVL = Zero
                                    Notify (THM0, 0x81) // Thermal Trip Point Change
                                }
                            }

                            Device (FAN)
                            {
                                Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
                                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                                {
                                    FPWR
                                })
                            }
                        }

                        ThermalZone (THM1)
                        {
                            Name (_TZP, 0x64)  // _TZP: Thermal Zone Polling
                            Name (_TSP, 0x64)  // _TSP: Thermal Sampling Period
                            Name (_TC1, 0x02)  // _TC1: Thermal Constant 1
                            Name (_TC2, 0x05)  // _TC2: Thermal Constant 2
                            Method (_PSL, 0, Serialized)  // _PSL: Passive List
                            {
                                Return (PPKG ())
                            }

                            Method (_CRT, 0, NotSerialized)  // _CRT: Critical Temperature
                            {
                                Return (C2K (0x63))
                            }

                            Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
                            {
                                Return (C2K (0x5E))
                            }

                            Method (_TMP, 0, NotSerialized)  // _TMP: Temperature
                            {
                                Return (C2K (\_SB.PCI0.LPCB.EC.TMP1))
                            }
                        }
                    }

                    Scope (\_SI)
                    {
                        Method (_SST, 1, NotSerialized)  // _SST: System Status
                        {
                            If ((Arg0 == Zero))
                            {
                                \_SB.PCI0.LPCB.EC.TLED (Zero)
                                \_SB.PCI0.LPCB.EC.TLED (0x07)
                            }

                            If ((Arg0 == One))
                            {
                                \_SB.PCI0.LPCB.EC.TLED (0x80)
                                \_SB.PCI0.LPCB.EC.TLED (0x07)
                            }

                            If ((Arg0 == 0x02))
                            {
                                \_SB.PCI0.LPCB.EC.TLED (0x80)
                                \_SB.PCI0.LPCB.EC.TLED (0xC7)
                            }

                            If ((Arg0 == 0x03))
                            {
                                \_SB.PCI0.LPCB.EC.TLED (0xA0)
                                \_SB.PCI0.LPCB.EC.TLED (0x87)
                            }
                        }
                    }

                    Device (HKEY)
                    {
                        Name (_HID, EisaId ("IBM0068"))  // _HID: Hardware ID
                        Name (BTN, Zero)
                        Name (BTAB, Zero)
                        Name (DHKN, 0x080C)
                        Name (EMSK, Zero)
                        Name (ETAB, Zero)
                        Name (EN, Zero)
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (MHKP, 0, NotSerialized)
                        {
                            Local0 = BTN /* \_SB_.PCI0.LPCB.EC__.HKEY.BTN_ */
                            If ((Local0 != Zero))
                            {
                                BTN = Zero
                                Local0 += 0x1000
                                Return (Local0)
                            }

                            Local0 = BTAB /* \_SB_.PCI0.LPCB.EC__.HKEY.BTAB */
                            If ((Local0 != Zero))
                            {
                                BTAB = Zero
                                Local0 += 0x5000
                                Return (Local0)
                            }

                            Return (Zero)
                        }

                        Method (RHK, 1, NotSerialized)
                        {
                            Local0 = (One << (Arg0 - One))
                            If ((EMSK & Local0))
                            {
                                BTN = Arg0
                                Notify (HKEY, 0x80) // Status Change
                            }
                        }

                        Method (RTAB, 1, NotSerialized)
                        {
                            Local0 = (One << (Arg0 - One))
                            If ((ETAB & Local0))
                            {
                                BTAB = Arg0
                                Notify (HKEY, 0x80) // Status Change
                            }
                        }

                        Method (MHKC, 1, NotSerialized)
                        {
                            If (Arg0)
                            {
                                EMSK = DHKN /* \_SB_.PCI0.LPCB.EC__.HKEY.DHKN */
                                ETAB = Ones
                            }
                            Else
                            {
                                EMSK = Zero
                                ETAB = Zero
                            }

                            EN = Arg0
                        }

                        Method (MHKM, 2, NotSerialized)
                        {
                            If ((Arg0 <= 0x20))
                            {
                                Local0 = (One << (Arg0 - One))
                                If (Arg1)
                                {
                                    DHKN |= Local0
                                }
                                Else
                                {
                                    DHKN &= ~Local0
                                }

                                If (EN)
                                {
                                    EMSK = DHKN /* \_SB_.PCI0.LPCB.EC__.HKEY.DHKN */
                                }
                            }
                        }

                        Method (MHKA, 0, NotSerialized)
                        {
                            Return (0x07FFFFFF)
                        }

                        Method (MHKG, 0, NotSerialized)
                        {
                            Return ((TBSW << 0x03))
                        }

                        Method (SSMS, 1, NotSerialized)
                        {
                            ALMT = Arg0
                        }

                        Method (MMTS, 1, NotSerialized)
                        {
                            If (Arg0)
                            {
                                TLED (0x8E)
                            }
                            Else
                            {
                                TLED (0x0E)
                            }
                        }

                        Method (MHKV, 0, NotSerialized)
                        {
                            Return (0x0100)
                        }

                        Method (WLSW, 0, NotSerialized)
                        {
                            Return (GSTS) /* \_SB_.PCI0.LPCB.EC__.GSTS */
                        }

                        Name (INIT, Zero)
                        Name (HAST, Zero)
                        Name (WBDC, Zero)
                        Method (GBDC, 0, NotSerialized)
                        {
                            HAST = One
                            If (HBDC)
                            {
                                Local0 = One
                                If (BTEB)
                                {
                                    Local0 |= 0x02
                                }

                                Local0 |= (WBDC << 0x02)
                                Return (Local0)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (SBDC, 1, NotSerialized)
                        {
                            HAST = One
                            If (HBDC)
                            {
                                Local0 = ((Arg0 & 0x02) >> One)
                                BTEB = Local0
                                Local0 = ((Arg0 & 0x04) >> 0x02)
                                WBDC = Local0
                            }
                        }

                        Name (WWAN, Zero)
                        Method (GWAN, 0, NotSerialized)
                        {
                            HAST = One
                            If (HWAN)
                            {
                                Local0 = One
                                If (WWEB)
                                {
                                    Local0 |= 0x02
                                }

                                Local0 |= (WWAN << 0x02)
                                Return (Local0)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (SWAN, 1, NotSerialized)
                        {
                            HAST = One
                            If (HWAN)
                            {
                                Local0 = ((Arg0 & 0x02) >> One)
                                WWEB = Local0
                                WWAN = ((Arg0 & 0x04) >> 0x02)
                            }
                        }

                        Method (MLCG, 1, NotSerialized)
                        {
                            If (HKBL)
                            {
                                Local0 = 0x0200
                                Local0 |= KBLT /* \_SB_.PCI0.LPCB.EC__.KBLT */
                                Return (Local0)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (MLCS, 1, NotSerialized)
                        {
                            If (HKBL)
                            {
                                WWEB = (Arg0 & One)
                            }
                        }

                        Method (GUWB, 0, NotSerialized)
                        {
                            If (HUWB)
                            {
                                Local0 = One
                                If (UWBE)
                                {
                                    Local0 |= 0x02
                                }

                                Return (Local0)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (SUWB, 1, NotSerialized)
                        {
                            If (HUWB)
                            {
                                Local0 = ((Arg0 & 0x02) >> One)
                                UWBE = Local0
                            }
                        }

                        Method (WAKE, 1, NotSerialized)
                        {
                            If (HAST)
                            {
                                BTEB = WBDC /* \_SB_.PCI0.LPCB.EC__.HKEY.WBDC */
                                WWEB = WWAN /* \_SB_.PCI0.LPCB.EC__.HKEY.WWAN */
                            }
                        }

                        Method (BCSS, 1, NotSerialized)
                        {
                            Local0 = (Arg0 & 0xFF)
                            Local1 = ((Arg0 >> 0x08) & 0x03)
                            If ((Local1 == Zero))
                            {
                                ^^BAT0.SETT (One, Local0)
                                ^^BAT1.SETT (One, Local0)
                                Local2 = (Local0 != ^^BAT0.GETT (One))
                                Local3 = (Local0 != ^^BAT1.GETT (One))
                                Return (((Local2 && Local3) << 0x1F))
                            }

                            If ((Local1 == One))
                            {
                                ^^BAT0.SETT (One, Local0)
                                Return (((Local0 != ^^BAT0.GETT (One)) << 0x1F))
                            }

                            If ((Local1 == 0x02))
                            {
                                ^^BAT1.SETT (One, Local0)
                                Return (((Local0 != ^^BAT1.GETT (One)) << 0x1F))
                            }

                            Return (0x80000000)
                        }

                        Method (BCCS, 1, NotSerialized)
                        {
                            Local0 = (Arg0 & 0xFF)
                            Local1 = ((Arg0 >> 0x08) & 0x03)
                            If ((Local1 == Zero))
                            {
                                ^^BAT0.SETT (Zero, Local0)
                                ^^BAT1.SETT (Zero, Local0)
                                Local2 = (Local0 != ^^BAT0.GETT (Zero))
                                Local3 = (Local0 != ^^BAT1.GETT (Zero))
                                Return (((Local2 && Local3) << 0x1F))
                            }

                            If ((Local1 == One))
                            {
                                ^^BAT0.SETT (Zero, Local0)
                                Return (((Local0 != ^^BAT0.GETT (Zero)) << 0x1F))
                            }

                            If ((Local1 == 0x02))
                            {
                                ^^BAT1.SETT (Zero, Local0)
                                Return (((Local0 != ^^BAT1.GETT (Zero)) << 0x1F))
                            }

                            Return (0x80000000)
                        }

                        Method (BCSG, 1, NotSerialized)
                        {
                            If ((Arg0 == One))
                            {
                                Return ((0x0300 | ^^BAT0.GETT (One)))
                            }

                            If ((Arg0 == 0x02))
                            {
                                Return ((0x0300 | ^^BAT1.GETT (One)))
                            }

                            Return (0x80000000)
                        }

                        Method (BCTG, 1, NotSerialized)
                        {
                            If ((Arg0 == One))
                            {
                                Return ((0x0300 | ^^BAT0.GETT (Zero)))
                            }

                            If ((Arg0 == 0x02))
                            {
                                Return ((0x0300 | ^^BAT1.GETT (Zero)))
                            }

                            Return (0x80000000)
                        }
                    }
                }

                Scope (EC)
                {
                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x03), 
                            ,   2, 
                        BSTP,   1, 
                        Offset (0x24), 
                        TSH0,   8, 
                        TSH1,   8
                    }
                }

                Scope (EC.BAT0)
                {
                    Method (SETT, 2, NotSerialized)
                    {
                        If (((Arg0 <= One) && (Arg1 <= 0x64)))
                        {
                            BSTP = Arg0
                            TSH0 = (Arg1 | 0x80)
                        }
                    }

                    Method (GETT, 1, NotSerialized)
                    {
                        If ((Arg0 <= One))
                        {
                            BSTP = Arg0
                            Return ((TSH0 & 0xFFFFFFFFFFFFFF7F))
                        }

                        Return (Zero)
                    }
                }

                Scope (EC.BAT1)
                {
                    Method (SETT, 2, NotSerialized)
                    {
                        If (((Arg0 <= One) && (Arg1 <= 0x64)))
                        {
                            BSTP = Arg0
                            TSH1 = (Arg1 | 0x80)
                        }
                    }

                    Method (GETT, 1, NotSerialized)
                    {
                        If ((Arg0 <= One))
                        {
                            BSTP = Arg0
                            Return ((TSH1 & 0xFFFFFFFFFFFFFF7F))
                        }

                        Return (Zero)
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x01,               // Alignment
                            0x11,               // Length
                            )
                        IO (Decode16,
                            0x0093,             // Range Minimum
                            0x0093,             // Range Maximum
                            0x01,               // Alignment
                            0x0D,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (FWH)
                {
                    Name (_HID, EisaId ("INT0800") /* Intel 82802 Firmware Hub Device */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        Memory32Fixed (ReadOnly,
                            0xFF000000,         // Address Base
                            0x01000000,         // Address Length
                            )
                    })
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP0C01") /* System Board */)  // _CID: Compatible ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y01)
                    })
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (HPTE)
                        {
                            If ((OSYS >= 0x07D1))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }

                        Return (Zero)
                    }

                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If (HPTE)
                        {
                            CreateDWordField (BUF0, \_SB.PCI0.LPCB.HPET._Y01._BAS, HPT0)  // _BAS: Base Address
                            If ((HPAS == One))
                            {
                                HPT0 = 0xFED01000
                            }

                            If ((HPAS == 0x02))
                            {
                                HPT0 = 0xFED02000
                            }

                            If ((HPAS == 0x03))
                            {
                                HPT0 = 0xFED03000
                            }
                        }

                        Return (BUF0) /* \_SB_.PCI0.LPCB.HPET.BUF0 */
                    }
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0024,             // Range Minimum
                            0x0024,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0028,             // Range Minimum
                            0x0028,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x002C,             // Range Minimum
                            0x002C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0030,             // Range Minimum
                            0x0030,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0034,             // Range Minimum
                            0x0034,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0038,             // Range Minimum
                            0x0038,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x003C,             // Range Minimum
                            0x003C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A4,             // Range Minimum
                            0x00A4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A8,             // Range Minimum
                            0x00A8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00AC,             // Range Minimum
                            0x00AC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B4,             // Range Minimum
                            0x00B4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B8,             // Range Minimum
                            0x00B8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00BC,             // Range Minimum
                            0x00BC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04") /* x87-compatible Floating Point Processing Unit */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (LDRC)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x004E,             // Range Minimum
                            0x004E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0063,             // Range Minimum
                            0x0063,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0067,             // Range Minimum
                            0x0067,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B2,             // Range Minimum
                            0x00B2,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0800,             // Range Minimum
                            0x0800,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0500,             // Range Minimum
                            0x0500,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x0580,             // Range Minimum
                            0x0580,             // Range Maximum
                            0x01,               // Alignment
                            0x40,               // Length
                            )
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                    })
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x10,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP030B"))  // _CID: Compatible ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {1}
                    })
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13") /* PS/2 Mouse */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {12}
                    })
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (AHC1)
            {
                Name (_ADR, 0x001F0002)  // _ADR: Address
                Device (PRID)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_GTM, 0, Serialized)  // _GTM: Get Timing Mode
                    {
                        Name (PBUF, Buffer (0x14)
                        {
                            /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                            /* 0010 */  0x00, 0x00, 0x00, 0x00                           // ....
                        })
                        CreateDWordField (PBUF, Zero, PIO0)
                        CreateDWordField (PBUF, 0x04, DMA0)
                        CreateDWordField (PBUF, 0x08, PIO1)
                        CreateDWordField (PBUF, 0x0C, DMA1)
                        CreateDWordField (PBUF, 0x10, FLAG)
                        Return (PBUF) /* \_SB_.PCI0.AHC1.PRID._GTM.PBUF */
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        CreateDWordField (Arg0, Zero, PIO0)
                        CreateDWordField (Arg0, 0x04, DMA0)
                        CreateDWordField (Arg0, 0x08, PIO1)
                        CreateDWordField (Arg0, 0x0C, DMA1)
                        CreateDWordField (Arg0, 0x10, FLAG)
                    }

                    Device (DSK0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                    }

                    Device (DSK1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }
                }
            }

            Device (AHC2)
            {
                Name (_ADR, 0x001F0005)  // _ADR: Address
                Device (PRID)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_GTM, 0, Serialized)  // _GTM: Get Timing Mode
                    {
                        Name (PBUF, Buffer (0x14)
                        {
                            /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                            /* 0010 */  0x00, 0x00, 0x00, 0x00                           // ....
                        })
                        CreateDWordField (PBUF, Zero, PIO0)
                        CreateDWordField (PBUF, 0x04, DMA0)
                        CreateDWordField (PBUF, 0x08, PIO1)
                        CreateDWordField (PBUF, 0x0C, DMA1)
                        CreateDWordField (PBUF, 0x10, FLAG)
                        Return (PBUF) /* \_SB_.PCI0.AHC2.PRID._GTM.PBUF */
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        CreateDWordField (Arg0, Zero, PIO0)
                        CreateDWordField (Arg0, 0x04, DMA0)
                        CreateDWordField (Arg0, 0x08, PIO1)
                        CreateDWordField (Arg0, 0x0C, DMA1)
                        CreateDWordField (Arg0, 0x10, FLAG)
                    }

                    Device (DSK0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                    }

                    Device (DSK1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }
                }
            }

            Device (SBUS)
            {
                Name (_ADR, 0x001F0003)  // _ADR: Address
            }

            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    Return (Arg3)
                }
                Else
                {
                    CreateDWordField (Arg3, Zero, CDW1)
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }

            Device (GFX0)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                OperationRegion (GFXC, PCI_Config, Zero, 0x0100)
                Field (GFXC, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                    BAR0,   64, 
                    Offset (0xE4), 
                    ASLE,   32, 
                    Offset (0xFC), 
                    ASLS,   32
                }

                OperationRegion (GFRG, SystemMemory, (BAR0 & 0xFFFFFFFFFFFFFFF0), 0x00400000)
                Field (GFRG, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x61254), 
                    BCLV,   16, 
                    BCLM,   16
                }

                Device (BOX3)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (OPRG, SystemMemory, ASLS, 0x2000)
                    Field (OPRG, DWordAcc, NoLock, Preserve)
                    {
                        Offset (0x58), 
                        MBOX,   32, 
                        Offset (0x300), 
                        ARDY,   1, 
                        Offset (0x304), 
                        ASLC,   32, 
                        TCHE,   32, 
                        ALSI,   32, 
                        BCLP,   32, 
                        PFIT,   32, 
                        CBLV,   32
                    }

                    Method (XBCM, 1, Serialized)
                    {
                        If ((ASLS == Zero))
                        {
                            Return (Ones)
                        }

                        If (((MBOX & 0x04) == Zero))
                        {
                            Return (Ones)
                        }

                        Local1 = ((Arg0 * 0xFF) / 0x64)
                        If ((Local1 > 0xFF))
                        {
                            Local1 = 0xFF
                        }

                        BCLP = (Local1 | 0x80000000)
                        If ((ARDY == Zero))
                        {
                            Return (Ones)
                        }

                        ASLC = 0x02
                        ASLE = One
                        Local0 = 0x20
                        While ((Local0 > Zero))
                        {
                            Sleep (One)
                            If (((ASLC & 0x02) == Zero))
                            {
                                Local1 = ((ASLC >> 0x0C) & 0x03)
                                If ((Local1 == Zero))
                                {
                                    Return (Zero)
                                }
                                Else
                                {
                                    Return (Ones)
                                }
                            }

                            Local0--
                        }

                        Return (Ones)
                    }
                }

                Device (LEGA)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (DRCL, 2, NotSerialized)
                    {
                        Return (((Arg0 + (Arg1 / 0x02)) / Arg1))
                    }

                    Method (XBCM, 1, NotSerialized)
                    {
                        BCLV = DRCL ((Arg0 * BCLM), 0x64)
                    }

                    Method (XBQC, 0, NotSerialized)
                    {
                        If ((BCLM == Zero))
                        {
                            Return (Zero)
                        }

                        Local0 = DRCL ((BCLV * 0x64), BCLM)
                        Local1 = 0x02
                        While ((Local1 < (SizeOf (BRIG) - One)))
                        {
                            Local2 = DerefOf (BRIG [Local1])
                            Local3 = DerefOf (BRIG [(Local1 + One)])
                            If ((Local0 < Local3))
                            {
                                If (((Local0 < Local2) || ((Local0 - Local2) < (Local3 - 
                                    Local0))))
                                {
                                    Return (Local2)
                                }
                                Else
                                {
                                    Return (Local3)
                                }
                            }

                            Local1++
                        }

                        Return (Local3)
                    }
                }

                Method (XBCM, 1, NotSerialized)
                {
                    If ((^BOX3.XBCM (Arg0) == Ones))
                    {
                        ^LEGA.XBCM (Arg0)
                    }
                }

                Method (XBQC, 0, NotSerialized)
                {
                    Return (^LEGA.XBQC ())
                }

                Name (BRCT, Zero)
                Method (BRID, 1, NotSerialized)
                {
                    Local0 = Match (BRIG, MEQ, Arg0, MTR, Zero, 0x02)
                    If ((Local0 == Ones))
                    {
                        Return ((SizeOf (BRIG) - One))
                    }

                    Return (Local0)
                }

                Method (XBCL, 0, NotSerialized)
                {
                    BRCT = One
                    Return (BRIG) /* \_SB_.PCI0.GFX0.BRIG */
                }

                Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                {
                }

                Method (DECB, 0, NotSerialized)
                {
                    If (BRCT)
                    {
                        Notify (LCD0, 0x87) // Device-Specific
                    }
                    Else
                    {
                        Local0 = BRID (XBQC ())
                        If ((Local0 != 0x02))
                        {
                            Local0--
                        }

                        XBCM (DerefOf (BRIG [Local0]))
                    }
                }

                Method (INCB, 0, NotSerialized)
                {
                    If (BRCT)
                    {
                        Notify (LCD0, 0x86) // Device-Specific
                    }
                    Else
                    {
                        Local0 = BRID (XBQC ())
                        If ((Local0 != (SizeOf (BRIG) - One)))
                        {
                            Local0++
                        }

                        XBCM (DerefOf (BRIG [Local0]))
                    }
                }
            }

            Scope (GFX0)
            {
                Name (BRIG, Package (0x12)
                {
                    0x64, 
                    0x64, 
                    0x02, 
                    0x04, 
                    0x05, 
                    0x07, 
                    0x09, 
                    0x0B, 
                    0x0D, 
                    0x12, 
                    0x14, 
                    0x18, 
                    0x1D, 
                    0x21, 
                    0x28, 
                    0x32, 
                    0x43, 
                    0x64
                })
            }
        }
    }

    Name (_S0, Package (0x04)  // _S0_: S0 System State
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S3, Package (0x04)  // _S3_: S3 System State
    {
        0x05, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S4, Package (0x04)  // _S4_: S4 System State
    {
        0x06, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S5, Package (0x04)  // _S5_: S5 System State
    {
        0x07, 
        Zero, 
        Zero, 
        Zero
    })
    Scope (_SB)
    {
        Device (DOCK)
        {
            Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                _SB
            })
            Method (_DCK, 1, NotSerialized)  // _DCK: Dock Present
            {
                If (Arg0)
                {
                    GP28 = One
                    ^^PCI0.LPCB.EC.DKR1 = One
                }
                Else
                {
                    GP28 = Zero
                    ^^PCI0.LPCB.EC.DKR1 = Zero
                }

                Local0 = (Arg0 ^ ^^PCI0.LPCB.EC.DKR1) /* \_SB_.PCI0.LPCB.EC__.DKR1 */
                Return (Local0)
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (^^PCI0.LPCB.EC.DKR1) /* \_SB_.PCI0.LPCB.EC__.DKR1 */
            }

            Name (G_ID, 0xFFFFFFFF)
            Method (GGID, 0, NotSerialized)
            {
                Local0 = G_ID /* \_SB_.DOCK.G_ID */
                If ((Local0 == 0xFFFFFFFF))
                {
                    Local0 = ((GP02 | (GP03 << One)) | (GP04 << 
                        0x02))
                    If ((Local0 == Zero))
                    {
                        Local0 = 0x03
                    }

                    G_ID = Local0
                }

                Return (Local0)
            }
        }
    }

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q18, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Notify (DOCK, 0x03) // Eject Request
        }

        Method (_Q37, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Notify (DOCK, Zero) // Bus Check
        }

        Method (_Q45, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Notify (DOCK, 0x03) // Eject Request
        }

        Method (_Q50, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Local0 = ^^^^DOCK.GGID ()
            If ((Local0 != 0x07))
            {
                Notify (DOCK, 0x03) // Eject Request
            }
        }

        Method (_Q58, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Notify (DOCK, Zero) // Bus Check
        }

        Method (_Q5A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Local0 = ^^^^DOCK.GGID ()
            If ((Local0 == 0x07))
            {
                Notify (DOCK, 0x03) // Eject Request
            }

            If ((Local0 == 0x03))
            {
                Sleep (0x64)
                Local1 = DKR1 /* \_SB_.PCI0.LPCB.EC__.DKR1 */
                If ((Local1 == One))
                {
                    Notify (DOCK, Zero) // Bus Check
                }
            }
        }
    }

    Method (UCMS, 1, Serialized)
    {
        Switch (ToInteger (Arg0))
        {
            Case (0x0C)
            {
                \_SB.PCI0.LPCB.EC.LGHT (One)
            }
            Case (0x0D)
            {
                \_SB.PCI0.LPCB.EC.LGHT (Zero)
            }

        }
    }
}

