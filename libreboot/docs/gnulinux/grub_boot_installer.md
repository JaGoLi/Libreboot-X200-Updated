---
title: How to Prepare and Boot a USB Installer on Libreboot Systems
x-toc-enable: true
...

This guide explains how to prepare a bootable USB for Libreboot systems that can be used to install several GNU+Linux distributions. For this guide, you will only need a USB flash drive and the `dd` utility (it's installed into all GNU+Linux distributions, by default).

For information on actually installing specific GNU+Linux distributions, refer to [this page](index.md).

## Prepare the USB Drive in GNU+Linux
If you downloaded your ISO while on an existing GNU+Linux system, here is how to create the bootable GNU+Linux USB drive:

Connect the USB drive. Check `lsblk`, to confirm its device name (e.g., **/dev/sdX**):

    $ lsblk

For this example, let's assume that our drive's name is `sdb`. Make sure that it's not mounted:

    $ sudo umount /dev/sdb

Overwrite the drive, writing your distro ISO to it with `dd`. For example, if we are installing Trisquel 7.0 64-bit, and it's located in our Downloads folder, this is the command we would run:

    $ sudo dd if=~/Downloads/trisquel_7.0_amd64.iso of=/dev/sdb bs=8M; sync

That's it! You should now be able to boot the installer from your USB drive (the instructions for doing so will be given later).

## Prepare the USB drive in NetBSD
[This page](https://wiki.netbsd.org/tutorials/how_to_install_netbsd_from_an_usb_memory_stick/) on the NetBSD website shows how to create a NetBSD bootable USB drive, from within NetBSD itself. You should the `dd` method documented there. This will work with any GNU+Linux ISO image.

## Prepare the USB drive in FreeBSD
[This page](https://www.freebsd.org/doc/handbook/bsdinstall-pre.html) on the FreeBSD website shows how to create a bootable USB drive for installing FreeBSD. Use the `dd` method documented. This will work with any GNU+Linux ISO image.

## Prepare the USB drive in LibertyBSD or OpenBSD
If you downloaded your ISO on a LibertyBSD or OpenBSD system, here is
how to create the bootable GNU+Linux USB drive:

Connect the USB drive. Run `lsblk` to determine which drive it is:

    $ lsblk

To confirm that you have the correct drive, use `disklabel`. For example, if you thought the correct drive were **sd3**, run this command:

    $ disklabel sd3

Make sure that the device isn't mounted, with `doas`; if it is, this command will unmount it:

    $ doas umount /dev/sd3i

`lsblk` told you what device it is. Overwrite the drive, writing the OpenBSD installer to it with `dd`. Here's an example:

    $ doas dd if=gnulinux.iso of=/dev/rsdXc bs=1M; sync

That's it! You should now be able to boot the installer from your USB drive (the instructions for doing so will be given later).

## Debian or Devuan net install
Download the Debian or Devuan net installer. You can download the Debian ISO
from [the Debian homepage](https://www.debian.org/), or the Devuan ISO from
[the Devuan homepage](https://www.devuan.org/).

Secondly, create a bootable USB drive using the commands in
[#prepare-the-usb-drive-in-gnulinux](#prepare-the-usb-drive-in-gnulinux).

Thirdly, boot the USB and enter these commands in the GRUB terminal
(for 64-bit Intel or AMD):

    grub> set root='usb0'
    grub> linux /install.amd/vmlinuz
    grub> initrd /install.amd/initrd.gz
    grub> boot

If you are on a 32-bit system (e.g. some Thinkpad X60's) then you will need to
use these commands (this is also true for 32-bit running on 64-bit machines):

    grub> set root='usb0'
    grub> linux /install.386/vmlinuz
    grub> initrd /install.386/initrd.gz
    grub> boot

NOTE FOR G41M USERS (32 bit, 64 bit): On the *linux* line, specify fb=false to
boot in text mode or the installer won't have a display on your monitor.

## Booting ISOLINUX Images (Automatic Method)
Boot it in GRUB using the `Parse ISOLINUX config (USB)` option. A new menu should appear in GRUB, showing the boot options for that distro; this is a GRUB menu, converted from the usual ISOLINUX menu provided by that distro.

## Booting ISOLINUX Images (Manual Method)
These are generic instructions. They may or may not be correct for your distribution. You must adapt them appropriately, for whatever GNU+Linux distribution it is that you are trying to install.

If the `ISOLINUX parser` or `Search for GRUB configuration` options won't work, then press `C` in GRUB to access the command line, then run the `ls` command:

    grub> ls

Get the device name from the above output (e.g., `usb0`). Here's an example:

    grub> cat (usb0)/isolinux/isolinux.cfg

Either the output of this command will be the ISOLINUX menuentries for that ISO, or link to other `.cfg` files (e.g, **/isolinux/foo.cfg**). For example, if the file found were **foo.cfg**, you would use this command:

    grub> cat (usb0)/isolinux/foo.cfg

And so on, until you find the correct menuentries for ISOLINUX.

For Debian-based distros (e.g., Trisquel, Devuan), there are typically menuentries listed in **/isolinux/txt.cfg** or **/isolinux/gtk.cfg**. For dual-architecture ISO images (i686 and x86\_64), there may be separate files directories for each architecture.  Just keep searching through the image, until you find the correct ISOLINUX configuration file.

**NOTE: Debian 8.6 ISO only lists 32-bit boot options in txt.cfg. This is important, if you want 64-bit booting on your system. Devuan versions based on Debian 8.x may also have the same issue.**

Now, look at the ISOLINUX menuentry; it'll look like this:

    kernel /path/to/kernel append PARAMETERS initrd=/path/to/initrd ...

GRUB works similarly; here are some example GRUB commands:

    grub> set root='usb0'
    grub> linux /path/to/kernel PARAMETERS MAYBE\_MORE\_PARAMETERS
    grub> initrd /path/to/initrd
    grub> boot

Note: `usb0` may be incorrect. Check the output of the `ls` command (in GRUB), to see a list of USB devices/partitions. Of course, this will vary from distro to distro. If you did all of that correctly, then it should now be booting your USB drive in the way that you specified.

## Troubleshooting
Most of these issues occur when using Libreboot with Coreboot's `text-mode`, instead of the Coreboot framebuffer. This mode is useful for booting payloads, like `MemTest86+`, which expect `text-mode`, but for GNU+Linux distributions, it can be problematic when they are trying to switch to a framebuffer, because it doesn't exist.

In most cases, you should use the **vesafb** ROM images. An example filename would be **libreboot\_ukdvorak\_vesafb.rom**.

### Parabola Won't Boot in Text-Mode
Use one of the ROM images with `vesafb` in the filename (uses Coreboot framebuffer, instead of `text-mode`).

### debian-installer Graphical Corruption in Text-Mode (Debian and Devuan)
When using the ROM images that use Coreboot's `text mode`, instead of the Coreboot framebuffer, booting the Debian or Devuan net installer results in graphical corruption, because it is trying to switch to a framebuffer, which doesn't exist. Use that kernel parameter on the `linux` line, when booting it:

    vga=normal fb=false

This forces debian-installer to start in `text-mode`, instead of trying to switch to a framebuffer.

If selecting `text-mode` from a GRUB menu created using the ISOLINUX parser, you can press `E` on the menu entry to add this. Or, if you are booting manually (from GRUB terminal), then just add the parameters.

This workaround was found on the [Debian site](https://www.debian.org/releases/stable/i386/ch05s04.html). It should also work for Devuan, and any other `apt-get` distro that provides the debian-installer (i.e., text-mode) net install method.

Copyright © 2014, 2015, 2016 Leah Rowe <info@minifree.org>

Copyright © 2016 Scott Bonds <scott@ggr.com>

Copyright © 2017 Elijah Smith <esmith1412@posteo.net>

Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License Version 1.3 or any later version published by the Free Software Foundation with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts. A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
