/*
 *  Copyright (C) 2014, 2015 Leah Rowe <info@minifree.org>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "mkdescriptor.h"

/* Generate a 4KiB Descriptor struct, with default values. */
/* Read ../descriptor/descriptor.h for an explanation of the default values used here */

struct DESCRIPTORREGIONRECORD generatedDescriptorStruct(unsigned int romSize, int hasGbe)
{
    int i;
    struct DESCRIPTORREGIONRECORD descriptorStruct;

    /* Flash Valid Signature Register */
    descriptorStruct.flValSig.signature = 0x0ff0a55a;

    /* Flash Map Registers */
    /* FLMAP0 */
    descriptorStruct.flMaps.flMap0.FCBA = 0x01;
    descriptorStruct.flMaps.flMap0.NC = 0x0;
    descriptorStruct.flMaps.flMap0.reserved1 = 0x00;
    descriptorStruct.flMaps.flMap0.FRBA = 0x04;
    descriptorStruct.flMaps.flMap0.NR = hasGbe ? 0x2 : 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.flMaps.flMap0.reserved2 = 0x00;
    /* FLMAP1 */
    descriptorStruct.flMaps.flMap1.FMBA = 0x06;
    descriptorStruct.flMaps.flMap1.NM = 0x2;
    descriptorStruct.flMaps.flMap1.reserved = 0x00;
    descriptorStruct.flMaps.flMap1.FISBA = 0x10;
    descriptorStruct.flMaps.flMap1.ISL = 0x02;
    /* FLMAP2 */
    descriptorStruct.flMaps.flMap2.FMSBA = 0x20;
    descriptorStruct.flMaps.flMap2.MSL = 0x01;
    descriptorStruct.flMaps.flMap2.reserved = 0x0000;

    /* Component Section Record */
    /* FLCOMP */
    descriptorStruct.componentSection.flcomp.component1Density = componentDensity(romSize);
    descriptorStruct.componentSection.flcomp.component2Density = componentDensity(romSize);
    descriptorStruct.componentSection.flcomp.reserved1 = 0x0;
    descriptorStruct.componentSection.flcomp.reserved2 = 0x00;
    descriptorStruct.componentSection.flcomp.reserved3 = 0x0;
    descriptorStruct.componentSection.flcomp.readClockFrequency = 0x0;
    descriptorStruct.componentSection.flcomp.fastReadSupport = 0x1;
    descriptorStruct.componentSection.flcomp.fastreadClockFrequency = 0x1;
    descriptorStruct.componentSection.flcomp.writeEraseClockFrequency = 0x0;
    descriptorStruct.componentSection.flcomp.readStatusClockFrequency = 0x0;
    descriptorStruct.componentSection.flcomp.reserved4 = 0x0;
    /* FLILL */
    descriptorStruct.componentSection.flill = 0x00000000;
    /* FLPB */
    descriptorStruct.componentSection.flpb = 0x00000000;
    /* Padding */
    for (i = 0; i < 36; i++) {
        descriptorStruct.componentSection.padding[i] = 0xFF;
    }

    /* Flash Descriptor Region Section */
    /* FLREG0 (Descriptor) */
    descriptorStruct.regionSection.flReg0.BASE = 0x0000;
    descriptorStruct.regionSection.flReg0.reserved1 = 0x0;
    descriptorStruct.regionSection.flReg0.LIMIT = 0x0000;
    descriptorStruct.regionSection.flReg0.reserved2 = 0x0;
    /* FLREG1 (BIOS) */
    descriptorStruct.regionSection.flReg1.BASE = (DESCRIPTORREGIONSIZE + (hasGbe ? GBEREGIONSIZE_8K : 0)) >> FLREGIONBITSHIFT; /* see ../descriptor/descriptor.c */
    descriptorStruct.regionSection.flReg1.reserved1 = 0x0;
    descriptorStruct.regionSection.flReg1.LIMIT = ((romSize >> FLREGIONBITSHIFT) - 1); /* see ../descriptor/descriptor.c */
    descriptorStruct.regionSection.flReg1.reserved2 = 0x0;
    /* FLREG2 (ME) */
    descriptorStruct.regionSection.flReg2.BASE = 0x1fff; /* see ../descriptor/descriptor.c */
    descriptorStruct.regionSection.flReg2.reserved1 = 0x0;
    descriptorStruct.regionSection.flReg2.LIMIT = 0x0000; /* see ../descriptor/descriptor.c */
    descriptorStruct.regionSection.flReg2.reserved2 = 0x0;
    /* FLREG3 (Gbe) */
    descriptorStruct.regionSection.flReg3.BASE = hasGbe ? (DESCRIPTORREGIONSIZE >> FLREGIONBITSHIFT) : 0x1fff; /* see ../descriptor/descriptor.c */
    descriptorStruct.regionSection.flReg3.reserved1 = 0x0;
    descriptorStruct.regionSection.flReg3.LIMIT = hasGbe ? (GBEREGIONSIZE_8K >> FLREGIONBITSHIFT) : 0x0000; /* see ../descriptor/descriptor.c */
    descriptorStruct.regionSection.flReg3.reserved2 = 0x0;
    /* FLREG4 (Platform) */
    descriptorStruct.regionSection.flReg4.BASE = 0x1fff; /* see ../descriptor/descriptor.c */
    descriptorStruct.regionSection.flReg4.reserved1 = 0x0;
    descriptorStruct.regionSection.flReg4.LIMIT = 0x0000; /* see ../descriptor/descriptor.c */
    descriptorStruct.regionSection.flReg4.reserved2 = 0x0;
    /* Padding */
    for (i = 0; i < 12; i++) {
        descriptorStruct.regionSection.padding[i] = 0xFF;
    }

    /* Master Access Section */
    /* FLMSTR1 (Host CPU / BIOS) */
    descriptorStruct.masterAccessSection.flMstr1.requesterId = 0x0000;
    descriptorStruct.masterAccessSection.flMstr1.fdRegionReadAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.biosRegionReadAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.meRegionReadAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.gbeRegionReadAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.pdRegionReadAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.reserved1 = 0x0;
    descriptorStruct.masterAccessSection.flMstr1.fdRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.biosRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.meRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.gbeRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.pdRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.reserved2 = 0x0;
    /* FLMSTR2 (ME) */
    descriptorStruct.masterAccessSection.flMstr2.requesterId = 0x0000;
    descriptorStruct.masterAccessSection.flMstr2.fdRegionReadAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.biosRegionReadAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.meRegionReadAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.gbeRegionReadAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.pdRegionReadAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.reserved1 = 0x0;
    descriptorStruct.masterAccessSection.flMstr2.fdRegionWriteAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.biosRegionWriteAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.meRegionWriteAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.gbeRegionWriteAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.pdRegionWriteAccess = 0x0; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr2.reserved2 = 0x0;
    /* FLMSTR3 (Gbe) */
    descriptorStruct.masterAccessSection.flMstr3.requesterId = 0x0218;
    descriptorStruct.masterAccessSection.flMstr3.fdRegionReadAccess = 0x0;
    descriptorStruct.masterAccessSection.flMstr3.biosRegionReadAccess = 0x0;
    descriptorStruct.masterAccessSection.flMstr3.meRegionReadAccess = 0x0;
    descriptorStruct.masterAccessSection.flMstr3.gbeRegionReadAccess = 0x1;
    descriptorStruct.masterAccessSection.flMstr3.pdRegionReadAccess = 0x0;
    descriptorStruct.masterAccessSection.flMstr3.reserved1 = 0x0;
    descriptorStruct.masterAccessSection.flMstr3.fdRegionWriteAccess = 0x0;
    descriptorStruct.masterAccessSection.flMstr3.biosRegionWriteAccess = 0x0;
    descriptorStruct.masterAccessSection.flMstr3.meRegionWriteAccess = 0x0;
    descriptorStruct.masterAccessSection.flMstr3.gbeRegionWriteAccess = 0x1;
    descriptorStruct.masterAccessSection.flMstr3.pdRegionWriteAccess = 0x0;
    descriptorStruct.masterAccessSection.flMstr3.reserved2 = 0x0;
    /* Padding */
    for (i = 0; i < 148; i++) {
        descriptorStruct.masterAccessSection.padding[i] = 0xFF;
    }

    /* ICH straps */
    /* ICHSTRAP0 */
    descriptorStruct.ichStraps.ichStrap0.meDisable = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.ichStraps.ichStrap0.reserved1 = 0x04;
    descriptorStruct.ichStraps.ichStrap0.tcoMode = 0x1;
    descriptorStruct.ichStraps.ichStrap0.smBusAddress = 0x64;
    descriptorStruct.ichStraps.ichStrap0.bmcMode = 0x0;
    descriptorStruct.ichStraps.ichStrap0.tripPointSelect = 0x0;
    descriptorStruct.ichStraps.ichStrap0.reserved2 = 0x0;
    descriptorStruct.ichStraps.ichStrap0.integratedGbe = hasGbe ? 0x1 : 0x0;
    descriptorStruct.ichStraps.ichStrap0.lanPhy = hasGbe ? 0x1 : 0x0;
    descriptorStruct.ichStraps.ichStrap0.reserved3 = 0x0;
    descriptorStruct.ichStraps.ichStrap0.dmiRequesterId = 0x0;
    descriptorStruct.ichStraps.ichStrap0.smBus2Address = 0x00;
    /* ICHSTRAP1 */
    descriptorStruct.ichStraps.ichStrap1.northMlink = 0x1;
    descriptorStruct.ichStraps.ichStrap1.southMlink = 0x1;
    descriptorStruct.ichStraps.ichStrap1.meSmbus = 0x1;
    descriptorStruct.ichStraps.ichStrap1.sstDynamic = 0x1;
    descriptorStruct.ichStraps.ichStrap1.reserved1 = 0x0;
    descriptorStruct.ichStraps.ichStrap1.northMlink2 = 0x1;
    descriptorStruct.ichStraps.ichStrap1.reserved2 = 0x00;
    descriptorStruct.ichStraps.ichStrap1.reserved3 = 0x0000;
    /* Padding */
    for (i = 0; i < 248; i++) {
        descriptorStruct.ichStraps.padding[i] = 0xFF;
    }

    /* MCH straps */
    /* MCHSTRAP0 */
    descriptorStruct.mchStraps.mchStrap0.meDisable = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.mchStraps.mchStrap0.meBootFromFlash = 0x0;
    descriptorStruct.mchStraps.mchStrap0.tpmDisable = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.mchStraps.mchStrap0.reserved1 = 0x7;
    descriptorStruct.mchStraps.mchStrap0.spiFingerprint = 0x1;
    descriptorStruct.mchStraps.mchStrap0.meAlternateDisable = 0x0;
    descriptorStruct.mchStraps.mchStrap0.reserved2 = 0xff;
    descriptorStruct.mchStraps.mchStrap0.reserved3 = 0xffff;
    /* Padding */
    for (i = 0; i < 3292; i++) {
        descriptorStruct.mchStraps.padding[i] = 0xFF;
    }

    /* ME VSCC Table */
    descriptorStruct.meVsccTable.jid0 = 0x001720c2;
    descriptorStruct.meVsccTable.vscc0 = 0x20052005;
    descriptorStruct.meVsccTable.jid1 = 0x001730ef;
    descriptorStruct.meVsccTable.vscc1 = 0x20052005;
    descriptorStruct.meVsccTable.jid2 = 0x0000481f;
    descriptorStruct.meVsccTable.vscc2 = 0x20152015;
    /* Padding */
    for (i = 0; i < 4; i++) {
        descriptorStruct.meVsccTable.padding[i] = 0xFF;
    }

    /* Descriptor Map 2 Record */
    descriptorStruct.descriptor2Map.meVsccTableBaseAddress = 0xee;
    descriptorStruct.descriptor2Map.meVsccTableLength = 0x06;
    descriptorStruct.descriptor2Map.reserved = 0x0000;

    /* OEM section */
    /* see ../descriptor/descriptor.c */
    /* Magic String (ascii characters) */
    descriptorStruct.oemSection.magicString[0] = 0x4c;
    descriptorStruct.oemSection.magicString[1] = 0x49;
    descriptorStruct.oemSection.magicString[2] = 0x42;
    descriptorStruct.oemSection.magicString[3] = 0x45;
    descriptorStruct.oemSection.magicString[4] = 0x52;
    descriptorStruct.oemSection.magicString[5] = 0x41;
    descriptorStruct.oemSection.magicString[6] = 0x54;
    descriptorStruct.oemSection.magicString[7] = 0x45;
    /* Padding */
    for (i = 0; i < 248; i++) {
        descriptorStruct.oemSection.padding[i] = 0xFF;
    }

    return descriptorStruct;
}

