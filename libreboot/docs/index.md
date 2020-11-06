---
title: Documentation
...

Information about Libreboot releases can be found at
[release.md](release.md). Always check [libreboot.org](/) for updates. New
releases of Libreboot are announced in the [news section](../news/) of the
website.

[Answers to Frequently Asked Questions about Libreboot](../faq.md).

Installing libreboot
====================

-   [What systems can I use libreboot on?](hardware/)
-   [How to install libreboot](install/)

Installing operating systems
============================

-   [How to install GNU+Linux on a libreboot system](gnulinux/)
-   [How to install BSD on a libreboot system](bsd/)

Information for developers
==========================

-   [How to compile the libreboot source code](git/)
-   [Depthcharge payload](depthcharge/)
-   [GRUB payload](grub/)

Other information
=================

-   [Miscellaneous](misc/)
-   [List of codenames](misc/codenames.md)

About the libreboot project
===========================

Libreboot is a [free](https://www.gnu.org/philosophy/free-sw.html) and Open
Source BIOS or UEFI replacement, initialising the hardware and booting your
operating system. We are a member of the [Peers Community](https://peers.community/)
project, an organisation that supports Free Software.

Libreboot is a [coreboot](http://coreboot.org/) distribution (distro)
with proprietary software removed, intended to be a
[free](https://www.gnu.org/philosophy/free-sw.html) (libre) 'BIOS'
replacement for your computer. The project is aimed at users, attempting
to make coreboot as easy to use as possible.

Libreboot has many practical advantages over proprietary boot firmware,
such as faster boot speeds and better security. You can [install
GNU+Linux with encrypted /boot/](gnulinux/), [verify GPG signatures on
your kernel](gnulinux/grub_hardening.md), put a kernel
in the flash chip and more.

The libreboot project has three main goals:
-------------------------------------------

-   *Recommend and distribute only free software*. Coreboot
    distributes certain pieces of proprietary software which is needed
    on some systems. Examples can include things like CPU microcode
    updates, memory initialization blobs and so on. The coreboot project
    sometimes recommends adding more blobs which it does not distribute,
    such as the Video BIOS or Intel's *Management Engine*. However, a
    lot of dedicated and talented individuals in coreboot work hard to
    replace these blobs whenever possible.
-   *Support as much hardware as possible!* Libreboot supports less
    hardware than coreboot, because most systems from coreboot still
    require certain proprietary software to work properly. Libreboot is
    an attempt to support as much hardware as possible, without any
    proprietary software.
-   *Make coreboot easy to use*. Coreboot is notoriously difficult
    to install, due to an overall lack of user-focussed documentation
    and support. Most people will simply give up before attempting to
    install coreboot.

Libreboot attempts to bridge this divide by providing a build system
automating much of the coreboot image creation and customization.
Secondly, the project produces documentation aimed at non-technical users.
Thirdly, the project attempts to provide excellent user support via mailing
lists and IRC.

Libreboot already comes with a payload (GRUB), flashrom and other
needed parts. Everything is fully integrated, in a way where most of
the complicated steps that are otherwise required, are instead done
for the user in advance.

You can download ROM images for your libreboot system and install
them without having to build anything from source. If, however, you are
interested in building your own image, the build system makes it relatively
easy to do so.

Libreboot is a coreboot distribution, not a coreboot fork
---------------------------------------------------------

Libreboot is not a fork of coreboot. Every so often, the project
re-bases on the latest version of coreboot, with the number of custom
patches in use minimized.

All new coreboot development should be done in coreboot (upstream), not
libreboot! Libreboot is about deblobbing and packaging coreboot in a
user-friendly way, where most work is already done for the user.

For example, if you wanted to add a new board to libreboot, you should
add it to coreboot first. Libreboot will automatically receive your code
at a later date, when it updates itself.

The deblobbed coreboot tree used in libreboot is referred to as
*coreboot-libre*, to distinguish it as a component of *libreboot*.

Libreboot is a 'stable' version of coreboot
---------------------------------------------

-   Coreboot uses the [rolling
release](https://en.wikipedia.org/wiki/Rolling_release) model, which
means that it is not guaranteed to be stable, or to even work at all
on a given day. Coreboot does have a strict code review process, but
being such a large project with so many contributors, regressions
are always possible.
-   Libreboot freezes on a particular revision of coreboot, making sure
that everything works properly, making fixes on top of that and
repeating this during each subsequent update to a later version of
coreboot. By doing this, it provides a stronger guarantee to the
user that the firmware will be reliable, and not break their system.

How do I know what version I'm running? {#version}
========================================

If you are at least 127 commits after release 20150518 (commit message
*build/roms/helper: add version information to CBFS*) (or you have any
*upstream* stable release of libreboot after 20150518), then you can
press C at the GRUB console, and use this command to find out what
version of libreboot you have:

    cat (cbfsdisk)/lbversion

This will also work on non-release images (the version string is
automatically generated, using `git describe --tags HEAD`), built from
the git repository. A file named `version` will also be included in the
archives that you downloaded (if you are using release archives).

If it exists, you can also extract this `lbversion` file by using the
`cbfstool` utility which libreboot includes, from a ROM image that you
either dumped or haven't flashed yet. In your distribution, run
cbfstool on your ROM image (`libreboot.rom`, in this example):

    $ ./cbfstool libreboot.rom extract -n lbversion -f lbversion

You will now have a file, named `lbversion`, which you can read in
whatever program it is that you use for reading/writing text files.

For git, it's easy. Just check the git log.

For releases on or below 20150518, or snapshots generated from the git
repository below 127 commits after 20150518, you can find a file named
*commitid* inside the archives. If you are using pre-built ROM images
from the libreboot project, you can press C in GRUB for access to the
terminal, and then run this command:

    lscoreboot

You may find a date in here, detailing when that ROM image was built.
For pre-built images distributed by the libreboot project, this is a
rough approximation of what version you have, because the version
numbers are dated, and the release archives are typically built on the
same day as the release; you can correlate that with the release
information in [release.md](release.md).

For 20160818, note that the lbversion file was missing from CBFS on GRUB
images. You can still find out what libreboot version you have by
comparing checksums of image dumps (with the descriptor blanked out with
00s, and the same done to the ROMs from the release archive, if you are
on a GM45 laptop).

There may also be a ChangeLog file included in your release archive, so
that you can look in there to figure out what version you have.

You can also check the documentation that came with your archives, and
in *docs/release.html* will be the information about the version of
libreboot that you are using.

Generally speaking, it is advisable to use the latest version of
libreboot.

Copyright © 2014, 2015, 2016 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [fdl-1.3.md](fdl-1.3.md)
