---
title: How to install NetBSD on a libreboot system
x-toc-enable: true
...

This section relates to preparing, booting and installing NetBSD on your
libreboot system, using nothing more than a USB flash drive (and *dd*).
They've only been tested on a librebooted ThinkPad X60.

It is expected that you use text mode in libreboot (txtmode images), for
the early boot process in NetBSD. *Suspend/hibernate is broken,
according to at least 1 user.*

Thanks go to ioxcide in [this Reddit
post](https://www.reddit.com/r/BSD/comments/53jt70/libreboot_and_bsds/)
for the initial instructions.

*This section is only for the GRUB payload. For depthcharge (used on
CrOS devices in libreboot), instructions have yet to be written in the
libreboot documentation.*

netbsd.iso is the installation image for NetBSD. Adapt the filename
accordingly, for your version of NetBSD.

Prepare the USB drive (in NetBSD)
---------------------------------

[This
page](https://wiki.netbsd.org/tutorials/how_to_install_netbsd_from_an_usb_memory_stick/)
on the NetBSD website shows how to create a NetBSD bootable USB drive
from within NetBSD itself. You should use the *dd* method documented
there.

Prepare the USB drive (in FreeBSD)
----------------------------------

[This page](https://www.freebsd.org/doc/handbook/bsdinstall-pre.html) on
the FreeBSD website shows how to create a bootable USB drive for
installing FreeBSD. Use the *dd* on that page. You can also use the same
instructions with a NetBSD ISO image.

Prepare the USB drive (in LibertyBSD or NetBSD)
-----------------------------------------------

If you downloaded your ISO on a LibertyBSD or NetBSD system, here is how
to create the bootable NetBSD USB drive:

Connect the USB drive. Check dmesg:

    $ dmesg | tail

Check to confirm which drive it is, for example, if you think its sd3:

    $ disklabel sd3

Check that it wasn't automatically mounted. If it was, unmount it. For
example:

    $ doas umount /dev/sd3i

dmesg told you what device it is. Overwrite the drive, writing the
NetBSD installer to it with dd. For example:

    $ doas netbsd.iso of=/dev/rsdXc bs=1M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Prepare the USB drive (in GNU+Linux)
------------------------------------

If you downloaded your ISO on a GNU+Linux system, here is how to create
the bootable NetBSD USB drive:

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

    $ sudo dd if=install60.fs of=/dev/sdX bs=8M; sync
    # dd if=netbsd.iso of=/dev/sdX bs=8M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Installing NetBSD without full disk encryption
----------------------------------------------

You might have to use an external USB keyboard during the installation.
Press C to access the GRUB terminal.

    grub> knetbsd -r sd0a (usb0,netbsd1)/netbsd
    grub> boot

It will start booting into the NetBSD installer. Follow the normal
process for installing NetBSD.

Installing NetBSD with full disk encryption
-------------------------------------------

TODO

Booting
-------

Press C in GRUB to access the command line:

    grub> knetbsd -r wd0a (ahci0,netbsd1)/netbsd
    grub> boot

NetBSD will start booting. Yay!

Configuring Grub
----------------

If you don't want to drop to the GRUB command line and type in a
command to boot NetBSD every time, you can create a GRUB configuration
that's aware of your NetBSD installation and that will automatically be
used by libreboot.

On your NetBSD root partition, create the `/grub` directory and add
the file `libreboot_grub.cfg` to it. Inside the
`libreboot_grub.cfg` add these lines:

    default=0
    timeout=3

    menuentry "NetBSD" {
        knetbsd -r wd0a (ahci0,netbsd1)/netbsd
    }

The next time you boot, you'll see the old Grub menu for a few seconds,
then you'll see the a new menu with only NetBSD on the list. After 3
seconds NetBSD will boot, or you can hit enter to boot.

Troubleshooting
===============

Most of these issues occur when using libreboot with coreboot's 'text
mode' instead of the coreboot framebuffer. This mode is useful for
booting payloads like memtest86+ which expect text-mode, but for NetBSD
it can be problematic when they are trying to switch to a framebuffer
because it doesn't exist.

In most cases, you should use the vesafb ROM images. Example filename:
libreboot\_ukdvorak\_vesafb.rom.

won't boot...something about file not found
---------------------------------------------

Your device names (i.e. usb0, usb1, sd0, sd1, wd0, ahci0, hd0, etc) and
numbers may differ. Use TAB completion.

Copyright © 2016 Leah Rowe <info@minifree.org>\
Copyright © 2016 Scott Bonds <scott@ggr.com>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
