---
title: ASUS KFSN4-DRE server/workstation board 
...

This is a server board using AMD hardware (Fam10h). It can also be used
for building a high-powered workstation. Powered by libreboot.

Flashing instructions can be found at
[../install/\#flashrom](../install/#flashrom)

Form factor {#formfactor}
===========

These boards use the SSI EEB 3.61 form factor; make sure that your case
supports this. This form factor is similar to E-ATX in that the size is
identical, but the position of the screws are different.

Flash chips {#flashchips}
===========

These boards use LPC flash (not SPI), in a PLCC socket. The default
flash size 1MiB (8Mbits), and can be upgraded to 2MiB (16Mbits).
SST49LF080A is the default that the board uses. SST49LF016C is an
example of a 2MiB (16Mbits) chip, which might work. It is believed that
2MiB (16Mbits) is the maximum size available for the flash chip.

*DO NOT hot-swap the chip with your bare hands. Use a PLCC chip
extractor. These can be found online. See
<http://www.coreboot.org/Developer_Manual/Tools#Chip_removal_tools>*

Native graphics initialization {#graphics}
==============================

Native graphics initialization exists (XGI Z9s) for this board.
Framebuffer- and text-mode both work. A serial port is also available.

Memory
======

DDR2 533/667 Registered ECC. 16 slots. Total capacity up to 64GiB.

Hex-core CPUs {#hexcore}
=============

PCB revision 1.05G is the latest version of this board and the best one
(the revision number is be printed on the board), if you want to use
dual hex-core CPUs (Opteron 2400/8400 series), though only two board
configurations are believed to support them. Other revisions are
believed to only support dual quad-core CPUs.

To be sure your board supports a CPU check the official ASUS website here:
<https://www.asus.com/support/cpu_support>. Note: not all CPUs are listed.

If you are running a Hex-Core CPU on any board version, please contact us.

Board configurations {#configurations}
==============
There are 7 different configurations of this board: "standard", 2S, iKVM,
iKVM/IST, SAS, SAS/iKVM and SAS/iKVM/IST.

The 2S boards have two PCI-E slots with the numbers of lanes shared,
making each slot have 8 lanes.

The iKVM boards are so called because they offer a remote real-time access
to the machine through a removable PCI management card, their hardware is
the same as the non-iKVM ones.

The SAS versions have a 4-port SAS controller and a four 7-pin SAS connectors
instead of the PCI-E 8x slot which is present in all the other board configurations.
Note: the SAS functionality is **not supported** by libreboot.

The IST versions with PCB revision 1.05G are the ones who are believed to
support the six core Opteron Istanbul processors (2400 and 8400 series).

Current issues {#issues}
==============

-   There seems to be a 30 second bootblock delay (observed by
    tpearson); the system otherwise boots and works as expected. See
    [text/kfsn4-dre/bootlog.txt](text/kfsn4-dre/bootlog.txt) - this uses
    the 'simple' bootblock, while tpearson uses the 'normal'
    bootblock, which tpearson suspects may be a possible cause. This
    person says that they will look into it. [This
    config](http://review.coreboot.org/gitweb?p=board-status.git;a=blob;f=asus/kfsn4-dre/4.0-10101-g039edeb/2015-06-27T03:59:16Z/config.txt;h=4742905c185a93fbda8eb14322dd82c70641aef0;hb=055f5df4e000a97453dfad6c91c2d06ea22b8545)
    doesn't have the issue.

-   Text-mode is jittery and it may not be usable, so it's recommended
    to flash the BIOS with the coreboot frame-buffer image (kfsn4-dre_vesafb.rom).
    The jitter disappears if using KMS once the kernel starts, but it will 
    remain, if booting the kernel in text-mode.

-   Booting from USB mass storage devices is not possible; neither GRUB
    nor SeaBIOS detect USB drives when present. USB keyboards function
    under both GRUB and SeaBIOS, albeit slowly under GRUB (several seconds per
    character typed).

-   To install an operating system you will need a hard disk
    with a pre-installed OS otherwise you have to plug in another hard disk or
    a CD/DVD reader in order to boot a copy of the installer of your OS, since
    the USB booting doesn't work.

Other information
=================

[specifications](https://web.archive.org/web/20181212180051/http://ftp.tekwind.co.jp/pub/asustw/mb/Socket%20F/KFSN4-DRE/Manual/e3335_kfsn4-dre.pdf)

Copyright © 2015 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
