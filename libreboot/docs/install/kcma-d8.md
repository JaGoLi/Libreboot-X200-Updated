---
title: KCMA-D8 external flashing instructions 
x-toc-enable: true
...

Initial flashing instructions for kcma-d8.

This guide is for those who want libreboot on their ASUS kcma-d8
motherboard, while they still have the proprietary ASUS BIOS present.
This guide can also be followed (adapted) if you brick you board, to
know how to recover.

*Memory initialization is still problematic, for some modules. We
recommend avoiding Kingston modules.*

For more general information about this board, refer to
[../hardware/kcma-d8.md](../hardware/kcma-d8.md).

TODO: show photos here, and other info.

External programmer {#programmer}
===================

Refer to [bbb\_setup.md](bbb_setup.md) for a guide on how to set up
an external SPI programmer.

The flash chip is in a PDIP 8 socket (SPI flash chip) on the
motherboard, which you take out and then re-flash with libreboot, using
the programmer. *DO NOT* remove the chip with your hands. Use a chip
extractor tool.

Copyright © 2016 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
