---
title: Installing Debian or Devuan GNU+Linux with full disk encryption (including /boot)
...

This guide is written for the Debian distribution, but it should also
work for Devuan with the net installer.

Gigabyte GA-G41M-ES2L
=====================

To boot the Trisquel net installer, make sure to specify fb=false on the linux
kernel parameters in GRUB. This will boot the installer in text mode instead
of using a framebuffer.

Moving on...
============

Libreboot on x86 uses the GRUB
[payload](http://www.coreboot.org/Payloads#GRUB_2) by default, which
means that the GRUB configuration file (where your GRUB menu comes from)
is stored directly alongside libreboot and its GRUB payload executable,
inside the flash chip. In context, this means that installing
distributions and managing them is handled slightly differently compared
to traditional BIOS systems.

On most systems, the /boot partition has to be left unencrypted while
the others are encrypted. This is so that GRUB, and therefore the
kernel, can be loaded and executed since the firmware can't open a LUKS
volume. Not so with libreboot! Since GRUB is already included directly
as a payload, even /boot can be encrypted. This protects /boot from
tampering by someone with physical access to the system.

This guide is written for Debian net installer. You can download the ISO
from the homepage on [debian.org](https://www.debian.org/). Use this on
the GRUB terminal to boot it from USB (for 64-bit Intel or AMD):

    set root='usb0'
    linux /install.amd/vmlinuz
    initrd /install.amd/initrd.gz
    boot
    
If you are on a 32-bit system (e.g. X60):

    set root='usb0'
    linux /install.386/vmlinuz
    initrd /install.386/initrd.gz
    boot
    
[This guide](grub_boot_installer.md) shows how to create a boot USB
drive with the Debian ISO image.

*This guide is only for the GRUB payload. If you use the depthcharge payload,
ignore this section entirely.*

Note: on some thinkpads, a faulty DVD drive can cause the cryptomount -a step
during boot to fail. If this happens to you, try removing the drive.

Set a strong user password (lots of lowercase/uppercase, numbers and symbols).

Use of the *diceware method* is recommended, for generating secure passphrases
(instead of passwords).

When the installer asks you to set up encryption (ecryptfs) for your home
directory, select 'Yes' if you want to: *LUKS is already secure and performs
well. Having ecryptfs on top of it will add noticeable performance penalty, for
little security gain in most use cases. This is therefore optional, and not
recommended. Choose 'no'.*

*Your user password should be different from the LUKS password which
you will set later on. Your LUKS password should, like the user
password, be secure.*

Partitioning
============

Choose 'Manual' partitioning:

-   Select drive and create new partition table
-   Single large partition. The following are mostly defaults:
    -   Use as: physical volume for encryption
    -   Encryption: aes
    -   key size: whatever default is given to you
    -   IV algorithm: whatever default is given to you
    -   Encryption key: passphrase
    -   erase data: Yes (only choose 'No' if it's a new drive that
        doesn't contain your private data)

-   Select 'configure encrypted volumes'
    -   Create encrypted volumes
    -   Select your partition
    -   Finish
    -   Really erase: Yes
    -   (erase will take a long time. be patient)
    -   (if your old system was encrypted, just let this run for about a
        minute to make sure that the LUKS header is wiped out)
-   Select encrypted space:
    -   use as: physical volume for LVM
    -   Choose 'done setting up the partition'
-   Configure the logical volume manager:
    -   Keep settings: Yes
-   Create volume group:
    -   Name: `matrix` (use this exact name)
    -   Select crypto partition
-   Create logical volume
    -   select `matrix` (use this exact name)
    -   name: `rootvol` (use this exact name)
    -   size: default, minus 2048 MB
-   Create logical volume
    -   select `matrix` (use this exact name)
    -   name: `swap` (user this exact name)
    -   size: press enter

Further partitioning
====================

Now you are back at the main partitioning screen. You will simply set
mountpoints and filesystems to use.

-   LVM LV rootvol
    -   use as: btrfs
    -   mount point: /
    -   done setting up partition
-   LVM LV swap
    -   use as: swap area
    -   done setting up partition
-   Now you select 'Finished partitioning and write changes to disk'.

Kernel
======

Installation will ask what kernel you want to use. linux-generic is
fine.

Tasksel
=======

For Debian, use the *MATE* option, or one of the others if you want. The
libreboot project recommends MATE, unless you're saavy enough to choose
something else.

If you want debian-testing, then you should only select barebones
options here and change the entries in /etc/apt/sources.list after
install to point to the new distro, and then run `apt-get update` and
`apt-get dist-upgrade` as root, then reboot and run `tasksel` as
root. This is to avoid downloading large packages twice.

NOTE: If you want the latest up to date version of the Linux kernel,
Debian's kernel is sometimes outdated, even in the testing distro. You
might consider using [this repository](https://jxself.org/linux-libre/)
instead, which contains the most up to date versions of the Linux
kernel. These kernels are also deblobbed, like Debian's kernels, so you
can be sure that no binary blobs are present.

Postfix configuration
=====================

If asked, choose *"No Configuration"* here (or maybe you want to
select something else. It's up to you.)

Install the GRUB boot loader to the master boot record
======================================================

Choose 'Yes'. It will fail, but don't worry. Then at the main menu,
choose 'Continue without a bootloader'. You could also choose 'No'.
Choice is irrelevant here.

*Don't forget to have grub-coreboot package installed, even though installing grub to MBR is irrelevant
on libreboot system, grub tools are still needed to eg. generate config (`grub-mkconfig`)*

Clock UTC
=========

Just say 'Yes'.

Booting your system
===================

At this point, you will have finished the installation. At your GRUB
payload, press C to get to the command line, and enter:

    grub> cryptomount -a
    grub> set root='lvm/matrix-rootvol'
    grub> linux /vmlinuz root=/dev/mapper/matrix-rootvol cryptdevice=/dev/mapper/matrix-rootvol:root
    grub> initrd /initrd.img
    grub> boot

ecryptfs
========

If you didn't encrypt your home directory, then you can safely ignore
this section.

Immediately after logging in, do that:

    $ sudo ecryptfs-unwrap-passphrase

This will be needed in the future if you ever need to recover your home
directory from another system, so write it down and keep the note
somewhere secret. Ideally, you should memorize it and then burn the note
(or not even write it down, and memorize it still)>

Generate distro's grub.cfg
======================

Now you need to set it up so that the system will automatically boot,
without having to type a bunch of commands.

Install grub-coreboot if not already installed:

    # apt-get install grub-coreboot

Modify or add following lines to /etc/default/grub

    GRUB_CMDLINE_LINUX="cryptdevice=/dev/mapper/matrix-rootvol:root"
    GRUB_ENABLE_CRYPTODISK=y

Copy fonts/backgrounds to /boot/grub and
generate grub.cfg using following command:

    # grub-install --target=i386-coreboot

[Refer to this guide](grub_hardening.md) for further guidance on
hardening your GRUB configuration, for security purposes.

LUKSv2 incompatibility
======================

When using libreboot version 20160907 and older it may be necessary to
downgrade LUKSv2 to LUKSv1. See
[debian's cryptsetup-team page to learn how to downgrade](https://cryptsetup-team.pages.debian.net/cryptsetup/encrypted-boot.html#downgrading-luks2-to-luks1).

Troubleshooting
===============

A user reported issues when booting with a docking station attached on
an X200, when decrypting the disk in GRUB. The error *AHCI transfer
timed out* was observed. The workaround was to remove the docking
station.

Further investigation revealed that it was the DVD drive causing
problems. Removing that worked around the issue.

    "sudo wodim -prcap" shows information about the drive:
    Device was not specified. Trying to find an appropriate drive...
    Detected CD-R drive: /dev/sr0
    Using /dev/cdrom of unknown capabilities
    Device type    : Removable CD-ROM
    Version        : 5
    Response Format: 2
    Capabilities   : 
    Vendor_info    : 'HL-DT-ST'
    Identification : 'DVDRAM GU10N    '
    Revision       : 'MX05'
    Device seems to be: Generic mmc2 DVD-R/DVD-RW.

    Drive capabilities, per MMC-3 page 2A:

      Does read CD-R media
      Does write CD-R media
      Does read CD-RW media
      Does write CD-RW media
      Does read DVD-ROM media
      Does read DVD-R media
      Does write DVD-R media
      Does read DVD-RAM media
      Does write DVD-RAM media
      Does support test writing

      Does read Mode 2 Form 1 blocks
      Does read Mode 2 Form 2 blocks
      Does read digital audio blocks
      Does restart non-streamed digital audio reads accurately
      Does support Buffer-Underrun-Free recording
      Does read multi-session CDs
      Does read fixed-packet CD media using Method 2
      Does not read CD bar code
      Does not read R-W subcode information
      Does read raw P-W subcode data from lead in
      Does return CD media catalog number
      Does return CD ISRC information
      Does support C2 error pointers
      Does not deliver composite A/V data

      Does play audio CDs
      Number of volume control levels: 256
      Does support individual volume control setting for each channel
      Does support independent mute setting for each channel
      Does not support digital output on port 1
      Does not support digital output on port 2

      Loading mechanism type: tray
      Does support ejection of CD via START/STOP command
      Does not lock media on power up via prevent jumper
      Does allow media to be locked in the drive via PREVENT/ALLOW command
      Is not currently in a media-locked state
      Does not support changing side of disk
      Does not have load-empty-slot-in-changer feature
      Does not support Individual Disk Present feature

      Maximum read  speed:  4234 kB/s (CD  24x, DVD  3x)
      Current read  speed:  4234 kB/s (CD  24x, DVD  3x)
      Maximum write speed:  4234 kB/s (CD  24x, DVD  3x)
      Current write speed:  4234 kB/s (CD  24x, DVD  3x)
      Rotational control selected: CLV/PCAV
      Buffer size in KB: 1024
      Copy management revision supported: 1
      Number of supported write speeds: 4
      Write speed # 0:  4234 kB/s CLV/PCAV (CD  24x, DVD  3x)
      Write speed # 1:  2822 kB/s CLV/PCAV (CD  16x, DVD  2x)
      Write speed # 2:  1764 kB/s CLV/PCAV (CD  10x, DVD  1x)
      Write speed # 3:   706 kB/s CLV/PCAV (CD   4x, DVD  0x)

    Supported CD-RW media types according to MMC-4 feature 0x37:
      Does write multi speed       CD-RW media
      Does write high  speed       CD-RW media
      Does write ultra high speed  CD-RW media
      Does not write ultra high speed+ CD-RW media

Copyright © 2014, 2015, 2016 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
