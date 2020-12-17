---
title: Depthcharge payload 
x-toc-enable: true
...

This section relates to the depthcharge payload used in libreboot.

CrOS security model
===================

CrOS (Chromium OS/Chrome OS) devices such as Chromebooks implement a strict
security model to ensure that these devices do not become compromised, that is
implemented as the verified boot (vboot) reference, most of which is executed
within depthcharge. A detailed overview of the CrOS security model is available
on the dedicated page.

In spite of the CrOS security model, depthcharge won't allow booting kernels
without verifying their signature and booting from external media or legacy
payload unless explicitly allowed: see [configuring verified boot
parameters](#configuring_verified_boot_parameters).

Developer mode screen
=====================

The developer mode screen can be accessed in depthcharge when developer mode is
enabled.  Developer mode can be enabled from the recovery mode screen.

It allows booting normally, booting from internal storage, booting from
external media (when enabled), booting from legacy payload (when enabled),
showing information about the device and disabling developer mode.

Holding the developer mode screen
---------------------------------

As instructed on the developer mode screen, the screen can be held by pressing
*Ctrl + H* in the first 3 seconds after the screen is shown.  After that delay,
depthcharge will resume booting normally.

Booting normally
----------------

As instructed on the developer mode screen, a regular boot will happen after *3
seconds* (if developer mode screen is not held).

The default boot medium (internal storage, external media, legacy payload) is
shown on screen.

Booting from different mediums
------------------------------

Depthcharge allows booting from different mediums, when they are allowed (see
[configuring verified boot parameters](#configuring_verified_boot_parameters)
to enable or disable boot mediums).

As instructed on the developer mode screen, booting from various mediums can be
triggered by pressing various key combinations:

-   Internal storage: *Ctrl + D*
-   External media: *Ctrl + U* (when enabled)
-   Legacy payload: *Ctrl + L* (when enabled)

Showing device information
--------------------------

As instructed on the developer mode screen, showing device information can be
triggered by pressing *Ctrl + I* or *Tab*.  Various information is shown,
including vboot non-volatile data, TPM status, GBB flags and key hashes.

Warnings
--------

The developer mode screen will show warnings when:

-   Booting kernels without verifying their signature is enabled
-   Booting from external media is enabled
-   Booting legacy payloads is enabled

Recovery mode screen
====================

The recovery mode screen can be accessed in depthcharge, by pressing *Escape +
Refresh + Power* when the device is off.

It allows recovering the device from a bad state by booting from a trusted
recovery media. When accessed with the device in a good state, it also allows
enabling developer mode.

Recovering from a bad state
---------------------------

When the device fails to verify the signature of a piece of the boot software
or when an error occurs, it is considered to be in a bad state and will
instruct the user to reboot to recovery mode.

Recovery mode boots using only software located in write-protected memory, that
is considered to be trusted and safe.

Recovery mode then allows recovering the device by booting from a trusted
recovery media, that is automatically detected when recovery mode starts. When
no external media is found or when the recovery media is invalid, instructions
are shown on screen.

Trusted recovery media are external media (USB drives, SD cards, etc) that hold
a kernel signed with the recovery key.

Google provides images of such recovery media for Chrome OS (which are not
advised to users as they contain proprietary software).

They are signed with Google's recovery keys, that are pre-installed on the
device when it ships.

When replacing the full flash of the device, the pre-installed keys are
replaced. When the recovery private key is available (e.g. when using
self-generated keys), it can be used to sign a kernel for recovery purposes.

Enabling developer mode
-----------------------

As instructed on the recovery mode screen, developer mode can be enabled by
pressing *Ctrl + D*.  Instructions to confirm enabling developer mode are then
shown on screen.

Configuring verified boot parameters
====================================

Depthcharge's behavior relies on the verified boot (vboot) reference
implementation, that can be configured with parameters stored in the verified
boot non-volatile storage.

These parameters can be modified with the `crossystem` tool, that requires
sufficient privileges to access the verified boot non-volatile storage.

`crossystem` relies on `mosys`, that is used to access the verified boot
non-volatile storage on some devices. `crossystem` and `mosys` are both free
software and their source code is made available by Google:
[crossystem](https://chromium.googlesource.com/chromiumos/platform/vboot_reference/).
[mosys](https://chromium.googlesource.com/chromiumos/platform/mosys/).

These tools are not distributed along with Libreboot yet. However, they are
preinstalled on the device, with ChromeOS.

Some of these parameters have the potential of *weakening the security of the
device*. In particular, disabling kernels signature verification, external
media boot and legacy payload boot can weaken the security of the device.

The following parameters can be configured:

Kernels signature verification:

    # crossystem dev_boot_signed_only=1 # enable
    # crossystem dev_boot_signed_only=0 # disable

External media boot:

    # crossystem dev_boot_usb=1 # enable
    # crossystem dev_boot_usb=0 # disable

Legacy payload boot:

    # crossystem dev_boot_legacy=1 # enable 
    # crossystem dev_boot_legacy=0 # disable

Default boot medium:

    # crossystem dev_default_boot=disk # internal storage
    # crossystem dev_default_boot=usb # external media
    # crossystem dev_default_boot=legacy # legacy payload


Copyright © 2015 Paul Kocialkowski <contact@paulk.fr>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
