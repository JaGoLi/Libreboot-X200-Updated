---
title: Do not use CH341A!
...

NOR flashes on all current osboot and libreboot systems run on 3.3v logic.
The ch341a has SPI flashing capabilities and it has 3.3v by default for the
VCC line but data lines (e.g. MISO/MOSI) are 5v. This can very easily damage
your SPI flash; it may still work afterwards, and you can use your machine,
but the reliability of it is now tainted.

These ch341a programmers are unfortunately very popular. DO NOT use it unless
you have fixed the issue. You CAN fix it so that the data lines are 3.3v, if
you follow the notes here:

<https://www.eevblog.com/forum/repair/ch341a-serial-memory-programmer-power-supply-fix/>

A much nicer tool to use is an STM32 Blue Pill (basically similar to an
arduino but with an STM32 microcontroller), with stm32-vserprog installed.
Information about this will be available at a later date.

In practise, most people will not fix their ch341a and instead just risk it,
so no documentation will be provided for ch341a on this website. It is best
to discourage use of that device.

In case it's not clear:

Please do not buy the ch341a! It is incorrectly engineered for the purpose of
ROM flashing on systems with 3.3v SPI (which is most coreboot systems). DO NOT
USE IT!
