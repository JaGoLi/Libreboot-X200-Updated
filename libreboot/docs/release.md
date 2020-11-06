---
title: Lists of changes per stable release
x-toc-enable: true
...

Updated versions of libreboot can be found at
[libreboot.org](/). Announcements of new Libreboot releases can be found in
the [news section](../news/) on the website.

Libreboot 20160907 {#release20160907}
==================

Release date: 7th September 2016

For existing boards, there are no new board specific changes.

This release adds one new mainboard to libreboot:

-   Intel D945GCLF desktop motherboard (thanks to Arthur Heymans)

Other bugfixes:

-   Various improvements to the documentation
-   re-added "unset superusers" to the grub.cfg, which was needed for
    some users depending on the distros that they used

Libreboot 20160902 {#release20160922}
==================

Release date: 2nd September 2016.

This fixes build issues in the previous 20160818 release. See change log
for details.

Libreboot 20160818 {#release20160818}
==================

Release date: 18th August 2016.

Installation instructions can be found at `docs/install/`. Building
instructions (for source code) can be found at `docs/git/\#build`.

Machines supported in this release:
-----------------------------------

-   **ASUS Chromebook C201**
    -   Check notes in ***docs/hardware/c201.html***
-   **Gigabyte GA-G41M-ES2L desktop motherboard**
    -   Check notes in ***docs/hardware/ga-g41m-es2l.html***
-   **Intel D510MO desktop motherboard**
    -   Check notes in ***docs/hardware/d510mo.html***
-   **Intel D945GCLF desktop motherboard**
    -   Check notes in ***docs/hardware/d945gclf.html***
-   **Apple iMac 5,2**
    -   Check notes in ***docs/hardware/imac52.html***
-   **ASUS KFSN4-DRE server board**
    -   PCB revision 1.05G is the best version (can use 6-core CPUs)
    -   Check notes in ***docs/hardware/kfsn4-dre.html***
-   **ASUS KGPE-D16 server board**
    -   Check notes in ***docs/hardware/kgpe-d16.html***
-   **ASUS KCMA-D8 desktop/workstation board**
    -   Check notes in ***docs/hardware/kcma-d8.html***
-   **ThinkPad X60/X60s**
    -   You can also remove the motherboard from an X61/X61s and replace
        it with an X60/X60s motherboard. An X60 Tablet motherboard will
        also fit inside an X60/X60s.
-   **ThinkPad X60 Tablet** (1024x768 and 1400x1050) with digitizer
    support
    -   See ***docs/hardware/\#supported\_x60t\_list*** for list of supported
        LCD panels
    -   It is unknown whether an X61 Tablet can have it's mainboard
        replaced with an X60 Tablet motherboard.
-   **ThinkPad T60** (Intel GPU) (there are issues; see below):
    -   See notes below for exceptions, and
        ***docs/hardware/\#supported\_t60\_list*** for known working LCD
        panels.
    -   It is unknown whether a T61 can have it's mainboard replaced
        with a T60 motherboard.
    -   See ***docs/future/\#t60\_cpu\_microcode***.
    -   T60p (and T60 laptops with ATI GPU) will likely never be
        supported: ***docs/hardware/\#t60\_ati\_intel***
-   **ThinkPad X200**
    -   X200S and X200 Tablet are also supported, conditionally; see
        ***docs/hardware/x200.html\#x200s***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **ThinkPad R400**
    -   See ***docs/hardware/r400.html***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **ThinkPad T400**
    -   See ***docs/hardware/t400.html***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **ThinkPad T500**
    -   See ***docs/hardware/t500.html***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **Apple MacBook1,1** (MA255LL/A, MA254LL/A, MA472LL/A)
    -   See ***docs/hardware/\#macbook11***.
-   **Apple MacBook2,1** (MA699LL/A, MA701LL/A, MB061LL/A, MA700LL/A,
    MB063LL/A, MB062LL/A)
    -   See ***docs/hardware/\#macbook21***.

Changes for this release, relative to r20150518 (earliest changes last, recent changes first)
---------------------------------------------------------------------------------------------

-   NEW BOARDS ADDED:
    -   ASUS Chromebook C201 (ARM laptop) (thanks to Paul Kocialkowski)
    -   Gigabyte GA-G41M-ES2L motherboard (desktop) (thanks to Damien
        Zammit)
    -   Intel D510MO motherboard (desktop) (thanks to Damien Zammit)
    -   ASUS KCMA-D8 motherboard (desktop) (thanks to Timothy Pearson)
    -   ASUS KFSN4-DRE motherboard (server) (thanks to Timothy Pearson)
    -   ASUS KGPE-D16 motherboard (server) (thanks to Timothy Pearson)

For details development history on these boards, refer to the git log
and documentation.

For boards previously supported, many fixes from upstream have been
merged.

Other changes (compared to libreboot 20150518), for libreboot in general
or for previously supported systems: (this is a summary. For more
detailed change list, refer to the git log)

256MiB VRAM allocated on GM45 (X200, T400, T500, R400) instead of 32MiB.
This is an improvement over both Lenovo BIOS and Libreboot 20150518,
allowing video decoding at 1080p to be smoother. (thanks Arthur Heymans)
To clarify, GM45 video performance in libreboot 20160818 is better than
on the original BIOS and the previous libreboot release.

64MiB VRAM on i945 (X60, T60, MacBook2,1) now supported in
coreboot-libre, and used by default (in the previous release, it was
8MiB allocated). Thanks to Arthur Heymans.

Higher battery life on GM45 (X200, T400, T500, R400) due to higher
cstates now being supported (thanks Arthur Heymans). C4 power states
also supported.

Higher battery life on i945 (X60, T60, MacBook2,1) due to better CPU
C-state settings. (Deep C4, Dynamicl L2 shrinking, C2E).

Text mode on GM45 (X200, T400, T500, R400) now works, making it possible
to use MemTest86+ comfortably. (thanks to Nick High from coreboot)

Dual channel LVDS displays on GM45 (T400, T500) are now automatically
detected in coreboot-libre. (thanks Vladimir Serbinenko from coreboot)

Partial fix in coreboot-libre for GRUB display on GM45, for dual channel
LVDS higher resolution LCD panels (T400, T500). (thanks Arthur Heymans)

Massively improved GRUB configuration, making it easier to boot more
encrypted systems automatically, and generally a more useful menu for
booting the system (thanks go to Klemens Nanni of the autoboot project).
Libreboot now uses the grub.cfg provided by the installed GNU+Linux
distribution automatically, if present, switching to that configuration.
This is done across many partitions, where libreboot actively searches
for a configuration file (also on LVM volumes and encrypted volumes).
This should make libreboot more easy to use for non-technical users,
without having to modify the GRUB configuration used in libreboot.

Utilities archives is now source only. You will need to compile the
packages in there (build scripts included, and a script for installing
build dependencies). (binary utility archives are planned again in the
next release, when the new build system is merged)

SeaGRUB is now the default payload on all x86 boards. (SeaBIOS
configured to load a compressed GRUB payload from CBFS immediately,
without providing an interface in SeaBIOS. This way, GRUB is still used
but now BIOS services are available, so you get the best of both
worlds). Thanks go to Timothy Pearson of coreboot for this idea.

crossgcc is now downloaded and built as a separate module to
coreboot-libre, with a universal revision used to build all boards.

Individual boards now have their own coreboot revision and patches,
independently of each other board. This makes maintenance easier.

Updated all utilities, and modules (coreboot, GRUB, etc) to newer
versions, with various bugfixes and improvements upstream.

RTC century byte issue now fixed on GM45 in coreboot-libre, so the date
should now be correctly displayed when running the latest linux kernel,
instead of seeing 1970-01-01 when you boot (thanks to Alexander Couzens
from coreboot)

Build system now uses multiple CPU cores when building, speeding up
building for some people. Manually specifying how many cores are needed
is also possible, for those using the build system in a chroot
environment. (thanks go to Timothy Pearson from coreboot)

In the build system (git repository), https:// is now used when cloning
coreboot. http:// is used as a fallback for GRUB, if git:// fails.

New payload, the depthcharge bootloader (free bootloader maintained by
Google) for use on the ASUS Chromebook C201. (thanks go to Paul
Kocialkowski)

Various fixes to the ich9gen utility (e.g. flash component density is
now set correctly in the descriptor, gbe-less descriptors now supported)

Release 20150518 {#release20150518}
================

Release date: 18th May 2015.

Installation instructions can be found at ***docs/install/***. Building
instructions (for source code) can be found at ***docs/git/\#build***.

Machines supported in this release:
-----------------------------------

-   **ThinkPad X60/X60s**
    -   You can also remove the motherboard from an X61/X61s and replace
        it with an X60/X60s motherboard. An X60 Tablet motherboard will
        also fit inside an X60/X60s.
-   **ThinkPad X60 Tablet** (1024x768 and 1400x1050) with digitizer
    support
    -   See ***docs/hardware/\#supported\_x60t\_list*** for list of supported
        LCD panels
    -   It is unknown whether an X61 Tablet can have it's mainboard
        replaced with an X60 Tablet motherboard.
-   **ThinkPad T60** (Intel GPU) (there are issues; see below):
    -   See notes below for exceptions, and
        ***docs/hardware/\#supported\_t60\_list*** for known working LCD
        panels.
    -   It is unknown whether a T61 can have it's mainboard replaced
        with a T60 motherboard.
    -   See ***docs/future/\#t60\_cpu\_microcode***.
    -   T60p (and T60 laptops with ATI GPU) will likely never be
        supported: ***docs/hardware/\#t60\_ati\_intel***
-   **ThinkPad X200**
    -   X200S and X200 Tablet are also supported, conditionally; see
        ***docs/hardware/x200.html\#x200s***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **ThinkPad R400**
    -   See ***docs/hardware/r400.html***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **ThinkPad T400**
    -   See ***docs/hardware/t400.html***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **ThinkPad T500**
    -   See ***docs/hardware/t500.html***
    -   **ME/AMT**: libreboot removes this, permanently.
        ***docs/hardware/gm45\_remove\_me.html***
-   **Apple MacBook1,1** (MA255LL/A, MA254LL/A, MA472LL/A)
    -   See ***docs/hardware/\#macbook11***.
-   **Apple MacBook2,1** (MA699LL/A, MA701LL/A, MB061LL/A, MA700LL/A,
    MB063LL/A, MB062LL/A)
    -   See ***docs/hardware/\#macbook21***.

Changes for this release, relative to r20150208 (earliest changes last, recent changes first)
---------------------------------------------------------------------------------------------

-   Add a whitelist entry to board\_enable.c in flashrom, for the
    ThinkPad R400, T400 and T500
-   Updated flashrom (to SVN revision 1889)
    -   X200 whitelist patch removed (merged upstream)
    -   X200 whitelist modified to include X200S and X200 Tablet
-   libreboot\_util: don't include cmos layout files (not needed
    anymore)
-   **coreboot-libre: backport patches for X200 Tablet digitizer
    support**
-   build/release/archives: create SHA512 sum manifest file of the
    release archives
-   build/release/archives: separate crossgcc into a new archive
-   disabled generation of txtmode ROM images for now (they will be back
    again in the next release)
-   coreboot-libre: delete unused code (reduce size of src archive)
-   Flashing guides: make them more friendly to colourblind people
-   docs/gnulinux/encrypted\_\*.html: Remove mention of password
    length - it was arbitrary and pointless.
-   docs/maintain/: Finish the guide
-   scripts/download/coreboot: use diffs included in libreboot, not
    external gerrit cherry-picks - review.coreboot.org (gerrit) being
    down no longer kills libreboot (backup mirrors of the master
    repository exist)
-   docs/install/bbb\_setup.html: Add info about wp/hold and pinouts
-   docs/: improve the description of libreboot
-   docs/hardware/gm45\_remove\_me.html: notes about the demefactory utility
-   docs/install/bbb\_setup.html: EHCI debug: recommend linux-libre
-   docs/install/bbb\_setup.html: EHCI Debug logging setup guide
-   docs/hardware/t500.html: Add screen compatibility report (TODO: fix
    incompatible screens)
-   Update coreboot(again) + merge GM45 hybrid GPU patches - means that
    T400/T500 with the ATI+Intel hybrid GPU setup will work (ATI
    disabled, Intel permanently enabled). power\_on\_after\_fail nvram
    option added to all GM45 boards, defaulting to No, so that plugging
    it AC doesn't boot up the system against the users will. Net20DC is
    now the default debug dongle on all boards (compatible with BBB).
-   demefactory (new utility): create GM45 factory.rom without the ME
-   ich9deblob: re-factor descriptor.c functions
-   docs/hardware/t500.html: add hardware logs
-   docs/gnulinux/encrypted\_\*.html: No password for default entry
-   docs/git/: Add more details about BUC.TS
-   grub.cfg: Also scan for grub2/grub.cfg, not just grub/grub.cfg
-   docs/maintain/ (new section. WIP!): Maintaining libreboot
-   docs/gnulinux/grub\_boot\_installer.html: Fix hazardous instruction
-   docs/tasks.html: Better categorization between intel/amd/arm
-   docs/install/bbb\_setup.html: notes about SPI flashing stability
-   docs/install/bbb\_setup.html: more names for the 0.1" cables
-   docs/install/\*\_external.html: add disclaimer about thermal paste
-   docs/install/bbb\_setup.html: Fix broken links
-   docs/install/bbb\_setup.html: preliminary notes about EHCI debug
-   docs/hardware/gm45\_remove\_me.html: Link to websites talking about the
    ME
-   docs/install/{t400,t500,r400}\_external.html: Notes about CPU
    compatibility
-   Delete the ich9macchange script. It's useless, and confuses people
-   docs/hardware/gm45\_remove\_me.html: prioritize ich9gen executable path
-   docs/hardware/gm45\_remove\_me.html: prioritize changing mac address
-   docs/hardware/gm45\_remove\_me.html: less confusing notes about ich9gen
-   build/dependencies/parabola: Add dependencies for x86\_64
-   scripts/dependencies/paraboladependencies: build dependencies
    (32-bit Parabola)
-   **New board**: ThinkPad T500
-   Add diffs for descriptor/gbe differences between T500 and X200
-   coreboot-libre: provide better blob categorization
-   docs/hardware/gm45\_remove\_me.html: add notes about flash write protect
-   **New board**: ThinkPad T400
-   GRUB: add partial vesamenu.c32 support (fixes tails ISOLINUX menu)
-   Update GRUB (to revision fa07d919d1ff868b18d8a42276d094b63a58e299)
-   Update coreboot (to revision
    83b05eb0a85d7b7ac0837cece67afabbdb46ea65)
    -   Intel CPU microcode (most of it) no longer deleted, because it
        was deleted upstream (moved to a 3rd party repository).
    -   MacBook2,1 cstate patch is no longer cherry picked (merged
        upstream)
    -   Patch to disable use of timestamps in coreboot no longer
        included (merged upstream)
-   coreboot-libre: don't list vortex86ex kbd firmware as microcode
    (list it separately)
-   coreboot-libre: don't rm \*/early\_setup\_ss.h (these are not
    blobs)
-   coreboot-libre: add GPLv3 license to the findblobs script
-   coreboot-libreboot: don't rm raminit\_tables (nahelem/sandybridge)
    (they are not blobs)
-   coreboot-libre: don't delete the .spd.hex files (they are not
    blobs)
-   build/release/archives: don't put rmodtool in libreboot\_util
-   docs/install/x200\_external.html: recommend installing GNU+Linux at
    the end
-   docs/install/x200\_external.html: add more photos, improve
    instructions
-   build/clean/grub: use distclean instead of clean
-   grub-assemble: Add the *bsd* and *part\_bsd* modules
-   build/roms/withgrub: Only run ich9gen if gm45/gs45 images exist
-   docs/git/: Add notes about building for specific boards
-   build/roms/withgrub: Allow building for a custom range of boards
-   grub-assemble: Disable verbose output
-   Add documentation on how to unlock root encrypted fs with key in
    initramfs in Parabola Linux
-   docs/gnulinux/grub\_cbfs.html: Improve structure (easier to use)
-   grub.cfg: Disable the beep on startup
-   docs/install/bbb\_setup.html: Make the guide easier to use
-   docs/gnulinux/grub\_cbfs.html: Remove redundant instructions
-   docs/install/x200\_external.html: Mark pins in the images
-   docs/install/bbb\_setup.html: Replace 3.3V PSU photo with ATX PSU
-   docs/hardware/x200.html: Add dumps from 4-MiB X200 with Lenovo BIOS 3.22
-   docs/hardware/x200.html: Add dumps from 4-MiB X200 with Lenovo BIOS 3.18
-   grub.cfg: add syslinux\_configfile menuentry for ahci0
-   grub.cfg: Add more paths for syslinux\_configfile
-   docs/future.html: T60: Add EDID dump from LG-Philips LP150E05-A2K1
-   docs/install/bbb\_setup.html: Further clarify which clip is needed
-   bash scripts: Make script output more user-friendly in general
-   bash scripts: Only enable verbose output if DEBUG= is used
-   build: Support multiple extra options - now possible to build
    multiple images for arbitrary boards (configs), but without building
    the entire collection.
-   Deleted the signing archive key - the finger print and ID is given
    instead, so that the user can download it from a key server
-   scripts/helpers/build/release: Move docs to separate archive -
    reduces the size of the other archives considerably
-   Move DEBLOB to resources/utilities/coreboot-libre/deblob
-   scripts/helpers/build/release: Delete DEBLOB from libreboot\_src/ -
    not needed in libreboot\_src (release archive) because it contains a
    coreboot revision that has already been deblobbed.
-   flash (script): Use *build* instead of *DEBLOB* to know if in src
-   docs/install/r400\_external.html: Show images, don't link.
-   docs/install/x200\_external.html: Show images, don't link.
-   docs/install/bbb\_setup.html: Show images, instead of linking
-   Documentation: optimize all images (reduce file sizes)
-   Remove download links from the release page (and the archive page) -
    release archives are hosted differently following this release,
    which means that the old methods are no longer viable.
-   Moved ich9macchange to resources/scripts/misc/ich9macchange
-   ich9macchange: assume that the script is being run from \_util (act
    only on one ROM image, defined by a user-provided path)
-   Move grub-background to resources/scripts/misc/grub-background
-   grub-background: assume that it is being run from libreboot\_util
-   grub-background: change only one ROM image, specified by path
-   build (release archives): Add the commitid file to release/
-   build-release: Move the release archives to release/
-   Merge all build scripts into a single generic script, with helpers
    in resources/scripts/helpers/build/
-   Replace *getall* with *download*, which takes as input an argument
    specifying which program the user wants to download.
-   Moved the get scripts to resources/scripts/helpers/download/
-   build-release: Remove the powertop entries
-   Documentation: general improvements to the flashing instructions
-   Merged all flashing scripts into a single script
-   Updated GRUB
-   bucts: Make it build without git
-   Moved dejavu-fonts-ttf-2.34/AUTHORS to resources/grub/font/
-   Deleted GRUB Invaders from libreboot
-   Deleted SeaBIOS from libreboot
-   build-release: optimize use of tar (reduced file sizes)
-   grub.cfg: add another SYSLINUX config location
    (/syslinux/syslinux.cfg)
-   build-release: remove the bin/ directory from libreboot\_util
-   cleandeps: delete the bin/ directory
-   buildrom-withgrub: create the bin directory if it does not exist
-   coreboot-libre: don't use git for version timestamp
-   i945-pwm: add clean command to Makefile
-   i945-pwm: add -lz to Makefile
-   docs/install/x200\_external: Mention GPIO33 non-descriptor mode
-   docs/hardware/: Remove redundant links
-   ich9macchange: Add R400
-   build-release: Separate ROM images into individual archives
-   build-release: rename libreboot\_bin to libreboot\_util
-   **New board:** ThinkPad R400 support added to libreboot.
-   bbb\_setup.html: tell user to use libreboot's own flashrom

Release 20150124, 20150126 and 20150208 {#release20150124}
=======================================

Release date: 24th January 2015.

Machines supported in this release:
-----------------------------------

-   **Lenovo ThinkPad X60/X60s**
    -   You can also remove the motherboard from an X61/X61s and replace
        it with an X60/X60s motherboard. An X60 Tablet motherboard will
        also fit inside an X60/X60s.
-   **Lenovo ThinkPad X60 Tablet** (1024x768 and 1400x1050) with
    digitizer support
    -   See **hardware/\#supported\_x60t\_list** for list of supported LCD
        panels
    -   It is unknown whether an X61 Tablet can have it's mainboard
        replaced with an X60 Tablet motherboard.
-   **Lenovo ThinkPad T60** (Intel GPU) (there are
    issuesinstall/x200\_external.html; see below):
    -   See notes below for exceptions, and
        **hardware/\#supported\_t60\_list** for known working LCD panels.
    -   It is unknown whether a T61 can have it's mainboard replaced
        with a T60 motherboard.
    -   See **future/\#t60\_cpu\_microcode**.
    -   T60p (and T60 laptops with ATI GPU) will likely never be
        supported: **hardware/\#t60\_ati\_intel**
-   **Lenovo ThinkPad X200**
    -   X200S and X200 Tablet are also supported, conditionally; see
        **hardware/x200.html\#x200s**
    -   **ME/AMT**: libreboot removes this, permanently.
        **hardware/gm45\_remove\_me.html**
-   **Lenovo ThinkPad R400** (r20150208 and later, only)
    -   **ME/AMT**: libreboot removes this, permanently.
        **hardware/gm45\_remove\_me.html**
-   **Apple MacBook1,1** (MA255LL/A, MA254LL/A, MA472LL/A)
    -   See **hardware/\#macbook11**.
-   **Apple MacBook2,1** (MA699LL/A, MA701LL/A, MB061LL/A, MA700LL/A,
    MB063LL/A, MB062LL/A)
    -   See **hardware/\#macbook21**.

Revisions for r20150208 (relative to r20150126)
-----------------------------------------------

This is a maintenance release (polishing) based on r20150126. Users who
installed r20150126 don't really need to update to this release.

-   buildrom-withgrub: use gnulove.jpg background on 16:10 laptops
    (MacBook2,1 and X200)
-   build-release: include grub-background script in libreboot\_bin
-   grub-background (new): lets user change GRUB background image
-   grub-assemble: Add link to original utility.
-   buildrom-withgrub: Put background.jpg in CBFS, not GRUB memdisk
-   grub-assemble: merge scripts into a single script gen.sh
-   Documentation: implement theme, drastically improve readability
-   docs/hardware/: update list of compatible T60 LCD panels
-   docs/: more clarification of libreboot's stated purpose.
-   build-release: include the commitid file in the release archives
-   docs/: Further emphasize the GNU+Linux requirement.
-   lenovobios\_firstflash: fix BASH errors
-   lenovobios\_secondflash: fix BASH errors
-   docs/install/x200\_external.html: Tell user to switch MAC address.
-   docs/git/: Add to the list of x86\_64 compatible hosts.
-   docs/install/: Remove old (obsolete) information.
-   docs/git/: Say that the build dependencies are for src (and not
    nedeed for libreboot\_bin)
-   build: re-factor the descriptor/gbe generating loop for GM45/ICH9M
-   X60, X60S and X60 Tablet now the same ROM images.
-   Add QEMU (q35/ich9) support to libreboot.
-   Add QEMU (i440fx/piix4) support to libreboot
-   docs/: Re-write the description of what libreboot is.
-   docs/release.html: Add notes about how to use GPG.
-   build-release: delete the commitid file from release archives
-   build-release: create file named commitid after build-release

Revisions for r20150126 (relative to r20150124)
-----------------------------------------------

This is a bug fix release based on r20150124. It contains a few small
changes:

-   grub.cfg: hardcode the list of partitions to search (speeds up
    booting considerably. GRUB regexp isn't very well optimized)
-   Docs (x200.html hcl): Remove incorrect information
-   Documentation (bbb\_setup.md): Fix typos
-   build-release: delete ich9fdgbe\_{4m,8m}.bin files from ich9gen
    -   These were accidentically included in the r20150124 release.
        They are generated from ich9gen so it's ok, but they don't
        need to be in the archive.
-   Documentation (grub\_cbfs.md): Looping in libreboot\_grub.cfg (Add
    notes about it if the user copied from grub.cfg in CBFS.)

Changes for this release (latest changes first, earliest changes last)
----------------------------------------------------------------------

-   grub.cfg: Added (ahci1) to list of devices for ISOLINUX parser
    (CD/DVD) (this is needed for the X200 docking station).
-   grub.cfg: ISOLINUX parsing is now done on all USB partitions.
-   grub.cfg: Automatically switched to /boot/grub/libreboot\_grub.cfg
    on a partition, if it exists.
-   libreboot\_bin: added static ARM binaries for flashrom, cbfstool,
    ich9gen and ich9deblob (tested on beaglebone black).
-   Flashrom: removed redundant Macronix flashchip definitions (for X200
    owners).
-   Flashrom: added whitelist for ThinkPad X200.
-   X200: fixed uneven backlight (at low levels)
-   ich9macchange (new script, uses ich9gen): for changing the default
    MAC address on X200 ROM images.
-   ich9gen: added capability to change the default MAC address (and
    update the checksum)
-   ich9deblob: added new utility ich9gen: this can generate a
    descriptor+gbe image without a factory.rom dump present.
-   Modified ich9deblob to use a struct for Gbe, documenting everything.
-   Massively updated the ich9deblob utility: re-factored everything
    completely.
-   Enabled cstates 1 and 2 on macbook21. This reduces idle heat / power
    consumption.
-   buildrom-withgrub: disabled creation of \*txtmode\*.rom for X200
    (only framebuffer graphics work)
-   Updated SeaBIOS (again)
-   docs/install/\#flashrom\_x200: improve instructions
-   Updated flashrom (again) - patches updated
-   Updated GRUB (again)
-   Updated coreboot (again)
-   build-release: not all files were copied to libreboot\_src. fix
    that.
-   build-release: include cbmem (statically compiled) in libreboot\_bin
-   Documentation (X200): added software-based flashing instructions
-   Documentation: remove all references to the bus pirate (replaced
    with BBB flashing tutorials)
-   **New board:** ThinkPad X200S and X200 Tablet support added to
    libreboot
-   build: automatically find board names (configs) to build for
-   **New board:** ThinkPad X200 support added to libreboot
-   coreboot-libre config (all boards): enable USB dongle log output
    (for BeagleBone Black)
-   cleandeps: actually clean grubinvaders
-   .gitignore: add powertop directory
-   cleandeps: clean i945-pwm utility
-   scripts (all): fix typos
-   Documentation: general cleanup.
-   builddeps-flashrom: reduce build commands to a single for loop
-   scripts (all): replace unnecessary rm -Rf with rm -f
-   docs/release.html: add lenovo g505s to the list of candidates
-   .gitignore: add libreboot\_bin.tar.xz and libreboot\_src.tar.xz
-   libreboot\_bin.tar.xz: Include utils as statically linked binaries
    -   This means that the user does not have to install build
        dependency or build from source anymore.
-   deps-parabola (removed) Remove Parabola dependencies script. Will
    re-add later (properly tested)
-   grub.cfg: Add more path checks to isolinux parser (more ISOs should
    work now)
-   Update SeaBIOS
-   x60flashfrom5 (new), for X60 users upgrading from 5th/early release
-   Update flashrom
-   Update GRUB
-   Updated coreboot-libre
    -   i945: permanently set tft\_brightness to 0xff (fixes bug on X60
        where turning up brightness at max would make it loop back to
        low brightness)
-   getcb: Revert X60/T60 to legacy backlight controls
    -   The ACPI brightness patches were abandoned and obsolete.
-   grub.cfg: Only load initrd.img if it exists. Add rw to linux line
    (for ProteanOS)
-   build: Only generate the GRUB configurations once (re-use on all
    images)
-   Only build 2 GRUB payload executables, re-use on all boards.
-   resources/utilities/grub-assemble/gen.txtmode.sh: Use GNU BASH\
    resources/utilities/grub-assemble/gen.vesafb.sh: Use GNU BASH
-   scripts (error handling): Replace exit with exit 1 (make debugging
    easier)
-   Move most files in CBFS to GRUB memdisk, except grub.cfg and
    grubtest.cfg
-   docs/release.html Add DMP vortex86ex to list of candidates.
-   docs/release.html Add ThinkPad X201 to list of candidates.
-   New links added to docs/security/x60\_security and
    docs/security/t60\_security
-   lenovobios\_secondflash: Warn if BUCTS is not present. (not a
    dealbreaker. Can just pull out nvram battery/coin).
-   lenovobios\_firstflash: Fail if BUCTS fails. (anti-bricking
    precaution)
-   Removed obnoxious warnings from flashing scripts, improved
    documentation instead.
-   scripts (all): add proper error checking (fail fast, fail early. Do
    not continue if there are errors)
-   buildrom-withgrub: rename image to boardname\_layout\_romtype.rom
-   buildrom-withgrub: don't move cbfstool, execute directly
-   resources/utilities/grub-assemble: add French Dvorak (BEPO) keyboard
    layout.
-   Documentation: add docs/hardware/x60\_keyboard.html (show how to
    replace keyboard on X60/X60T)
-   Documentation: major cleanup (better structure, easier to find
    things)
-   docs/release.html: Remove Acer CB5 from list of future candidates.
    -   Too many issues. Chromebooks are crippled (soldered
        RAM/storage/wifi) and have too many usability issues for the
        libreboot project.
-   docs/gnulinux/grub\_cbfs.html Major cleanup. Usability improvements.
-   flash (flashrom script): remove boardmismatch=force
    -   This was put there before for users upgrading from libreboot r5
        to r6, but also allows the user to flash the wrong image. For
        example, the user could flash a T60 image on an X60, thus
        bricking the system. It's almost certain that most people have
        upgraded by now, so remove this potentially dangerous option.
-   Documentation: update compatibility list for X60T LCD panels.
-   docs/release.html: add note about X60 Tablet board in X60/X60s
-   docs/howtos/grub\_boot\_installer.html: small corrections
-   docs/howtos/grub\_boot\_installer.html: improved readability, fixed
    html errors
-   Documentation (macbook21 related): clean up

Release 20141015 {#release20141015}
================

Machines supported in this release:
-----------------------------------

-   **Lenovo ThinkPad X60/X60s**
    -   You can also remove the motherboard from an X61/X61s and replace
        it with an X60/X60s motherboard. An X60 Tablet motherboard will
        also fit inside an X60/X60s.
-   **Lenovo ThinkPad X60 Tablet** (1024x768 and 1400x1050) with
    digitizer support
    -   See **hardware/\#supported\_x60t\_list** for list of supported LCD
        panels
    -   It is unknown whether an X61 Tablet can have its mainboard
        replaced with an X60 Tablet motherboard.
-   **Lenovo ThinkPad T60** (Intel GPU) (there are issues; see below):
    -   See notes below for exceptions, and
        **hardware/\#supported\_t60\_list** for known working LCD panels.
    -   It is unknown whether a T61 can have its mainboard replaced with
        a T60 motherboard.
    -   See **future/\#t60\_cpu\_microcode**.
    -   T60p (and T60 variants with ATI GPU) will likely never be supported:
        **hardware/\#t60\_ati\_intel**
-   **Apple MacBook1,1** (MA255LL/A, MA254LL/A, MA472LL/A)
    -   See **hardware/\#macbook11**.
-   **Apple MacBook2,1** (MA699LL/A, MA701LL/A, MB061LL/A, MA700LL/A,
    MB063LL/A, MB062LL/A)
    -   See **hardware/\#macbook21**.

Changes for this release (latest changes first, earliest changes last)
----------------------------------------------------------------------

-   Updated coreboot (git commit
    8ffc085e1affaabbe3dca8ac6a89346b71dfc02e), the latest at the time of
    writing.
-   Updated SeaBIOS (git commit
    67d1fbef0f630e1e823f137d1bae7fa5790bcf4e), the latest at the time of
    writing.
-   Updated Flashrom (svn revision 1850), the latest at the time of
    writing.
-   Updated GRUB (git commit 9a67e1ac8e92cd0b7521c75a734fcaf2e58523ad),
    the latest at the time of writing.
-   Cleaned up the documentation, removed unneeded files.
-   ec/lenovo/h8 (x60/x60s/x60t/t60): Enable
    wifi/bluetooth/wwan/touchpad/trackpoint by default.
-   Documentation: Updated list of T60 LCDs (Samsung LTN150XG 15" XGA
    listed as non-working).
-   builddeps-coreboot: Don't build libpayload (not needed. This was
    leftover by mistake, when trying out the TINT payload).
-   Replaced most diff files (patches) for coreboot with gerrit
    checkouts (cherry-pick).
-   Documentation: x60\_security.html and t60\_security.html: added
    links to info about the ethernet controller (Intel 82573).
-   Documentation: x60\_security.html and t60\_security.html: added
    notes about DMA and the docking station.
-   Documentation: configuring\_parabola.html: basic post-install steps
    for Parabola GNU+Linux (helpful, since libreboot development is
    being moved to Parabola at the time of writing).
-   builddeps-coreboot: use 'make crossgcc-i386' instead of 'make
    crossgcc'. Libreboot only targets x86 at the time of writing.
-   ROM images no longer include SeaBIOS. Instead, the user adds it
    afterwards. Documentation and scripts updated.
-   docs/images/encrypted\_parabola.html: Notes about linux-libre-grsec
-   Documentation: encrypted\_parabola.html: add tutorial for encrypted
    Parabola GNU+Linux installation.
-   Documentation: added more info about wifi chipsets

6th release (pre-release, 7th beta) {#release20140911}
===================================

-   Released 11th July 2014 (pre-release) 1st beta
-   Revised (pre-release, 2nd beta) 16th July 2014
-   Revised (pre-release, 3rd beta) 20th July 2014
-   Revised (pre-release, 4th beta) 29th July 2014
-   Revised (pre-release, 5th beta) 11th August 2014 (corrected 11th
    August 2014)
-   Revised (pre-release, 6th beta) 3rd September 2014
-   Revised (pre-release, 7th beta) 11th September 2014

Machines still supported (compared to previous release):
--------------------------------------------------------

-   **Lenovo ThinkPad X60/X60s**
    -   You can also remove the motherboard from an X61/X61s and replace
        it with an X60/X60s motherboard.

New systems supported in this release:
--------------------------------------

-   **Lenovo ThinkPad X60 Tablet** (1024x768 and 1400x1050) with
    digitizer support
    -   See **hardware/\#supported\_x60t\_list** for list of supported LCD
        panels
    -   It is unknown whether an X61 Tablet can have its mainboard
        replaced with an X60 Tablet motherboard.
-   **Lenovo ThinkPad T60** (Intel GPU) (there are issues; see below)
    -   See notes below for exceptions, and
        **hardware/\#supported\_t60\_list** for known working LCD panels.
    -   It is unknown whether a T61 can have its mainboard replaced with
        a T60 motherboard.
    -   T60p (and T60 variants with ATI GPU) will likely never be supported:
        **hardware/\#t60\_ati\_intel**
-   **Apple MacBook1,1** (MA255LL/A, MA254LL/A, MA472LL/A)
    -   See **hardware/\#macbook11**.
-   **Apple MacBook2,1** (MA699LL/A, MA701LL/A, MB061LL/A, MA700LL/A,
    MB063LL/A, MB062LL/A)
    -   See **hardware/\#macbook21**.

Machines no longer supported (compared to previous release):
------------------------------------------------------------

-   **All previous systems still supported!**

Revisions for r20140911 (7th beta) (11th September 2014)
--------------------------------------------------------

-   The changes below were made in a git repository, unlike in previous
    releases. Descriptions below are copied from 'git log'.
-   Update .gitignore for new dependencies.
-   Use a submodule for i945-pwm.
-   Don't clean packages that fail or don't need cleaning.
-   Don't clean i945-pwm, it's not needed.
-   Regression fix: Parabola live ISO boot issues
-   Re-enable background images in ISOLINUX/SYSLINUX GRUB parser menus
-   Regression fix: Re-add CD-ROM (ata0) in GRUB
-   Documentation: add notes about performance penalty when using
    ecryptfs.
-   Documentation: Fixed spelling and grammatical errors.
-   Documentation: macbook21: add new system as tested
-   Documentation: macbook21: add info about improving touchpad
    sensitivity
-   Documentation: X60 Tablet: add more information about finger input
-   Documentation: release.html: Add information about recently merged
    commit in coreboot

Revisions for r20140903 (6th beta) (3rd September 2014)
-------------------------------------------------------

-   Added modified builddeb\* scripts for Parabola GNU+Linux-libre:
    buildpac, buildpac-flashrom, buildpac-bucts (courtesy of Noah
    Vesely)
-   Documentation: updated all relevant areas to mention use of
    buildpac\* scripts for Parabola users.
-   Documentation: added information showing how to enable or disable
    bluetooth on the X60
-   MacBook1,1 tested! See **hardware/\#macbook11**
-   Documentation: fixed typo in \#get\_edid\_panelname (get-edit
    changed to get-edid)
-   Documentation: added images/x60\_lcd\_change/ (pics only for now)
-   Added gcry\_serpent and gcry\_whirlpool to the GRUB module list in
    the 'build' script (for luks users)
-   **Libreboot is now based on a new coreboot version from August 23rd,
    2014:\
    Merged commits (relates to boards that were already supported in
    libreboot):**
    -   <http://review.coreboot.org/#/c/6697/>
    -   <http://review.coreboot.org/#/c/6698/> (merged already)
    -   <http://review.coreboot.org/#/c/6699/> (merged already)
    -   <http://review.coreboot.org/#/c/6696/> (merged already)
    -   <http://review.coreboot.org/#/c/6695/> (merged already)
    -   **<http://review.coreboot.org/#/c/5927/> (merged already)**
    -   <http://review.coreboot.org/#/c/6717/> (merged already)
    -   <http://review.coreboot.org/#/c/6718/> (merged already)
    -   <http://review.coreboot.org/#/c/6723/> (merged already)
        (text-mode patch, might enable memtest. macbook21)
    -   <http://review.coreboot.org/#/c/6732/> (MERGED) (remove useless
        ps/2 keyboard delay from macbook21. already merged)
-   These were also merged in coreboot (relates to boards that libreboot
    already supported):
    -   <http://review.coreboot.org/#/c/5320/> (merged)
    -   <http://review.coreboot.org/#/c/5321/> (merged)
    -   <http://review.coreboot.org/#/c/5323/> (merged)
    -   <http://review.coreboot.org/#/c/6693/> (merged)
    -   <http://review.coreboot.org/#/c/6694/> (merged)
    -   <http://review.coreboot.org/#/c/5324/> (merged)
-   Documentation: removed the section about tft\_brightness on X60 (new
    code makes it obsolete)
-   Removed all patches from resources/libreboot/patch/ and added new
    patch: 0000\_t60\_textmode.git.diff
-   Updated getcb script and DEBLOB script.
-   Updated configuration files under resources/libreboot/config/ to
    accomodate new coreboot version.
-   Removed grub\_serial\*.cfg and libreboot\_serial\*.rom, all
    configs/rom files are now unified (containing same configuration as
    serial rom files from before).
    -   Documentation: updated \#rom to reflect the above.
-   Updated GRUB to new version from August 14th, 2014.
-   Unified all grub configurations for all systems to a single grub.cfg
    under resources/grub/config/
-   Updated flashrom to new version from August 20th, 2014
-   Added getseabios and builddeps-seabios (builddeps and getall were
    also updated)
    -   Added instructions to 'buildrom-withgrub' to include
        bios.bin.elf and vgaroms/vgabios.bin from SeaBIOS inside the
        ROM.
-   Added seabios (and sgavgabios) to grub as payload option in menu
-   Disabled serial output in Memtest86+ (no longer needed) to speed up
    tests.
    -   MemTest86+ now works properly, it can output on the laptop
        screen (no serial port needed anymore).
-   Added getgrubinvaders, builddeps-grubinvaders scripts. Added these
    to getall and builddeps.
    -   Added [GRUB Invaders](http://www.coreboot.org/GRUB_invaders)
        menu entry in resources/grub/config/grub.cfg
-   Added rules to builddeps-coreboot to build libpayload with
    TinyCurses. (added appropriate instructions to cleandeps script).
-   Commented out lines in resources/grub/config/grub.cfg for loading
    font/background (not useful anymore, now that GRUB is in text-mode).
-   Commented out lines in buildrom-withgrub that included
    backgrounds/fonts (not useful anymore, now that GRUB is in
    text-mode).
-   Added resources/utilities/i945-pwm/ (from
    git://git.mtjm.eu/i945-pwm), for debugging acpi brightness on i945
    systems.
    -   Added instructions for it in builddeps, builddeps-i945pwm,
        builddeb and cleandeps
-   'build' script: removed the parts that generated sha512sum
    manifests (not needed, since release tarballs are GPG-signed)
-   'build' script: removed the parts that generated libreboot\_meta
    directory (not needed anymore, since \_meta will be hosted in git)
    -   Updated \#build\_meta (and other parts of documentation) to
        accomodate this change.
-   Documentation: simplified (refactored) the notes in \#rom
-   'build' script: removed the parts that generated libreboot\_bin
    and added them to a new script: 'build-release'
    -   Documentation: \#build updated to reflect the above.
-   ~~Added all gcry\_\* modules to grub (luks/cryptomount):
    gcry\_arcfour gcry\_camellia gcry\_crc gcry\_dsa gcry\_md4
    gcry\_rfc2268 gcry\_rmd160 gcry\_seed gcry\_sha1 gcry\_sha512
    gcry\_twofish gcry\_blowfish gcry\_cast5 gcry\_des gcry\_idea
    gcry\_md5 gcry\_rijndael gcry\_rsa gcry\_serpent gcry\_sha256
    gcry\_tiger gcry\_whirlpool~~
-   Added GNUtoo's list of GRUB modules (includes all of the gcry\_\*
    modules above), cryptomount should be working now.
-   Removed builddeb-bucts and builddeb-flashrom, merged them with
    builddeb ( updated accordingly)
-   Removed buildpac-bucts and buildpac-flashrom, merged them with
    buildpac ( updated accordingly)
-   Renamed buildpac to deps-parabola ( updated accordingly)
-   Documentation: removed all parts talking about build dependencies,
    replaced them with links to \#build\_dependencies
-   Documentation: emphasized more strongly on the documentation, the
    need to re-build bucts and/or flashrom before flashing a ROM image.
-   build-release: flashrom, nvramtool, cbfstool and bucts are no longer
    provided pre-compiled in binary archives, and are now in source form
    only. (to maximize distro compatibility).
-   'build' script: replaced grub.elf assembly instructons, it is now
    handled by a utility added under resources/utilities/grub-assemble
-   Moved resources/grub/keymap to
    resources/utilities/grub-assemble/keymap, and updated that utility
    to use it
-   Documentation: removed useless links to pictures of keyboard layouts
    and unmodified layouts.
-   Removed all unused fonts from dejavu-fonts-ttf-2.34/ directory
-   'buildrom-withgrub' script: updated it to create 2 sets of ROMs
    for each system: one with text-mode, one with coreboot framebuffer.
-   Documentation: updated \#rom to reflect the above
-   Deleted unused README and COPYING file from main directory
-   Removed some rm -Rf .git\* instructions from the get\* scripts and
    moved them to build-release script
-   Split up default grub.cfg into 6 parts:
    extra/{common.cfg,txtmode.cfg,vesafb.cfg} and
    menuentries/{common.cfg,txtmode.cfg,vesafb.cfg}
    -   buildrom-withgrub script uses these to generate the correct
        grub.cfg for each type of configuration.
-   grub\_memdisk.cfg (used inside grub.elf) now only loads grub.cfg
    from cbfs. It no longer enables serial output or sets prefix.
    (menuentries/common.cfg does instead)
-   resources/grub/config/extra/common.cfg, added:
    -   insmod instructions to load those modules: nativedisk, ehci,
        ohci, uhci, usb, usbserial\_pl2303, usbserial\_ftdi,
        usbserial\_usbdebug
    -   set prefix=(memdisk)/boot/grub
    -   For native graphics (recommended by coreboot wiki):\
        gfxpayload=keep\
        terminal\_output \--append gfxterm
    -   Play a beep on startup:\
        play 480 440 1
-   Documentation: updated gnulinux/grub\_cbfs.html to make it safer
    (and easier) to follow.

Corrections to r20140811 (5th beta) (11th August 2014)
------------------------------------------------------

-   Fixed typo where revision list for 5th beta was listed as March 11th
    2014, when in fact it was August 11th 2014
-   Fixed incorrect grub.cfg that was actually placed in
    resources/grub/config/x60/grub\_usqwerty.cfg which broke the default
    GRUB menu entry on X60

Revisions for r20140811 (5th beta) (11th August 2014)
-----------------------------------------------------

-   build: added 'luks', 'lvm', 'cmosdump' and 'cmostest' to the
    list of modules for grub.elf
-   Documentation: added pics showing T60 unbricking (still need to
    write a tutorial)
-   build: include cmos.layout
    (coreboot/src/mainboard/manufacturer/model/cmos.layout) files in
    libreboot\_bin
-   Documentation: added **install/x60tablet\_unbrick.html**
-   Documentation: added **install/t60\_unbrick.html**
-   Documentation: added **install/t60\_lcd\_15.html**
-   Documentation: added **install/t60\_security.html**
-   Documentation: added **install/t60\_heatsink.html**
-   Documentation: Renamed RELEASE.html to release.html
-   Documentation: removed pcmcia reference in x60\_security.html (it's
    cardbus)
-   Documentation: added preliminary information about randomized seal
    (for physical intrusion detection) in x60\_security.html and
    t60\_security.html
-   Documentation: added preliminary information about
    preventing/mitigating cold-boot attack in x60\_security.html and
    t60\_security.html
-   Documentation: added info to \#macbook21 warning about issues with
    macbook21
-   Documentation: X60/T60: added information about checking custom ROMs
    using dd to see whether or not the top 64K region is duplicated
    below top or not. Advise caution about this in the tutorial that
    deals with flashing on top of Lenovo BIOS, citing the correct dd
    commands necessary if it is confirmed that the ROM has not been
    applied with dd yet. (in the case that the user compiled their own
    ROMs from libreboot, without using the build scripts, or if they
    forgot to use dd, etc).
-   Split resources/libreboot/patch/gitdiff into separate patch files
    (getcb script updated to accomodate this change).
-   Re-added .git files to bucts
-   Fixed the oversight where macbook21\_firstflash wasn't included in
    binary archives
-   Release archives are now compressed using .tar.xz for better
    compression

Revisions for r20140729 (4th beta) (29th July 2014)
---------------------------------------------------

-   Documentation: improved (more explanations, background info) in
    docs/security/x60\_security.html (courtesy of Denis Carikli)
-   MacBook2,1 tested (confirmed)
-   macbook21: Added script 'macbook21\_firstflash' for flashing
    libreboot while Apple EFI firmware is running.
-   Documentation: macbook21: added software-based flashing instructions
    for flashing libreboot while Apple EFI firmware is running.
-   Reduced size of libreboot\_src.tar.gz:
    -   Removed .git and .gitignore from grub directory
        (libreboot\_src); not needed. Removing them reduces the size of
        the archive (by a lot). GRUB development should be upstream.
    -   Removed .git and .gitignore from bucts directory
        (libreboot\_src); not needed. Removing them reduces the size of
        the archive. bucts development should be upstream.
    -   Removed .svn from flashrom directory (libreboot\_src); not
        needed. Removing it reduces the size of the archive. flashrom
        development should be upstream.
-   Added ROMs with Qwerty (Italian) layout in GRUB
    (libreboot\*itqwerty.rom)
-   Added resources/utilities/i945gpu/intel-regs.py for debugging issues
    related to LCD panel compatibility on X60 Tablet and T60. (courtesy
    of [Michał Masłowski](http://mtjm.eu))

Revisions for r20140720 (3rd beta) (20th July 2014)
---------------------------------------------------

-   Fixed typo that existed in 2nd beta where the release date of the
    2nd beta was listed as being in year 2016, when in actual fact it
    was 2014.
-   Documentation: added (preliminary) details about (rare) buggy CPUs
    on the ThinkPad T60 that were found to fail (instability, kernel
    panics, etc) without the microcode updates.
-   Documentation: added docs/hardware/x60\_heatsink.html for showing
    how to change the heatsink on the Thinkpad X60
-   Added ROM images for Azerty (French) keyboard layout in GRUB
    (courtesy of Olivier Mondoloni)
-   Tidied up some scripts:
    -   ~~Re-factored those scripts (made easier to read/maintain):
        build-x60, build-x60t, build-t60, build-macbook21~~
    -   ~~Reduced the number of grub configs to 2 (or 1, for macbook21),
        the build scripts now generate the other configs at build
        time.~~
    -   Deleted build-x60, build-x60t, build-t60, build-macbook21 and
        replaced with intelligent (generic) buildrom-withgrub script
    -   Updated build to use buildrom-withgrub script for building the
        ROM images.
    -   coreboot.rom and coreboot\_serial.rom renamed to
        coreboot\_usqwerty.rom and coreboot\_serial\_usqwerty.rom
    -   coreboot\_dvorak and coreboot\_serial\_dvorak.rom renamed to
        coreboot\_usdvorak.rom and coreboot\_serial\_usdvorak.rom
    -   Renamed coreboot\*rom to libreboot\*rom
    -   Made flash, lenovobios\_firstflash and lenovobios\_secondflash
        scripts fail if the specified file does not exist.
    -   Updated all relevant parts of the documentation to reflect the
        above.
-   Replaced background.png with background.jpg. added gnulove.jpg.
    (resources/grub/background/)
-   Updated buildrom-withgrub to use background.jpg instead of
    background.png
-   Updated buildrom-withgrub to use gnulove.jpg aswell
-   Updated resources/grub/config/macbook21/grub\*cfg to use gnulove.jpg
    background.
-   Updated resources/grub/config/{x60,t60,x60t}/grub\*cfg to use
    background.jpg background.
-   Documentation: updated docs/\#grub\_custom\_keyboard to be more
    generally useful.
-   nvramtool:
    -   Updated builddeps-coreboot script to build it
    -   Updated build script to include it in libreboot\_bin
-   Documentation: added docs/security/x60\_security.html (security
    hardening for X60)

Revisions for r20140716 (2nd beta) (16th July 2014)
---------------------------------------------------

-   Deleted all git-related files from the coreboot directory. This was
    necessary because with those it is possible to run 'git diff'
    which shows the changes made in the form of a patch (diff format);
    this includes the blobs that were deleted during deblobbing.

Revisions for r20140711 (1st beta) (11th July 2014)
---------------------------------------------------

-   Initial release (new coreboot base, dated 1st June 2014. See
    'getcb' script for reference)
-   DEBLOBBED coreboot
-   Removed the part from memtest86+ 'make' where it tried to connect
    to some scp server while compiling. (commented out line 24 in the
    Makefile)
-   X60 now uses a single .config (for coreboot)
-   X60 now uses a single grub.cfg (for grub memdisk)
-   X60 now uses a single grub.elf (payload)
-   Added new native graphics code for X60 (replaces the old 'replay'
    code) from Vladimir Serbinenko: 5320/9 from review.coreboot.org
-   T60 is now supported, with native graphics. (5345/4 from
    review.coreboot.org, cherry-picked on top of 5320/9 checkout)
-   Added macbook2,1 support (from Mono Moosbart and Vladimir
    Serbinenko) from review.coreboot.org (see 'getcb' script to know
    how that was done)
    -   Documentation: added information linking to correct page and
        talking about which models are supported.
    -   Added resources/libreboot/config/macbook21config
    -   macbook21: Added 'build-macbook21' script and linked to it in
        'build' (ROMs included under bin/macbook21/)
    -   macbook21: Removed dd instructions from build-macbook21 script
        (macbook21 does not need bucts when flashing libreboot while
        Apple EFI firmware is running)
    -   Documentation: Added macbook21 ROMs to the list of ROMs in
        docs/\#rom
    -   Documentation: Write documentation linking to Mono Moosbart's
        macbook21 and parabola page (and include a copy)
-   Documentation: added a copy of Mono's Parabola install guide (for
    macbook21 with Apple EFI firmware) and linked in in main index.
-   Documentation: added a copy of Mono's Coreboot page (for macbook21)
    and linked it in main index.
-   T60: Copy CD option from the grub.cfg files for T60 \*serial\*.rom
    images into the grub configs for non-serial images. (T60 laptops have
    CD/DVD drive on main laptop)
-   macbook21: remove options in build-macbook21 for \*serial\*.rom
    (there is no dock or serial port available for macbook21)
-   Added patches for backlight controls on X60 and T60 with help from
    Denis Carikli (see ./resources/libreboot/patch/gitdiff and ./getcb
    and docs/i945\_backlight.md)
    -   Documentation: added docs/i945\_backlight.html showing how
        backlight controls were made to work on X60/T60
-   Documentation: Added info about getting LCD panel name based on EDID
    data.
    -   Documentation: Added a link to this from the list of supported
        T60 laptopss and LCD panels for T60 (so that the user can check
        what LCD panel they have).
-   X60/T60: Merged patches for 3D fix (from Paul Menzel) when using
    kernel 3.12 or higher (see ./resources/libreboot/patch/gitdiff and
    ./getcb)
    -   based on 5927/11 and 5932/5 from review.coreboot.org
-   Improved thinkpad\_acpi support (from coreboot ): xsensors shows
    more information.
    -   From 4650/29 in review.coreboot.org (merged in coreboot
        'master' on June 1st 2014)
-   Merged changes for digitizer (X60 Tablet) and IR (X60 and T60) based
    on 5243/17, 5242/17 and 5239/19 from review.coreboot.org
    -   (see ./resources/libreboot/patch/gitdiff and ./getcb)
-   Documentation: added information about building flashrom using
    'builddeps-flashrom' script.
-   Re-created resources/libreboot/config/x60config
-   Re-created resources/libreboot/config/t60config
-   Added 'x60tconfig' in resources/libreboot/config (because X60
    Tablet has different information about serial/model/version in
    'dmidecode')
    -   Added 'build-x60t' script
    -   Updated 'build' script to use 'build-x60t'
    -   Documentation: added to \#config section the section
        \#config\_x60t (libreboot configuration and dmidecode info)
    -   Documentation: added x60t ROMs to the list of ROMs
-   Tidied up the 'builddeps' script (easier to read)
-   Tidied up the 'cleandeps' script (easier to read)
-   Annotated the 'buildall' script
-   Added 'getcb' script for getting coreboot revision used from git,
    and patching it.
-   Added 'getgrub' script for getting the GRUB revision used from
    git, and patching it.
-   Added 'getmt86' script for getting the memtest86+ version used,
    and patching it.
-   Added 'getbucts' script for getting the bucts version used.
-   Added 'getflashrom' script for getting the flashrom version used,
    and patching it
-   Added 'getall' script which runs all of the other 'get' scripts.
-   Add instructions to the 'build' script to prepare
    libreboot\_meta.tar.gz
    -   New archive: libreboot\_meta.tar.gz - minimal archive, using the
        'get' scripts to download all the dependencies (coreboot,
        memtest, grub and so on).
-   Documentation: added information about where 'build' script
    prepares the libreboot\_meta.tar.gz archive.
-   Documentation: added information about how to use the 'get'
    scripts in libreboot\_meta.tar.gz (to generate
    libreboot\_src.tar.gz)
    -   Documentation: mention that meta doesn't create libreboot\_src/
        directory, but that libreboot\_meta itself becomes the same.
    -   Documentation: advise to rename libreboot\_meta to
        libreboot\_src after running 'getall'.
-   Annotated the 'builddeb' script, to say what each set of
    dependencies are for.
-   Separated bucts/flashrom builddeb sections into separate scripts:
    builddeb-flashrom, builddeb-bucts.
-   Documentation: Updated relevant parts based on the above.
-   Added instructions to 'build' script for including builddeb-bucts
    and builddeb-flashrom in libreboot\_bin
-   Updated flashrom checkout (r1822 2014-06-16) from SVN
    (http://flashrom.org/Downloads).
    -   Updated flashing instructions in docs/ for new commands needed
        (Macronix chip on X60/T60)
    -   For X60/T60 (flashrom): Patched
        flashchips.c\_lenovobios\_macronix and
        flashchips.c\_lenovobios\_sst executables for SST/macronix
        (included in resources/flashrom/patch)
    -   Updated builddeps to build flashrom\_lenovobios\_sst and
        flashrom\_lenovobios\_macronix, for X60/T60 users with Lenovo
        BIOS
    -   moved the flashrom build instructions from 'builddeps' and put
        them in 'builddeps-flashrom', excecuting that from
        'builddeps'.
    -   Added builddeps-flashrom to libreboot\_bin.tar.gz
-   flashrom: added patched flashchips.c to resources/flashrom/patch
    (automatically use correct macronix chip on libreboot, without using
    '-c' switch)
    -   removed 'MX25L1605' and 'MX25L1605A/MX25L1606E' entries in
        flashchips.c for the patched version of flashchips.c
    -   added instructions to 'builddeps-flashrom' to automatically
        use this modified flashchips.c in the default build
-   Added builddeb to libreboot\_bin.tar.gz
-   Moved 'bucts' build instructions from builddeps to builddeps-bucts
    -   builddeps now runs 'builddeps-bucts' instead
    -   Added 'builddeps-bucts' to libreboot\_bin.tar.gz
    -   Documentation: Added information about using 'builddep-bucts'
        to build the BUC.TS utility.
-   Added 'lenovobios\_firstflash' and 'lenovobios\_secondflash'
    scripts
    -   Added instructions to 'build' script for including those files
        in libreboot\_bin
    -   Documentation: Add tutorial for flashing while Lenovo BIOS is
        running (on X60/T60)
-   Added 'flash' script (make sure to run builddeps-flashrom first)
    which (while libreboot is already running) can use flashrom to flash
    a ROM
    -   eg: "sudo ./flash bin/x60/coreboot\_serial\_ukdvorak.rom"
        equivalent to "sudo ./flashrom/flashrom -p internal -w
        bin/x60/coreboot\_uk\_dvorak.rom"
    -   updated 'build' script to include the 'flash' script in
        libreboot\_bin.tar.gz
-   Documentation: replaced default flashrom tutorial to recommend the
    'flash' script instead.
-   Re-add cbfstool source code back into libreboot\_bin.tar.gz, as
    cbfstool\_standalone
    -   Patched that version to work (able to be built and used) without
        requiring the entire coreboot source code.
    -   Created patched version of the relevant source files and added
        it into resources/cbfstool/patch
        -   see coreboot/util/cbfstool/rmodule.c and then the patched
            version in resources/cbfstool/patch/rmodule.c
        -   see coreboot/src/include/rmodule-defs.h and the rule in
            'build' for including this in
            ../libreboot\_bin/cbfstool\_standalone
    -   Added instructions to 'build' script for applying this patch
        to the cbfstool\_standalone source in libreboot\_bin
    -   Added instructions to 'build' script for then re-compiling
        cbfstool\_standalone in libreboot\_bin after applying the patch
    -   Added a 'builddeps-cbfstool' script (in src, but only used in
        bin and put in bin by 'build') that compiles
        cbfstool\_standalone in libreboot\_bin (make), moves the
        cbfstool and rmodtool binaries into libreboot\_bin/ and then
        does 'make clean' in libreboot\_bin/cbfstool\_standalone
    -   Updated the 'build' script to put 'builddeps-cbfstool' in
        libreboot\_bin
    -   Updated the 'build' script in the cbfstool (standalone) part
        to accomodate the above.
    -   Documentation: added notes about cbfstool (standalone) in
        libreboot\_bin
-   Documentation: made docs/gnulinux/grub\_cbfs.html slightly easier to
    follow.
-   Annotate the 'build\*' scripts with 'echo' commands, to help the
    user understand what it actually happening during the build process.
-   Documentation: added information about how 'dmidecode' data was
    put in the coreboot configs
    -   Documentation: In fact, document how the 'config' files in
        resources/libreboot/config/ were created
-   Documentation: Added information about which ThinkPad T60 laptops are
    supported, and which are not.
-   Documentation: added information about LCD inverters (for upgrading
    the LCD panel on a T60 14.1' XGA or 15.1' XGA)
    -   it's FRU P/N 41W1478 (on T60 14.1") so this was added to the
        docs.
    -   it's P/N 42T0078 FRU 42T0079 or P/N 41W1338 (on T60 15.1") so
        this was added to the docs.
-   Documentation: added information about names of LCD panels for T60
    to the relevant parts of the documentation.
-   Documentation: added information (with pictures) about the
    differences between T60 with Intel GPU and T60 with ATI GPU.
-   Documentation: added pictures of keyboard layouts (US/UK
    Qwerty/Dvorak) to the ROM list, to let the user compare with their
    own keyboard.
-   Move the coreboot build instructions in 'builddeps' into
    'builddeps-coreboot' and link it in 'builddeps'
    -   Link to 'builddeps-coreboot' in final stage of 'getcb'
-   Move GRUB build instructions from 'builddeps' into
    'builddeps-grub', link from 'builddeps'
    -   Link to 'builddeps-grub' in final stage of 'getgrub'
-   Move MemTest86+ build instructions from 'builddeps' into
    'builddeps-memtest86', link from 'builddeps'
    -   Link to 'builddeps-memtest86' in final stage of 'getmt86'
-   made 'build' script put resources/ directory in libreboot\_bin, to
    make builddeps-flashrom work in libreboot\_bin
-   Removed instructions for building source code in the 'get' script
    (they don't really belong there)
-   Added libfuse-dev and liblzma-dev to the list of GRUB dependencies
    in 'builddeb' script.
-   Converted the 'RELEASE' file to 'docs/RELEASE.html'
-   Added those dependencies to builddeb script (for GRUB part): gawk
    libdevmapper-dev libtool libfreetype6-dev
-   Added to build script the instruction at the end to create a
    sha512sum.txt with a file manifest plus checksums.
-   Deleted the RELEASE and BACKPORT files (no longer needed)
-   Documentation: added information about X60/T60 dock (ultrabase x6
    and advanced mini dock) to relevant sections.
    -   Added to docs/\#serial

Release 20140622 (5th release) {#release20140622}
==============================

-   7th March 2014
-   revised 22nd June 2014

Officially supported
--------------------

-   ThinkPad X60
-   ThinkPad X60s

Revision (22nd June 2014 - extra)
---------------------------------

-   Documentation: added X60 Unbricking tutorial
-   Documentation: added info about enabling or disabling wifi
-   Documentation: added info about enabling or disabling trackpoint

Revision (22nd June 2014 - extra)
---------------------------------

-   Documentation: Improved the instructions for using flashrom
-   Documentation: Improved the instructions for using cbfstool (to
    change the default GRUB menu)
-   Documentation: Numerous small fixes.

Revision notes (22nd June 2014)
-------------------------------

-   updated GRUB (git 4b8b9135f1676924a8458da528d264bbc7bbb301, 20th
    April 2014)
-   Made "DeJavu Sans Mono" the default font in GRUB (fixes border
    corruption).
-   re-added background image in GRUB (meditating GNU)
-   added 6 more images:
    -   coreboot\_ukqwerty.rom (UK Qwerty keyboard layout in GRUB)
    -   coreboot\_serial\_ukqwerty.rom (UK Qwerty keyboard layout in
        GRUB)
    -   coreboot\_dvorak.rom (US Dvorak keyboard layout in GRUB)
    -   coreboot\_serial\_dvorak.rom (US Dvorak keyboard layout in GRUB)
    -   coreboot\_ukdvorak.rom (UK Dvorak keyboard layout in GRUB)
    -   coreboot\_serial\_ukdvorak.rom (UK Dvorak keyboard layout in
        GRUB)
    -   (coreboot.rom and coreboot\_serial.rom have US Qwerty keyboard
        layout in GRUB, as usual)
-   improved the documentation:
    -   removed FLASH\_INSTRUCTION and README.powertop and merged them
        with README
    -   removed obsolete info from README and tidied it up
    -   deleted README (replaced with docs/)
-   tidied up the menu entries in GRUB
-   tidied up the root directory of X60\_source/, sorted more files into
    subdirectories
-   improved the commenting inside the 'build' script (should make
    modifying it easier)
-   Renamed X60\_binary.tar.gz and X60\_source.tar.gz to
    libreboot\_bin.tar.gz and libreboot\_src.tar.gz, respectively.
-   Replaced "GNU GRUB version" with "FREE AS IN FREEDOM" on GNU
    GRUB start screen.
-   Added sha512.txt files in libreboot\_src and libreboot\_bin. (inside
    the archives)
-   Added libreboot\_bin.tar.gz.sha512.txt and
    libreboot\_src.tar.gz.sha512.txt files (outside of the archives)

Revision notes (11th June 2014):
--------------------------------

-   removed 'CD' boot option from coreboot.rom (not needed)
-   removed 'processor.max\_cstate=2' and 'idle=halt' options (see
    README.powertop file)

Revision notes (5th June 2014):
-------------------------------

-   added backlight support (Fn+Home and Fn+End) on X60
-   fixed broken/unstable 3D when using kernel 3.12 or higher
-   (see 'BACKPORT' file)

Revision notes (9th March 2015):
--------------------------------

-   recreated coreboot config from scratch
-   GRUB loads even faster now (less than 2 seconds).
-   Total boot time reduced by further \~5 seconds.
-   Added crypto and cryptodisk modules to GRUB
-   cbfstool now included in the binary archives

Development notes
-----------------

-   Binary archive now have 2 images:
    -   With serial output enabled and memtest86+ included (debug level
        8 in coreboot)
    -   With serial output disabled and memtest86+ excluded (faster boot
        speeds) (debugging disabled)
-   Reduced impact on battery life:
    -   'processor.max\_cstate=2' instead of 'idle=halt' for booting
        default kernel
-   coreboot.rom (faster boot speeds, debugging disabled):
    -   Disabled coreboot serial output (Console-> in "make
        menuconfig")
    -   Set coreboot debug level to 0 instead of 8 (Console-> in
        "make menuconfig")
    -   Changed GRUB timeout to 1 second instead of 2 (in grub.cfg
    -   Removed background image in GRUB.
    -   Removed memtest86+ payload (since it relies on serial output)
-   coreboot\_serial.rom (slower boot speeds, debugging enabled):
    -   Boot time still reduced, but only by \~2 seconds
    -   has the memtest86+ payload included in the ROM
    -   has serial port enabled. How this is achieved (from
        X60\_source): Turn on debugging level to 8, and enable serial
        output
-   (in Console-> in coreboot "make menuconfig")
-   (and build with grub\_serial.cfg and grub\_memdisk\_serial.cfg)

Release 20140221 (4th release) {#release20140221}
==============================

-   21st February 2014

Officially supported
--------------------

-   ThinkPad X60
-   ThinkPad X60s

Development notes
-----------------

-   Removed SeaBIOS (redundant)
-   New GRUB version (2.02\~beta2)
    -   Fixes some USB issues
    -   Includes ISOLINUX/SYSLINUX parser
-   New grub.cfg
-   Removed useless options:
    -   options for booting sda 2/3/4
    -   seabios boot option
-   Added new menu entries:
    -   Parse ISOLINUX config (USB)
    -   Parse ISOLINUX config (CD)
    -   Added 'cat' module for use on GRUB command line.
-   "set pager=1" is set in grub.cfg, for less-like functionality

The "Parse" options read ./isolinux/isolinux.cfg on a CD or USB, and
automatically converts it to a grub config and switches to the boot menu
of that distro. This makes booting ISOs \*much\* easier than before.

r20131214 (3rd release) {#release20131214}
=======================

-   14th December 2013

Supported:
----------

-   ThinkPad X60
-   ThinkPad X60s

Development notes
-----------------

-   Added SeaBIOS payload to GRUB2 (for booting USB drives)
-   new grub.cfg

r20131213 (2nd release) {#release20131213}
=======================

-   13th December 2013

Supported:
----------

-   ThinkPad X60
-   ThinkPad X60s

Development notes
-----------------

-   added background image to GRUB2
-   added memtest86+ payload to grub2
-   improvements to the documentation
-   new grub.cfg

r20131212 (1st release) {#release20131212}
=======================

-   12th December 2013

Supported:
----------

-   ThinkPad X60
-   ThinkPad X60s

Development notes
-----------------

-   initial release
-   source code deblobbed

Copyright © 2014, 2015, 2016 Leah Rowe <info@minifree.org>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [fdl-1.3.md](fdl-1.3.md)
