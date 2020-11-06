---
title: Gigabyte GA-G41M-ES2L desktop board 
...

This is a desktop board using intel hardware (circa \~2009, ICH7
southbridge, similar performance-wise to the Libreboot X200. It can make
for quite a nifty desktop. Powered by libreboot.

IDE on the board is untested, but it might be possible to use a SATA HDD
using an IDE SATA adapter. The SATA ports do work.

You need to set a custom MAC address in GNU+Linux for the NIC to work.
In /etc/network/interfaces on debian-based systems like Debian or
Devuan, this would be in the entry for your NIC:\
hwaddress ether macaddressgoeshere

Flashing instructions can be found at
[../install/\#flashrom](../install/#flashrom)

Copyright © 2016 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
