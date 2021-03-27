---
title: Contribute financially to the Libreboot project
x-toc-enable: true
...

Introduction
============

Donate money to the Retroboot and Libreboot projects. Your money will be used
to fund development and pay people who work on these projects. Some of the money
received will be donated to the
[Free Software Foundation](https://www.fsf.org/) and
[Electronic Frontier Foundation](https://www.eff.org/)

Some of the money will also be donated to the coreboot, which is a member
project under the Software Freedom Conservancy (coreboot uses SFC's legal
infrastructure to accept donations). Libreboot and Retroboot both use coreboot
extensively, for hardware initialization and neither project would be possible
without coreboot!

I, Leah Rowe, am founder of both Libreboot and Retroboot. I am also the lead
developer of both projects. I use whatever money is received to fund development;
this also includes paying the other developers for their time on the project.

Send money via Patreon
======================

Go here for information:

<https://www.patreon.com/libreleah>

You can contribute money there, using a number of payment options that Patreon
supports.

Send money via Bitcoin
======================

Send money to this bitcoin wallet:

    bc1qc7yz0e3uum5nwln08dr65zapqz7xrqhuk3aqm9

This bitcoin wallet is owned and operated by Leah Rowe. This bitcoin address
was last updated on 16 January 2021; keep an eye on this page in case this
bitcoin address changes in the future.

How will your money be used?
============================

I, Leah Rowe, am founder and lead developer of both
[Libreboot](https://libreboot.org/) and [Retroboot](https://retroboot.org/). I
work with other developers too. This page is intended to raise money to financially
assist such development on both Libreboot and Retroboot, both of which provide
coreboot-based hardware initialization on supported machines.

The word *donation* and *donate* may be used here, but legally speaking it is
not a donation. You are simply sending money to Leah Rowe. I use whatever money
is received to pay for development costs, and I share it with the other developers
in the Libreboot project, to pay them for their time working on Libreboot.

My own work is focused on:

* Adding new boards from coreboot whenever feasible
* Experimenting with coreboot payloads; for years I've preferred GNU GRUB,
  but lately I've been experimenting more with SeaBIOS, Tianocore and linuxboot,
  the latter of which is not yet present in Retroboot and Tianocore/linuxboot
  are both currently absent in Libreboot but will be added. For ARM (rockchip
  and so on) I've been experimenting with UBoot, as has Swiftgeek and Andrew.
* Providing excellent documentation, written for non-technical users (with
  developer documentation also provided, either in Retroboot/Libreboot or
  submitted upstream to projects such as coreboot)
* Working on upstream projects such as coreboot and GRUB (bug fixes, mostly,
  though I myself added ThinkPad T400 support to coreboot many years ago and
  huge improvements were made to it by other people in that project. I've also
  commissioned work on new coreboot ports in the past, and paid for such work)
* Work on the Libreboot and Retroboot build systems (lbmk and rbmk, not paper)
* Generally running the project, coordinating development and handling releases
* Occasionally I provide user support on IRC, but that's mostly swiftgeek's
  thing these days.

The two other developers, Andrew Robbins and swiftgeek, also do a lot of work.

swiftgeek focuses mainly on:

* Hardware research and reverse engineering - for example,
  documenting how particular feature of a board works,
  figuring out repairs of common faults and reviewing code against schematics.
* Providing user support on IRC - he excels at this, and a lot of new libreboot
  users now exist because he provided such support!

Andrew focuses mainly on:

* Work on the Libreboot build system (and has expressed interest in working on
  Retroboot in the future)
* Andrew is largely responsible for getting SeaGRUB working. In this config,
  SeaBIOS is the main payload and loads i386-pc grub instead of i386-coreboot
  grub, *in the boot flash*. The benefit of this is that you get the same
  benefits of GNU GRUB in flash, but now it is BIOS GRUB so can make use of
  x86 BIOS calls (useful for chainloading non-coreboot things such as MBR
  boot sector on a hard drive. i386-coreboot grub can't do that, and this is
  the configuration used in Libreboot and Retroboot at present).

Libreboot hasn't had a stable release since 2016. Since that date, work has been
done on a new build system (the *Paper build system*) which adds many new
features but is not yet complete. I, Leah Rowe, decided to fork Libreboot's old
build system and I've made huge improvements to *that* in order to create
Retroboot. I will soon create Retroboot-libre, based on Retroboot, which will be
very similar to Libreboot. I've been authorized (by Andrew and Swiftgeek) to do
a new Libreboot release
based on this work, as a stop-gap to give users updated coreboot/GRUB versions
and so on, and a few new machines added to the build system that can now be
supported in Libreboot; this will *not* replace the work done on the Paper
build system. Retroboot's build system is named `rbmk` (short for Retroboot
Make) based on `lbmk` (Libreboot Make) and is much easier to work on than the
Paper build system, enabling quicker releases schedules.

ETA for lbmk-based Libreboot release: late March 2021 to mid April 2021. More
boards will be added, and existing ones will be updated to use the latest
versions of coreboot, GRUB and whatever other software is required.

