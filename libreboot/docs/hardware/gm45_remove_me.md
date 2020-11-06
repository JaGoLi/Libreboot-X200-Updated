---
title: "GM45 chipsets: remove the ME (manageability engine)"
...

This sections relates to disabling and removing the ME (Intel
*M*anagement *E*ngine) on GM45. This was originally done on the
ThinkPad X200, and later adapted for the ThinkPad R400/T400/T500. It can
in principle be done on any GM45 or GS45 system.

The ME is a blob that typically must be left inside the flash chip (in
the ME region, as outlined by the default descriptor). On GM45, it is
possible to remove it without any ill effects. All other parts of
coreboot on GM45 systems (provided GMA MHD4500 / Intel graphics) can be
blob-free, so removing the ME was the last obstacle to make GM45 a
feasible target in libreboot (the systems can also work without the
microcode blobs).

The ME is removed and disabled in libreboot by modifying the descriptor.
More info about this can be found in the ich9deblob/ich9gen source code
in resources/utilities/ich9deblob/ in libreboot, or more generally on
this page.

More information about the ME can be found at
<http://www.coreboot.org/Intel_Management_Engine> and
<http://me.bios.io/Main_Page>.

Another project recently found: <http://io.netgarage.org/me/>

ICH9 gen utility {#ich9gen}
================

It is no longer necessary to use [ich9deblob](#ich9deblob) to generate a
deblobbed descriptor+gbe image for GM45 targets. ich9gen is a small
utility within ich9deblob that can generate them from scratch, without a
factory.bin dump.

ich9gen executables can be found under ./ich9deblob/ statically compiled
in libreboot\_util. If you are using src or git, build ich9gen from
source with:

    $ ./oldbuild module ich9deblob

The executable will appear under resources/utilities/ich9deblob/

Run:

    $ ./ich9gen

Running ich9gen this way (without any arguments) generates a default
descriptor+gbe image with a generic MAC address. You probably don't
want to use the generic one; the ROM images in libreboot contain a
descriptor+gbe image by default (already inserted) just to prevent or
mitigate the risk of bricking your laptop, but with the generic MAC
address (the libreboot project does not know what your real MAC address
is).

You can find out your MAC address from `ip addr` or `ifconfig` in
GNU+Linux. Alternatively, if you are running libreboot already (with the
correct MAC address in your ROM), dump it (flashrom -r) and read the
first 6 bytes from position 0x1000 (or 0x2000) in a hex editor (or,
rename it to factory.rom and run it in ich9deblob: in the newly created
mkgbe.c will be the individual bytes of your MAC address). If you are
currently running the stock firmware and haven't installed libreboot
yet, you can also run that through ich9deblob to get the mac address.

An even simpler way to get the MAC address would be to read what's on
the little sticker on the bottom/base of the laptop.

On GM45 laptops that use flash descriptors, the MAC address or the
onboard ethernet chipset is flashed (inside the ROM image). You should
generate a descriptor+gbe image with your own MAC address inside (with
the Gbe checksum updated to match). Run:

    $ ./ich9gen --macaddress XX:XX:XX:XX:XX:XX

(replace the XX chars with the hexadecimal chars in the MAC address that
you want)

Two new files will be created:

-   `ich9fdgbe_4m.bin`: this is for GM45 laptops with the 4MB flash
    chip.
-   `ich9fdgbe_8m.bin`: this is for GM45 laptops with the 8MB flash
    chip.
-   `ich9fdgbe_16m.bin`: this is for GM45 laptops with the 16MB flash
    chip.

Assuming that your libreboot image is named **libreboot.rom**, copy the
file to where **libreboot.rom** is located and then insert the
descriptor+gbe file into the ROM image.\
For 16MiB flash chips:

    # dd if=ich9fdgbe_16m.bin of=libreboot.rom bs=12k count=1 conv=notrunc

For 8MiB flash chips:

    # dd if=ich9fdgbe_8m.bin of=libreboot.rom bs=12k count=1 conv=notrunc

For 4MiB flash chips:

    # dd if=ich9fdgbe_4m.bin of=libreboot.rom bs=12k count=1 conv=notrunc

Your libreboot.rom image is now ready to be flashed on the system. Refer
back to [../install/\#flashrom](../install/#flashrom) for how to flash
it.

Write-protecting the flash chip
-------------------------------

Look in *resources/utilities/ich9deblob/src/descriptor/descriptor.c* for
the following lines in the *descriptorHostRegionsUnlocked* function:

    descriptorStruct.masterAccessSection.flMstr1.fdRegionWriteAccess = 0x1;
    descriptorStruct.masterAccessSection.flMstr1.biosRegionWriteAccess = 0x1;
    descriptorStruct.masterAccessSection.flMstr1.meRegionWriteAccess = 0x1;
    descriptorStruct.masterAccessSection.flMstr1.gbeRegionWriteAccess = 0x1;
    descriptorStruct.masterAccessSection.flMstr1.pdRegionWriteAccess = 0x1;

Also look in *resources/utilities/ich9deblob/src/ich9gen/mkdescriptor.c*
for the following lines:

    descriptorStruct.masterAccessSection.flMstr1.fdRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.biosRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.meRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.gbeRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */
    descriptorStruct.masterAccessSection.flMstr1.pdRegionWriteAccess = 0x1; /* see ../descriptor/descriptor.c */

NOTE: When you write-protect the flash chip, re-flashing is no longer
possible unless you use dedicated external equipment, which also means
disassembling the laptop. The same equipment can also be used to remove
the write-protection later on, if you choose to do so. \*Only\*
write-protect the chip if you have the right equipment for external
flashing later on; for example, see
[../install/bbb\_setup.md](../install/bbb_setup.md).

Change them all to 0x0, then re-compile ich9gen. After you have done
that, follow the notes in [\#ich9gen](#ich9gen) to generate a new
descriptor+gbe image and insert that into your ROM image, then flash it.
The next time you boot, the flash chip will be read-only in software
(hardware re-flashing will still work, which you will need for
re-flashing the chip after write-protecting it, to clear the write
protection or to flash yet another ROM image with write protection set
in the descriptor).

Flashrom will tell you that you can still forcefully re-flash, using *-p
internal:ich\_spi\_force=yes* but this won't actually work; it'll just
brick your laptop.

For external flashing guides, refer to [../install/](../install/).

ICH9 deblob utility {#ich9deblob}
===================

**This is no longer strictly necessary. Libreboot ROM images for GM45
systems now contain the 12KiB descriptor+gbe generated from ich9gen, by
default.**

This was the tool originally used to disable the ME on X200 (later
adapted for other systems that use the GM45 chipset).
[ich9gen](#ich9gen) now supersedes it; ich9gen is better because it does
not rely on dumping the factory.rom image (whereas, ich9deblob does).

This is what you will use to generate the deblobbed descriptor+gbe
regions for your libreboot ROM image.

If you are working with libreboot\_src (or git), you can find the source
under resources/utilities/ich9deblob/ and will already be compiled if
you ran **./oldbuild module all** or **./oldbuild module ich9deblob**
from the main directory (./), otherwise you can build it like so:

    $ ./oldbuild module ich9deblob

An executable file named **ich9deblob** will now appear under
resources/utilities/ich9deblob/

If you are working with libreboot\_util release archive, you can find
the utility included, statically compiled (for i686 and x86\_64 on
GNU+Linux) under ./ich9deblob/.

Place the factory.rom from your system (can be obtained using the
external flashing guides for GM45 targets linked
[../install/](../install/)) in the directory where you have your
ich9deblob executable, then run the tool:

    $ ./ich9deblob

A 12kiB file named **deblobbed\_descriptor.bin** will now appear. **Keep
this and the factory.rom stored in a safe location!** The first 4KiB
contains the descriptor data region for your system, and the next 8KiB
contains the gbe region (config data for your gigabit NIC). These 2
regions could actually be separate files, but they are joined into 1
file in this case.

A 4KiB file named **deblobbed\_4kdescriptor.bin** will alternatively
appear, if no GbE region was detected inside the ROM image. This is
usually the case, when a discrete NIC is used (eg Broadcom) instead of
Intel. Only the Intel NICs need a GbE region in the flash chip.

Assuming that your libreboot image is named **libreboot.rom**, copy the
**deblobbed\_descriptor.bin** file to where **libreboot.rom** is located
and then run:

    # dd if=deblobbed_descriptor.bin of=libreboot.rom bs=12k count=1 conv=notrunc

Alternatively, if you got a the **deblobbed\_4kdescriptor.bin** file (no
GbE defined), do this:

    # dd if=deblobbed_4kdescriptor.bin of=libreboot.rom bs=4k count=1 conv=notrunc

The utility will also generate 4 additional files:

-   mkdescriptor.c
-   mkdescriptor.h
-   mkgbe.c
-   mkgbe.h

These are C source files that can re-generate the very same Gbe and
Descriptor structs (from ich9deblob/ich9gen). To use these, place them
in src/ich9gen/ in ich9deblob, then re-build. The newly built
**ich9gen** executable will be able to re-create the very same 12KiB
file from scratch, based on the C structs, this time **without** the
need for a factory.rom dump!

You should now have a **libreboot.rom** image containing the correct 4K
descriptor and 8K gbe regions, which will then be safe to flash. Refer
back to [../install/\#flashrom](../install/#flashrom) for how to flash
it.

demefactory utility {#demefactory}
===================

This takes a factory.rom dump and disables the ME/TPM, but leaves the
region intact. It also sets all regions read-write.

The ME interferes with flash read/write in flashrom, and the default
descriptor locks some regions. The idea is that doing this will remove
all of those restrictions.

Simply run (with factory.rom in the same directory):

    $ ./demefactory

It will generate a 4KiB descriptor file (only the descriptor, no GbE).
Insert that into a factory.rom image (NOTE: do this on a copy of it.
Keep the original factory.rom stored safely somewhere):

    # dd if=demefactory_4kdescriptor.bin of=factory_nome.rom bs=4k count=1 conv=notrunc

TODO: test this.\
TODO: lenovobios (GM45 thinkpads) still write-protects parts of the
flash. Modify the assembly code inside. Note: the factory.rom (BIOS
region) from lenovobios is in a compressed format, which you have to
extract. bios\_extract upstream won't work, but the following was said
in \#coreboot on freenode IRC:

    <roxfan> vimuser: try bios_extract with ffv patch http://patchwork.coreboot.org/patch/3444/
    <roxfan> or https://github.com/coreboot/bios_extract/blob/master/phoenix_extract.py
    <roxfan> what are you looking for specifically, btw?

    0x74: 0x9fff03e0 PR0: Warning: 0x003e0000-0x01ffffff is read-only.
    0x84: 0x81ff81f8 PR4: Warning: 0x001f8000-0x001fffff is locked.

Use-case: a factory.rom image modified in this way would theoretically
have no flash protections whatsoever, making it easy to quickly switch
between factory/libreboot in software, without ever having to
disassemble and re-flash externally unless you brick the device.

demefactory is part of the ich9deblob src, found at
*resources/utilities/ich9deblob/*

The sections below are adapted from (mostly) IRC logs related to early
development getting the ME removed on GM45. They are useful for
background information. This could not have been done without sgsit's
help.

Early notes {#early_notes}
-----------

-   <http://www.intel.co.uk/content/dam/doc/datasheet/io-controller-hub-10-family-datasheet.pdf>
    page 230 mentions about descriptor and non-descriptor mode (which
    wipes out gbe and ME/AMT).
-   ~~**See reference to HDA\_SDO (disable descriptor security)**~~
    strap connected GPIO33 pin is it on ICH9-M (X200). HDA\_SDO applies
    to later chipsets (series 6 or higher). Disabling descriptor
    security also disables the ethernet according to sgsit. sgsit's
    method involves use of 'soft straps' (see IRC logs below) instead
    of disabling the descriptor.
-   **and the location of GPIO33 on the x200s: (was an external link.
    Putting it here instead)**
    [images/x200/gpio33\_location.jpg](images/x200/gpio33_location.jpg) -
    it's above the number 7 on TP37 (which is above the big intel chip
    at the bottom)
-   The ME datasheet may not be for the mobile chipsets but it doesn't
    vary that much. This one gives some detail and covers QM67 which is
    what the X201 uses:
    <http://www.intel.co.uk/content/dam/www/public/us/en/documents/datasheets/6-chipset-c200-chipset-datasheet.pdf>

Flash chips {#flashchips}
-----------
-   X200 laptop (Mocha-1):
    ICH9-M overrides ifd permissions with a strap connected to GPIO33 pin (see IRC notes below)

    - The X200 can be found with any of the following flash
    chips:
        -   ATMEL AT26DF321-SU 72.26321.A01 - this is a 32Mb (4MiB) chip
        -   MXIC (Macronix?) MX25L3205DM2I-12G 72.25325.A01 - another 32Mb
            (4MiB) chip
        -   MXIC (Macronix?) MX25L6405DMI-12G 41R0820AA - this is a 64Mb
            (8MiB) chip
        -   Winbond W25X64VSFIG 41R0820BA - another 64Mb (8MiB) chip

    sgsit says that the X200s (Pecan-1) with the 64Mb flash chips are (probably)
    the ones with AMT (alongside the ME), whereas the 32Mb chips contain
    only the ME.

Early development notes {#early_development_notes}
-----------------------

    Start (hex) End (hex)   Length (hex)    Area Name
    ----------- ---------   ------------    ---------
    00000000    003FFFFF    00400000    Flash Image

    00000000    00000FFF    00001000    Descriptor Region
    00000004    0000000F    0000000C        Descriptor Map
    00000010    0000001B    0000000C        Component Section
    00000040    0000004F    00000010        Region Section
    00000060    0000006B    0000000C        Master Access Section
    00000060    00000063    00000004            CPU/BIOS
    00000064    00000067    00000004            Manageability Engine (ME)
    00000068    0000006B    00000004            GbE LAN
    00000100    00000103    00000004        ICH Strap 0
    00000104    00000107    00000004        ICH Strap 1
    00000200    00000203    00000004        MCH Strap 0
    00000EFC    00000EFF    00000004        Descriptor Map 2
    00000ED0    00000EF7    00000028        ME VSCC Table
    00000ED0    00000ED7    00000008            Flash device 1
    00000ED8    00000EDF    00000008            Flash device 2
    00000EE0    00000EE7    00000008            Flash device 3
    00000EE8    00000EEF    00000008            Flash device 4
    00000EF0    00000EF7    00000008            Flash device 5
    00000F00    00000FFF    00000100        OEM Section
    00001000    001F5FFF    001F5000    ME Region
    001F6000    001F7FFF    00002000    GbE Region
    001F8000    001FFFFF    00008000    PDR Region
    00200000    003FFFFF    00200000    BIOS Region

    Start (hex) End (hex)   Length (hex)    Area Name
    ----------- ---------   ------------    ---------
    00000000    003FFFFF    00400000    Flash Image

    00000000    00000FFF    00001000    Descriptor Region
    00000004    0000000F    0000000C        Descriptor Map
    00000010    0000001B    0000000C        Component Section
    00000040    0000004F    00000010        Region Section
    00000060    0000006B    0000000C        Master Access Section
    00000060    00000063    00000004            CPU/BIOS
    00000064    00000067    00000004            Manageability Engine (ME)
    00000068    0000006B    00000004            GbE LAN
    00000100    00000103    00000004        ICH Strap 0
    00000104    00000107    00000004        ICH Strap 1
    00000200    00000203    00000004        MCH Strap 0
    00000ED0    00000EF7    00000028        ME VSCC Table
    00000ED0    00000ED7    00000008            Flash device 1
    00000ED8    00000EDF    00000008            Flash device 2
    00000EE0    00000EE7    00000008            Flash device 3
    00000EE8    00000EEF    00000008            Flash device 4
    00000EF0    00000EF7    00000008            Flash device 5
    00000EFC    00000EFF    00000004        Descriptor Map 2
    00000F00    00000FFF    00000100        OEM Section
    00001000    00002FFF    00002000    GbE Region
    00003000    00202FFF    00200000    BIOS Region

    Build Settings
    --------------
    Flash Erase Size = 0x1000

It's a utility called 'Flash Image Tool' for ME 4.x that was used for
this. You drag a complete image into in and the utility decomposes the
various components, allowing you to set soft straps.

This tool is proprietary, for Windows only, but was used to deblob the
X200. End justified means, and the utility is no longer needed since the
ich9deblob utility (documented on this page) can now be used to create
deblobbed descriptors.

GBE (gigabit ethernet) region in SPI flash {#gbe_region}
------------------------------------------

Of the 8K, about 95% is 0xFF. The data is the gbe region is fully
documented in this public datasheet:
<http://www.intel.co.uk/content/dam/doc/application-note/i-o-controller-hub-9m-82567lf-lm-v-nvm-map-appl-note.pdf>

The only actual content found was:

    00  1F  1F  1F  1F  1F  00  08  FF  FF  83  10  FF  FF  FF  FF  
    08  10  FF  FF  C3  10  EE  20  AA  17  F5  10  86  80  00  00  
    01  0D  00  00  00  00  05  06  20  30  00  0A  00  00  8B  8D  
    02  06  40  2B  43  00  00  00  F5  10  AD  BA  F5  10  BF  10  
    AD  BA  CB  10  AD  BA  AD  BA  00  00  00  00  00  00  00  00  
    00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  
    00  01  00  40  28  12  07  40  FF  FF  FF  FF  FF  FF  FF  FF  
    FF  FF  FF  FF  FF  FF  FF  FF  FF  FF  FF  FF  FF  FF  D9  F0  
    20  60  1F  00  02  00  13  00  00  80  1D  00  FF  00  16  00  
    DD  CC  18  00  11  20  17  00  DD  DD  18  00  12  20  17  00  
    00  80  1D  00  00  00  1F  

The first part is the MAC address set to all 0x1F. It's repeated haly
way through the 8K area, and the rest is all 0xFF. This is all
documented in the datasheet.

The GBe region starts at 0x20A000 bytes from the \*end\* of a factory
image and is 0x2000 bytes long. In libreboot (deblobbed) the descriptor
is set to put gbe directly after the initial 4K flash descriptor. So the
first 4K of the ROM is the descriptor, and then the next 8K is the gbe
region.

### GBE region: change MAC address {#gbe_region_changemacaddress}

According to the datasheet, it's supposed to add up to 0xBABA but can
actually be others on the X200.
<https://web.archive.org/web/20150912070329/https://communities.intel.com/community/wired/blog/2010/10/14/how-to-basic-eeprom-checksums>

*"One of those engineers loves classic rock music, so they selected
0xBABA"*

In honour of the song *Baba O'Reilly* by *The Who* apparently. We're
not making this stuff up...

0x3ABA, 0x34BA, 0x40BA and more have been observed in the main Gbe
regions on the X200 factory.rom dumps. The checksums of the backup
regions match BABA, however.

By default, the X200 (as shipped by Lenovo) actually has an invalid main
gbe checksum. The backup gbe region is correct, and is what these
systems default to. Basically, you should do what you need on the
\*backup\* gbe region, and then correct the main one by copying from the
backup.

Look at resources/utilities/ich9deblob/ich9deblob.c.

-   Add the first 0x3F 16bit numbers (unsigned) of the GBe descriptor
    together (this includes the checksum value) and that has to add up
    to 0xBABA. In other words, the checksum is 0xBABA minus the total of
    the first 0x3E 16bit numbers (unsigned), ignoring any overflow.

Flash descriptor region {#flash_descriptor_region}
-----------------------

<http://www.intel.co.uk/content/dam/doc/datasheet/io-controller-hub-9-datasheet.pdf>
from page 850 onwards. This explains everything that is in the flash
descriptor, which can be used to understand what libreboot is doing
about modifying it.

How to deblob:

-   patch the number of regions present in the descriptor from 5 - 3
-   originally descriptor + bios + me + gbe + platform
-   modified = descriptor + bios + gbe
-   the next stage is to patch the part of the descriptor which defines
    the start and end point of each section
-   then cut out the gbe region and insert it just after the region
-   all this can be substantiated with public docs (ICH9 datasheet)
-   the final part is flipping 2 bits. Halting the ME via 1 MCH soft
    strap and 1 ICH soft strap
-   the part of the descriptor described there gives the base address
    and length of each region (bits 12:24 of each address)
-   to disable a region, you set the base address to 0xFFF and the
    length to 0
-   and you change the number of regions from 4 (zero based) to 2

There's an interesting parameter called 'ME Alternate disable', which
allows the ME to only handle hardware errata in the southbridge, but
disables any other functionality. This is similar to the 'ignition' in
the 5 series and higher but using the standard firmware instead of a
small 128K version. Useless for libreboot, though.

To deblob GM45, you chop out the platform and ME regions and correct the
addresses in flReg1-4. Then you set meDisable to 1 in ICHSTRAP0 and
MCHSTRAP0.

How to patch the descriptor from the factory.rom dump

-   map the first 4k into the struct (minus the gbe region)
-   set NR in FLMAP0 to 2 (from 4)
-   adjust BASE and LIMIT in flReg1,2,3,4 to reflect the new location of
    each region (or remove them in the case of Platform and ME)
-   set meDisable to 1/true in ICHSTRAP0 and MCHSTRAP0
-   extract the 8k GBe region and append that to the end of the 4k
    descriptor
-   output the 12k concatenated chunk
-   Then it can be dd'd into the first 12K part of a coreboot image.
-   the GBe region always starts 0x20A000 bytes from the end of the ROM

This means that libreboot's descriptor region will simply define the
following regions:

-   descriptor (4K)
-   gbe (8K)
-   bios (rest of flash chip. CBFS also set to occupy this whole size)

The data in the descriptor region is little endian, and it represents
bits 24:12 of the address (bits 12-24, written this way since bit 24 is
nearer to left than bit 12 in the binary representation).

So, *x << 12 = address*

If it's in descriptor mode, then the first 4 bytes will be 5A A5 F0 0F.

platform data partition in boot flash (factory.rom / lenovo bios) {#platform_data_region}
-----------------------------------------------------------------

Basically useless for libreboot, since it appears to be a blob. Removing
it didn't cause any issues in libreboot.

This is a 32K region from the factory image. It could be data
(non-functional) that the original Lenovo BIOS used, but we don't know.

It has only a 448 byte fragment different from 0x00 or 0xFF.

Copyright © 2014, 2015 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
