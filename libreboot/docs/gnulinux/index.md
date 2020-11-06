---
title: GNU+Linux Installation Instructions
...

This section explains how to deal with various operating systems (both GNU+Linux and non-GNU+Linux) in Libreboot (e.g., Creating bootable USB drives, Installing Operating Systems, Changing the default GRUB menu, etc.).

**NOTE: This section is only for the GRUB payload. For the depthcharge payload (used on CrOS devices, like the ASUS C201 Chromebook), instructions have yet to be written.**

Libreboot uses the GRUB payload by default, which means that the GRUB configuration file (where your GRUB menu comes from) is stored directly alongside Libreboot and its GRUB payload executable, inside the flash chip. In context, this means that installing distributions and managing them is handled slightly differently compared to traditional BIOS systems.

On most systems, **/boot** (the folder that contains all the files needed for your operating system to boot) has to be on its own partition, and left unencrypted (while the other partitions are encrypted); this is so that GRUB (and therefore the kernel) can be loaded and executed, since traditional firmware can't open a LUKS volume.

However, with Libreboot, GRUB is already included directly (as a payload), so even **/boot** can be encrypted; this protects **/boot** from tampering by someone with physical access to the machine.

- [How to Prepare and Boot a USB Installer in Libreboot Systems](grub_boot_installer.md)

- [Modifying the GRUB Configuration in Libreboot Systems](grub_cbfs.md)

- [Guix System with Full-Disk Encryption on Libreboot](guix_system.md)

- [Installing Parabola or Arch GNU+Linux-Libre, with Full-Disk Encryption (including /boot)](encrypted_parabola.md)

  - Follow-Up Tutorial: [Configuring Parabola (Post-Install)](configuring_parabola.md)

- [Installing Hyperbola GNU+Linux, with Full-Disk Encryption (including /boot)](https://wiki.hyperbola.info/en:guide:encrypted_installation)

- [Installing Trisquel GNU+Linux-Libre, with Full-Disk Encryption (including /boot)](encrypted_trisquel.md)

- [Installing Debian or Devuan GNU+Linux-Libre, with Full-Disk Encryption (including /boot)](encrypted_debian.md)

- [How to Harden Your GRUB Configuration, for Security](grub_hardening.md)

Fedora won't boot?
------------------

This may also apply to CentOS or Redhat. Chroot guide can be found on
[fedora website](https://docs.fedoraproject.org/en-US/quick-docs/bootloading-with-grub2/#restoring-bootloader-using-live-disk)

### linux16 issue
When you use Libreboot's default GRUB config, and libreboot's grub uses fedora's
default `grub.cfg` (in `/boot/grub2/grub.cfg`), fedora by default makes use of the
`linux16` command, whereas it should be saying `linux`

Do this in fedora:

Open `/etc/grub.d/10_linux`

Set the `sixteenbit` variable to an empty string, then run:

    grub2-mkconfig -o /boot/grub2/grub.cfg

### BLS issue
With [newer versions of fedora](https://fedoraproject.org/wiki/Changes/BootLoaderSpecByDefault),
scripts from grub package default to generating [BLS](https://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/)
instead of `grub.cfg`. To change that behaviour add following line
to `/etc/default/grub` (or modify existing one if it already exists):

    GRUB_ENABLE_BLSCFG=false

Then generate `grub.cfg` with:

    grub2-mkconfig -o /boot/grub2/grub.cfg

Copyright © 2014, 2015 Leah Rowe <info@minifree.org>

Copyright © 2017 Elijah Smith <esmith1412@posteo.net>

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
