/*
 *  Copyright (C) 2014 Leah Rowe <info@minifree.org>
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

#include "mkgbe.h"

/* Generate a 4KiB Gbe struct, with default values. */
/* Read ../gbe/gbe.h for an explanation of the default values used here */

struct GBEREGIONRECORD_4K generatedGbeStruct4k()
{
    int i;
    struct GBEREGIONRECORD_4K gbeStruct4k;

    /* MAC address (words 00h to 02h) */
    /* see ../gbe/gbe.c */
    gbeStruct4k.macAddress[0] = 0x00;
    gbeStruct4k.macAddress[1] = 0xDE;
    gbeStruct4k.macAddress[2] = 0xAD;
    gbeStruct4k.macAddress[3] = 0xC0;
    gbeStruct4k.macAddress[4] = 0xFF;
    gbeStruct4k.macAddress[5] = 0xEE;

    /* Word 03h (Reserved) */
    gbeStruct4k.reservedWord03h.reserved1_0 = 0x00;
    gbeStruct4k.reservedWord03h.reserved1_1 = 0x0;
    gbeStruct4k.reservedWord03h.ibaLom = 0x1;
    gbeStruct4k.reservedWord03h.reserved2 = 0x0;

    /* Word 04h (Reserved) */
    gbeStruct4k.reservedWord04h = 0xffff;

    /* Word 05h (Image Version Information) */
    gbeStruct4k.imageVersionInformation = 0x1083;

    /* Words 06h and 07h (Reserved) */
    gbeStruct4k.reservedWords06h07h[0] = 0xffff;
    gbeStruct4k.reservedWords06h07h[1] = 0xffff;

    /* Word 08h and 09h (PBA Low and PBA High) */
    gbeStruct4k.pbaLow = 0x1008;
    gbeStruct4k.pbaHigh = 0xffff;

    /* Word 0Ah (PCI Initialization Control Word) */
    gbeStruct4k.pciInitializationControlWord.loadVendorDeviceId = 0x1;
    gbeStruct4k.pciInitializationControlWord.loadSubsystemId = 0x1;
    gbeStruct4k.pciInitializationControlWord.reserved1 = 0x0;
    gbeStruct4k.pciInitializationControlWord.reserved2 = 0x0;
    gbeStruct4k.pciInitializationControlWord.pmEnable = 0x1;
    gbeStruct4k.pciInitializationControlWord.auxPwr = 0x1;
    gbeStruct4k.pciInitializationControlWord.reserved3 = 0x0;
    gbeStruct4k.pciInitializationControlWord.reserved4 = 0x1;

    /* Word 0Bh (Subsystem ID) */
    gbeStruct4k.subsystemId = 0x20ee;

    /* Word 0Ch (Subsystem Vendor ID) */
    gbeStruct4k.subsystemVendorId = 0x17aa;

    /* Word 0Dh (Device ID) */
    gbeStruct4k.deviceId = 0x10f5;

    /* Word 0Eh (Vendor ID) */
    gbeStruct4k.vendorId = 0x8086;

    /* Word 0Fh (Device Revision ID) */
    gbeStruct4k.deviceRevId = 0x0000;

    /* Word 10h (LAN Power Consumption) */
    gbeStruct4k.lanPowerConsumption.lanD3Power = 0x01;
    gbeStruct4k.lanPowerConsumption.reserved = 0x0;
    gbeStruct4k.lanPowerConsumption.lanD0Power = 0x0d;

    /* Words 11h and 12h (Reserved) */
    gbeStruct4k.reservedWords11h12h[0] = 0x0000;
    gbeStruct4k.reservedWords11h12h[1] = 0x0000;

    /* Word 13h (Shared Initialization Control Word) */
    gbeStruct4k.sharedInitializationControlWord.reserved1 = 0x5;
    gbeStruct4k.sharedInitializationControlWord.forceDuplex = 0x0;
    gbeStruct4k.sharedInitializationControlWord.forceSpeedEnable = 0x0;
    gbeStruct4k.sharedInitializationControlWord.reserved2_0 = 0x0;
    gbeStruct4k.sharedInitializationControlWord.reserved2_1 = 0x0;
    gbeStruct4k.sharedInitializationControlWord.phyPowerDownEnable = 0x1;
    gbeStruct4k.sharedInitializationControlWord.reserved3 = 0x1;
    gbeStruct4k.sharedInitializationControlWord.reserved4 = 0x0;
    gbeStruct4k.sharedInitializationControlWord.sign = 0x2;

    /* Word 14h (Extended Configuration Control Word 1) */
    gbeStruct4k.extendedConfigurationControlWord1.extendedConfigurationPointer = 0x020;
    gbeStruct4k.extendedConfigurationControlWord1.oemWriteEnable = 0x1;
    gbeStruct4k.extendedConfigurationControlWord1.reserved1 = 0x1;
    gbeStruct4k.extendedConfigurationControlWord1.reserved2 = 0x0;
    gbeStruct4k.extendedConfigurationControlWord1.reserved3 = 0x0;

    /* Word 15h (Extended Configuration Control Word 2) */
    gbeStruct4k.extendedConfigurationControlWord2.reserved = 0x00;
    gbeStruct4k.extendedConfigurationControlWord2.extendedPhyLength = 0x0a;

    /* Word 16h (Extended Configuration Control Word 3) */
    gbeStruct4k.extendedConfigurationControlWord3 = 0x0000;

    /* Word 17h (LED 1 Configuration and Power Management) */
    gbeStruct4k.ledCtl1.led1Mode = 0xb;
    gbeStruct4k.ledCtl1.reserved1 = 0x0;
    gbeStruct4k.ledCtl1.led1BlinkMode = 0x0;
    gbeStruct4k.ledCtl1.led1Invert = 0x0;
    gbeStruct4k.ledCtl1.led1Blink = 0x1;
    gbeStruct4k.ledCtl1.reserved2 = 0x1;
    gbeStruct4k.ledCtl1.lpluEnable = 0x0;
    gbeStruct4k.ledCtl1.lpluEnableNonD0a = 0x1;
    gbeStruct4k.ledCtl1.gbeDisableNonD0a = 0x1;
    gbeStruct4k.ledCtl1.reserved3 = 0x0;
    gbeStruct4k.ledCtl1.gbeDisable = 0x0;
    gbeStruct4k.ledCtl1.reserved4 = 0x1;

    /* Word 18h (LED 0 and 2 Configuration Defaults) */
    gbeStruct4k.ledCtl02.led0Mode = 0x2;
    gbeStruct4k.ledCtl02.reserved1 = 0x0;
    gbeStruct4k.ledCtl02.led0BlinkMode = 0x0;
    gbeStruct4k.ledCtl02.led0Invert = 0x0;
    gbeStruct4k.ledCtl02.led0Blink = 0x0;
    gbeStruct4k.ledCtl02.led2Mode = 0x6;
    gbeStruct4k.ledCtl02.reserved2 = 0x0;
    gbeStruct4k.ledCtl02.led2BlinkMode = 0x0;
    gbeStruct4k.ledCtl02.led2Invert = 0x0;
    gbeStruct4k.ledCtl02.led2Blink = 0x0;

    /* Word 19h (Reserved) */
    gbeStruct4k.reservedWord19h = 0x2b40;

    /* Word 1Ah (Reserved) */
    gbeStruct4k.reservedWord1Ah = 0x0043;

    /* Word 1Bh (Reserved) */
    gbeStruct4k.reservedWord1Bh = 0x0000;

    /* Word 1Ch (Reserved) */
    gbeStruct4k.reservedWord1Ch = 0x10f5;

    /* Word 1Dh (Reserved) */
    gbeStruct4k.reservedWord1Dh = 0xbaad;

    /* Word 1Eh (Device ID for Intel 82567LM gigabit ethernet controller) */
    gbeStruct4k._82567lmDeviceId = 0x10f5;

    /* Word 1Fh (Device ID for Intel 82567LF gigabit ethernet controller) */
    gbeStruct4k._82567lfDeviceId = 0x10bf;

    /* Word 20h (Reserved) */
    gbeStruct4k.reservedWord20h = 0xbaad;

    /* Word 21h (Device ID for Intel 82567V gigabit ethernet controller) */
    gbeStruct4k._82567vDeviceId = 0x10cb;

    /* Word 22h (Reserved) */
    gbeStruct4k.reservedWord22h = 0xbaad;

    /* Word 23h (Reserved) */
    gbeStruct4k.reservedWord23h = 0xbaad;

    /* Words 24h to 2Fh (Reserved) */
    gbeStruct4k.reservedWords24to2Fh[0] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[1] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[2] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[3] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[4] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[5] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[6] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[7] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[8] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[9] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[10] = 0x0000;
    gbeStruct4k.reservedWords24to2Fh[11] = 0x0000;

    /* Words 30h to 3Eh (PXE Software Region) */
    /* Boot Agent Main Setup Options (Word 30h) */
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.protocolSelect = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved1 = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.defaultBootSelection = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved2 = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.promptTime = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.displaySetupMessage = 0x1;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved3 = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.forceSpeed = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.forceFullDuplex = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.reserved4 = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.efiPresence = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentMainSetupOptions.pxePresence = 0x0;
    /* Boot Agent Configuration Customization Options (Word 31h) */
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableSetupMenu = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableTitleMessage = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableProtocolSelect = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableBootSelection = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableLegacyWakeupSupport = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.disableFlashUpdate = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.reserved1 = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.ibaBootOrderSetupMode = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.reserved2 = 0x0;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions31h.signature = 0x1;
    /* Boot Agent Configuration Customization Options (Word 32h) */
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions32h.buildNumber = 0x18;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions32h.minorVersionNumber = 0x3;
    gbeStruct4k.pxeSoftwareRegion.bootAgentConfigurationCustomizationOptions32h.majorVersionNumber = 0x1;
    /* IBA Capabilities (Word 33h) */
    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.baseCodePresent = 0x1;
    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.undiCapabilityPresent = 0x1;
    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.reserved1 = 0x1;
    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.efiUndiCapabilityPresent = 0x0;
    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.reserved2_0 = 0x0;
    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.reserved2_1 = 0x00;
    gbeStruct4k.pxeSoftwareRegion.ibaCapabilities.signature = 0x1;
    /* Padding (Words 34h to 3Eh) */
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[0] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[1] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[2] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[3] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[4] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[5] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[6] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[7] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[8] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[9] = 0xffff;
    gbeStruct4k.pxeSoftwareRegion.paddingWords34hTo3Eh[10] = 0xffff;

    /* Word 3Fh (Checksum) */
    gbeStruct4k.checkSum = 0x348a;

    /* The rest of Gbe (word 40h or byte 80h onwards) is just padding (0xFF) */
    for (i = 0; i < 3968; i++) {
        gbeStruct4k.padding[i] = 0xFF;
    }

    return gbeStruct4k;
}

struct GBEREGIONRECORD_8K generatedGbeStruct8k()
{
    struct GBEREGIONRECORD_8K gbeStruct8k;
    gbeStruct8k.main = generatedGbeStruct4k();
    memcpy(&gbeStruct8k.backup, &gbeStruct8k.main, GBEREGIONSIZE_4K);
    return gbeStruct8k;
}

