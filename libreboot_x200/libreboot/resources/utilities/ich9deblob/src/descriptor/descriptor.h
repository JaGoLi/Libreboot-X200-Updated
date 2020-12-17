/*
 *  descriptor/descriptor.h
 *  This file is part of the ich9deblob utility from the libreboot project
 *
 *  Copyright (C) 2014, 2015 Leah Rowe <info@minifree.org>
 *  Copyright (C) 2014 Steve Shenton <sgsit@libreboot.org>
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
 
/*
 * Purpose: provide struct representing descriptor region.
 * Map actual buffers of this regions, directly to instances of these
 * structs. This makes working with descriptor really easy.
 *
 * bit fields used, corresponding to datasheet. See links to datasheets
 * and documentation in ich9deblob.c
 */
 
/*
 * See docs/hardware/x200_remove_me.html for info plus links to datasheet (also linked below)
 * 
 * Info about flash descriptor (read page 845 onwards):
 * http://www.intel.co.uk/content/dam/doc/datasheet/io-controller-hub-9-datasheet.pdf
 */

#ifndef DESCRIPTORSTRUCT_H
#define DESCRIPTORSTRUCT_H

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include "../gbe/gbe.h" /* Needed for GBEREGIONSIZE_4K/8K define */

/* size of the descriptor in bytes */
#define DESCRIPTORREGIONSIZE 0x1000

/* ROM image sizes in bytes */
#define ROMSIZE_512KB 0x80000
#define ROMSIZE_1MB 0x100000
#define ROMSIZE_2MB 0x200000
#define ROMSIZE_4MB 0x400000
#define ROMSIZE_8MB 0x800000
#define ROMSIZE_16MB 0x1000000

/* 
 * Related to the flash descriptor
 * bits 12(0xC)-24(0x18) are represented for words found in the flash descriptor
 * To manipulate these easily in C, we shift them by FLREGIONBITSHIFT and then shift them back when done
 * (because this is how data is stored in the flash descriptor)
 */
#define FLREGIONBITSHIFT 0xC

/*
 * ---------------------------------------------------------------------
 * Descriptor struct representing the data
 * ---------------------------------------------------------------------
 */

/* Flash Valid Signature Register */
struct FLVALSIG
{
	/*
	 * 4 bytes. 
	 * descriptor mode = 0FF0A55A (hex, big endian). Note: stored in ROM in little endian order.
	 * Anything else is considered invalid and will put the system in non-descriptor mode.
	 */
	uint32_t signature; /* Put 0x0FF0A55A here. confirmed in deblobbed_descriptor.bin */
};

/*  */
struct FLMAP0
{
	/* least signicant bits */
	uint8_t FCBA                      : 8;
	uint8_t NC                        : 2;
	uint8_t reserved1                 : 6;
	uint8_t FRBA                      : 8;
	uint8_t NR                        : 3;
	uint8_t reserved2                 : 5;
	/* most significant bits. */
};

struct FLMAP1 
{
	/* least significant bits */
	uint8_t FMBA                      : 8;
	uint8_t NM                        : 3;
	uint8_t reserved                  : 5;
	uint8_t FISBA                     : 8;
	uint8_t ISL                       : 8;
	/* most significant bits */
};

struct FLMAP2 
{
	/* least significant bits */
	uint8_t FMSBA                     : 8;
	uint8_t MSL                       : 8;
	uint16_t reserved                 : 16;
	/* most significant bits */
};

/* Flash Map Registers */
struct FLMAPS 
{
	struct FLMAP0 flMap0;
	struct FLMAP1 flMap1;
	struct FLMAP2 flMap2;
};

/* Flash Components Register */
struct FLCOMP 
{
	/* least significant bits */
	uint8_t component1Density         : 3;
	uint8_t component2Density         : 3;
	uint8_t reserved1                 : 2;
	uint8_t reserved2                 : 8;
	uint8_t reserved3                 : 1;
	uint8_t readClockFrequency        : 3;
	uint8_t fastReadSupport           : 1;
	uint8_t fastreadClockFrequency    : 3;
	uint8_t writeEraseClockFrequency  : 3;
	uint8_t readStatusClockFrequency  : 3;
	uint8_t reserved4                 : 2;
	/* most significant bits */
};

struct COMPONENTSECTIONRECORD 
{
	struct FLCOMP flcomp;
	uint32_t flill;
	uint32_t flpb;
	uint8_t padding[36];
};

struct FLREG 
{
	/* least significant bits */
	uint16_t BASE                     : 13;
	uint16_t reserved1                : 3;
	uint16_t LIMIT                    : 13;
	uint16_t reserved2                : 3;
	/* most significant bits */
};

/* Flash Descriptor Region Section */
/*
 * Defines where all the regions begin/end.
 * This is very important for disabling ME/AMT
 */
struct REGIONSECTIONRECORD 
{
	struct FLREG flReg0;                         /*  Descriptor */
	struct FLREG flReg1;                         /*  BIOS       */
	struct FLREG flReg2;                         /*  ME         */
	struct FLREG flReg3;                         /*  Gbe        */
	struct FLREG flReg4;                         /*  Platform   */
	uint8_t padding[12];
};

struct FLMSTR 
{
	/* least significant bits */
   uint16_t requesterId              : 16;
	uint8_t fdRegionReadAccess        : 1;
	uint8_t biosRegionReadAccess      : 1;
	uint8_t meRegionReadAccess        : 1;
	uint8_t gbeRegionReadAccess       : 1;
	uint8_t pdRegionReadAccess        : 1;
	uint8_t reserved1                 : 3; /* Must be zero, according to datasheet */
	uint8_t fdRegionWriteAccess       : 1;
	uint8_t biosRegionWriteAccess     : 1;
	uint8_t meRegionWriteAccess       : 1;
	uint8_t gbeRegionWriteAccess      : 1;
	uint8_t pdRegionWriteAccess       : 1;
	uint8_t reserved2                 : 3; /* Must be zero, according to datasheet */
	/* most significant bits */
};

/* Master Access Section */
struct MASTERACCESSSECTIONRECORD
{
	struct FLMSTR flMstr1;                       /* Flash Master 1 (Host CPU / BIOS) */
	struct FLMSTR flMstr2;                       /* Flash Master 2 (ME) */
	struct FLMSTR flMstr3;                       /* Flash Master 3 (Gbe) */
	uint8_t padding[148];
};

struct ICHSTRAP0 
{
	/* least significant bits */
	                                             /* todo: add MeSmBus2Sel (boring setting) */
	uint8_t meDisable                 : 1; /* If true, ME is disabled. */
	uint8_t reserved1                 : 6;
	uint8_t tcoMode                   : 1; /* TCO Mode: (Legacy,TCO Mode) The TCO Mode, along with the BMCMODE strap, determines the behavior of the IAMT SmBus controller. */
	uint8_t smBusAddress              : 7; /* The ME SmBus 7-bit address. */
	uint8_t bmcMode                   : 1; /* BMC mode: If true, device is in BMC mode.  If Intel(R) AMT or ASF using Intel integrated LAN then this should be false. */
	uint8_t tripPointSelect           : 1; /* Trip Point Select: false the NJCLK input buffer is matched to 3.3v signal from the external PHY device, true is matched to 1.8v. */
	uint8_t reserved2                 : 2;
	uint8_t integratedGbe             : 1; /* Integrated GbE or PCI Express select: (PCI Express,,Integrated GbE) Defines what PCIe Port 6 is used for. */
	uint8_t lanPhy                    : 1; /* LANPHYPC_GP12_SEL: Set to 0 for GP12 to be used as GPIO (General Purpose Input/Output), or 1 for GP12 to be used for native mode as LAN_PHYPC for 82566 LCD device */
	uint8_t reserved3                 : 3;
	uint8_t dmiRequesterId            : 1; /* DMI requestor ID security check disable: The primary purpose of this strap is to support server environments with multiple CPUs that each have a different RequesterID that can access the Flash. */
	uint8_t smBus2Address             : 7; /* The ME SmBus 2 7-bit address. */
	/* most significant bits */
};

struct ICHSTRAP1 
{
	/* least significant bits */
	uint8_t northMlink                : 1;  /* North MLink Dynamic Clock Gate Disable : Sets the default value for the South MLink Dynamic Clock Gate Enable registers. */
	uint8_t southMlink                : 1;  /* South MLink Dynamic Clock Gate Enable : Sets the default value for the South MLink Dynamic Clock Gate Enable registers. */
	uint8_t meSmbus                   : 1;  /* ME SmBus Dynamic Clock Gate Enable : Sets the default value for the ME SMBus Dynamic Clock Gate Enable for both the ME SmBus controllers. */
	uint8_t sstDynamic                : 1;  /* SST Dynamic Clock Gate Enable : Sets the default value for the SST Clock Gate Enable registers. */
	uint8_t reserved1                 : 4;
	uint8_t northMlink2               : 1;  /* North MLink 2 Non-Posted Enable : 'true':North MLink supports two downstream non-posted requests. 'false':North MLink supports one downstream non-posted requests. */
	uint8_t reserved2                 : 7;
	uint16_t reserved3                : 16;
	/* most significant bits */
};

/* ICH straps */
struct ICHSTRAPSRECORD 
{
	struct ICHSTRAP0 ichStrap0;
	struct ICHSTRAP1 ichStrap1;
	uint8_t padding[248];
};

struct MCHSTRAP0 
{
	/* least significant bits */
	uint8_t meDisable                 : 1;  /* If true, ME is disabled. */
	uint8_t meBootFromFlash           : 1;  /* ME boot from Flash - guessed location */
	uint8_t tpmDisable                : 1;  /* iTPM Disable : When set true, iTPM Host Interface is disabled. When set false (default), iTPM is enabled. */
	uint8_t reserved1                 : 3;
	uint8_t spiFingerprint            : 1;  /* SPI Fingerprint Sensor Present: Indicates if an SPI Fingerprint sensor is present at CS#1. */
	uint8_t meAlternateDisable        : 1;  /* ME Alternate Disable: Setting this bit allows ME to perform critical chipset functions but prevents loading of any ME FW applications. */
	uint8_t reserved2                 : 8;
	uint16_t reserved3                : 16;
	/* most significant bits */
};

/* MCH straps */
struct MCHSTRAPSRECORD 
{
	struct MCHSTRAP0 mchStrap0;
	uint8_t padding[3292];
};

/* ME VSCC Table */
struct MEVSCCTABLERECORD 
{
	uint32_t jid0;
	uint32_t vscc0;
	uint32_t jid1;
	uint32_t vscc1;
	uint32_t jid2;
	uint32_t vscc2;
	uint8_t padding[4];
};

/* Descriptor Map 2 Record */
struct DESCRIPTORMAP2RECORD
{
	/* least significant bits */
	uint8_t meVsccTableBaseAddress    : 8;
	uint8_t meVsccTableLength         : 8;
	uint16_t reserved                 : 16;
	/* most significant bits */
};

/* OEM section */
struct OEMSECTIONRECORD 
{
	uint8_t magicString[8];
	uint8_t padding[248];
};

/* 4KiB descriptor region, goes at the beginning of the ROM image */
struct DESCRIPTORREGIONRECORD 
{
	struct FLVALSIG flValSig;                                   /* Flash Valid Signature Register */
	struct FLMAPS flMaps;                                       /* Flash Map Registers */
	struct COMPONENTSECTIONRECORD componentSection;             /* Component Section Record */
	struct REGIONSECTIONRECORD regionSection;                   /* Flash Descriptor Region Section */
	struct MASTERACCESSSECTIONRECORD masterAccessSection;       /* Master Access Section */
	struct ICHSTRAPSRECORD ichStraps;                           /* ICH straps */
	struct MCHSTRAPSRECORD mchStraps;                           /* MCH straps */
	struct MEVSCCTABLERECORD meVsccTable;                       /* ME VSCC Table */
	struct DESCRIPTORMAP2RECORD descriptor2Map;                 /* Descriptor Map 2 Record */
	struct OEMSECTIONRECORD oemSection;                         /* OEM section */
};

/*
 * ---------------------------------------------------------------------
 * Function declarations (keep gcc/make happy. check them in descriptor.c)
 * ---------------------------------------------------------------------
 */
 
struct DESCRIPTORREGIONRECORD descriptorHostRegionsUnlocked(struct DESCRIPTORREGIONRECORD descriptorStruct);
struct DESCRIPTORREGIONRECORD descriptorMeRegionsForbidden(struct DESCRIPTORREGIONRECORD descriptorStruct);
struct DESCRIPTORREGIONRECORD descriptorMeRegionRemoved(struct DESCRIPTORREGIONRECORD descriptorStruct);
struct DESCRIPTORREGIONRECORD descriptorPlatformRegionRemoved(struct DESCRIPTORREGIONRECORD descriptorStruct);
struct DESCRIPTORREGIONRECORD descriptorDisableMe(struct DESCRIPTORREGIONRECORD descriptorStruct);
struct DESCRIPTORREGIONRECORD descriptorDisableTpm(struct DESCRIPTORREGIONRECORD descriptorStruct);
struct DESCRIPTORREGIONRECORD descriptorMoveGbeToStart(struct DESCRIPTORREGIONRECORD descriptorStruct);
struct DESCRIPTORREGIONRECORD descriptorGbeRegionRemoved(struct DESCRIPTORREGIONRECORD descriptorStruct);
struct DESCRIPTORREGIONRECORD descriptorBiosRegionFillImageAfterGbe(struct DESCRIPTORREGIONRECORD descriptorStruct, unsigned int romSize);
struct DESCRIPTORREGIONRECORD descriptorBiosRegionFillImageAfterDescriptor(struct DESCRIPTORREGIONRECORD descriptorStruct, unsigned int romSize);
struct DESCRIPTORREGIONRECORD descriptorOemString(struct DESCRIPTORREGIONRECORD descriptorStruct);
int descriptorDefinesGbeRegion(struct DESCRIPTORREGIONRECORD descriptorStruct);
struct DESCRIPTORREGIONRECORD librebootSetGbeBiosDescriptorRegions(struct DESCRIPTORREGIONRECORD descriptorStruct, unsigned int romSize);
uint8_t componentDensity(unsigned int romSizeInBytes);
struct DESCRIPTORREGIONRECORD librebootDescriptorStructFromFactory(struct DESCRIPTORREGIONRECORD descriptorStruct, unsigned int romSize);
int notCreatedHFileForDescriptorCFile(char* outFileName, char* cFileName);
int notCreatedCFileFromDescriptorStruct(struct DESCRIPTORREGIONRECORD descriptorStruct, char* outFileName, char* headerFileName);
void printDescriptorRegionLocations(struct DESCRIPTORREGIONRECORD descriptorStruct, char* romName);

#endif
