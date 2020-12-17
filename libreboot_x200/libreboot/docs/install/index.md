---
title: Installation instructions
...

This section relates to installing Libreboot on supported targets.

NOTE: if running `flashrom -p internal` for software based flashing, and you
get an error related to `/dev/mem` access, you should reboot with
`iomem=relaxed` kernel parameter before running flashrom, or use a kernel that
has `CONFIG_STRICT_DEVMEM` not enabled.

Which systems are Libreboot compatible with?
--------------------------------------------

-   [Information about Libreboot hardware compatibility](../hardware/)

General information
-------------------

-   [Information about libreboot ROM images](#rom)

Flashing via software methods, on system:
-----------------------------------------

-   [How to update or install libreboot on all systems](#flashrom)
-   [ASUS KFSN4-DRE](#flashrom)
-   [ThinkPad X60/T60 (if running Lenovo BIOS)](#flashrom_lenovobios)
-   [Apple MacBook2,1](#flashrom_macbook21)
-   [ASUS Chromebook C201](c201.md)

Setting up programmers, for external SPI flashing 
-----------------------------------------------------------------

-   [BeagleBone Black Setup](bbb_setup.md)
-   [Raspberry Pi Setup](rpi_setup.md)

Flashing via hardware methods, on system:
-----------------------------------------

-   [Gigabyte GA-G41-ES2L](ga-g41m-es2l.md)
-   [Intel D510MO](d510mo.md)
-   [Intel D945GCLF](d945gclf.md)
-   [ASUS KGPE-D16](kgpe-d16.md)
-   [ASUS KCMA-D8](kcma-d8.md)
-   [ASUS Chromebook C201](c201.md)
-   [ThinkPad X60](x60_unbrick.md)
-   [ThinkPad X60 Tablet](x60tablet_unbrick.md)
-   [ThinkPad T60](t60_unbrick.md)
-   [ThinkPad X200/X200S/X200T](x200_external.md)
-   [ThinkPad R400](r400_external.md)
-   [ThinkPad T400](t400_external.md)
-   [ThinkPad T500](t500_external.md)
-   [ThinkPad W500](t500_external.md)

Information about libreboot ROM images {#rom}
======================================

Libreboot distributes pre-compiled ROM images, built from the libreboot
source code. These images are provided for user convenience, so that
they don't have to build anything from source on their own.

The ROM images in each archive use the following at the end of the file
name, if they are built with the GRUB payload: `*_*keymap*_*mode*.rom`

Available modes: vesafb or txtmode. The vesafb ROM images are recommended
for regular use, but when flashing for the first time use txtmode version,
as it comes with Memtest86+, which requires text-mode instead of the usual
framebuffer used by coreboot native graphics initialization.
Machine should be tested with Memtest86+ after each reassembly or changing
from vendor bios to libreboot due to differences in raminit code.

`keymap` can be one of several keymaps that keyboard supports (there are
quite a few), which affects the keyboard layout configuration that is
used in GRUB. It doesn't matter which ROM image you choose here, as far
as the keymap in GNU+Linux is concerned.

Keymaps are named appropriately according to each keyboard layout
support in GRUB. To learn how these keymaps are created, see
[../grub/\#grub\_keyboard](../grub/#grub_keyboard)

QEMU
----

Libreboot comes with ROM images built for QEMU, by default:

Examples of how to use libreboot ROM images in QEMU:

    $ qemu-system-i386 -M q35 -m 512 -bios qemu_q35_ich9_keymap_mode.rom
    $ qemu-system-i386 -M pc -m 512 -bios qemu_i440fx_piix4_keymap_mode.rom

You can optionally specify the `-serial stdio` argument, so that QEMU
will emulate a serial terminal on the standard input/output (most likely
your terminal emulator or TTY).

Other arguments are available for QEMU. The manual will contain more
information.

How to update or install libreboot (if you are already running libreboot or coreboot) {#flashrom}
=====================================================================================

On all current targets, updating libreboot can be accomplished without
disassembly and, therefore, without having to externally re-flash using
any dedicated hardware. In other words, you can do everything entirely
in software, directly from the OS that is running on your libreboot
system.

*If you are using `libreboot_src` or git, then make sure that you built the
sources first (see [../git/\#build](../git/#build)).*

Look at the [list of ROM images](#rom) to see which image is compatible
with your device.

Are you currently running the original, proprietary firmware?
-------------------------------------------------------------

If you are currently running the proprietary firmware (not libreboot or
coreboot), then the flashing instructions for your system are going to
be different.

X60/T60 users running the proprietary firmware should refer to
[\#flashrom\_lenovobios](#flashrom_lenovobios). MacBook2,1 users running
Apple EFI should refer to [\#flashrom\_macbook21](#flashrom_macbook21)

X200 users, refer to [x200\_external.md](x200_external.md), R400
users refer to [r400\_external.md](r400_external.md), T400 users
refer to [t400\_external.md](t400_external.md), T500 and W500 users refer to
[t500\_external.md](t500_external.md)

ASUS KFSN4-DRE?
---------------

Internal flashing should work just fine, even if you are currently
booting the proprietary firmware.

Libreboot currently lacks documentation for externally re-flashing an
LPC flash chip. However, these boards have the flash chip inside of a
PLCC socket, and it is possible to hot-swap the chips. If you want to
back up your known-working image, simply hot-swap the chip for one that
is the same capacity, after having dumped a copy of the current firmware
(flashrom -p internal -r yourchosenname.rom), and then flash that chip
with the known-working image. Check whether the system still boots, and
if it does, then it should be safe to flash the new image (because you
now have a backup of the old image).

Keeping at least one spare LPC PLCC chip with working firmware on it is
highly recommended, in case of bricks.

*DO NOT hot-swap the chip with your bare hands. Use a PLCC chip
extractor. These can be found online. See
<http://www.coreboot.org/Developer_Manual/Tools#Chip_removal_tools>*

Do check the HCL entry: [../hardware/kfsn4-dre.md](../hardware/kfsn4-dre.md)

ASUS KGPE-D16?
--------------

If you have the proprietary BIOS, you need to flash libreboot
externally. See [kgpe-d16.md](kgpe-d16.md).

If you already have coreboot or libreboot installed, without write
protection on the flash chip, then you can do it in software (otherwise,
see link above).

*DO NOT hot-swap the chip with your bare hands. Use a PDIP-8 chip
extractor. These can be found online. See
<http://www.coreboot.org/Developer_Manual/Tools#Chip_removal_tools>*

Do check the HCL entry: [../hardware/kgpe-d16.md](../hardware/kgpe-d16.md)

ASUS KCMA-D8?
-------------

If you have the proprietary BIOS, you need to flash libreboot
externally. See [kcma-d8.md](kcma-d8.md).

If you already have coreboot or libreboot installed, without write
protection on the flash chip, then you can do it in software (otherwise,
see link above).

*DO NOT hot-swap the chip with your bare hands. Use a PDIP-8 chip
extractor. These can be found online. See
<http://www.coreboot.org/Developer_Manual/Tools#Chip_removal_tools>*

Do check the HCL entry: [../hardware/kcma-d8.md](../hardware/kcma-d8.md)

Intel D945GCLF?
---------------

If you're running the original Intel factory BIOS, then you will need
to flash externally. For instructions on how to do that, refer to
[d945gclf.md](d945gclf.md).

Otherwise, read the generic instructions below for using the *flash*
script.

Are you currently running libreboot (or coreboot)?
--------------------------------------------------

X60/T60 users should be fine with this guide. If you write-protected the
flash chip, please refer to [x60\_unbrick.md](x60_unbrick.md),
[x60tablet\_unbrick.md](x60tablet_unbrick.md) or
[t60\_unbrick.md](t60_unbrick.md). *This probably does not apply to
you. Most people do not write-protect the flash chip, so you probably
didn't either.*

Similarly, it is possible to write-protect the flash chip in coreboot or
libreboot on GM45 laptops (X200/R400/T400/T500/W500). If you did this, then
you will need to use the links above for flashing, treating your laptop
as though it currently has the proprietary firmware (because
write-protected SPI flash requires external re-flashing, as is also the
case when running the proprietary firmware).

If you did not write-protect the flash chip, or it came to you without
any write-protection (*libreboot does not write-protect the flash chip
by default, so this probably applies to you*), read on!

MAC address on GM45 (X200/R400/T400/T500/W500)
-----------------------------------------

*Users of the X200/R400/T400/T500/W500 take note:* The MAC address for the
onboard ethernet chipset is located inside the flash chip. Libreboot ROM
images for these laptops contain a generic MAC address by default, but
this is not what you want. *Make sure to change the MAC address inside
the ROM image, before flashing it. The instructions on
[../hardware/gm45\_remove\_me.html\#ich9gen](../hardware/gm45_remove_me.html#ich9gen)
show how to do this.*

It is important that you change the default MAC address, before
flashing. It will be printed on a sticker at the bottom of the laptop,
or it will be printed on a sticker next to or underneath the RAM.
Alternatively, and assuming that your current firmware has the correct
MAC address in it, you can get it from your OS.

Apple iMac 5,2?
---------------

Internal flashing works, even when flashing from Apple EFI to libreboot.
Continue reading the instructions below.

*NOTE: If you're flashing an older version of Libreboot, the iMac5,2
motherboard is compatible with the MacBook2,1. Simply flash a MacBook2,1
ROM image, and it should work.*

Flash chip size
---------------

Use this to find out:

    # flashrom -p internal

All good?
---------

Excellent! Moving on...

Download the *libreboot\_util.tar.xz* archive, and extract it. Inside,
you will find a directory called *flashrom*. This contains statically
compiled executable files of the *flashrom* utility, which you will use
to re-flash your libreboot system.

Simply use *cd* on your terminal, to switch to the *libreboot\_util*
directory. Inside, there is a script called *flash*, which will detect
what CPU architecture you have (e.g. i686, x86\_64) and use the
appropriate executable. It is also possible for you to build these
executables from the libreboot source code archives.

How to update the flash chip contents:

`$ sudo ./flash update `[`yourrom.rom`](#rom)

Ocassionally, coreboot changes the name of a given board. If flashrom
complains about a board mismatch, but you are sure that you chose the
correct ROM image, then run this alternative command:

 `$ sudo ./flash forceupdate `[`yourrom.rom`](#rom)

You should see `Verifying flash... VERIFIED.` written at the end
of the flashrom output. *Shut down* after you see this, and then boot
up again after a few seconds.

ThinkPad X60/T60: Initial installation guide (if running the proprietary firmware) {#flashrom_lenovobios}
==================================================================================

*This is for the ThinkPad X60 and T60 while running Lenovo BIOS. If you
already have coreboot or libreboot running, then go to
[\#flashrom](#flashrom) instead!*

*If you can, make sure that RTC battery is not discharged. Discharged RTC battery may lead to brick due to not holding BUC register value*

*If you are flashing a Lenovo ThinkPad T60, be sure to read
[../hardware/\#supported\_t60\_list](../hardware/#supported_t60_list)*

*If you are using libreboot\_src or git, then make sure that you built
the sources first (see [../git/\#build](../git/#build)).*

*Warning: this guide will not instruct the user how to backup the
original Lenovo BIOS firmware. These backups are tied to each system,
and will not work on any other. For that, please refer to
<http://www.coreboot.org/Board:lenovo/x60/Installation>.*

*If you're using libreboot 20150518, note that there is a mistake in
the flashing script. do this: *

    rm -f patch
    wget -O flash https://notabug.org/libreboot/libreboot/raw/9d850543ad90b72e0e333c98075530b31e5d23f1/flash
    chmod +x flash

The first half of the procedure is as follows:

`$ sudo ./flash i945lenovo_firstflash `[`yourrom.rom`](#rom)

You should see within the output the following:

    Updated BUC.TS=1 - 64kb address ranges at 0xFFFE0000 and 0xFFFF0000 are
    swapped

You should also see within the output the following:

    (...) failed during command execution at address 0x1f0000
    ...
    Your flash chip is in an unknown state
    ...
    FAILED
    ...
    DO NOT REBOOT OR POWEROFF

Seeing this means that the operation was a *resounding* success!
*DON'T PANIC*.

See this link for more details:
<http://thread.gmane.org/gmane.linux.bios.flashrom/575>.

If the above is what you see, then *SHUT DOWN* (but do not remove power, especially RTC battery). Wait a few seconds,
and then boot; libreboot is running, but there is a 2nd procedure
needed (see below).

When you have booted up again, you must also do this:

`$ sudo ./flash i945lenovo_secondflash `[`yourrom.rom`](#rom)

If flashing fails at this stage, try the following:

`$ sudo ./flashrom/i686/flashrom -p internal:laptop=force_I_want_a_brick -w `[`yourrom.rom`](#rom)

You should see within the output the following:

    Updated BUC.TS=0 - 128kb address range 0xFFFE0000-0xFFFFFFFF is
    untranslated

You should also see within the output the following:

    Verifying flash... VERIFIED.

MacBook2,1: Initial installation guide (if running the proprietary firmware) {#flashrom_macbook21}
============================================================================

*If you have a MacBook1,1, refer to
[../hardware/\#information-about-the-macbook11](../hardware/#information-about-the-macbook11) for flashing instructions.*

*This is for the MacBook2,1 while running Apple EFI firmware. If you
already have coreboot or libreboot running, then go to
[\#flashrom](#flashrom) instead!*

Be sure to read the information in
[../hardware/\#information-about-the-macbook21](../hardware/#information-about-the-macbook21).

*Warning: this guide will not instruct the user how to backup the
original Apple EFI firmware. For that, please refer to
<http://www.coreboot.org/Board:apple/macbook21>.*

*If you are using libreboot\_src or git, then make sure that you built
the sources first (see [../git/\#build](../git/#build)).*

Look at the [list of ROM images](#rom) to see which image is compatible
with your device.

Use this flashing script, to install libreboot:

`$ sudo ./flash i945apple_firstflash `[`yourrom.rom`](#rom)

You should also see within the output the following:

    Verifying flash... VERIFIED.

Shut down.

Copyright © 2014, 2015, 2016 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
