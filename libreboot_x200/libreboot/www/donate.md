---
title: Contribute financially to the Libreboot project
x-toc-enable: true
...

Introduction
============

Donate money to the Libreboot project. Your money will be used
to fund development and pay people who work on these projects. Some of the money
received will be donated to the
[Free Software Foundation](https://www.fsf.org/).

I, Leah Rowe, am founder of Libreboot. I am also the lead
developer of Libreboot. I use whatever money is received to fund development;
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

I, Leah Rowe, am founder and lead developer of
[Libreboot](https://libreboot.org/). I
work with other developers too. This page is intended to raise money to financially
assist such development on both Libreboot and osboot, both of which provide
coreboot-based hardware initialization on supported machines.

The word *donation* and *donate* may be used here, but legally speaking it is
not a donation. You are simply sending money to Leah Rowe. I use whatever money
is received to pay for development costs.

My own work is focused on:

* Adding new boards from coreboot whenever feasible
* Experimenting with coreboot payloads; for years I've preferred GNU GRUB,
  but lately I've been experimenting more with SeaBIOS, Tianocore and linuxboot,
  the latter of which is not yet present in osboot and Tianocore/linuxboot
  are both currently absent in Libreboot but will be added. For ARM (rockchip
  and so on) I've been experimenting with UBoot; ARM support is quite weak
  in Libreboot, so this is something that I was to improve.
* Providing excellent documentation, written for non-technical users (with
  developer documentation also provided, either in osboot/Libreboot or
  submitted upstream to projects such as coreboot)
* Working on upstream projects such as coreboot and GRUB (bug fixes, mostly,
  though I myself added ThinkPad T400 support to coreboot many years ago and
  huge improvements were made to it by other people in that project. I've also
  commissioned work on new coreboot ports in the past, and paid for such work)
* Work on the Libreboot and osboot build systems (lbmk and rbmk, not paper)
* Generally running the project, coordinating development and handling releases
* I also provide user support on IRC

PLANNED: COREBOOT FORK:
-----------------------

Fork coreboot. For years, Libreboot has simply applied deblob scripts on the
upstream coreboot repository, but this is no longer feasible; coreboot has
deleted many boards over the years, and maintaining these scripts has become
much harder because multiple coreboot revisions have to be used.

So, on the agenda is this: fork coreboot, and re-add those deleted boards.
Maintain a proper fork of coreboot, while trying to stay as close to upstream
as possible (to make development easier), while making decisions that are more
optimal for Libreboot. Then Libreboot can use that fork, instead of deblobbing
upstream.
