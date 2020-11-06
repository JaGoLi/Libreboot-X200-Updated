---
title: Modifying the GRUB Configuration in Libreboot Systems
x-toc enable: true
...


This guide will go through all the steps to modify a GRUB configuration file
in Libreboot; this is so that the user doesn't have to manually boot
their operating system each time, by typing in commands at the GRUB command line.

For the purposes of this guide, you can either modify the GRUB configuration file
that resides in the computer's ROM, or else you could modify the version that
exists within the operating system itself; both options will be explained here.

## How to Get the GRUB Configuration File
The first step of the process is to actually get a hold of the GRUB configuration file
that we need to modify. There are two ways to do this:

1. We can extract the one that already exists within the ROM
2. We can use one of the pre-compiled ROMS supplied by the Libreboot project

However, both ways will require us to download the Libreboot Utility Archive.

### Download the Libreboot Utility Archive
The Libreboot Utility Archive contains the programs that we'll need
to get our **grubtest.cfg** file. The latest release of the Libreboot Utility Archive
can be downloaded [from libreboot.org](https://www.mirrorservice.org/sites/libreboot.org/release/stable/20160907/libreboot_r20160907_util.tar.xz).
The quickest way to download it would be to use the `wget` program,
which (if you don't know) allows you to download files from the internet.

If you don't already have it installed, you can install it,
using the `apt-get` command (in Debian-based distributions):

    $ sudo apt-get install wget

You can install it in Arch-based systems, using `pacman`:

    $ sudo pacman -S wget

Once you've installed `wget`, use it to download the file,
simply by passing it the URL as an argument; you can save the file anywhere,
but for the purpose of this guide, save it in **~/Downloads**
(your **Home** directory's downloads folder).
First, change the current working directory to **~/Downloads**:

    $ cd ~/Downloads

This guide assumes you are using the **20160907** version of Libreboot;
if using a different version, modify the following commands accordingly:

    $ wget https://www.mirrorservice.org/sites/libreboot.org/release/stable/20160907/\
    >libreboot_r20160907_util.tar.xz

After the file is downloaded, use the `tar` command to extract its contents:

    $ tar -xf libreboot_r20160907_util.tar.xz

After extraction, the folder will have the same name as the archive: in this case,
**libreboot\_r20160907\_util**. For simplicity's sake, we'll rename it **libreboot\_util**,
using the `mv` command:

    $ mv "libreboot_r20160907_util" "libreboot_util"

Now you have the folder with all the utilities necessary to read and modify the contents of the ROM.

### Get the Necessary Utilities
Once you have the **libreboot\_util** archive, you can find the `cbfstool` and `flashrom`
utilities in **libreboot\_util/cbfstools/x86\_64/cbfstool**,
and **libreboot\_util/flashrom/x86\_64/flashrom**, respectively.

**NOTE: This guide assumes that you are using a device with the** x86\_64 **architecture;
if you are using a device with a different architecture (e.g.,** i686 **or** armv7l**),
the proper version of** `cbfstool` **and** `flashrom` **will be in that folder,
inside their respective directories.**

You could also compile both of these utilities; see [How to Build flashrom](../git/#build_flashrom).

`flashrom` is also available from the repositories; if using an Arch-based distribution,
use `pacman`:

    $ sudo pacman -S flashrom

Or, if you have a Debian-based distribution, use `apt-get`:

    $ sudo apt-get install flashrom

### Get the ROM Image
You can either work directly with one of the ROM images already included
in the libreboot ROM archives, or re-use the ROM that you have currently
flashed. For the purpose of this tutorial, it is assumed that your ROM
image file is named **libreboot.rom**, so please make sure to adapt.

There are two ways to get a pre-compiled ROM image:

#### 1. Download a Pre-Compiled Image from the Libreboot Website
For the current release, **20160907**, they can be found [on a Libreboot mirror](https://www.mirrorservice.org/sites/libreboot.org/release/stable/20160907/rom/grub/);
please adopt this guide, if using a different version of Libreboot.

You also need to make sure that you select both the correct ROM for the device you're using,
as well as the correct flash chip size (if applicable): **4mb**, **8mb**, or **16mb**;
variable flash chip sizes only apply for the Thinkpads that Libreboot supports (excluding the X60 and T60).

You can find the flash chip size, by running the following command:

    # flashrom -p internal

Look for a line like this:

    Found Macronix flash chip "MX25L6406E/MX25L6408E" (8192 kB, SPI) \
    mapped at physical address 0x00000000ff800000.

Running this command on my Thinkpad X200 gives me the above result, so I know that
my flash chip size is **8mb**.

Once you've determined the correct ROMs and flash chip size, download them from the website.
Since I'm currently using an X200 to write this guide, I'll demonstrate how
to download the correct ROM images for that model.

First, we're going to navigate to the **libreboot\_util** folder:

    $ cd ~/Downloads/libreboot_util/

Then, we will download the ROM images, using `wget`:

    $ wget https://www.mirrorservice.org/sites/libreboot.org/release/stable/\
    >20160907/rom/grub/libreboot_r20160907_grub_x200_8mb.tar.xz

Extract the archive, using `tar`:

    $ tar -xf libreboot_r20160907_grub_x200_8mb.tar.xz

Navigate to the directory that you just created:

    $ cd libreboot_r20160907_grub_x200_8mb

Now that we are in the archive, we must choose the correct ROM image.
To figure out the correct image, we must first parse the filenames for each ROM.
For example, for the file named **x200_8mb_usqwerty_vesafb.rom**:

    Model Name: x200
    Flash Chip Size: 8mb
    Country: us
    Keyboard Layout: qwerty
    ROM Type: vesafb or txtmode

Since I am using a QWERTY keyboard, I will ignore all the non-QWERTY options.
Note that there are two types of ROMs: **vesafb** and **txtmode**;
The **vesafb** ROM images are recommended, in most cases; **txtmode** ROM images
come with `MemTest86+`, which requires text-mode, instead of the usual framebuffer
used by coreboot native graphics initialization.

I'll choose **x200_8mb_usqwerty_vesafb.rom**; I'll copy the file (to the `cbfstool` directory),
and rename it with one command:

    $ mv "x200_8mb_usqwerty_vesafb.rom" ../cbfstool/x86_64/libreboot.rom

#### 2. Create an Image from the Current ROM
The simpler way to get a ROM image is to just create it from your current ROM,
using `flashrom`, making sure to save it in the `cbfstool` folder, inside **libreboot\_util**:

    $ sudo flashrom -p internal -r ~/Downloads/libreboot_util/cbfstool/x86_64/libreboot.rom

If you are told to specify the chip, add the option `-c {your chip}` to the command, like this:

    $ sudo flashrom -c MX25L6405 -p internal -r ~/Downloads/libreboot_util/cbfstool/x86_64/libreboot.rom

Now you are ready to extract the GRUB configuration files from the ROM, and modify them the way you want.


### Copy grubtest.cfg from the ROM Image
You can check the contents of the ROM image, inside CBFS, using `cbfstool`.
First, navigate to the cbfstool folder:

    $ cd ~/Downloads/libreboot_util/cbfstool/x86_64/

Then, run the `cbfstool` commmand, with the `print` option; this will display
a list of all the files located in the ROM:

    $ ./cbfstool libreboot.rom print

You should see **grub.cfg** and **grubtest.cfg** in the list. **grub.cfg** is
loaded by default, with a menu entry for switching to **grubtest.cfg**. In
this tutorial, you will first modify and test **grubtest.cfg**. This is to
reduce the possibility of bricking your device, so *DO NOT SKIP THIS!*

Extract (i.e., get a copy of ) **grubtest.cfg** from the ROM image:

    $ ./cbfstool libreboot.rom extract -n grubtest.cfg -f grubtest.cfg

By default `cbfstool` will extract files to the current working directory;
so, **grubtest.cfg** should appear in the same folder as **libreboot.rom**.

## How to Modify the GRUB Configuration File
This section will instruct the user *how* to modify their GRUB configuration file;
whether they decide to use the version located in their operating system's **/** folder,
or the one located in the ROM, the modifications will be the same.

Once the file is open, look for the following line (it will be towards the bottom of the file):

    menuentry 'Load Operating System [o]' --hotkey='o' --unrestricted

After this line, there will be an opening bracket **{**, followed by a several lines
of code, and then a closing  bracket **}**; delete everything that is between those two brackets,
and replace it with the following code, if you're using an Arch-based disribution (e.g., Parabola GNU+Linux-Libre):

    cryptomount -a
    set root='lvm/matrix-root'
    linux /boot/vmlinuz-linux-libre root=/dev/matrix/root cryptdevice=/dev/sda1:root \
    cryptkey=rootfs:/etc/mykeyfile
    initrd /boot/initramfs-linux-libre.img

Or, replace it with this, if you are using a Debian-based distribution (e.g., Trisquel GNU+Linux):

    cryptomount -a
    set root='lvm/matrix-rootvol'
    linux /vmlinuz root=/dev/mapper/matrix-rootvol cryptdevice=/dev/mapper/matrix-rootvol:root
    initrd /initrd.img

Remember, that these names come from the instructions to install GNU+Linux
on Libreboot systems, located [in the docs](index.md). If you followed different instructions,
(or for some other reason, used different names), simply put the names
of your **root** and **swap** volumes, in place of the ones used here.

This covers the basic changes that we can make to GRUB; however, there are some more
changes that you could make, to increase the security of your GRUB configuration.
If you are interested in those modifications, see the Libreboot guide on [Hardening GRUB](grub_hardening.md).

That's it for the modifications! Now all you need to do is follow the instructions below,
in order to use this new configuration to boot your system.

## Change the GRUB Configuration File that the Operating System Uses
Now that we have explained *how* to modify the file itself, we need to explain
how to actually make our system *use* the new GRUB configuration file to boot.

### Without Re-Flashing the ROM
To change the GRUB Configuration that our system uses, without having to re-flash the ROM,
we need to take our **grubest.cfg** file, rename it to **libreboot\_grub**;
this is because that, by default, GRUB in Libreboot is configured to scan all partitions on
the main storage for **/boot/grub/libreboot\_grub.cfg** or **/grub/libreboot\_grub.cfg**
(for systems where **/boot** is on a dedicated partition), and then use it automatically.

Therefore, we need to either copy **libreboot\_grub.cfg** to **/grub**, or to **/boot/grub**:

    $ sudo cp ~/Downloads/libreboot_util/cbfstool/x86_64/libreboot_grub.cfg /boot/grub    # or /grub

Now, the next time we boot our computer, GRUB (in Libreboot) will automatically switch
to this configuration file. *This means that you do not have to re-flash,
recompile, or otherwise modify Libreboot at all!*

### With Re-Flashing the ROM
Changing the GRUB configuration that resides in ROM is a bit more complicated
that the one in **/**, but most of the hard work is already done.

#### Change grubtest.cfg in ROM
Now that you have the modified **grubtest.cfg**, we need to remove
the old **grubtest.cfg** from the ROM, and put in our new one. To remove
the old one, we will use `cbfstool`:

    $ ./cbfstool libreboot.rom remove -n grubtest.cfg

Then, add the new one to the ROM:

    $ ./cbfstool libreboot.rom add -n grubtest.cfg -f grubtest.cfg -t raw

#### Flash Updated ROM Image
The last step of flashing the ROM requires us to change our current working directory
to **libreboot\_util**:

    $ cd ~/Downloads/libreboot_util

Now, all we have to do is use the `flash` script in this directory,
with the `update` option, using **libreboot.rom** as the argument:

    $ sudo ./flash update libreboot.rom

Ocassionally, coreboot changes the name of a given board. If `flashrom`
complains about a board mismatch, but you are sure that you chose the
correct ROM image, then run this alternative command:

    $ sudo ./flash forceupdate libreboot.rom

You will see the `flashrom` program running for a little while, and you might see errors,
but if it says `Verifying flash... VERIFIED` at the end, then it’s flashed,
and should boot. If you see errors, try again (and again, and again).
The message, `Chip content is identical to the requested image` is also
an indication of a successful installation.

#### Reboot the Computer
Now that you have flashed the image, reboot the computer. Keep pressing `spacebar`
right after you turn it on, until you see the GRUB menu, to prevent libreboot
from automatically trying to load the operating system.

Scroll down with the arrow keys, and choose the `Load test configuration (grubtest.cfg) inside of CBFS` option;
this will switch the GRUB configuration to your test version. If all goes well,
it should prompt you for a GRUB username and password, and then your LUKS password.

Once the operating system starts loading, it will prompt you for your LUKS password again.
If it continues, and loads into the OS without errors, then that means your flashing
attempt was a success.

#### Final Steps
When you are satisfied booting from **grubtest.cfg**, you can create a copy
of **grubtest.cfg**, called **grub.cfg**.

First, go to the `cbfstool` directory:

    $ cd ~/Downloads/libreboot_util/cbfstool/x86_64/

Then, create a copy of **grubest.cfg**, named **grub.cfg**:

    $ cp grubtest.cfg ./grub.cfg

Now you will use the `sed` command to make several changes to the file:
the menu entry `'Switch to grub.cfg'` will be changed to `Switch to grubtest.cfg`,
and inside it, all instances of **grub.cfg** to **grubtest.cfg**.
This is so that the main configuration still links (in the menu) to **grubtest.cfg**,
so that you don't have to manually switch to it, in case you ever want to follow
this guide again in the future (modifying the already modified config).:

    $ sed -e 's:(cbfsdisk)/grub.cfg:(cbfsdisk)/grubtest.cfg:g' -e \
    >'s:Switch to grub.cfg:Switch to grubtest.cfg:g' < grubtest.cfg > \
    >grub.cfg

Move **libreboot.rom** from **libreboot\_util** to your current directory:

    $ mv ~/Downloads/libreboot_util/libreboot.rom .

Delete the **grub.cfg** that's already inside the ROM:

    $ ./cbfstool libreboot.rom remove -n grub.cfg

Add your modified **grub.cfg** to the ROM:

    $ ./cbfstool libreboot.rom add -n grub.cfg -f grub.cfg -t raw

Move **libreboot.rom** back to **libreboot\_util**:

    $ mv libreboot.rom ../..

If you don't remember how to flash it, refer back to the *Flash Updated ROM Image*, above; it's the same method as you used before. Afterwards, reboot the machine with your new configuration.

Copyright © 2014, 2015, 2016 Leah Rowe <info@minifree.org>

Copyright © 2017 Elijah Smith <esmith1412@posteo.net>

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)

