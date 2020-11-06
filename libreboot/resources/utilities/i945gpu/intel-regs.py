#!/usr/bin/env python2
# -*- coding: utf-8 -*-
# Copyright (C) 2014  Michał Masłowski  <mtjm@mtjm.eu>
#
# Licensed under copyleft-next version 0.3.0.  See
# https://gitorious.org/copyleft-next/copyleft-next/raw/master:Releases/copyleft-next-0.3.0
# for more information.

"""Get values of interesting i945 graphics parameters from a running system.

This script might show the values for GPU registers specified in
devicetree.cb on coreboot mainboard ports using i945 native VGA init
from <http://review.coreboot.org/#/c/5320/>.

Run as root.
"""


import mmap
import re
import struct
import subprocess


_MEMORY = re.compile(r"^\s+Memory\s+at\s+([0-9a-f]+)\s+\(32-bit, non-prefetchable\)\s+\[size=[0-9]+K\]$")


def get_pci_data():
    # lspci has a machine readable format, but it doesn't have the needed data.
    for devid in ("8086:27a2",):
        lspci = subprocess.Popen(("lspci", "-vn", "-d", devid),
                                 stdout=subprocess.PIPE,
                                 stderr=subprocess.PIPE)
        address = None
        memory = None
        for line in lspci.communicate()[0].split("\n"):
            if line and line[0] == "0":
                address = line.split()[0]
            match = _MEMORY.match(line)
            if match is not None:
                memory = int(match.group(1), 16)
                break
        yield (address, memory)


def config_byte(address, offset):
    """Return byte at specified offset in PCI config space of device
    identified by address."""
    with open("/sys/bus/pci/devices/0000:%s/config" % address, "rb") as f:
        f.seek(offset)
        return struct.unpack("=B", f.read(1))


addr0, func0 = list(get_pci_data())[0]


def read32(fo, base, offset):
    memory = mmap.mmap(fo.fileno(), offset + 4,
                       mmap.MAP_SHARED, mmap.ACCESS_READ,
                       offset=base)
    try:
        memory.seek(offset)
        val = memory.read(4)
        return struct.unpack("=I", val)[0]
    finally:
        memory.close()

# Some i915 register names.
PORT_HOTPLUG_EN = 0x61110
BLC_PWM_CTL = 0x61254
LVDS = 0x61180

# Bits in LVDS.
LVDS_CLOCK_B_POWERUP_ALL = 3 << 4
LVDS_CLOCK_BOTH_POWERUP_ALL = 3 << 2

# Expansion of DPLL(1).
DPLL1 = ((0x06014) + (1)*((0x06018)-(0x06014)))

# Bits there.
DPLL_INTEGRATED_CLOCK_VLV = (1<<13)
DPLL_INTEGRATED_CRI_CLK_VLV = (1<<14)

if __name__ == "__main__":
    with open("/dev/mem", "rb") as mem:
        print "gpu_hotplug = 0x%08x" % read32(mem, func0, PORT_HOTPLUG_EN)
        dpll = read32(mem, func0, DPLL1)
        spread_spectrum = dpll & (DPLL_INTEGRATED_CLOCK_VLV \
                                  | DPLL_INTEGRATED_CRI_CLK_VLV)
        if spread_spectrum != 0:
            spread_spectrum = 1
        print "gpu_lvds_use_spread_spectrum_clock = %d" % spread_spectrum
        lvds = read32(mem, func0, LVDS)
        dual_channel = lvds & (LVDS_CLOCK_B_POWERUP_ALL \
                               | LVDS_CLOCK_BOTH_POWERUP_ALL)
        if dual_channel != 0:
            dual_channel = 1
        print "gpu_lvds_is_dual_channel = %d" % dual_channel
        backlight = read32(mem, func0, BLC_PWM_CTL)
        print "gpu_backlight = 0x%08x" % backlight
        # Using display clock from i945_get_display_clock_speed in
        # drivers/gpu/drm/i915/intel_display.c.  Result multiplied by
        # two to match BIOS-reported PWM frequency on my X60t.
        mod_freq = 2 * 400000000 / ((backlight >> 16) * 128.0)
        print "backlight modulation frequency = %f Hz" % mod_freq
        print "duty cycle = %d%%" % (100.0 * (backlight & 0xffff)
                                     / (backlight >> 16))
        print "legacy backlight brightness = 0x%02x" % config_byte(addr0, 0xf4)
