---
title: GRUB payload 
x-toc-enable: true
...

This section relates to the GRUB payload used in libreboot.

Changing the background image in GRUB
=====================================

Use cbfstool from libreboot\_util, or
libreboot\_src/coreboot/util/cbfstool/ if you want to build from source.

    $ ./cbfstool yourrom.rom remove background.png -n background.png
    $ ./cbfstool yourrom.rom add -f background.png -n background.png -t raw

When you've done this, re-flash your ROM and you should have a new
background at boot time.

Setting font in GRUB (for reference)
====================================

You don't need to do this unless you would like to change the default
font yourself. (this is just for reference. It has already been done for
you)

The old font used was Unifont, and this had some missing characters: for
instance, the border showed ??? characters instead of lines.

I tried DeJavu Sans Mono from this website:
[dejavu-fonts.org](http://dejavu-fonts.org/wiki/Download)

Specifically, the version that I chose was the latest at the time of
writing (Saturday 21 June 2014): [this
one](http://sourceforge.net/projects/dejavu/files/dejavu/2.34/dejavu-fonts-ttf-2.34.tar.bz2)

This is a free font that is also contained in GNU+Linux distributions
like Debian, Devuan or Parabola.

    $ cd libreboot\_src/grub

compile grub (the build scripts info on how to do this)\
come back out into libreboot\_src/resources/grub:

    $ cd ../libreboot\_src/resources/grub/font

I took Dejavu Sans Mono from dejavu (included in this version of
libreboot) and did:

    $ ../../../grub/grub-mkfont -o dejavusansmono.pf2 dejavu-fonts-ttf-2.34/ttf/DejaVuSansMono.ttf

I then added the instructions to 'gen.sh' script in grub-assemble to
include resources/grub/dejavusansmono.pf2 in all of the ROM images, at
the root of the GRUB memdisk.\
I then added that instructions to the grub.cfg files (to load the
font):

    loadfont (memdisk)/dejavusansmono.pf2

GRUB keyboard layouts (for reference)
=====================================

Custom keyboard layout in GRUB (for reference)
----------------------------------------------

Keymaps are stored in resources/utilities/grub-assemble/keymap/.

Example (French Azerty):

    $ ckbcomp fr > frazerty

Go in grub directory:

    $ cat frazerty | ./grub/grub-mklayout -o frazerty.gkb

You must make sure that the files are named keymap and keymap.gkb (where
'keymap' can be whatever you want).

Then from the above example, you would put `frazerty` in
`resources/utilities/grub-assemble/keymap/original/` and the
`frazerty.gkb` file goes under
`resources/utilities/grub-assemble/keymap/`

The build scripts will automatically see this, and automatically build
ROM images with your custom layout (given the name) and include them
under bin. Example: `libreboot_frazerty.rom`.

UK Dvorak keyboard layout in GRUB (for reference)
-------------------------------------------------

ukdvorak had to be created manually, based on usdvorak. diff them (under
resources/utilities/grub-assemble/keymap/original) to see how ukdvorak
file was created

    $ cat ukdvorak | ./grub/grub-mklayout -o ukdvorak.gkb

Copyright © 2014 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
