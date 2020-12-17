---
title: How to install FreeBSD on a libreboot system
x-toc-enable: true
...

This section relates to preparing, booting and installing FreeBSD on
your libreboot system, using nothing more than a USB flash drive (and
*dd*). They've only been tested on a Lenovo ThinkPad x200.

It is expected that you use text mode in libreboot (txtmode images), for
the early boot process in FreeBSD. *Booting the installer results in a
red flickering text display, and doesn't boot.*

Thanks go to ioxcide in [this Reddit
post](https://www.reddit.com/r/BSD/comments/53jt70/libreboot_and_bsds/)
for the initial instructions.

TODO: test FreeBSD more extensively, and make sure it works (and fix it
if it does not). Instructions are provided here, to boot and install
FreeBSD but we're not sure whether it is currently fully compatible
with libreboot.

*This section is only for the GRUB payload. For depthcharge (used on
CrOS devices in libreboot), instructions have yet to be written in the
libreboot documentation.*

freebsd.img is the installation image for FreeBSD. Adapt the filename
accordingly, for whatever FreeBSD version you use.

Prepare the USB drive (in FreeBSD)
----------------------------------

[This page](https://www.freebsd.org/doc/handbook/bsdinstall-pre.html) on
the FreeBSD website shows how to create a bootable USB drive for
installing FreeBSD. Use the *dd* on that page.

Prepare the USB drive (in NetBSD)
---------------------------------

[This
page](https://wiki.netbsd.org/tutorials/how_to_install_netbsd_from_an_usb_memory_stick/)
on the NetBSD website shows how to create a NetBSD bootable USB drive
from within NetBSD itself. You should use the *dd* method documented
there; you can use this with any ISO, including FreeBSD.

Prepare the USB drive (in LibertyBSD or OpenBSD)
------------------------------------------------

If you downloaded your ISO on a LibertyBSD or OpenBSD system, here is
how to create the bootable FreeBSD USB drive:

Connect the USB drive. Check dmesg:

    $ dmesg | tail

Check to confirm which drive it is, for example, if you think its sd3:

    $ disklabel sd3

Check that it wasn't automatically mounted. If it was, unmount it. For
example:

    $ doas umount /dev/sd3i

dmesg told you what device it is. Overwrite the drive, writing the
FreeBSD installer to it with dd. For example:

    $ doas dd if=freebsd.img of=/dev/rsdXc bs=1M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Prepare the USB drive (in GNU+Linux)
------------------------------------

If you downloaded your ISO on a GNU+Linux system, here is how to create
the bootable FreeBSD USB drive:

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

    $ sudo dd if=freebsd.img of=/dev/sdX bs=8M; sync
    # dd if=freebsd.img of=/dev/sdX bs=8M; sync

You should now be able to boot the installer from your USB drive.
Continue reading, for information about how to do that.

Installing FreeBSD without full disk encryption
-----------------------------------------------

Press C in GRUB to access the command line:

    grub> kfreebsd (usb0,gpt3)/boot/kernel/kernel
    grub> set FreeBSD.vfs.mountfrom=ufs:/dev/da1p3\
    grub> boot

It will start booting into the FreeBSD installer. Follow the normal
process for installing FreeBSD.

Installing FreeBSD with full disk encryption
--------------------------------------------

TODO

Booting
-------

TODO

Configuring Grub
----------------

TODO

Troubleshooting
===============

Most of these issues occur when using libreboot with coreboot's 'text
mode' instead of the coreboot framebuffer. This mode is useful for
booting payloads like memtest86+ which expect text-mode, but for FreeBSD
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
