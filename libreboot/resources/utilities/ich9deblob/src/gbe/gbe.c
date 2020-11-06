/*
 *  gbe/gbe.c
 *  This file is part of the ich9deblob utility from the libreboot project
 *
 *  Copyright (C) 2014 Steve Shenton <sgsit@libreboot.org>
 *                     Leah Rowe <info@minifree.org>
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
 * Provide gbe related functions.
 */

/* structs describing the data from gbe region */
#include "gbe.h"

/*
 * ---------------------------------------------------------------------
 * Gbe functions:
 * ---------------------------------------------------------------------
 */

/* gbe checksum calculation (algorithm based on datasheet) */
uint16_t gbeGetChecksumFrom4kBuffer(uint16_t* gbeWord, uint16_t desiredValue, int gbeRegionBase)
{
	int wordOffset;
	uint16_t total = 0;

	for (wordOffset = 0; wordOffset < 0x3F; wordOffset++)
		total += gbeWord[wordOffset + (gbeRegionBase>>1)];
	
	return desiredValue - total;
}

/* checksum calculation for 4k gbe struct (algorithm based on datasheet) */
uint16_t gbeGetChecksumFrom4kStruct(struct GBEREGIONRECORD_4K gbeStruct4k, uint16_t desiredValue)
{
	return gbeGetChecksumFrom4kBuffer((uint16_t*)&gbeStruct4k, desiredValue, 0);
}

/* modify the gbe region extracted from a factory.rom dump */
struct GBEREGIONRECORD_8K deblobbedGbeStructFromFactory(struct GBEREGIONRECORD_8K gbeStruct8k) 
{	
	unsigned int i;
	
	/*
	 * http://www.intel.co.uk/content/dam/doc/application-note/82573-nvm-map-appl-note.pdf
	 * That is a datasheet for a later chipset. Word 40H-53H seems (as per this datasheet) to be for AMT. 
	 * Writing over it doesn't seem to cause any harm, since the ME/AMT is already removed in libreboot.
	 */
	for(i = 0; i < sizeof(gbeStruct8k.backup.padding); i++) {
		gbeStruct8k.backup.padding[i] = 0xFF; /* FF is correct. In the struct, this is a char buffer. */
	} /* We really only need to do this for words 40h-53h, but let's just nuke the whole lot. It's all 0xFF anyway. */
	
	/* Fix the checksum */
	gbeStruct8k.backup.checkSum = gbeGetChecksumFrom4kStruct(gbeStruct8k.backup, GBECHECKSUMTOTAL);
	
	/* Main Gbe region on X200 (as shipped by Lenovo) is broken. Fix it by over-writing it with the contents of the backup */
	memcpy(&gbeStruct8k.main, &gbeStruct8k.backup, GBEREGIONSIZE_4K);
	
	return gbeStruct8k;
}

/*
 * ---------------------------------------------------------------------
 * C code generator (self-writing code)
 * ---------------------------------------------------------------------
 */

/*
 * Generate a C (.h) header file for the C source file made by notCreatedCFileFromGbeStruct4k()
 * 
 * Output it to a file.
 */
int notCreatedHFileForGbeCFile(char* outFileName, char* cFileName) 
{		
	remove(outFileName); /* Remove the old file before continuing */
	
	/* Open the file that will be written to */
	FILE* fp = fopen(outFileName, "w+");

	/* ------------------------------ */
	
	fprintf(fp, "/* %s: generated C code from ich9deblob */\n", outFileName);
	fprintf(fp, "/* .h header file for the gbe-generating C code (%s) */\n\n", cFileName);
	
	fprintf(fp, "#ifndef ICH9GEN_MKGBE_H\n");
	fprintf(fp, "#define ICH9GEN_MKGBE_H\n\n");
	
	fprintf(fp, "#include <stdio.h>\n");
	fprintf(fp, "#include <string.h>\n");
	fprintf(fp, "#include \"../gbe/gbe.h\"\n\n");
	
	fprintf(fp, "struct GBEREGIONRECORD_4K generatedGbeStruct4k();\n");
	fprintf(fp, "struct GBEREGIONRECORD_8K generatedGbeStruct8k();\n\n");
	
	fprintf(fp, "#endif\n");
	
	/* ------------------------------ */
	
	fclose(fp); /* Always close the file when done. */
	
	return 0;
}
/*
 * Generate a C source file that initializes the same data from a given
 * 4KiB Gbe data structure.
 * 
 * It will simply copy the 4KiB struct at the end to make a full 8KiB struct.
 * So just pass a working 4KiB Gbe struct here and you're good to go.
 * 
 * Output it to a file.
 */
int notCreatedCFileFromGbeStruct4k(struct GBEREGIONRECORD_4K gbeStruct4k, char* outFileName, char* headerFileName)
{
	int i;
	int paddingSize;
	int paddingIdentical;
	
	remove(outFileName); /* Remove the old file before continuing */
	
	/* Open the file that will be written to */
	FILE* fp = fopen(outFileName, "w+");

	/* ------------------------------ */
	
	fprintf(fp, "/* %s: generated C code from ich9deblob */\n", outFileName);
	fprintf(fp, "/* .c source file for the gbe-generating C code */\n\n");
	
	fprintf(fp, "#include \"%s\"\n\n", headerFileName);
	
	fprintf(fp, "/* Generate a 4KiB Gbe struct, with default values. */\n");
	fprintf(fp, "/* Read ../gbe/gbe.h for an explanation of the default values used here */\n\n");
	
	fprintf(fp, "struct GBEREGIONRECORD_4K generatedGbeStruct4k()\n");
	fprintf(fp, "{\n");
	fprintf(fp, "    int i;\n");
	fprintf(fp, "    struct GBEREGIONRECORD_4K gbeStruct4k;\n");
	fprintf(fp, "\n");
	/* Words 00h to 02h: MAC Address */
	fprintf(fp, "    /* MAC address (words 00h to 02h) */\n");
	fprintf(fp, "    /* see ../gbe/gbe.c */\n");
	for (i = 0; i < 6; i++) {
		fprintf(fp, "    gbeStruct4k.macAddress[%d] = 0x%02x;\n", i, gbeStruct4k.macAddress[i]);
	}
	fprintf(fp, "\n");
	/* Word 03h (Reserved) */
	fprintf(fp, "    /* Word 03h (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord03h.reserved1_0 = 0x%02x;\n", gbeStruct4k.reservedWord03h.reserved1_0);
	fprintf(fp, "    gbeStruct4k.reservedWord03h.reserved1_1 = 0x%01x;\n", gbeStruct4k.reservedWord03h.reserved1_1);
	fprintf(fp, "    gbeStruct4k.reservedWord03h.ibaLom = 0x%01x;\n", gbeStruct4k.reservedWord03h.ibaLom);
	fprintf(fp, "    gbeStruct4k.reservedWord03h.reserved2 = 0x%01x;\n", gbeStruct4k.reservedWord03h.reserved2);
	fprintf(fp, "\n");
	/* Word 04h (Reserved) */
	fprintf(fp, "    /* Word 04h (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord04h = 0x%04x;\n", gbeStruct4k.reservedWord04h);
	fprintf(fp, "\n");
	/* Word 05h (Image Version Information) */
	fprintf(fp, "    /* Word 05h (Image Version Information) */\n");
	fprintf(fp, "    gbeStruct4k.imageVersionInformation = 0x%04x;\n", gbeStruct4k.imageVersionInformation);
	fprintf(fp, "\n");
	/* Words 06h and 07h (Reserved) */
	fprintf(fp, "    /* Words 06h and 07h (Reserved) */\n");
	for (i = 0; i < 2; i++) {
		fprintf(fp, "    gbeStruct4k.reservedWords06h07h[%d] = 0x%04x;\n", i, gbeStruct4k.reservedWords06h07h[i]);
	}
	fprintf(fp, "\n");
	/* Words 08h and 09h (PBA Low and PBA High) */
	fprintf(fp, "    /* Word 08h and 09h (PBA Low and PBA High) */\n");
	fprintf(fp, "    gbeStruct4k.pbaLow = 0x%04x;\n", gbeStruct4k.pbaLow);
	fprintf(fp, "    gbeStruct4k.pbaHigh = 0x%04x;\n", gbeStruct4k.pbaHigh);
	fprintf(fp, "\n");
	/* Word 0Ah (PCI Initialization Control Word) */
	fprintf(fp, "    /* Word 0Ah (PCI Initialization Control Word) */\n");
	fprintf(fp, "    gbeStruct4k.pciInitializationControlWord.loadVendorDeviceId = 0x%01x;\n", gbeStruct4k.pciInitializationControlWord.loadVendorDeviceId);
	fprintf(fp, "    gbeStruct4k.pciInitializationControlWord.loadSubsystemId = 0x%01x;\n", gbeStruct4k.pciInitializationControlWord.loadSubsystemId);
	fprintf(fp, "    gbeStruct4k.pciInitializationControlWord.reserved1 = 0x%01x;\n", gbeStruct4k.pciInitializationControlWord.reserved1);
	fprintf(fp, "    gbeStruct4k.pciInitializationControlWord.reserved2 = 0x%01x;\n", gbeStruct4k.pciInitializationControlWord.reserved2);
	fprintf(fp, "    gbeStruct4k.pciInitializationControlWord.pmEnable = 0x%01x;\n", gbeStruct4k.pciInitializationControlWord.pmEnable);
	fprintf(fp, "    gbeStruct4k.pciInitializationControlWord.auxPwr = 0x%01x;\n", gbeStruct4k.pciInitializationControlWord.auxPwr);
	fprintf(fp, "    gbeStruct4k.pciInitializationControlWord.reserved3 = 0x%01x;\n", gbeStruct4k.pciInitializationControlWord.reserved3);
	fprintf(fp, "    gbeStruct4k.pciInitializationControlWord.reserved4 = 0x%01x;\n", gbeStruct4k.pciInitializationControlWord.reserved4);
	fprintf(fp, "\n");
	/* Word 0Bh (Subsystem ID) */
	fprintf(fp, "    /* Word 0Bh (Subsystem ID) */\n");
	fprintf(fp, "    gbeStruct4k.subsystemId = 0x%04x;\n", gbeStruct4k.subsystemId);
	fprintf(fp, "\n");
	/* Word 0Ch (Subsystem Vendor ID) */
	fprintf(fp, "    /* Word 0Ch (Subsystem Vendor ID) */\n");
	fprintf(fp, "    gbeStruct4k.subsystemVendorId = 0x%04x;\n", gbeStruct4k.subsystemVendorId);
	fprintf(fp, "\n");
	/* Word 0Dh (Device ID) */
	fprintf(fp, "    /* Word 0Dh (Device ID) */\n");
	fprintf(fp, "    gbeStruct4k.deviceId = 0x%04x;\n", gbeStruct4k.deviceId);
	fprintf(fp, "\n");
	/* Word 0Eh (Vendor ID) */
	fprintf(fp, "    /* Word 0Eh (Vendor ID) */\n");
	fprintf(fp, "    gbeStruct4k.vendorId = 0x%04x;\n", gbeStruct4k.vendorId);
	fprintf(fp, "\n");
	/* Word 0Fh (Device Revision ID) */
	fprintf(fp, "    /* Word 0Fh (Device Revision ID) */\n");
	fprintf(fp, "    gbeStruct4k.deviceRevId = 0x%04x;\n", gbeStruct4k.deviceRevId);
	fprintf(fp, "\n");
	/* Word 10h (LAN Power Consumption) */
	fprintf(fp, "    /* Word 10h (LAN Power Consumption) */\n");
	fprintf(fp, "    gbeStruct4k.lanPowerConsumption.lanD3Power = 0x%02x;\n", gbeStruct4k.lanPowerConsumption.lanD3Power);
	fprintf(fp, "    gbeStruct4k.lanPowerConsumption.reserved = 0x%01x;\n", gbeStruct4k.lanPowerConsumption.reserved);
	fprintf(fp, "    gbeStruct4k.lanPowerConsumption.lanD0Power = 0x%02x;\n", gbeStruct4k.lanPowerConsumption.lanD0Power);
	fprintf(fp, "\n");
	/* Words 11h and 12h (Reserved) */
	fprintf(fp, "    /* Words 11h and 12h (Reserved) */\n");
	for (i = 0; i < 2; i++) {
		fprintf(fp, "    gbeStruct4k.reservedWords11h12h[%d] = 0x%04x;\n", i, gbeStruct4k.reservedWords11h12h[i]);
	}
	fprintf(fp, "\n");
	/* Word 13h (Shared Initialization Control Word) */
	fprintf(fp, "    /* Word 13h (Shared Initialization Control Word) */\n");
	fprintf(fp, "    gbeStruct4k.sharedInitializationControlWord.reserved1 = 0x%01x;\n", gbeStruct4k.sharedInitializationControlWord.reserved1);
	fprintf(fp, "    gbeStruct4k.sharedInitializationControlWord.forceDuplex = 0x%01x;\n", gbeStruct4k.sharedInitializationControlWord.forceDuplex);
	fprintf(fp, "    gbeStruct4k.sharedInitializationControlWord.forceSpeedEnable = 0x%01x;\n", gbeStruct4k.sharedInitializationControlWord.forceSpeedEnable);
	fprintf(fp, "    gbeStruct4k.sharedInitializationControlWord.reserved2_0 = 0x%01x;\n", gbeStruct4k.sharedInitializationControlWord.reserved2_0);
	fprintf(fp, "    gbeStruct4k.sharedInitializationControlWord.reserved2_1 = 0x%01x;\n", gbeStruct4k.sharedInitializationControlWord.reserved2_1);
	fprintf(fp, "    gbeStruct4k.sharedInitializationControlWord.phyPowerDownEnable = 0x%01x;\n", gbeStruct4k.sharedInitializationControlWord.phyPowerDownEnable);
	fprintf(fp, "    gbeStruct4k.sharedInitializationControlWord.reserved3 = 0x%01x;\n", gbeStruct4k.sharedInitializationControlWord.reserved3);
	fprintf(fp, "    gbeStruct4k.sharedInitializationControlWord.reserved4 = 0x%01x;\n", gbeStruct4k.sharedInitializationControlWord.reserved4);
	fprintf(fp, "    gbeStruct4k.sharedInitializationControlWord.sign = 0x%01x;\n", gbeStruct4k.sharedInitializationControlWord.sign);
	fprintf(fp, "\n");
	/* Word 14h (Extended Configuration Control Word 1) */
	fprintf(fp, "    /* Word 14h (Extended Configuration Control Word 1) */\n");
	fprintf(fp, "    gbeStruct4k.extendedConfigurationControlWord1.extendedConfigurationPointer = 0x%03x;\n", gbeStruct4k.extendedConfigurationControlWord1.extendedConfigurationPointer);
	fprintf(fp, "    gbeStruct4k.extendedConfigurationControlWord1.oemWriteEnable = 0x%01x;\n", gbeStruct4k.extendedConfigurationControlWord1.oemWriteEnable);
	fprintf(fp, "    gbeStruct4k.extendedConfigurationControlWord1.reserved1 = 0x%01x;\n", gbeStruct4k.extendedConfigurationControlWord1.reserved1);
	fprintf(fp, "    gbeStruct4k.extendedConfigurationControlWord1.reserved2 = 0x%01x;\n", gbeStruct4k.extendedConfigurationControlWord1.reserved2);
	fprintf(fp, "    gbeStruct4k.extendedConfigurationControlWord1.reserved3 = 0x%01x;\n", gbeStruct4k.extendedConfigurationControlWord1.reserved3);
	fprintf(fp, "\n");
	/* Word 15h (Extended Configuration Control Word 2) */
	fprintf(fp, "    /* Word 15h (Extended Configuration Control Word 2) */\n");
	fprintf(fp, "    gbeStruct4k.extendedConfigurationControlWord2.reserved = 0x%02x;\n", gbeStruct4k.extendedConfigurationControlWord2.reserved);
	fprintf(fp, "    gbeStruct4k.extendedConfigurationControlWord2.extendedPhyLength = 0x%02x;\n", gbeStruct4k.extendedConfigurationControlWord2.extendedPhyLength);
	fprintf(fp, "\n");
	/* Word 16h (Extended Configuration Control Word 3) */
	fprintf(fp, "    /* Word 16h (Extended Configuration Control Word 3) */\n");
	fprintf(fp, "    gbeStruct4k.extendedConfigurationControlWord3 = 0x%04x;\n", gbeStruct4k.extendedConfigurationControlWord3);
	fprintf(fp, "\n");
	/* Word 17h (LED 1 Configuration and Power Management) */
	fprintf(fp, "    /* Word 17h (LED 1 Configuration and Power Management) */\n");
	fprintf(fp, "    gbeStruct4k.ledCtl1.led1Mode = 0x%01x;\n", gbeStruct4k.ledCtl1.led1Mode);
	fprintf(fp, "    gbeStruct4k.ledCtl1.reserved1 = 0x%01x;\n", gbeStruct4k.ledCtl1.reserved1);
	fprintf(fp, "    gbeStruct4k.ledCtl1.led1BlinkMode = 0x%01x;\n", gbeStruct4k.ledCtl1.led1BlinkMode);
	fprintf(fp, "    gbeStruct4k.ledCtl1.led1Invert = 0x%01x;\n", gbeStruct4k.ledCtl1.led1Invert);
	fprintf(fp, "    gbeStruct4k.ledCtl1.led1Blink = 0x%01x;\n", gbeStruct4k.ledCtl1.led1Blink);
	fprintf(fp, "    gbeStruct4k.ledCtl1.reserved2 = 0x%01x;\n", gbeStruct4k.ledCtl1.reserved2);
	fprintf(fp, "    gbeStruct4k.ledCtl1.lpluEnable = 0x%01x;\n", gbeStruct4k.ledCtl1.lpluEnable);
	fprintf(fp, "    gbeStruct4k.ledCtl1.lpluEnableNonD0a = 0x%01x;\n", gbeStruct4k.ledCtl1.lpluEnableNonD0a);
	fprintf(fp, "    gbeStruct4k.ledCtl1.gbeDisableNonD0a = 0x%01x;\n", gbeStruct4k.ledCtl1.gbeDisableNonD0a);
	fprintf(fp, "    gbeStruct4k.ledCtl1.reserved3 = 0x%01x;\n", gbeStruct4k.ledCtl1.reserved3);
	fprintf(fp, "    gbeStruct4k.ledCtl1.gbeDisable = 0x%01x;\n", gbeStruct4k.ledCtl1.gbeDisable);
	fprintf(fp, "    gbeStruct4k.ledCtl1.reserved4 = 0x%01x;\n", gbeStruct4k.ledCtl1.reserved4);
	fprintf(fp, "\n");
	/* Word 18h (LED 0 and 2 Configuration Defaults) */
	fprintf(fp, "    /* Word 18h (LED 0 and 2 Configuration Defaults) */\n");
	fprintf(fp, "    gbeStruct4k.ledCtl02.led0Mode = 0x%01x;\n", gbeStruct4k.ledCtl02.led0Mode);
	fprintf(fp, "    gbeStruct4k.ledCtl02.reserved1 = 0x%01x;\n", gbeStruct4k.ledCtl02.reserved1);
	fprintf(fp, "    gbeStruct4k.ledCtl02.led0BlinkMode = 0x%01x;\n", gbeStruct4k.ledCtl02.led0BlinkMode);
	fprintf(fp, "    gbeStruct4k.ledCtl02.led0Invert = 0x%01x;\n", gbeStruct4k.ledCtl02.led0Invert);
	fprintf(fp, "    gbeStruct4k.ledCtl02.led0Blink = 0x%01x;\n", gbeStruct4k.ledCtl02.led0Blink);
	fprintf(fp, "    gbeStruct4k.ledCtl02.led2Mode = 0x%01x;\n", gbeStruct4k.ledCtl02.led2Mode);
	fprintf(fp, "    gbeStruct4k.ledCtl02.reserved2 = 0x%01x;\n", gbeStruct4k.ledCtl02.reserved2);
	fprintf(fp, "    gbeStruct4k.ledCtl02.led2BlinkMode = 0x%01x;\n", gbeStruct4k.ledCtl02.led2BlinkMode);
	fprintf(fp, "    gbeStruct4k.ledCtl02.led2Invert = 0x%01x;\n", gbeStruct4k.ledCtl02.led2Invert);
	fprintf(fp, "    gbeStruct4k.ledCtl02.led2Blink = 0x%01x;\n", gbeStruct4k.ledCtl02.led2Blink);
	fprintf(fp, "\n");
	/* Word 19h (Reserved) */
	fprintf(fp, "    /* Word 19h (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord19h = 0x%04x;\n", gbeStruct4k.reservedWord19h);
	fprintf(fp, "\n");
	/* Word 1Ah (Reserved) */
	fprintf(fp, "    /* Word 1Ah (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord1Ah = 0x%04x;\n", gbeStruct4k.reservedWord1Ah);
	fprintf(fp, "\n");
	/* Word 1Bh (Reserved) */
	fprintf(fp, "    /* Word 1Bh (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord1Bh = 0x%04x;\n", gbeStruct4k.reservedWord1Bh);
	fprintf(fp, "\n");
	/* Word 1Ch (Reserved) */
	fprintf(fp, "    /* Word 1Ch (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord1Ch = 0x%04x;\n", gbeStruct4k.reservedWord1Ch);
	fprintf(fp, "\n");
	/* Word 1Dh (Reserved) */
	fprintf(fp, "    /* Word 1Dh (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord1Dh = 0x%04x;\n", gbeStruct4k.reservedWord1Dh);
	fprintf(fp, "\n");
	/* Word 1Eh (Device ID for Intel 82567LM gigabit ethernet controller) */
	fprintf(fp, "    /* Word 1Eh (Device ID for Intel 82567LM gigabit ethernet controller) */\n");
	fprintf(fp, "    gbeStruct4k._82567lmDeviceId = 0x%04x;\n", gbeStruct4k._82567lmDeviceId);
	fprintf(fp, "\n");
	/* Word 1Fh (Device ID for Intel 82567LF gigabit ethernet controller) */
	fprintf(fp, "    /* Word 1Fh (Device ID for Intel 82567LF gigabit ethernet controller) */\n");
	fprintf(fp, "    gbeStruct4k._82567lfDeviceId = 0x%04x;\n", gbeStruct4k._82567lfDeviceId);
	fprintf(fp, "\n");
	/* Word 20h (Reserved) */
	fprintf(fp, "    /* Word 20h (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord20h = 0x%04x;\n", gbeStruct4k.reservedWord20h);
	fprintf(fp, "\n");
	/* Word 21h (Device ID for Intel 82567V gigabit ethernet controller) */
	fprintf(fp, "    /* Word 21h (Device ID for Intel 82567V gigabit ethernet controller) */\n");
	fprintf(fp, "    gbeStruct4k._82567vDeviceId = 0x%04x;\n", gbeStruct4k._82567vDeviceId);
	fprintf(fp, "\n");
	/* Word 22h (Reserved) */
	fprintf(fp, "    /* Word 22h (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord22h = 0x%04x;\n", gbeStruct4k.reservedWord22h);
	fprintf(fp, "\n");
	/* Word 23h (Reserved) */
	fprintf(fp, "    /* Word 23h (Reserved) */\n");
	fprintf(fp, "    gbeStruct4k.reservedWord23h = 0x%04x;\n", gbeStruct4k.reservedWord23h);
	fprintf(fp, "\n");
	/* Words 24h to 2Fh (Reserved) */
	fprintf(fp, "    /* Words 24h to 2Fh (Reserved) */\n");
	for (i = 0; i < 12; i++) {
		fprintf(fp, "    gbeStruct4k.reservedWords24to2Fh[%d] = 0x%04x;\n", i, gbeStruct4k.reservedWords24to2Fh[i]);
	}
	fprintf(fp, "\n");
	/* Words 30h to 3Eh (PXE Software Region) */
	fprintf(fp, "    /* Words 30h to 3Eh (PXE Software Region) */\n");
	fprintf(fp, "    /* Boot Agent Main Setup Options (Word 30h) */\n");
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.protocolSelect = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.protocolSelect);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved1 = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved1);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.defaultBootSelection = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.defaultBootSelection);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved2 = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved2);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.promptTime = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.promptTime);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.displaySetupMessage = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.displaySetupMessage);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved3 = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved3);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.forceSpeed = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.forceSpeed);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.forceFullDuplex = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.forceFullDuplex);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved4 = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved4);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.efiPresence = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.efiPresence);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.pxePresence = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.pxePresence);
	fprintf(fp, "    /* Boot Agent Configuration Customization Options (Word 31h) */\n");
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableSetupMenu = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableSetupMenu);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableTitleMessage = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableTitleMessage);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableProtocolSelect = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableProtocolSelect);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableBootSelection = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableBootSelection);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableLegacyWakeupSupport = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableLegacyWakeupSupport);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableFlashUpdate = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableFlashUpdate);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.reserved1 = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.reserved1);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.ibaBootOrderSetupMode = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.ibaBootOrderSetupMode);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.reserved2 = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.reserved2);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.signature = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.signature);
	fprintf(fp, "    /* Boot Agent Configuration Customization Options (Word 32h) */\n");
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions32h.buildNumber = 0x%02x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions32h.buildNumber);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions32h.minorVersionNumber = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions32h.minorVersionNumber);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions32h.majorVersionNumber = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions32h.majorVersionNumber);
	fprintf(fp, "    /* IBA Capabilities (Word 33h) */\n");
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.baseCodePresent = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.baseCodePresent);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.undiCapabilityPresent = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.undiCapabilityPresent);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.reserved1 = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.reserved1);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.efiUndiCapabilityPresent = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.efiUndiCapabilityPresent);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.reserved2_0 = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.reserved2_0);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.reserved2_1 = 0x%02x;\n", gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.reserved2_1);
	fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.signature = 0x%01x;\n", gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.signature);
	fprintf(fp, "    /* Padding (Words 34h to 3Eh) */\n");
	for (i = 0; i < 11; i++) {
		fprintf(fp, "    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[%d] = 0x%04x;\n", i, gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[i]);
	}
	fprintf(fp, "\n");
	/* Word 3Fh (Checksum) */
	fprintf(fp, "    /* Word 3Fh (Checksum) */\n");
	fprintf(fp, "    gbeStruct4k.checkSum = 0x%04x;\n", gbeStruct4k.checkSum);
	fprintf(fp, "\n");
	/* The rest of Gbe is just padding */
	paddingSize = sizeof(gbeStruct4k.padding);
	paddingIdentical = 1; /* Assume that it's all 0xFF, then try to disprove it */
	for (i = 0; i < paddingSize; i++) { /* check whether contents differ */
		if (gbeStruct4k.padding[i] != 0xFF) {
			paddingIdentical = 0;
			break;
		}
	}
	if (!paddingIdentical) {
		fprintf(fp, "    /* The rest of Gbe (word 40h or byte 80h onwards) is just padding */\n");
		for (i = 0; i < paddingSize; i++) { /* contents are not all 0xFF, just spit them all out one by one */
			fprintf(fp, "    gbeStruct4k.padding[%d] = 0x%02x;\n", i, gbeStruct4k.padding[i]);
		}
	} else { /* contents are all 0xFF. Generate a small for loop that sets them all to 0xFF */
		fprintf(fp, "    /* The rest of Gbe (word 40h or byte 80h onwards) is just padding (0xFF) */\n");
		fprintf(fp, "    for (i = 0; i < %d; i++) {\n", paddingSize);
		fprintf(fp, "        gbeStruct4k.padding[i] = 0xFF;\n");
		fprintf(fp, "    }\n");
	}
	fprintf(fp, "\n");
	fprintf(fp, "    return gbeStruct4k;\n");
	fprintf(fp, "}\n\n");
	
	fprintf(fp, "struct GBEREGIONRECORD_8K generatedGbeStruct8k()\n");
	fprintf(fp, "{\n");
	fprintf(fp, "    struct GBEREGIONRECORD_8K gbeStruct8k;\n");
	fprintf(fp, "    gbeStruct8k.main = generatedGbeStruct4k();\n");
	fprintf(fp, "    memcpy(&gbeStruct8k.backup, &gbeStruct8k.main, GBEREGIONSIZE_4K);\n");
	fprintf(fp, "    return gbeStruct8k;\n");
	fprintf(fp, "}\n\n");
	
	/* ------------------------------ */
	
	fclose(fp); /* Always close the file when done. */
	
	return 0;
}

/*
 * ---------------------------------------------------------------------
 * Debugging functions:
 * ---------------------------------------------------------------------
 */

/*
 * show debugging info: show calculated (correct) gbe checksum and what
 * is actually stored, in a 4K gbe struct. Only for a single region.
 */
void printGbeChecksumDataFromStruct4k(struct GBEREGIONRECORD_4K gbeStruct4k, char* romName, char* regionName)
{
	printf(
		"%s Gbe (%s): calculated Gbe checksum: 0x%hx and actual GBe checksum: 0x%hx\n", 
		romName,
		regionName,
		gbeGetChecksumFrom4kStruct(gbeStruct4k, GBECHECKSUMTOTAL), 
		gbeStruct4k.checkSum
	);
	
	return;
}

/*
 * show debugging info: show calculated (correct) gbe checksum and what 
 * is actually stored, in a 8K gbe struct. Do so for main and backup regions.
 */
void printGbeChecksumDataFromStruct8k(struct GBEREGIONRECORD_8K gbeStruct8k, char* romName)
{	
	printGbeChecksumDataFromStruct4k(gbeStruct8k.main, romName, "main");
	printGbeChecksumDataFromStruct4k(gbeStruct8k.backup, romName, "backup");
	
	return;
}
