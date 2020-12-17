---
title: ASUS KCMA-D8 desktop/workstation board 
...

This is a desktop board using AMD hardware (Fam10h *and Fam15h* CPUs
available). It can also be used for building a high-powered workstation.
Powered by libreboot. The coreboot port was done by Timothy Pearson of
Raptor Engineering Inc. and, working with them, merged into libreboot.

Note that not all boards are compatible. See [board status](#boardstatus)
below to determine compatibility with your board.

Flashing instructions can be found at
[../install/\#flashrom](../install/#flashrom) - note that external
flashing is required (e.g. BBB), if the proprietary (ASUS) firmware is
currently installed. If you already have libreboot, by default it is
possible to re-flash using software running in GNU+Linux on the kcma-d8,
without using external hardware.

CPU compatibility
=================

- Opteron 4100 series: Incompatible
- Opteron 4200 series: Compatible, does not require microcode updates
- Opteron 4300 series: Compatible, requires microcode updates (nonfree!)

Board status (compatibility) {#boardstatus}
============================

There are two ways to identify a supported KCMA-D8 board:

1. Serial number (sticker attached to the 24-pin ATX power connector)
2. BIOS version (sticker next to CPU slot 1, last four digits)

Supported boards begin with a serial number of **B9S2xxxxxxxx** or above where
the first character refers to the year of manufacture (A = 2010, B = 2011, etc.)
and the following character the month in hexadecimal (1...9, A, B, C). Thus, any
board produced September 2011 *or later* are compatible with Libreboot. Boards
originally shipped with BIOS version **2001** or higher are also compatible.

For help locating these identifying markers, see [ASUS documentation for determining Opteron 4200 series compatibility](https://web.archive.org/web/20200710022605/https://dlcdnets.asus.com/pub/ASUS/mb/SocketC%281027%29/KCMA-D8/Manual&QVL/How_to_identify_MB_supporting_Opteron_4200_CPU.pdf)

For more detailed information regarding the coreboot port, see
<https://raptorengineeringinc.com/coreboot/kcma-d8-status.php>

Form factor {#formfactor}
===========

This board is ATX form factor. While the [ATX standard, version 2.2](https://web.archive.org/web/20120725150314/http://www.formfactors.org/developer/specs/atx2_2.pdf)
specifies board dimensions 305mm x 244mm, this board measures 305mm x 253mm;
ensure your case supports this extra ~cm in width.

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

-   Opteron 4100 series CPUs are currently incompatible
-   LRDIMM memory modules are currently incompatible
-   Memory initialization is still problematic for some modules. We
    recommend avoiding Kingston and Super Talent modules for this reason.
-   Booting from USB mass storage devices is currently broken under GRUB.
    Consequently, the textmode ROM with SeaBIOS is recommended otherwise
    in order to install an operating system you will need a hard disk with
    a pre-installed OS or will have to plug in another HDD or CD/DVD
    reader in order to boot OS installation media.
-   SeaBIOS lacked serial console support out-of-the-box in release 20160907
    and as such a workaround using SGABIOS is necessary. You can find
    instructions on how to do this on the
    [Notabug issue tracker](https://notabug.org/libreboot/libreboot/issues/736)
-   SAS (via PIKE 2008 module) requires non-free option ROM (and
    SeaBIOS) to boot from it (theoretically possible to replace, but you
    can put a kernel in CBFS or on SATA and use that to boot GNU, which
    can be on a SAS drive. The linux kernel can use those SAS drives
    (via PIKE module) without an option ROM).
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

Check the ASUS website.

Copyright © 2016 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
