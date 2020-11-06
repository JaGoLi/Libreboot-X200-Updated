---
title: Product Codenames
...

Introduction
============

This document lists product codenames for some hardware.
Please note that just because a certain device is listed here does NOT mean
that it is supported in Libreboot. For supported devices refer to the
installation documentation.

### A note on GPUs

Some laptops come with and without a discrete GPU (dGPU). Whether the
motherboard includes one or not can be determined by (in descending order
of reliability):

-   often thorough disassembly and searching for the actual chip
-   looking at white PCB markings near RAM slots / under keyboard
    and comparing with some known codenames (if not available FRU ID sticker)
    listed below.
-   sometimes by looking at heatsink grills: on
    discrete GPU laptops these will look orange and on intergrated ones
    they will appear silver.

List of models and codenames
============================

### Codenames

-   Asus Chromebook C201PA: speedy\_rk3288, veyron-speedy

-   ThinkPad X60: KS Note
-   ThinkPad X60s (slim): KS Note-2 / KS-2
-   ThinkPad X60 Tablet: Dali (Same PCB as KS Note-2, different EC firmware)

-   ThinkPad X200: Mocha-1
-   ThinkPad X200s (slim): Pecan-1
-   ThinkPad X200 Tablet: Caramel-1

-   ThinkPad R400/T400: Malibu-3
    -   with discrete GPU (dGPU), at board revision 0: "MLB3D-0
    -   with only integrated GPU (iGPU), at board revision 0: "MLB3I-0"

-   ThinkPad T500/W500: Coronado-5
    - with dGPU (radeon): "COR5D-0" (last number is the board revision)
    - with only iGPU: "COR5I-0"

-   ThinkPad T400s (slim): Shinai-MV
-   ThinkPad R500: Waikiki-3

-   T6x (whole family): Davinci. They don't have codename label in
silkscreen so you need to use FRU label of the board, which is placed
under RAM sticks.
-   T60:
    -   with dGPU (radeon): Magi-0 (last number is the board revision)
    -   with iGPU: Lisa-0

-   R60(e): RP-1, RP-2 - Rockwell / Picasso

-   With ThinkPads on Intel platforms newer than Montevina (Except T410),
    the codenames become more consistent. All boards have the following
    appended based on the type of graphics they have:
    -   with dGPU: SWG (SWitchable Graphics)
    -   with only iGPU: UMA (Unified Memory Access)

*Note that Intel platforms newer than Montevina are not supported by libreboot
yet!. Currently only Calistoga and Montevina platforms are supported.

-   These are the known model codenames:
    -   ThinkPad T410: NOZOMI-1 # EXT/INT
    -   ThinkPad T410s: SHINAI-2 # SWG/UMA
    -   ThinkPad T420: NOZOMI-3 # SWG/UMA
    -   ThinkPad T420s: SHINAI-3 # SWG/UMA
    -   ThinkPad T430: NOZOMI-4 # SWG/UMA
    -   ThinkPad T430s: SHINAI-4 # SWG/UMA
    -   ThinkPad T520: KENDO-1
    -   ThinkPad W520: KENDO-1 WS
    -   ThinkPad T520: KENDO-3
    -   ThinkPad W520: KENDO-3 WS
    -   ThinkPad T530: KENDO-4
    -   ThinkPad W530: KENDO-4 WS


### Miscellaneous
-   [Calistoga](https://ark.intel.com/products/codename/5950/Calistoga):
945GM/945PM chipset family name
-   Napa: calistoga based platform
-   [Cantiga](https://ark.intel.com/products/codename/26552/Cantiga):
GM45/GS45/PM45 chipset family name.
    This is the chipset used in T400,X200 and similar.
-   Montevina: cantiga based platform.
-   PMH: the Power Management Hub is a gate array for managing the power
    up/down sequence. It is additionally tasked with extending EC's I/O.
    Its later version was called "Thinker-1", and eventually it was merged
    with PMIC (Rinkan) as ThinkEngine (Do not confuse it with EC chip which is also
    has ThinkEngine logo on ThinkPad boards)
-   Kozak, Tsurumai, Rinkan: These are successive versions of power management
    ICs for Notebook PCs. Tsurumai chip marking is "TB62501F" and datasheet
    of it fully describes its operation.

See also
========
-   Many more Intel codenames can be found at
    [Wikipedia](https://en.wikipedia.org/wiki/List_of_Intel_codenames).
-   For ThinkPads see [Documentation/thinkpad/codenames.csv @ Coreboot]
(https://review.coreboot.org/cgit/coreboot.git/tree/Documentation/thinkpad/codenames.csv)

Copyright © 2018 Fedja Beader <fedja@protonmail.ch>

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
