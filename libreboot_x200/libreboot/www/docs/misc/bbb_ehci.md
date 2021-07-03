---
title: EHCI debugging on the BeagleBone Black 
...

EHCI debugging
==============

1.  [Find USB port on the target that supports EHCI
    debug](#FindUSBportonthetargetthatsupportsEHCIdebug)

2.  [Initial setup of BBB to act as EHCI debug
    dongle](#InitialsetupofBBBtoactasEHCIdebugdongle)
3.  [Patch BBB's `g_dbgp` module (optional, but highly
    recommended)](#PatchBBBsgdbgpmoduleoptionalbuthighlyrecommended)
4.  [Configure libreboot with EHCI
    debug](#ConfigurelibrebootwithEHCIdebug)
    1.  [Selecting `HCD Index` and
        `USB Debug port`](#SelectingHCDIndexandUSBDebugport)
5.  [How to get the debug logs](#Howtogetthedebuglogs)
6.  [Eneble EHCI Debug on the target's kernel (optional,
    recommended)](#EnebleEHCIDebugonthetargetskerneloptionalrecommended)
7.  [References](#References)

*NOTE: this documentation may be outdated, and discusses configuring
EHCI debug on the default Debian system that the BBB sometimes comes
with. If you want an easier time, just use [BBB
ScrewDriver](https://www.coreboot.org/BBB_screwdriver) which comes
pre-configured.*

If your computer does not boot after installing libreboot, it is very
useful to get debug logs from it, from the payload (grub) and/or the
kernel (if gets to there). All of them stream debug logs on the
available serial (RS-232) by default. However, most of todays laptops
lack RS-232 port. The other option is to stream the logs to USB EHCI
debug port.

This section explains step-by-step how to setup BBB as a “USB EHCI debug
dongle” and configure libreboot and the linux kernel to stream logs to
it (TODO: grub).

I will refer to three computers:

-   *host* - this is the computer you use, have tools, compiler,
    Internet, etc
-   *BBB* - Beaglebone Black (rev. B or higher, i use rev. C)
-   *target* - the computer you are trying to install liberboot

### Find USB port on the target that supports EHCI debug {#FindUSBportonthetargetthatsupportsEHCIdebug}

Not all USB controllers support EHCI debug (see: [EHCI Debug
Port](http://www.coreboot.org/EHCI_Debug_Port#Hardware_capability) ).
Even more, if a USB controller supports EHCI debug, it is available only
*on a single port* that might or might not be exposed externally.

-   You need running OS (GNU+Linux) on your target for this step (If
    you've flashed libreboot and it does not boot, you have to flush
    back the stock bios)
-   You need USB memory stick (the data on it will not be touched).
-   The EHCI debugging can not be done through external hub, BBB must be
    connected directly to the debug port of the controller (so, no hubs)

<!-- -->

-   Download^[1](#___fn1)^
    [this](http://www.coreboot.org/pipermail/coreboot/attachments/20080909/ae11c291/attachment.sh)
    shell script.

1.  Plug the usb stick in the first available usb port
2.  Run the script, you will get output similar to following:
3.  The buses the support debug are Bus 3 (0000:00:1a.0) on Port 1 and
    Bus 4 (0000:00:1d.0) on port 2. Your usb stick is plugged on Bus 1,
    Port 3
4.  Repeat the steps, plugging the USB stick in the next available port
5.  Go through all available ports and remember(write down) those for
    which bus/port of the usb stick matches one of the bus/port that
    support debug (bold).

Remember (write down) for each port (external plug) you found that
supports debug: *PCI device id, the bus id, the port number, and the
physical location of the usb plug.*

If you do not find a match, you can not get debug over EHCI. Sorry.

^1^ The guys from coreboot were talking about including the script in
coreboot distribution (check the status).

### Initial setup of BBB to act as EHCI debug dongle {#InitialsetupofBBBtoactasEHCIdebugdongle}

BBB must be powered with a barrel power connector since the mini-B USB
plug will be used for the EHCI debug stream. So you will need:

-   power supply (5V, 2A(10W) is sufficient).
-   an extra usb cable: A to mini-B

(On BBB) The linux kernel includes module (g\_dbgp that enables one of
the usb ports on a computer to behave as EHCI debug dongle. Make sure
you have this module available on your BBB (Debian 7.8 that comes with
BBB should have it), if not, you should compile it yourself (see next
section):

    ls /lib/modules/3.8.13-bone70/kernel/drivers/usb/gadget/g_dbgp.ko

Unload all other g\_\* modules:

    # lsmod
    # rmmod g_multi
    ...

Then load g\_dbgp :

    # modprobe g_dbgp
    # lsmod # should show that g_dbgp is loaded, and no other g_*

Plug the mini-B side of the USB cable in your BBB and the A side in your
target. Then one of the usb devices on your target (with lsusb ) should
be:

    Bus 001 Device 024: ID 0525:c0de Netchip Technology, Inc.

If you see the device on the target, you are good to continue to the
next step.

### Patch BBB's g\_dbgp module (optional, but highly recommended) {#PatchBBBsgdbgpmoduleoptionalbuthighlyrecommended}

For the reasons why you need this, see: [EHCI Gadget
Debug](http://www.coreboot.org/EHCI_Gadget_Debug).\
Make sure that you have cross compiling environment for
arm-linux-gnueabihf setup on your *host*.

-   On BBB: uname -r - this will give you version number like
    3.8.13-bone70 (I will refer to this as: \$mav.\$miv-\$lv: where
    mav=3.8, miv=13, lv=bone70
-   Get the BBB kernel ready on your host for cross-compiling:

<!-- -->

    $ cd $work_dir
    $ git clone https://github.com/beagleboard/kernel.git
    $ cd kernel
    $ git checkout $mav (see above)
    $ ./patch.sh
    $ wget http://arago-project.org/git/projects/?p=am33x-cm3.git\;a=blob_plain\;f=bin/am335x-pm-firmware.bin\;hb=HEAD -O kernel/firmware/am335x-pm-firmware.bin
    $ cp configs/beaglebone kernel/arch/arm/configs/beaglebone_defconfig

-   Download the patch from
    [coreboot.org](http://www.coreboot.org/images/8/88/Ehci-debug-gadget-patches.tar.gz)
-   tar -xf Ehci-debug-gadget-patches.tar.gz (will create dir:
    usbdebug-gadget)
-   Note that there are two patches (patch\_1 and patch\_2) for each of
    the two different version of the kernel (3.8 and 3.10). I will use
    3.8. (If using kernel 3.12 patch\_1 is not needed)
-   cd kernel (note that this is one more level: you should be in
    \$work\_dir/kernel/kernel)
-   Apply the patches:

<!-- -->

    git apply ../usbdebug-gadget/v3.8-debug-gadget/0001-usb-dbgp-gadget-Fix-re-connecting-after-USB-disconne.patch
    git apply ../usbdebug-gadget/v3.8-debug-gadget/0002-usb-serial-gadget-no-TTY-hangup-on-USB-disconnect-WI.patch
    ;
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- beaglebone_defconfig -j4@

-   You should also apply the linux-libre *deblob* script to turn it
    into linux-libre (deletes all the blobs from the linux kernel).
    [fsfla website](http://www.fsfla.org/ikiwiki/selibre/linux-libre/) -
    see
    [scripts](http://www.fsfla.org/svn/fsfla/software/linux-libre/scripts/).
-   Get your current BBB kernel config (from: /boot/config-<ver>)
    and copy it to your host as \$work\_dir/kernel/kernel/.config
-   Set proper version number:
    -   On your host, edit \$work\_dir/kernel/kernel/.config (the one
        you've just copied from BBB), find the line
        CONFIG\_LOCALVERSION="<something or empty>" and change
        it to CONFIG\_LOCALVERSION="-\$lv", so it will look something
        like: CONFIG\_LOCALVERSION="-bone70"
-   Also, make sure that: CONFIG\_USB\_G\_DBGP=m (If not, make
    menuconfig, and set @Device Drivers-> USB Support -> USB
    Gadget Support -> EHCI Debug Device Gadget=m
-   Build the module:

<!-- -->

    $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 (is it possoble to build only the gadget modules)
    $ mkdir ../tmp && make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=../tmp modules_install

-   on BBB, backup /lib/modules/3.8.13-bone70/kernel/drivers/usb/gadget
    (i.e. mv /lib/modules/3.8.13-bone70/kernel/drivers/usb/gadget
    \$HOME)
-   copy the freshly compiled usb/gadget dir to
    /lib/modules/3.8.13-bone70/kernel/drivers/usb
-   restart BBB
-   Remove all g\_\* modules (rmmod g\_<>)
-   modprobpe g\_dbgp

### Configure libreboot with EHCI debug {#ConfigurelibrebootwithEHCIdebug}

Libreboot(coreboot) should be configured with debug turned on and to
push debug messages to the EHCI debug port.\
If you've downloaded the binary distribution, you can check if it is
properly configured in the following way:

-   Go to the libreboot dist root directory cd \$libreboot\_bin
-   Locate the rom image for your target (I will call it: \$img\_path)
-   Running the following command will extract the config in a file
    ./my\_config:

<!-- -->

    ./cbfstool/i686/cbfstool $img_path extract -n config -f ./my_config

-   Make sure that the following params in the config are set as
    following:

<!-- -->

    CONFIG_USBDEBUG=y (Generic Drivers -> USB 2.0 EHCI debug dongle support)
    CONFIG_USBDEBUG_IN_ROMSTAGE=y (Generic Drivers -> Enable early (pre-RAM) usbdebug)
    CONFIG_USBDEBUG_HCD_INDEX=<HCD Index of usb controller - see below> (Generic Drivers -> Index for EHCI controller to use with usbdebug)
    CONFIG_USBDEBUG_DEFAULT_PORT=<USB Debug port - see below> (Generic Drivers -> Default USB port to use as Debug Port)

The following three are behind radio button in the menu. Only the first
one^[2](#___fn2)^ should be = y

    USBDEBUG_DONGLE_STD=y                       (Generic Drivers -> Type of dongle (Net20DC or compatible) -> Net20DC or compatible)
    CONFIG_USBDEBUG_DONGLE_BEAGLEBONE=n         (Generic Drivers -> Type of dongle (Net20DC or compatible) -> BeagleBone)
    CONFIG_USBDEBUG_DONGLE_BEAGLEBONE_BLACK=n   (Generic Drivers -> Type of dongle (Net20DC or compatible) -> BeagleBone Black)

^2^ The g\_dbgp module on BeagleBone Black (Rev. C) reports it self as
Net20DC, the other options are for older BB(B) - ver1. This is
documented
[on John Lewis's blog](https://johnlewis.ie/coreboot-ehci-debug-gadget-demonstration/)
(also tested/verified).

Then:\

    CONFIG_CONSOLE_USB=y (Console -> USB dongle console output)

Also Debugging \---> Output verbose XYZ ) (*FIXME* somebody verify
these):

    CONFIG_DEBUG_CBFS=y (Output verbose CBFS debug messages )
    CONFIG_HAVE_DEBUG_RAM_SETUP=y (??? What/where is this)
    CONFIG_DEBUG_RAM_SETUP=y (Output verbose RAM init debug messages)
    CONFIG_DEBUG_SMI=y      (Output verbose SMI debug messages)
    CONFIG_DEBUG_ACPI=y     (Output verbose ACPI debug messages )
    CONFIG_DEBUG_USBDEBUG=y (Output verbose USB 2.0 EHCI debug dongle messages)

If some of the above mentioned configuration options are not as
specified, you have to configure and compile libreboot yourself. Please
refer to the doc(*FIXME: link* about compiling libreboot.

#### Selecting HCD Index and USB Debug port {#SelectingHCDIndexandUSBDebugport}

This applies (and works) only if the USB controller that supports debug
(found in the first section) is from Intel.\
If the PCI ID of the port you found in the first section is 0000:00:1a.0
or 0000:00:1d.0 , you are ok. Otherwise you have to try without
guarantee that will work.

If the externally exposed port is on a bus with PCI ID == 0000:00:1a.0
then for CONFIG\_USBDEBUG\_HCD\_INDEX choose 2, otherwise choose 0 .

For CONFIG\_USBDEBUG\_DEFAULT\_PORT choose the port from the first
section that correspond to the PCI ID

Notes:\
The above is based on the implementation of
coreboot/src/southbridge/intel/common/usb\_debug.c :
pci\_ehci\_dbg\_dev() .\
This is enough as it applies for the supported GM45/G45 Thinkpads.
coreboot support some other contollers too, but they are irellevent for
libreboot (for now).

-   On T500 (with switchable GPU) the debug ports for both intel
    controllers is exposed.
-   On x200t the debug ports for both intel controllers is exposed.

### How to get the debug logs {#Howtogetthedebuglogs}

-   Plug the USB cable in the target's debug port (the one you found in
    step 1) and BBB's mini-B USB
-   Make sure no other then g\_dbgp of the g\_\* modules is loaded on
    your BBB
-   On the BBB:

<!-- -->

    stty -icrnl -inlcr -F /dev/ttyGS0
    cat /dev/ttyGS0

-   Power on the target with libreboot
-   You should see debug logs comming on your BBB console

Note that this is not permanent on BBB, if you reboot it, you have to
rmmod g\_\* and modprobe g\_dbgp

### Eneble EHCI Debug on the target's kernel (optional, recommended) {#EnebleEHCIDebugonthetargetskerneloptionalrecommended}

You have to know how to compile kernel for your target.

1.  Check if early debugging is already enabled: grep
    CONFIG\_EARLY\_PRINTK\_DBGP /boot/config-<ver>
2.  If enabled, you do not have to compile the kernel (skip this step).
    Otherwise, prepare kernel source for your distribution and select
    (Kernel hacking -> Early printk via EHCI debug port). Compile and
    install the new kernel.
3.  Edit your grub configuration and add following to the kenel
    parameters^[20](#___fn20)[21](#___fn21)^: earlyprintk=dbgp,keep.
    Also, try: earlyprintk=dbgp<N>,keep where N is the debug port
    id if the first does not work.

### References {#References}

^10^ [EHCI Debug Port](http://www.coreboot.org/EHCI_Debug_Port)

^11^ [coreboot EHCI debug gadget
demonstration](https://johnlewis.ie/coreboot-ehci-debug-gadget-demonstration/)

^12^ [EHCI Gadget Debug](http://www.coreboot.org/EHCI_Gadget_Debug)

^13^
[Ehci-debug-gadget-patches.tar.gz](http://www.coreboot.org/images/8/88/Ehci-debug-gadget-patches.tar.gz)

^14^ [Compiling the BeagleBone Black
Kernel](http://wiki.beyondlogic.org/index.php/BeagleBoneBlack_Building_Kernel)

^15^
http://dumb-looks-free.blogspot.ca/2014/06/beaglebone-black-bbb-compile-kernel.html

^16^
http://dumb-looks-free.blogspot.fr/2014/06/beaglebone-black-bbb-kernal-headers.html

^17^ [Building BBB Kernel](http://elinux.org/Building_BBB_Kernel)

^18^
http://komposter.com.ua/documents/USB-2.0-Debug-Port%28John-Keys%29.pdf

^19^ [Exploring USB at the Hardware/Software
Interface](http://cs.usfca.edu/~cruse/cs698s10/)

^20^ https://www.kernel.org/doc/Documentation/x86/earlyprintk.txt

^21^ https://wiki.ubuntu.com/Kernel/Debugging/USBearlyprintk

*TODO*:

1.  grub does not send messages to EHCI debug. Investigate.
2.  The section “Configure libreboot with EHCI debug” can be
    skipped/simplified if a common configuration works for all relevant
    targets is selected as defualt
3.  Patch and compule g\_dbgp on BBB instead cross-compile
4.  Find a simple way to send debug messages from targets userland

Copyright © 2015 Alex David <opdecirkel@gmail.com>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
