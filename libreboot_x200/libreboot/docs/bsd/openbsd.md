---
title: How to install LibertyBSD or OpenBSD on a libreboot system
x-toc-enable: true
...

NOTE: This guide was written for OpenBSD by the person who contributed
it, but the libreboot project recommends LibertyBSD. LibertyBSD is a
version of OpenBSD without proprietary software in the repositories
(OpenBSD distributes firmware blobs for devices inside its kernel). Go
to the [LibertyBSD website](http://libertybsd.net/) -- TODO: test on
LibertyBSD and prioritise that in this guide.

This section relates to preparing, booting and installing OpenBSD on
your libreboot system, using nothing more than a USB flash drive (and
`dd`). They've only been tested on a Lenovo ThinkPad x200.

*This section is only for the GRUB payload. For depthcharge (used on
CrOS devices in libreboot), instructions have yet to be written in the
libreboot documentation.*

install61.fs is the installation image for OpenBSD 6.1. Adapt the
filename accordingly, for a different OpenBSD version or LibertyBSD.

Prepare the USB drive (in LibertyBSD or OpenBSD)
------------------------------------------------

If you downloaded your ISO on a LibertyBSD or OpenBSD system, here is
how to create the bootable LibertyBSD/OpenBSD USB drive:

Connect the USB drive and check the system message buffer:

    $ dmesg | tail

Check to confirm which drive it is, for example, if you think it's `sd3`:

    $ disklabel sd3

Check that it wasn't automatically mounted. If it was, unmount it:

    $ doas umount /dev/sd3i

Now write the OpenBSD installer to the drive with `dd`:

    $ doas dd if=install60.fs of=/dev/rsdXc bs=1M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Prepare the USB drive (in NetBSD)
---------------------------------

[This
page](https://wiki.netbsd.org/tutorials/how_to_install_netbsd_from_an_usb_memory_stick/)
on the NetBSD website shows how to create a NetBSD bootable USB drive
from within NetBSD itself. You should use the `dd` method documented
there. This will also work with the OpenBSD image.

Prepare the USB drive (in FreeBSD)
----------------------------------

[This page](https://www.freebsd.org/doc/handbook/bsdinstall-pre.md) on
the FreeBSD website shows how to create a bootable USB drive for
installing FreeBSD. Use the `dd` on that page. You can also use the same
instructions with a OpenBSD ISO image.

Prepare the USB drive (in GNU+Linux)
------------------------------------

If you downloaded your ISO on a GNU+Linux system, here is how to create
the bootable OpenBSD USB drive:

Connect the USB drive. Check dmesg:

    $ dmesg

Check lsblk to confirm which drive it is:

    $ lsblk

Check that it wasn't automatically mounted. If it was, unmount it. For
example:

    $ sudo umount /dev/sdX\*
    # umount /dev/sdX\*

dmesg told you what device it is. Overwrite the drive, writing your
distro ISO to it with dd. For example:

    $ sudo dd if=install61.fs of=/dev/sdX bs=8M; sync
    # dd if=install61.fs of=/dev/sdX bs=8M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Installing OpenBSD without full disk encryption
-----------------------------------------------

Press C in GRUB to access the command line:

    grub> kopenbsd (usb0,openbsd1)/6.1/amd64/bsd.rd
    grub> boot

It will start booting into the OpenBSD installer. Follow the normal
process for installing OpenBSD.

Installing OpenBSD with full disk encryption
--------------------------------------------

Not working. You can modify the above procedure (installation w/o
encryption) to install OpenBSD using full disk encryption, and it
appears to work, except that it's not yet clear how to actually *boot* an
OpenBSD+FDE installation using libreboot+Grub2. If you get it working,
please let us know.

If booting in text mode (framebuffer mode might also work), it might be
possible to chainload the OpenBSD or LibertyBSD bootloader from the MBR
section on the internal storage device. This way, it would be possible
to boot with an encrypted OpenBSD or LibertyBSD installation. Please let
us know (contact details are on the libreboot homepage) if you get it
working this way.

Alternatively, it would be good to port OpenBSD either natively as a
coreboot payload, or port it to libpayload (payload library in coreboot;
it has a basic C library and a few functions for certain operations e.g.
text/bitmap). *This would be ideal, because then it would be possible
to boot a truly fully encrypted OpenBSD or LibertyBSD installation, by
putting everything in the flash chip.*

Alternatively, modifying GRUB to support booting fully encrypted OpenBSD
installations would be possible, but probably not feasible; it's an
alien codebase to the OpenBSD project, not tightly integrated and the
OpenBSD bootloader already works.

Booting
-------

Press C in GRUB to access the command line:

    grub> kopenbsd -r sd0a (ahci0,openbsd1)/bsd
    grub> boot

OpenBSD will start booting. Yay!

Configuring Grub
----------------

If you don't want to drop to the GRUB command line and type in a
command to boot OpenBSD every time, you can create a GRUB configuration
that's aware of your OpenBSD installation and that will automatically
be used by libreboot.

On your OpenBSD root partition, create the `/grub` directory and add the file
`libreboot_grub.cfg` to it. Inside the `libreboot_grub.cfg` add these lines:

    default=0
    timeout=3

    menuentry "OpenBSD" {
        kopenbsd -r sd0a (ahci0,openbsd1)/bsd
    }

If your OpenBSD installation uses a GPT scheme, use the `gpt4` partition
instead of `openbsd1`.

The next time you boot, you'll see the old Grub menu for a few seconds,
then you'll see the a new menu with only OpenBSD on the list. After 3
seconds OpenBSD will boot, or you can hit enter to boot.

Troubleshooting
===============

Most of these issues occur when using libreboot with coreboot's 'text
mode' instead of the coreboot framebuffer. This mode is useful for
booting payloads like memtest86+ which expect text-mode, but for OpenBSD
it can be problematic when they are trying to switch to a framebuffer
because it doesn't exist.

In most cases, you should use the vesafb ROM images. Example filename:
libreboot\_ukdvorak\_vesafb.rom.

Won't boot...something about file not found
---------------------------------------------

Your device names (i.e. usb0, usb1, sd0, sd1, wd0, ahci0, hd0, etc) and
numbers may differ. Use TAB completion.

Copyright © 2016 Scott Bonds <scott@ggr.com>\
Copyright © 2016 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
