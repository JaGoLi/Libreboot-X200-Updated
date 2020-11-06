
# Release Notes

## Version:

PSTI7687

## Release Date:

Dec 3, 2019

## Supported silicon:

The STM is designed to be BIOS, platform, and operating system agnostic.
It has been tested on the Purism Librem 15v4 (Kabylake), Dell 990
(Sandybridge with a non-coreboot BIOS), and Minnowboard Max (Atom).

## Instructions:

This folder serves as the location for the stm.bin file.  The developer
can use the default stm.bin provided or replace it with one that has
been custom built.  The coreboot build system will look here for the
STM binary when the STM has been configured.

The default STM requires a MSEG of 4MB.  If a smaller MSEG is used
then the STM has to be custom built.  Also, if a larger MSEG is
configured, then the STM has to be custom built to take advantage
of the additional memory.

For version changes, issues, etc see the git repository.

## Toolchains:

The STM can be built with either Microsoft Visual Studio or with CMAKE/GNU.

## ABI:

This document defines both the firmware interface and the operating system
interface with the STM:

SMI Transfer Monitor (STM) User Guide, August 2015

The above document can be obtained from firmware.intel.com.

The STM-PE interface is defined in the Readme.STMPE file found on
the stmpe branch of review.coreboot.org/STM.

