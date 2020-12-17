---
title: Flashing the X200 with a BeagleBone Black
x-toc-enable: true
...

This guide is for those who want libreboot on their ThinkPad X200 while
they still have the original Lenovo BIOS present. This guide can also be
followed (adapted) if you brick your X200, to know how to recover.

X200 laptops with libreboot pre-installed
=========================================

If you don't want to install libreboot yourself, companies exist that
sell these laptops with libreboot pre-installed, along with a free
GNU+Linux distribution.

Flash chip size
===============

Run this command on x200 to find out flash chip model and its size:

    # flashrom -p internal

The X200S and X200 Tablet will use a WSON-8 flash chip, on the bottom of the
motherboard (this requires removal of the motherboard). Not all X200S/X200T are
supported; see the [hardware](../hardware/x200.html#x200s) page.

MAC address
===========

Refer to [mac\_address.md](../hardware/mac_address.md).

Initial BBB configuration
=========================

Refer to [bbb\_setup.md](bbb_setup.md) for how to set up the BBB for
flashing.

The following table shows how to connect the test clip to the BBB (on the P9
header), for SOIC-8/SOIC-16:

|BeagleBoneBlack|Pin on P9|SPI |25xx SOIC8 pin|SOIC16|Ball    |DTS      |
|---------------|---------|----|--------------|------|--------|---------|
|I2C1_SCL       |17       |/CS |1             |7     |A16     |spi0_cs0 |
|I2C1_SDA       |18       |MOSI|5             |15    |B16     |spi0_d1  |
|UART2_RXD      |22       |CLK |6             |16    |A17     |spi0_sclk|
|UART2_TXD      |21       |MISO|2             |8     |B17     |spi0_d0  |
|GND            |1 or 2   |GND |4             |10    |GND     |GND      |
|VDD_3V3D       |3 or 4   |Vcc |8             |2     |VDD_3V3D|VDD_3V3D |

*Pictures of flash chip location are located further down on this page*

If onboard 3.3V supply happens to be insuficient, use a separate
module/power supply and set its current limit to 400mA.
Do not forget that in this case ground has to be continuous across between
motherboard, BBB and PSU (all three)!

On the X200S and X200 Tablet the flash chip is underneath the board, in a WSON
package. The pinout is very much the same as a SOIC-8, but such package makes
it impossible to use testclip.  In order to enable external flashing of device,
chip has to be changed to SOIC-8 one. Such procedure requires hot air station
and soldering station (with "knife" K-Tip to easily solder SOIC-8).

Check the list of SOIC-8 flash chips at [List of supported flash
chips](https://www.flashrom.org/Supported_hardware#Supported_flash_chips)\ 25XX
series SPI NOR Flash in 8/16MiB sizes will work fine with libreboot.

The procedure
-------------

This section is for the X200. This does not apply to the X200S or X200
Tablet (for those systems, you have to remove the motherboard
completely, since the flash chip is on the other side of the board).

Remove these screws:\
![](images/x200/disassembly/0003.jpg)

Gently push the keyboard towards the screen, then lift it off, and optionally
disconnect it from the board:\
![](images/x200/disassembly/0004.jpg)
![](images/x200/disassembly/0005.jpg)

Disconnect the cable of the fingerpring reader, and then pull up the palm rest,
lifting up the left and right side of it:\
![](images/x200/disassembly/0006.1.jpg)
![](images/x200/disassembly/0006.jpg)

This shows the location of the flash chip, for both SOIC-8 and SOIC-16:\
![](images/x200/x200_soic16.jpg)
![](images/x200/x200_soic8.jpg)

Lift back the tape that covers a part of the flash chip, and then
connect the clip:\
![](images/x200/disassembly/0008.jpg)

On pin 2 of the BBB, where you have the ground (GND), connect the ground
to your PSU:\
![](images/x200/disassembly/0009.jpg)
![](images/x200/disassembly/0010.jpg)

Connect the 3.3V DC supply from your PSU to the flash chip (via the clip):\
![](images/x200/disassembly/0011.jpg)
![](images/x200/disassembly/0012.jpg)

Now, you should be ready to install libreboot.

Flashrom binaries for ARM (tested on a BBB) are distributed in
libreboot\_util. Alternatively, libreboot also distributes flashrom
source code which can be built.

Log in as root on your BBB, using the instructions in
[bbb\_setup.html\#bbb\_access](bbb_setup.html#bbb_access).

Probe for chips with flashrom:

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

Here is how to backup factory.rom:

    # ./flashrom -p linux_spi:dev=/dev/spidev1.0,spispeed=512 -r factory.rom
    # ./flashrom -p linux_spi:dev=/dev/spidev1.0,spispeed=512 -r factory1.rom
    # ./flashrom -p linux_spi:dev=/dev/spidev1.0,spispeed=512 -r factory2.rom

Note: the `-c` option is not required in libreboot's patched
flashrom, because the redundant flash chip definitions in *flashchips.c*
have been removed.

Now compare the 3 images:

    # sha512sum factory*.rom

If the hashes match and if hex editor (like `dhex`) shows that
they have valid contents (eg. it's not filled entirely with `0x00`/`0xFF`),
then just copy one of them (the factory.rom) to a
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

    # ./flashrom -p linux_spi:dev=/dev/spidev1.0,spispeed=512 -w path/to/libreboot/rom/image.rom

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

Wifi
====

The X200 typically comes with an Intel wifi chipset, which does not work
without proprietary software. For a list of wifi chipsets that work
without proprietary software, see
[../hardware/\#recommended\_wifi](../hardware/#recommended_wifi).

Some X200 laptops come with an Atheros chipset, but this is 802.11g
only.

It is recommended that you install a new wifi chipset. This can only be
done after installing libreboot, because the original firmware has a
whitelist of approved chips, and it will refuse to boot if you use an
'unauthorized' wifi card.

The following photos show an Atheros AR5B95 being installed, to replace
the Intel chip that this X200 came with:

![](images/x200/disassembly/0016.jpg)
![](images/x200/disassembly/0017.jpg)

WWAN
====

If you have a WWAN/3G card and/or sim card reader, remove them
permanently. The WWAN-3G card has proprietary firmware inside; the
technology is identical to what is used in mobile phones, so it can also
track your movements.

Not to be confused with wifi (wifi is fine).

Intel Turbo Memory
==================

Some X200 devices were sold with Intel Turbo Memory installed in the top-most
mini PCI-e slot.

If you have one installed, you should probably remove it as it mostly likely
brings no benefits, while having many issues:
-  It has been [shown to be
   ineffective](http://www.anandtech.com/show/2252) at disk caching or battery
   saving in most use cases. Having it installed might lead to more
   battery consumption.
-  Using it will most likely lead to data loss because with its
   [driver](https://github.com/yarrick/turbomem),
   "data cannot be written/read back reliably". The driver development
   has also stopped.
-  It might also be a security risk as it may have access to the system
   RAM through the PCIe bus.

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

In this photo, 8GiB of RAM (2x4GiB) is installed:

![](images/x200/disassembly/0018.jpg)

Boot it!
--------

You should see something like this:

![](images/x200/disassembly/0019.jpg)

Now [install GNU+Linux](../gnulinux/).

X200S and X200 Tablet users: GPIO33 trick will not work.
--------------------------------------------------------

sgsit found out about a pin called GPIO33, which can be grounded to
disable the flashing protections by the descriptor and stop the ME from
starting (which itself interferes with flashing attempts). The theory
was proven correct; however, it is still useless in practise.

Look just above the 7 in TP37 (that's GPIO33):

![](../hardware/images/x200/gpio33_location.jpg)

By default we would see this in lenovobios, when trying flashrom -p
internal -w rom.rom:

    FREG0: Warning: Flash Descriptor region (0x00000000-0x00000fff) is read-only.
    FREG2: Warning: Management Engine region (0x00001000-0x005f5fff) is locked.

With GPIO33 grounded during boot, this disabled the flash protections as
set by descriptor, and stopped the ME from starting. The output changed
to:

    The Flash Descriptor Override Strap-Pin is set. Restrictions implied by
    the Master Section of the flash descriptor are NOT in effect. Please note
    that Protected Range (PR) restrictions still apply.

The part in bold is what got us. This was still observed:

    PR0: Warning: 0x007e0000-0x01ffffff is read-only.
    PR4: Warning: 0x005f8000-0x005fffff is locked.

It is actually possible to disable these protections. Lenovobios does,
when updating the BIOS (proprietary one). One possible way to go about
this would be to debug the BIOS update utility from Lenovo, to find out
how it's disabling these protections. Some more research is available
here:
<http://www.coreboot.org/Board:lenovo/x200/internal_flashing_research>

On a related note, libreboot has a utility that could help with
investigating this:
[../hardware/gm45\_remove\_me.html\#demefactory](../hardware/gm45_remove_me.md#demefactory)

Copyright © 2014, 2015 Leah Rowe <info@minifree.org>

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
