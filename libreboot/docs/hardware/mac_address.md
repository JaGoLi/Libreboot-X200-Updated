---
title: Changing the MAC address
...

Introduction (GM45+e1000)
=========================

This section is applicable to all Libreboot-supported laptops with the
mobile 4 series chipset (as shown in `$ lspci`)
that use the e1000 ethernet controller (e.g. T400, X200).
The R500 is an exception to this as it does not use the built-in e1000.

On all these laptops, the
[MAC address](https://en.wikipedia.org/wiki/MAC_address)
for the built-in gigabit ethernet controller is stored inside the flash chip,
along with Libreboot and other configuration data. Therefore, installing
Libreboot will overwrite it.

Thus, for these laptops, prebuilt Libreboot already contains a generic
MAC address in the configuration section. This address is `00:f5:f0:40:71:fe`
in builds before 2018-01-16 and `00:4c:69:62:72:65` (see the ascii character
set) afterwards.
Unless you change it, your computer will boot and use it. This can lead
to network problems if you have more than one Libreboot computer on
the same layer2 network (e.g. on the same network switch). The switch
(postman) will simply not know who to deliver to as the MAC (house) addresses
will be the same.

To prevent these address clashes, you can either modify prebuilt Libreboot
to use an address of your own choosing or you can change the address in your
operating system's boot scripts.

In either case, it is a good idea to write down the address that your
computer originally had.

Obtaining the existing MAC address
==================================

The existing MAC address may be obtained by the following methods:

1.  Run `ip link` or `ifconfig` in a terminal/console/shell;
    find your ethernet device (e.g., **enpXXX** or **ethXXX**),
    and look for a set of 12 colon-delimited
    [hexadecimal digits](https://en.wikipedia.org/wiki/Hexadecimal).
    For example: `00:f3:f0:45:91:fe`.

    * `$ ip link`

         `... link/ether ??:??:??:??:??:?? brd ...`

    * Alternatively:

        `$ ifconfig`

        `... ether ??:??:??:??:??:?? txqueuelen ...`


2.  Otherwise you can read the white label that is often found on the
    motherboard under the memory sticks:
    ![](../install/images/t400/macaddress1.jpg)

3.  The MAC address is usually listed on the laptop chassis as well. This one
    will be incorrect if the motherboard was changed and the stickers were not
    updated.

Changing the MAC address in the operating system
================================================

There are three portable ways of doing so:

1.  Using the new iproute2 package:

    `# ip link set <interface> down`

    `# ip link set dev <interface> address 00:4c:69:62:72:65`

    `# ip link set <interface> up`


2.  Using the old `ifconfig` command:

    `# ifconfig <interface> hw ether 00:4c:69:62:72:65`


3. Using the macchanger package.

You can use use of these three methods in your operating system's
init scripts or you can use your operating system's own networking
configuration. Refer to your operating system's documentation for
how to do this.

Changing the MAC address in Libreboot
=====================================

See [here](../gnulinux/grub_cbfs.md#changeMAC).



Copyright © 2017 Fedja Beader <fedja@protonmail.ch>

Copyright © 2014, 2015 Leah Rowe <info@minifree.org>

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
