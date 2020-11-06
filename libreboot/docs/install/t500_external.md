---
title: Flashing the T500 with a BeagleBone Black
...

Initial flashing instructions for T500.

This guide is for those who want libreboot on their ThinkPad T500 while
they still have the original Lenovo BIOS present. This guide can also be
followed (adapted) if you brick your T500, to know how to recover.

W500 is also mostly compatible with this guide.

Libreboot T400 {#t400}
==============

You may also be interested in the smaller, more portable [Libreboot
T400](t400_external.md).

Serial port {#serial_port}
-----------

EHCI debug might not be needed. It has been reported that the docking
station for this laptop has a serial port, so it might be possible to
use that instead.

A note about CPUs
=================

[ThinkWiki](http://www.thinkwiki.org/wiki/Category:T500) has a list of
CPUs for this system. The Core 2 Duo P8400, P8600 and P8700 are believed
to work in libreboot. The T9600 was also tested on the T400 and
confirmed working.

T9550 and T9900 was tested by a user, and is compatible as reported in the IRC channel.
T9500 and T9400 may also work, but YMMV.

Quad-core CPUs
--------------
Very likely to be compatible, but requires hardware modification.
Based on info from German forum post about installing Core Quad CPU on T500 found in coreboot mailing list. Currently work in progress and no guide available.

Q9100 is compatible and confirmed working (after hw mod), as reported by users in the IRC
channel

- [Coreboot mailing list post](https://mail.coreboot.org/pipermail/coreboot/2016-November/082463.html)
- [German forum post about install Core Quad on T500](https://thinkpad-forum.de/threads/199129)

A note about GPUs
=================

Some models have an Intel GPU, while others have both an ATI and an
Intel GPU; this is referred to as "switchable graphics". In the *BIOS
setup* program for lenovobios, you can specify that the system will use
one or the other (but not both).

Libreboot is known to work on systems with only the Intel GPU, using
native graphics initialization. On systems with switchable graphics, the
Intel GPU is used and the ATI GPU is disabled, so native graphics
initialization works all the same.

CPU paste required
==================

See [\#paste](#paste).

Flash chip size {#flashchips}
===============

Use this to find out:

    # flashrom -p internal

MAC address {#macaddress}
===========

Refer to [mac\_address.md](../hardware/mac_address.md).

Initial BBB configuration
=========================

Refer to [bbb\_setup.md](bbb_setup.md) for how to configure the BBB
for flashing.

The following shows how to connect clip to the BBB (on the P9 header),
for SOIC-16 (clip: Pomona 5252):

    POMONA 5252 (correlate with the BBB guide)
    ===  ethernet jack and VGA port ====
     NC              -       - 21
     1               -       - 17
     NC              -       - NC
     NC              -       - NC
     NC              -       - NC
     NC              -       - NC
     18              -       - 3.3V (PSU)
     22              -       - NC - this is pin 1 on the flash chip
    ===  SATA port ===
    This is how you will connect. Numbers refer to pin numbers on the BBB, on the plugs near the DC jack.

The following shows how to connect clip to the BBB (on the P9 header),
for SOIC-8 (clip: Pomona 5250):

    POMONA 5250 (correlate with the BBB guide)
    ===  RAM slots ====
     18              -       - 1
     22              -       - NC
     NC              -       - 21
     3.3V (PSU)      -       - 17 - this is pin 1 on the flash chip
    ===  slot where the AC jack is connected ===

    This is how you will connect. Numbers refer to pin numbers on the BBB, on the plugs near the DC jack.

The procedure
-------------

Remove all screws:\
![](images/t500/0000.jpg)\
It is also advisable to, throughout the disassembly, place any screws
and/or components that you removed in the same layout or arrangement.
The follow photos demonstrate this:\
![](images/t500/0001.jpg) ![](images/t500/0002.jpg)

Remove the HDD/SSD and optical drive:\
![](images/t500/0003.jpg) ![](images/t500/0004.jpg)

Remove the palm rest:\
![](images/t500/0005.jpg) ![](images/t500/0006.jpg)

Remove the keyboard and rear bezel:\
![](images/t500/0007.jpg) ![](images/t500/0008.jpg)
![](images/t500/0009.jpg) ![](images/t500/0010.jpg)
![](images/t500/0011.jpg) ![](images/t500/0012.jpg)

If you have a WWAN/3G card and/or sim card reader, remove them
permanently. The WWAN-3G card has proprietary firmware inside; the
technology is identical to what is used in mobile phones, so it can also
track your movements:\
![](images/t500/0013.jpg) ![](images/t500/0017.jpg)
![](images/t500/0018.jpg)

Remove this frame, and then remove the wifi chip:\
![](images/t500/0014.jpg) ![](images/t500/0015.jpg)
![](images/t500/0016.jpg)

Remove the speakers:\
![](images/t500/0019.jpg) ![](images/t500/0020.jpg)
![](images/t500/0021.jpg) ![](images/t500/0022.jpg)
![](images/t500/0023.jpg) ![](images/t500/0024.jpg)
![](images/t500/0025.jpg)

Remove the NVRAM battery (already removed in this photo):\
![](images/t500/0026.jpg)

When you re-assemble, you will be replacing the wifi chip with another.
These two screws don't hold anything together, but they are included in
your system because the screw holes for half-height cards are a
different size, so use these if you will be installing a half-height
card:\
![](images/t500/0027.jpg)

Unroute the antenna wires:\
![](images/t500/0028.jpg) ![](images/t500/0029.jpg)
![](images/t500/0030.jpg) ![](images/t500/0031.jpg)

Disconnect the LCD cable from the motherboard:\
![](images/t500/0032.jpg) ![](images/t500/0033.jpg)

Remove the LCD assembly hinge screws, and then remove the LCD assembly:\
![](images/t500/0034.jpg) ![](images/t500/0035.jpg)
![](images/t500/0036.jpg)

Remove the fan and heatsink:\
![](images/t500/0037.jpg) ![](images/t500/0038.jpg)
![](images/t500/0039.jpg)

Remove this screw:\
![](images/t500/0040.jpg)

Remove these cables, keeping note of how and in what arrangement they
are connected:\
![](images/t500/0041.jpg) ![](images/t500/0042.jpg)
![](images/t500/0043.jpg) ![](images/t500/0044.jpg)
![](images/t500/0045.jpg) ![](images/t500/0046.jpg)
![](images/t500/0047.jpg) ![](images/t500/0048.jpg)
![](images/t500/0049.jpg)

Disconnect the power jack:\
![](images/t500/0050.jpg) ![](images/t500/0051.jpg)

Remove the motherboard and cage from the base (the marked hole is where
those cables were routed through):\
![](images/t500/0052.jpg) ![](images/t500/0053.jpg)

Remove all screws, arranging them in the same layout when placing the
screws on a surface and marking each screw hole (this is to reduce the
possibility of putting them back in the wrong holes):\
![](images/t500/0054.jpg) ![](images/t500/0055.jpg)

Also remove this:\
![](images/t500/0056.jpg) ![](images/t500/0057.jpg)

Separate the motherboard from the cage:\
![](images/t500/0058.jpg) ![](images/t500/0059.jpg)

The flash chip is next to the memory slots. On this system, it was a
SOIC-8 (4MiB or 32Mb) flash chip:\
![](images/t500/0060.jpg)

Connect your programmer, then connect GND and 3.3V\
![](images/t500/0061.jpg)\
![](images/t400/0067.jpg) ![](images/t400/0069.jpg)
![](images/t400/0070.jpg) ![](images/t400/0071.jpg)

A dedicated 3.3V PSU was used to create this guide, but at ATX PSU is
also fine:\
![](images/t400/0072.jpg)

Of course, make sure to turn on your PSU:\
![](images/x200/disassembly/0013.jpg)

Now, you should be ready to install libreboot.

Flashrom binaries for ARM (tested on a BBB) are distributed in
libreboot\_util. Alternatively, libreboot also distributes flashrom
source code which can be built.

Log in as root on your BBB, using the instructions in
[bbb\_setup.html\#bbb\_access](bbb_setup.html#bbb_access).

Test that flashrom works:

    # ./flashrom -p linux_spi:dev=/dev/spidev1.0,spispeed=512

In this case, the output was:

    flashrom v0.9.7-r1854 on Linux 3.8.13-bone47 (armv7l)
    flashrom is free software, get the source code at http://www.flashrom.org
    Calibrating delay loop... OK.
    Found Macronix flash chip "MX25L6405(D)" (8192 kB, SPI) on linux_spi.
    Found Macronix flash chip "MX25L6406E/MX25L6436E" (8192 kB, SPI) on linux_spi.
    Found Macronix flash chip "MX25L6445E/MX25L6473E" (8192 kB, SPI) on linux_spi.
    Multiple flash chip definitions match the detected chip(s): "MX25L6405(D)", "MX25L6406E/MX25L6436E", "MX25L6445E/MX25L6473E"
    Please specify which chip definition to use with the -c <chipname> option.

How to backup factory.rom (change the -c option as neeed, for your flash
chip):

    # ./flashrom -p linux_spi:dev=/dev/spidev1.0,spispeed=512 -r factory.rom

    # ./flashrom -p linux_spi:dev=/dev/spidev1.0,spispeed=512 -r factory1.rom

    # ./flashrom -p linux_spi:dev=/dev/spidev1.0,spispeed=512 -r factory2.rom

Note: the `-c` option is not required in libreboot's patched
flashrom, because the redundant flash chip definitions in *flashchips.c*
have been removed.\
Now compare the 3 images:

    # sha512sum factory\*.rom

If the hashes match, then just copy one of them (the factory.rom) to a
safe place (on a drive connected to another system, not the BBB). This
is useful for reverse engineering work, if there is a desirable
behaviour in the original firmware that could be replicated in coreboot
and libreboot.

While there is a default MAC address inside the gbe region of flash image,
it is not one you want to use. Make sure to change the MAC address to the one
that is correct for your system, for **later internal flash**,
but always remember to **flash unmodfied txtmode image first** as it is known
to work and only this variant provides memtest. You can follow instructions
at [../hardware/gm45\_remove\_me.html\#ich9gen](../hardware/gm45_remove_me.html#ich9gen)
to change the MAC address inside the libreboot image.

Now flash it:

    # ./flashrom -p linux_spi:dev=/dev/spidev1.0,spispeed=512 -w path/to/libreboot/rom/image.rom -V

![](images/x200/disassembly/0015.jpg)

You might see errors, but if it says `Verifying flash... VERIFIED` at
the end, then it's flashed and should boot. If you see errors, try
again (and again, and again); the message `Chip content is identical to
the requested image` is also an indication of a successful
installation.

Example output from running the command (see above):

    flashrom v0.9.7-r1854 on Linux 3.8.13-bone47 (armv7l)
    flashrom is free software, get the source code at http://www.flashrom.org
    Calibrating delay loop... OK.
    Found Macronix flash chip "MX25L6405(D)" (8192 kB, SPI) on linux_spi.
    Reading old flash chip contents... done.
    Erasing and writing flash chip... FAILED at 0x00001000! Expected=0xff, Found=0x00, failed byte count from 0x00000000-0x0000ffff: 0xd716
    ERASE FAILED!
    Reading current flash chip contents... done. Looking for another erase function.
    Erase/write done.
    Verifying flash... VERIFIED.

Thermal paste (IMPORTANT)
=========================

Because part of this procedure involved removing the heatsink, you will
need to apply new paste. Arctic MX-4 is ok. You will also need isopropyl
alcohol and an anti-static cloth to clean with.

When re-installing the heatsink, you must first clean off all old paste
with the alcohol/cloth. Then apply new paste. Arctic MX-4 is also much
better than the default paste used on these systems.

![](images/t400/paste.jpg)

NOTE: the photo above is for illustration purposes only, and does not
show how to properly apply the thermal paste. Other guides online detail
the proper application procedure.

Wifi
====

The T500 typically comes with an Intel wifi chipset, which does not work
without proprietary software. For a list of wifi chipsets that work
without proprietary software, see
[../hardware/\#recommended\_wifi](../hardware/#recommended_wifi).

Some T500 laptops might come with an Atheros chipset, but this is
802.11g only.

It is recommended that you install a new wifi chipset. This can only be
done after installing libreboot, because the original firmware has a
whitelist of approved chips, and it will refuse to boot if you use an
'unauthorized' wifi card.

The following photos show an Atheros AR5B95 being installed, to replace
the Intel chip that this T500 came with:\
![](images/t400/0012.jpg) ![](images/t400/ar5b95.jpg)

WWAN
====

If you have a WWAN/3G card and/or sim card reader, remove them
permanently. The WWAN-3G card has DMA, and proprietary firmware inside;
the technology is identical to what is used in mobile phones, so it can
also track your movements.

Not to be confused with wifi (wifi is fine).

Memory
======

In DDR3 machines with Cantiga (GM45/GS45/PM45), northbridge requires sticks
that will work as PC3-8500 (faster PC3/PC3L sticks can work as PC3-8500).
Non-matching pairs may not work. Single module (meaning, one of the slots
will be empty) will currently only work in slot 0.

NOTE: according to users reports, non matching pairs (e.g. 1+2 GiB) might
work in some cases.

Make sure that the RAM you buy is the 2Rx8 configuration when buying 4GiB sticks
(In other words: maximum of 2GiB per rank, 2 ranks per card).

[This page](http://www.forum.thinkpads.com/viewtopic.php?p=760721) might
be useful for RAM compatibility info (note: coreboot raminit is
different, so this page might be BS)

The following photo shows 8GiB (2x4GiB) of RAM installed:\
![](images/t400/memory.jpg)

Boot it!
--------

You should see something like this:

![](images/t500/0062.jpg)

Now [install GNU+Linux](../gnulinux/).

Copyright © 2015 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
