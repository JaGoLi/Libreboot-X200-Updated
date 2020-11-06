---
title: ASUS KGPE-D16 server/workstation board 
...

This is a server board using AMD hardware (Fam10h *and Fam15h* CPUs
available). It can also be used for building a high-powered workstation.
Powered by libreboot. The coreboot port was done by Timothy Pearson of
Raptor Engineering Inc. and, working with them (and sponsoring the
work), merged into libreboot.

*Memory initialization is still problematic, for some modules. We
recommend avoiding Kingston modules.*
*For working configurations see <https://www.coreboot.org/Board:asus/kgpe-d16>.*

Flashing instructions can be found at
[../install/\#flashrom](../install/#flashrom) - note that external
flashing is required (e.g. BBB), if the proprietary (ASUS) firmware is
currently installed. If you already have libreboot, by default it is
possible to re-flash using software running in GNU+Linux on the
KGPE-D16, without using external hardware.

CPU compatibility
=================

*Use Opteron 6200 series (works without microcode updates, including hw
virt).* 6300 series needs microcode updates, so avoid those CPUs. 6100
series is too old, and mostly untested.

Board status (compatibility) {#boardstatus}
============================

See <https://raptorengineeringinc.com/coreboot/kgpe-d16-status.php>.

Form factor {#formfactor}
===========

These boards use the SSI EEB 3.61 form factor; make sure that your case
supports this. This form factor is similar to E-ATX in that the size is
identical, but the position of the screws are different.

IPMI iKVM module add-on {#ipmi}
=======================

Don't use it. It uses proprietary firmware and adds a backdoor (remote
out-of-band management chip, similar to the [Intel Management
Engine](../../faq.md#intelme). Fortunately, the firmware is
unsigned (possibly to replace) and physically separate from the
mainboard since it's on the add-on module, which you don't have to
install.

Flash chips {#flashchips}
===========

2MiB flash chips are included by default, on these boards. It's on a
P-DIP 8 slot (SPI chip). The flash chip can be upgraded to higher sizes:
4MiB, 8MiB or 16MiB. With at least 8MiB, you could feasibly fit a
compressed linux+initramfs image (BusyBox+Linux system) into CBFS and
boot that, loading it into memory.

Libreboot has configs for 2, 4, 8 and 16 MiB flash chip sizes (default
flash chip is 2MiB).

*DO NOT hot-swap the chip with your bare hands. Use a P-DIP 8 chip
extractor. These can be found online. See
<http://www.coreboot.org/Developer_Manual/Tools#Chip_removal_tools>*

Native graphics initialization {#graphics}
==============================

Only text-mode is known to work, but linux(kernel) can initialize the
framebuffer display (if it has KMS - kernel mode setting).

Current issues {#issues}
==============

-   LRDIMM memory modules are currently incompatible
-   SAS (via PIKE 2008 module) requires non-free option ROM (and
    SeaBIOS) to boot from it (theoretically possible to replace, but you
    can put a kernel in CBFS or on SATA and use that to boot GNU, which
    can be on a SAS drive. The linux kernel can use those SAS drives
    (via PIKE module) without an option ROM).
-   SeaBIOS lacked serial console support out-of-the-box in release 20160907
    and as such a workaround using SGABIOS is necessary. You can find
    instructions on how to do this on the
    [Notabug issue tracker](https://notabug.org/libreboot/libreboot/issues/736)
-   IPMI iKVM module (optional add-on card) uses proprietary firmware.
    Since it's for remote out-of-band management, it's theoretically a
    backdoor similar to the Intel Management Engine. Fortunately, unlike
    the ME, this firmware is unsigned which means that a free
    replacement is theoretically possible. For now, the libreboot
    project recommends not installing the module. [This
    project](https://github.com/facebook/openbmc) might be interesting
    to derive from, for those who want to work on a free replacement. In
    practise, out-of-band management isn't very useful anyway (or at
    the very least, it's not a major inconvenience to not have it).
-   Graphics: only text-mode works. See [\#graphics](#graphics)

Hardware specifications {#specifications}
-----------------------

The information here is adapted, from the ASUS website.

### Processor / system bus

-   2 CPU sockets (G34 compatible)
-   HyperTransport™ Technology 3.0
-   CPUs supported:
    -   AMD Opteron 6100 series (Fam10h. No IOMMU support. *Not*
        recommended - old. View errata datasheet here:
        <http://support.amd.com/TechDocs/41322_10h_Rev_Gd.pdf>)
    -   AMD Opteron 6200 series (Fam15h, with full IOMMU support in
        libreboot - *highly recommended - fast, and works well without
        microcode updates, including virtualization*)
    -   AMD Opteron 6300 series (Fam15h, with full IOMMU support in
        libreboot. *AVOID LIKE THE PLAGUE - virtualization is broken
        without microcode updates.*
    -   NOTE: 6300 series CPUs have buggy microcode built-in, and
        libreboot recommends avoiding the updates. The 6200 series CPUs
        have more reliable microcode. Look at this errata datasheet:
        <http://support.amd.com/TechDocs/48063_15h_Mod_00h-0Fh_Rev_Guide.pdf>
        (see Errata 734 - this is what kills the 6300 series)
-   6.4 GT/s per link (triple link)

### Core logic

-   AMD SR5690
-   AMD SP5100

### Memory compatibility (with libreboot)

-   *Total Slots:* 16 (4-channel per CPU, 8 DIMM per CPU), ECC
-   *Capacity:* Maximum up to 256GB RDIMM (Tested max 128GB)
-   *Memory Type that is compatible:*
    -   DDR3 1600/1333/1066/800 UDIMM\*
    -   DDR3 1600/1333/1066/800 RDIMM\*
-   *Compatible sizes per memory module:*
    -   16GB, 8GB, 4GB, 3GB, 2GB, 1GB RDIMM
    -   8GB, 4GB, 2GB, 1GB UDIMM

### Expansion slots

-   *Total slot:* 6
-   *Slot Location 1:* PCI 32bit/33MHz
-   *Slot Location 2:* PCI-E x16 (Gen2 X8 Link)
-   *Slot Location 3:* PCI-E x16 (Gen2 X16 Link), Auto switch to x8
    link if slot 2 is occupied
-   *Slot Location 4:* PCI-E x8 (Gen2 X4 Link)
-   *Slot Location 5:* PCI-E x16 (Gen2 X16 Link)
-   *Slot Location 6:* PCI-E x16 (Gen2 X16 Link), Auto turn off if
    slot 5 is occupied, For 1U FH/FL Card, MIO supported
-   *Additional Slot 1:* PIKE slot (for SAS drives. See notes above)
-   Follow SSI Location\#

### Form factor {#form-factor}

-   SSI EEB 3.61 (12"x13")

### ASUS features

-   Fan Speed Control
-   Rack Ready (Rack and Pedestal dual use)

### Storage

-   *SATA controller:*
    -   AMD SP5100
    -   6 x SATA2 300MB/s
-   *SAS/SATA Controller:*
    -   ASUS PIKE2008 3Gbps 8-port SAS card included

### Networking

-   2 x Intel® 82574L + 1 x Mgmt LAN

### Graphics

-   Aspeed AST2050 with 8MB VRAM

### On board I/O

-   1 x PSU Power Connector (24-pin SSI power connector + 8-pin SSI
    12V + 8-pin SSI 12V power connector)
-   1 x Management Connector , Onboard socket for management card
-   3 x USB pin header , Up to 6 Devices
-   1 x Internal A Type USB Port
-   8 x Fan Header , 4pin (3pin/4pin fan dual support)
-   2 x SMBus
-   1 x Serial Port Header
-   1 x TPM header
-   1 x PS/2 KB/MS port

### Back I/O ports

-   1 x External Serial Port
-   2 x External USB Port
-   1 x VGA Port
-   2 x RJ-45
-   1 x PS/2 KB/Mouse

### Environment

-   *Operation temperature:* 10C \~ 35C
-   *Non operation temperature:* -40C \~ 70C
-   *Non operation humidity:* 20% \~ 90% ( Non condensing)

### Monitoring

-   CPU temperatures
-   Fan speed (RPM)

### Note:

-   \* DDR3 1600 can only be supported with AMD Opteron 6300/6200 series
    processor

Copyright © 2015 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
