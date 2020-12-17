---
title: Frequently Asked Questions
x-toc-enable: true
...

Important issues
================

Is the Libreboot project still active?
-------------------------------------------

Yes! The [git repository](https://notabug.org/libreboot/libreboot) shows all of
the work that we're currently doing. Libreboot is quite active.

So when is the next version of Libreboot coming out?
-------------------------------------------------------

Short answer: It's out when it's out. If you want to help out and submit
patches, refer to [the Git page](git.md).

We don't issue ETAs.

Long answer:

We've been re-writing the entire Libreboot build system from scratch, since
the previous release. This has taken longer than we expected, but the new
build system is reaching maturity. We are polishing it.

Once the new build system is stable, our next priority is ensuring that all
currently supported build targets build properly in Libreboot.

After that, the priority is to make sure that all current boards in Libreboot
use the most up to date revision of coreboot, with all of the most recent fixes
and improvements. Testing those boards will then be a matter of peer review,
reaching out to the entire community via alpha/beta/RC releases.

Generally, all major release-blocking issues must be addressed before a new
release can be issued. See:
<https://notabug.org/libreboot/libreboot/issues>

The most important tasks now are as follows:

- Study the build system of Libreboot (written in BASH), and make fixes to it.
- Work on new improvements and help with testing once ROMs build for all
  boards, when the build system is stable.
- In particular, there are several new boards in coreboot that we can add to
  Libreboot, as documented on the Libreboot bug tracker. These will also have
  to be added, and fully tested. Instructions for setting up hardware-based
  flashing tools can be found in
  [the Libreboot installation guides](docs/install/)
- Bugs! Report bugs! <https://notabug.org/libreboot/libreboot/issues>
- A few new board ports will also come in handy ;)
  If you've got the skills, we'd really appreciate that. Port them to coreboot
  first, or make existing coreboot targets work without binary blobs.

More generally:

- Tell your friends about Libreboot! Libreboot wants to liberate as many people
  as possible.
- If you have ways to improve the documentation, you can do that too.
  Refer to [the Git page](git.md) for instructions on submitting patches to the
  documentation.
- Encourage companies, or any persons with the skills/resources, to get
  involved with Libreboot development.

What version of libreboot do I have?
----------------------------------------------------------------

See "Version" [in the documentation](../docs/#version)

Flashrom complains about DEVMEM access
--------------------------------------

If running `flashrom -p internal` for software based flashing, and
you get an error related to /dev/mem access, you should reboot with
`iomem=relaxed` kernel parameter before running flashrom, or use a kernel
that has `CONFIG_STRICT_DEVMEM` and `CONFIG_IO_STRICT_DEVMEM` not enabled.

Example flashrom output with both `CONFIG_STRICT_DEVMEM` and `CONFIG_IO_STRICT_DEVMEM` enabled:
```
flashrom v0.9.9-r1955 on Linux 4.11.9-1-ARCH (x86_64)
flashrom is free software, get the source code at https://flashrom.org

Calibrating delay loop... OK.
Error accessing high tables, 0x100000 bytes at 0x000000007fb5d000
/dev/mem mmap failed: Operation not permitted
Failed getting access to coreboot high tables.
Error accessing DMI Table, 0x1000 bytes at 0x000000007fb27000
/dev/mem mmap failed: Operation not permitted
```

The backlight is darker on the left side of the screen when lowering the brightness on my X200/T400/T500/R400 
---------------------------------------------------------------------------------------------------------------

We don't know how to detect the correct PWM value to use in
coreboot-libre, so we just use the default one in coreboot which has
this issue on some CCFL panels, but not LED panels.

You can work around this in your distribution, by following the notes at
[docs: backlight control](../docs/misc/#finetune-backlight-control-on-intel-gpus).

The ethernet doesn't work on my X200/T400/X60/T60 when I plug in it 
-------------------------------------------------------------------

This was observed on some systems using network-manager. This happens
both on the original BIOS and in libreboot. It's a quirk in the
hardware. On debian systems, a workaround is to restart the networking
service when you connect the ethernet cable:

    $ sudo service network-manager restart

On Parabola, you can try:

    $ sudo systemctl restart network-manager

(the service name might be different for you, depending on your
configuration)

My KCMA-D8 or KGPE-D16 doesn't boot with the PIKE2008 module installed 
-----------------------------------------------------------------------

Libreboot 20160818, 20160902 and 20160907 all have a bug: in SeaBIOS,
PCI options ROMs are loaded when available, by default. This is not
technically a problem, because an option ROM can be free or non-free. In
practise, though, they are usually non-free.

Loading the option ROM from the PIKE2008 module on either ASUS KCMA-D8
or KGPE-D16 causes the system to hang at boot. It's possible to use
this in the payload (if you use a linux kernel payload, or petitboot),
or to boot (with SeaGRUB and/or SeaBIOS) from regular SATA and then use
it in GNU+Linux. The Linux kernel is capable of using the PIKE2008
module without loading the option ROM.

Libreboot-unstable (or git) now disables loading PCI option ROMs, but
previous releases with SeaGRUB (20160818-20160907) do not. You can work
around this by running the following command:

    $ ./cbfstool yourrom.rom add-int -i 0 -n etc/pci-optionrom-exec

You can find *cbfstool* in the \_util archive with the libreboot release
that you are using.

What are the ata/ahci errors I see in libreboot's GRUB?
-----------------------------------------------------------------------

You can safely ignore those errors, they exist because we can't quiet down
cryptomount command from `for` loop in libreboot's
[grub.cfg](https://notabug.org/libreboot/libreboot/src/r20160907/resources/grub/config/menuentries/common.cfg#L66).
It could be fixed in upstream grub by contributing patch that would add
quiet flag to it.

How to save kernel panic logs on thinkpad laptops?
--------------------------------------------------

The easiest method of doing so is by using the kernel's netconsole
and reproducing the panic. Netconsole requires two machines, the one that is
panicky (source) and the one that will receive crash logs (target). The
source has to be connected with an ethernet cable and the target has to be
reachable at the time of the panic. To set this system up, execute the
following commands as root on the source (`source#`) and normal user on
the target (`target$`):

1.  Start a listener server on the target machine (netcat works well):

    `target$ nc -u -l -p 6666`

2.  Mount configfs (only once per boot, you can check if it is already mounted
    with `mount | grep /sys/kernel/config`. This will return no output
    if it is not).

    `source# modprobe configfs`

    `source# mkdir -p /sys/kernel/config`

    `source# mount none -t configfs /sys/kernel/config`

3.  find source's ethernet interface name, it should be of the form `enp*` or
    `eth*`, see `ip address` or `ifconfig` output.

    `source# iface="enp0s29f8u1"` change this

    Fill the target machine's IPv4 address here:

    `source# tgtip="192.168.1.2"` change this


3.  Create netconsole logging target on the source machine:

    `source# modprobe netconsole`

    `source# cd /sys/kernel/config/netconsole`

    `source# mkdir target1; cd target1`

    `source# srcip=$(ip -4 addr show dev "$iface" | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')`

    `source# echo "$srcip" > local_ip`

    `source# echo "$tgtip" > remote_ip`

    `source# echo "$iface" > dev_name`

    `source# arping -I "$iface" "$tgtip" -f | grep -o '..:..:..:..:..:..' > remote_mac`

    `source# echo 1 > enabled`

4.  Change console loglevel to debugging:

    `source# dmesg -n debug`

5.  Test if the logging works by e.g. inserting or removing an USB
    device on the source. There should be a few lines appearing in the
    terminal, in which you started netcat (nc), on the target host.

6.  Try to reproduce the kernel panic.

Machine check exceptions on some Montevina (Penryn CPU) laptops
---------------------------------------------------------------

Some GM45 laptops have been freezing or experiencing a kernel panic
(blinking caps lock LED and totaly unresponsive machine, sometimes followed
by an automatic reboot within 30 seconds).
We do not know what the problem(s) is(are), but a CPU microcode
update in some cases prevents this from happening again.
See the following bug reports for more info:

- [T400 Machine check: Processor context corrupt](https://notabug.org/libreboot/libreboot/issues/493)
- [X200 Machine check: Processor context corrupt](https://notabug.org/libreboot/libreboot/issues/289)

- [Unrelated, RAM incompatibility and suspend-to-ram issues on X200](https://libreboot.org/docs/hardware/x200.html#ram_s3_microcode)


Hardware compatibility
======================

What systems are compatible with libreboot?
-----------------------------------------------------------------------------------

See the [hardware compatibility list](docs/hardware/).

Will the Purism laptops be supported?
----------------------------------------------------------------------

Short answer: no.

There are severe privacy, security and freedom issues with these laptops, due
to the Intel chipsets that they use. See:

- [Intel Management Engine](#intelme)
- [More freedom issues on modern Intel hardware](#intel)

Most notably, these laptops also use the Intel FSP binary blob, for the entire
hardware initialization. Coreboot does support a particular revision of one of
their laptops, but most are either unsupported or rely on binary blobs for most
of the hardware initialization.

In particular, the Intel Management Engine is a severe threat to privacy and
security, not to mention freedom, since it is a remote backdoor that provides
Intel remote access to a computer where it is present.

Intel themselves even admitted it, publicly.

The Libreboot project recommends avoiding all hardware sold by Purism.

Why is the latest Intel hardware unsupported in libreboot? {#intel}
-----------------------------------------------------------

It is unlikely that any post-2008 Intel hardware will ever be supported in
libreboot, due to severe security and freedom issues; so severe, that *the
libreboot project recommends avoiding all modern Intel hardware. If you have an
Intel based system affected by the problems described below, then you should
get rid of it as soon as possible*. The main issues are as follows:

### Intel Management Engine (ME) {#intelme}

Introduced in June 2006 in Intel's 965 Express Chipset Family of
(Graphics and) Memory Controller Hubs, or (G)MCHs, and the ICH8 I/O
Controller Family, the Intel Management Engine (ME) is a separate
computing environment physically located in the (G)MCH chip. In Q3 2009,
the first generation of Intel Core i3/i5/i7 (Nehalem) CPUs and the 5
Series Chipset family of Platform Controller Hubs, or PCHs, brought a
more tightly integrated ME (now at version 6.0) inside the PCH chip,
which itself replaced the ICH. Thus, the ME is ***present on all Intel
desktop, mobile (laptop), and server systems since mid 2006***.

The ME consists of an ARC processor core (replaced with other processor
cores in later generations of the ME), code and data caches, a timer,
and a secure internal bus to which additional devices are connected,
including a cryptography engine, internal ROM and RAM, memory
controllers, and a ***direct memory access (DMA) engine*** to access the
host operating system's memory as well as to reserve a region of
protected external memory to supplement the ME's limited internal RAM.
The ME also has ***network access*** with its own MAC address through an
Intel Gigabit Ethernet Controller. Its boot program, stored on the
internal ROM, loads a firmware "manifest" from the PC's SPI flash
chip. This manifest is ***signed with a strong cryptographic key***,
which differs between versions of the ME firmware. If the manifest
isn't signed by a specific Intel key, the boot ROM won't load and
execute the firmware and the ME processor core will be halted.

The ME firmware is compressed and consists of modules that are listed in
the manifest along with secure cryptographic hashes of their contents.
One module is the operating system kernel, which is based on a
***proprietary real-time operating system (RTOS) kernel*** called
"ThreadX". The developer, Express Logic, sells licenses and source
code for ThreadX. Customers such as Intel are forbidden from disclosing
or sublicensing the ThreadX source code. Another module is the Dynamic
Application Loader (DAL), which consists of a ***Java virtual machine***
and set of preinstalled Java classes for cryptography, secure storage,
etc. The DAL module can load and execute additional ME modules from the
PC's HDD or SSD. The ME firmware also includes a number of native
application modules within its flash memory space, including Intel
Active Management Technology (AMT), an implementation of a Trusted
Platform Module (TPM), Intel Boot Guard, and audio and video DRM
systems.

The Active Management Technology (AMT) application, part of the Intel
"vPro" brand, is a Web server and application code that enables remote
users to power on, power off, view information about, and otherwise
manage the PC. It can be ***used remotely even while the PC is powered
off*** (via Wake-on-Lan). Traffic is encrypted using SSL/TLS libraries,
but recall that all of the major SSL/TLS implementations have had highly
publicized vulnerabilities. The AMT application itself has ***[known
vulnerabilities](https://en.wikipedia.org/wiki/Intel_Active_Management_Technology#Known_vulnerabilities_and_exploits)***,
which have been exploited to develop rootkits and keyloggers and
covertly gain encrypted access to the management features of a PC.
Remember that the ME has full access to the PC's RAM. This means that
an attacker exploiting any of these vulnerabilities may gain access to
everything on the PC as it runs: all open files, all running
applications, all keys pressed, and more.

[Intel Boot Guard](https://mjg59.dreamwidth.org/33981.md) is an ME
application introduced in Q2 2013 with ME firmware version 9.0 on 4th
Generation Intel Core i3/i5/i7 (Haswell) CPUs. It allows a PC OEM to
generate an asymmetric cryptographic keypair, install the public key in
the CPU, and prevent the CPU from executing boot firmware that isn't
signed with their private key. This means that ***coreboot and libreboot
are impossible to port*** to such PCs, without the OEM's private
signing key. Note that systems assembled from separately purchased
mainboard and CPU parts are unaffected, since the vendor of the
mainboard (on which the boot firmware is stored) can't possibly affect
the public key stored on the CPU.

ME firmware versions 4.0 and later (Intel 4 Series and later chipsets)
include an ME application for ***audio and video
[DRM](https://defectivebydesign.org/what_is_drm_digital_restrictions_management)***
called "Protected Audio Video Path" (PAVP). The ME receives from the
host operating system an encrypted media stream and encrypted key,
decrypts the key, and sends the encrypted media decrypted key to the
GPU, which then decrypts the media. PAVP is also used by another ME
application to draw an authentication PIN pad directly onto the screen.
In this usage, the PAVP application directly controls the graphics that
appear on the PC's screen in a way that the host OS cannot detect. ME
firmware version 7.0 on PCHs with 2nd Generation Intel Core i3/i5/i7
(Sandy Bridge) CPUs replaces PAVP with a similar DRM application called
"Intel Insider". Like the AMT application, these DRM applications,
which in themselves are defective by design, demonstrate the omnipotent
capabilities of the ME: this hardware and its proprietary firmware can
access and control everything that is in RAM and even ***everything that
is shown on the screen***.

The Intel Management Engine with its proprietary firmware has complete
access to and control over the PC: it can power on or shut down the PC,
read all open files, examine all running applications, track all keys
pressed and mouse movements, and even capture or display images on the
screen. And it has a network interface that is demonstrably insecure,
which can allow an attacker on the network to inject rootkits that
completely compromise the PC and can report to the attacker all
activities performed on the PC. It is a threat to freedom, security, and
privacy that can't be ignored.

Before version 6.0 (that is, on systems from 2008/2009 and earlier), the
ME can be disabled by setting a couple of values in the SPI flash
memory. The ME firmware can then be removed entirely from the flash
memory space. libreboot [does this](../docs/hardware/gm45_remove_me.md) on
the Intel 4 Series systems that it supports, such as the [Libreboot
X200](../docs/install/x200_external.md) and [Libreboot
T400](../docs/install/t400_external.md). ME firmware versions 6.0 and
later, which are found on all systems with an Intel Core i3/i5/i7 CPU
and a PCH, include "ME Ignition" firmware that performs some hardware
initialization and power management. If the ME's boot ROM does not find
in the SPI flash memory an ME firmware manifest with a valid Intel
signature, the whole PC will shut down after 30 minutes.

Due to the signature verification, developing free replacement firmware
for the ME is basically impossible. The only entity capable of replacing
the ME firmware is Intel. As previously stated, the ME firmware includes
proprietary code licensed from third parties, so Intel couldn't release
the source code even if they wanted to. And even if they developed
completely new ME firmware without third-party proprietary code and
released its source code, the ME's boot ROM would reject any modified
firmware that isn't signed by Intel. Thus, the ME firmware is both
hopelessly proprietary and "tivoized".

**In summary, the Intel Management Engine and its applications are a
backdoor with total access to and control over the rest of the PC. The
ME is a threat to freedom, security, and privacy, and the libreboot
project strongly recommends avoiding it entirely. Since recent versions
of it can't be removed, this means avoiding all recent generations of
Intel hardware.**

More information about the Management Engine can be found on various Web
sites, including [me.bios.io](http://me.bios.io/Main_Page),
[unhuffme](http://io.netgarage.org/me/), [coreboot
wiki](http://www.coreboot.org/Intel_Management_Engine), and
[Wikipedia](https://en.wikipedia.org/wiki/Intel_Active_Management_Technology).
The book ***[Platform Embedded Security Technology
Revealed](https://www.apress.com/9781430265719)*** describes in great
detail the ME's hardware architecture and firmware application modules.

If you're stuck with the ME (non-libreboot system), you might find this
interesting:
<http://hardenedlinux.org/firmware/2016/11/17/neutralize_ME_firmware_on_sandybridge_and_ivybridge.html>

Also see (effort to disable the ME):
<https://www.coreboot.org/pipermail/coreboot/2016-November/082331.html>
- look at the whole thread

### Firmware Support Package (FSP) {#fsp}

On all recent Intel systems, coreboot support has revolved around
integrating a blob (for each system) called the *FSP* (firmware support
package), which handles all of the hardware initialization, including
memory and CPU initialization. Reverse engineering and replacing this
blob is almost impossible, due to how complex it is. Even for the most
skilled developer, it would take years to replace. Intel distributes
this blob to firmware developers, without source.

Since the FSP is responsible for the early hardware initialization, that
means it also handles SMM (System Management Mode). This is a special
mode that operates below the operating system level. **It's possible
that rootkits could be implemented there, which could perform a number
of attacks on the user (the list is endless). Any Intel system that has
the proprietary FSP blob cannot be trusted at all.** In fact, several
SMM rootkits have been demonstrated in the wild (use a search engine to
find them).

### CPU microcode updates {#microcode}

All modern x86 CPUs (from Intel and AMD) use what is called *microcode*.
CPUs are extremely complex, and difficult to get right, so the circuitry
is designed in a very generic way, where only basic instructions are
handled in hardware. Most of the instruction set is implemented using
microcode, which is low-level software running inside the CPU that can
specify how the circuitry is to be used, for each instruction. The
built-in microcode is part of the hardware, and read-only. Both the
circuitry and the microcode can have bugs, which could cause reliability
issues.

Microcode *updates* are proprietary blobs, uploaded to the CPU at boot
time, which patches the built-in microcode and disables buggy parts of
the CPU to improve reliability. In the past, these updates were handled
by the operating system kernel, but on all recent systems it is the boot
firmware that must perform this task. Coreboot does distribute microcode
updates for Intel and AMD CPUs, but libreboot cannot, because the whole
point of libreboot is to be 100% [free
software](https://www.gnu.org/philosophy/free-sw.html).

On some older Intel CPUs, it is possible to exclude the microcode
updates and not have any reliability issues in practise. All current
libreboot systems work without microcode updates (otherwise, they
wouldn't be supported in libreboot). However, all modern Intel CPUs
require the microcode updates, otherwise the system will not boot at
all, or it will be extremely unstable (memory corruption, for example).

Intel CPU microcode updates are *signed*, which means that you could not
even run a modified version, even if you had the source code. If you try
to upload your own modified updates, the CPU will reject them.

The microcode updates alter the way instructions behave on the CPU. That
means they affect the way the CPU works, in a very fundamental way. That
makes it software. The updates are proprietary, and are software, so we
exclude them from libreboot. The microcode built into the CPU already is
not so much of an issue, since we can't change it anyway (it's
read-only).

### Intel is uncooperative 

For years, coreboot has been struggling against Intel. Intel has been
shown to be extremely uncooperative in general. Many coreboot
developers, and companies, have tried to get Intel to cooperate; namely,
releasing source code for the firmware components. Even Google, which
sells millions of *chromebooks* (coreboot preinstalled) have been unable
to persuade them.

Even when Intel does cooperate, they still don't provide source code.
They might provide limited information (datasheets) under strict
corporate NDA (non-disclosure agreement), but even that is not
guaranteed. Even ODMs and IBVs can't get source code from Intel, in
most cases (they will just integrate the blobs that Intel provides).

Recent Intel graphics chipsets also [require firmware
blobs](https://01.org/linuxgraphics/intel-linux-graphics-firmwares?langredirect=1).

Intel is [only going to get
worse](https://www.phoronix.com/scan.php?page=news_item&px=Intel-Gfx-GuC-SLPC)
when it comes to user freedom. Libreboot has no support recent Intel
platforms, precisely because of the problems described above. The only
way to solve this is to get Intel to change their policies and to be
more friendly to the [free
software](https://www.gnu.org/philosophy/free-sw.html) community.
Reverse engineering won't solve anything long-term, unfortunately, but
we need to keep doing it anyway. Moving forward, Intel hardware is a
non-option unless a radical change happens within Intel.

**Basically, all Intel hardware from year 2010 and beyond will never be
supported by libreboot. The libreboot project is actively ignoring all
modern Intel hardware at this point, and focusing on alternative
platforms.**

Why is the latest AMD hardware unsupported in libreboot? {#amd}
----------------------------------------------------------------------------

It is extremely unlikely that any post-2013 AMD hardware will ever be
supported in libreboot, due to severe security and freedom issues; so
severe, that *the libreboot project recommends avoiding all modern AMD
hardware. If you have an AMD based system affected by the problems
described below, then you should get rid of it as soon as possible*. The
main issues are as follows:

[We call on AMD to release source code and specs for the new AMD Ryzen
platforms! We call on the community to put pressure on AMD. Click here
to read more](amd-libre.md)

### AMD Platform Security Processor (PSP) 

This is basically AMD's own version of the [Intel Management
Engine](#intelme). It has all of the same basic security and freedom
issues, although the implementation is wildly different.

The Platform Security Processor (PSP) is built in on all Family 16h +
systems (basically anything post-2013), and controls the main x86 core
startup. PSP firmware is cryptographically signed with a strong key
similar to the Intel ME. If the PSP firmware is not present, or if the
AMD signing key is not present, the x86 cores will not be released from
reset, rendering the system inoperable.

The PSP is an ARM core with TrustZone technology, built onto the main
CPU die. As such, it has the ability to hide its own program code,
scratch RAM, and any data it may have taken and stored from the
lesser-privileged x86 system RAM (kernel encryption keys, login data,
browsing history, keystrokes, who knows!). To make matters worse, the
PSP theoretically has access to the entire system memory space (AMD
either will not or cannot deny this, and it would seem to be required to
allow the DRM "features" to work as intended), which means that it has
at minimum MMIO-based access to the network controllers and any other
PCI/PCIe peripherals installed on the system.

In theory any malicious entity with access to the AMD signing key would
be able to install persistent malware that could not be eradicated
without an external flasher and a known good PSP image. Furthermore,
multiple security vulnerabilities have been demonstrated in AMD firmware
in the past, and there is every reason to assume one or more zero day
vulnerabilities are lurking in the PSP firmware. Given the extreme
privilege level (ring -2 or ring -3) of the PSP, said vulnerabilities
would have the ability to remotely monitor and control any PSP enabled
machine completely outside of the user's knowledge.

Much like with the Intel Boot Guard (an application of the Intel
Management Engine), AMD's PSP can also act as a tyrant by checking
signatures on any boot firmware that you flash, making replacement boot
firmware (e.g. libreboot, coreboot) impossible on some boards. Early
anecdotal reports indicate that AMD's boot guard counterpart will be
used on most OEM hardware, disabled only on so-called "enthusiast"
CPUs.

### AMD IMC firmware 

Read <https://www.coreboot.org/AMD_IMC>.

### AMD SMU firmware 

Handles some power management for PCIe devices (without this, your
laptop will not work properly) and several other power management
related features.

The firmware is signed, although on older AMD hardware it is a symmetric
key, which means that with access to the key (if leaked) you could sign
your own modified version and run it. Rudolf Marek (coreboot hacker)
found out how to extract this key [in this video
demonstration](https://media.ccc.de/v/31c3_-_6103_-_en_-_saal_2_-_201412272145_-_amd_x86_smu_firmware_analysis_-_rudolf_marek),
and based on this work, Damien Zammit (another coreboot hacker)
[partially replaced it](https://github.com/zamaudio/smutool/) with free
firmware, but on the relevant system (ASUS F2A85-M) there were still
other blobs present (Video BIOS, and others) preventing the hardware
from being supported in libreboot.

### AMD AGESA firmware 

This is responsible for virtually all core hardware initialization on
modern AMD systems. In 2011, AMD started cooperating with the coreboot
project, releasing this as source code under a free license. In 2014,
they stopped releasing source code and started releasing AGESA as binary
blobs instead. This makes AGESA now equivalent to [Intel FSP](#fsp).

### AMD CPU microcode updates 

Read the Intel section 
practically the same, though it was found with much later hardware in
AMD that you could run without microcode updates. It's unknown whether
the updates are needed on all AMD boards (depends on CPU).

### AMD is incompetent (and uncooperative) 

AMD seemed like it was on the right track in 2011 when it started
cooperating with and releasing source code for several critical
components to the coreboot project. It was not to be. For so-called
economic reasons, they decided that it was not worth the time to invest
in the coreboot project anymore.

For a company to go from being so good, to so bad, in just 3 years,
shows that something is seriously wrong with AMD. Like Intel, they do
not deserve your money.

Given the current state of Intel hardware with the Management Engine, it
is our opinion that all performant x86 hardware newer than the AMD
Family 15h CPUs (on AMD's side) or anything post-2009 on Intel's side
is defective by design and cannot safely be used to store, transmit, or
process sensitive data. Sensitive data is any data in which a data
breach would cause significant economic harm to the entity which created
or was responsible for storing said data, so this would include banks,
credit card companies, or retailers (customer account records), in
addition to the "usual" engineering and software development firms.
This also affects whistleblowers, or anyone who needs actual privacy and
security.

What *can* I use, then? {#whatcaniuse}
-------------------------

Libreboot has support for fam15h AMD hardware (~2012 gen) and some
older Intel platforms like Napa, Montevina, Eagle Lake, Lakeport (2004-2006).
We also have support for some
ARM chipsets (rk3288). On the Intel side, we're also interested in some
of the chipsets that use Atom CPUs (rebranded from older chipsets,
mostly using ich7-based southbridges).

Will libreboot work on a ThinkPad T400 or T500 with an ATI GPU?
---------------------------------------------------------------------------------------------------

Short answer: yes. These laptops also have an Intel GPU inside, which
libreboot uses. The ATI GPU is ignored by libreboot.

These laptops use what is called *switchable graphics*, where it will
have both an Intel and ATI GPU. Coreboot will allow you to set (using
nvramtool) a parameter, specifying whether you would like to use Intel
or ATI. The ATI GPU lacks free native graphics initialization in
coreboot, unlike the Intel GPU.

Libreboot modifies coreboot, in such a way where this nvramtool setting
is ignored. Libreboot will just assume that you want to use the Intel
GPU. Therefore, the ATI GPU is completely disabled on these laptops.
Intel is used instead, with the free native graphics initialization
(VBIOS replacement) that exists in coreboot.

Will desktop/server hardware be supported?
------------------------------------------------------------------------

Libreboot now supports desktop hardware:
[(see list)](../docs/hardware/#supported_desktops_x86/intel)
(with full native video initialization).

A common issue with desktop hardware is the Video BIOS, when no onboard
video is present, since every video card has a different Video BIOS.
Onboard GPUs also require one, so those still have to be replaced with
free software (non-trivial task). Libreboot has to initialize the
graphics chipset, but most graphics cards lack a free Video BIOS for
this purpose. Some desktop motherboards supported in coreboot do have
onboard graphics chipsets, but these also require a proprietary Video
BIOS, in most cases.

Hi, I have &lt;insert random system here&gt;, is it supported?
--------------------------------------------------------------------------------------------------------

Most likely not. First, you must consult coreboot's own hardware
compatibility list at <http://www.coreboot.org/Supported_Motherboards>
and, if it is supported, check whether it can run without any
proprietary blobs in the ROM image. If it can: wonderful! Libreboot can
support it, and you can add support for it. If not, then you will need
to figure out how to reverse engineer and replace (or remove) those
blobs that do still exist, in such a way where the system is still
usable in some defined way.

For those systems where no coreboot support exists, you must first port
it to coreboot and, if it can then run without any blobs in the ROM
image, it can be added to libreboot. See: [Motherboard Porting
Guide](http://www.coreboot.org/Motherboard_Porting_Guide) (this is just
the tip of the iceberg!)

Please note that board development should be done upstream (in coreboot)
and merged downstream (into libreboot). This is the correct way to do
it, and it is how the libreboot project is coordinated so as to avoid
too much forking of the coreboot source code.

What about ARM?
-----------------------------------

Libreboot has support for some ARM based laptops, using the *Rockchip
RK3288* SoC. Check the libreboot [hardware compatibility
list](../docs/hardware/#supported_list), for more information.

General questions
=================

How do I install libreboot?
-------------------------------------------------------

See [installation guide](docs/install/)

How do I program an SPI flash chip?
---------------------------------------------------------------------------------

SPI flash chips can be programmed with the [BeagleBone
Black](../docs/install/bbb_setup.md) or the [Raspberry
Pi](../docs/install/rpi_setup.md).

It's possible to use a 16-pin SOIC test clip on an 8-pin SOIC chip, if you
align the pins properly. The connection is generally more sturdy.

How do I set a boot password?
-------------------------------------------------------------------

If you are using the GRUB payload, you can add a username and password
(salted, hashed) to your GRUB configuration that resides inside the
flash chip. The following guides (which also cover full disk encryption,
including the /boot/ directory) show how to set a boot password in GRUB:
[(Installing Debian or Devuan with FDE)](../docs/gnulinux/encrypted_debian.md)
and
[(Installing Parabola or Arch GNU+Linux-Libre, with FDE)](../docs/gnulinux/encrypted_parabola.md)

How do I write-protect the flash chip?
----------------------------------------------------------------------------

By default, there is no write-protection on a libreboot system. This is
for usability reasons, because most people do not have easy access to an
external programmer for re-flashing their firmware, or they find it
inconvenient to use an external programmer.

On some systems, it is possible to write-protect the firmware, such that
it is rendered read-only at the OS level (external flashing is still
possible, using dedicated hardware). For example, on current GM45
laptops (e.g. ThinkPad X200, T400), you can write-protect (see
[ICH9 gen utility](../docs/hardware/gm45_remove_me.html#ich9gen)).

It's possible to write-protect on all libreboot systems, but the instructions
need to be written. The documentation is in the main git repository, so you are
welcome to submit patches adding these instructions.

How do I change the BIOS settings?
------------------------------------------------------------------------

Libreboot actually uses the [GRUB
payload](http://www.coreboot.org/GRUB2). More information about payloads
can be found at
[coreboot.org/Payloads](http://www.coreboot.org/Payloads).

Libreboot inherits the modular payload concept from coreboot, which
means that pre-OS bare-metal *BIOS setup* programs are not very
practical. Coreboot (and libreboot) does include a utility called
*nvramtool*, which can be used to change some settings. You can find
nvramtool under *coreboot/util/nvramtool/*, in the libreboot source
archives.

The *-a* option in nvramtool will list the available options, and *-w*
can be used to change them. Consult the nvramtool documentation on the
coreboot wiki for more information.

In practise, you don't need to change any of those settings, in most
cases.

Libreboot locks the CMOS table, to ensure consistent functionality for
all users. You can use:

    $ nvramtool -C yourrom.rom -w somesetting=somevalue

This will change the default inside that ROM image, and then you can
re-flash it.

How do I pad a ROM before flashing?
--------------------------------------

Required for ROMs where the ROM image is smaller than the flash chip
(e.g. writing a 2MiB ROM to a 16MiB flash chip).

Create an empty (00 bytes) file with a size the difference between
the ROM and flash chip. The case above, for example:

    $ truncate -s +14MiB pad.bin

For x86 descriptorless images you need to pad from the *beginning* of the ROM:

    $ cat pad.bin yourrom.rom > yourrom.rom.new

For ARM and x86 with intel flash descriptor, you need to pad after the image:

    $ cat yourrom.rom pad.bin > yourrom.rom.new

Flash the resulting file. Note that cbfstool will not be able to
operate on images padded this way so make sure to make all changes to
the image, including runtime config, before padding.

To remove padding, for example after reading it off the flash chip,
simply use dd(1) to extract only the non-padded portion. Continuing with the
examples above, in order to extract a 2MiB x86 descriptorless ROM from a
padded 16MiB image do the following:

    $ dd if=flashromread.rom of=yourrom.rom ibs=14MiB skip=1

With padding removed cbfstool will be able to operate on the image as usual.

Do I need to install a bootloader when installing a distribution?
---------------------------------------------------------------------------------------------------

Libreboot integrates the GRUB bootloader already, as a
*[payload](http://www.coreboot.org/Payloads)*. This means that the GRUB
bootloader is actually *flashed*, as part of the boot firmware
(libreboot). This means that you do not have to install a boot loader on
the HDD or SSD, when installing a new distribution. You'll be able to
boot just fine, using the bootloader (GRUB) that is in the flash chip.

This also means that even if you remove the HDD or SSD, you'll still
have a functioning bootloader installed which could be used to boot a
live distribution installer from a USB flash drive. See
[How to install GNU+Linux on a libreboot system](../docs/gnulinux/grub_boot_installer.md)

Do I need to re-flash when I re-install a distribution?
-------------------------------------------------------------------------------------------

Not anymore. Recent versions of libreboot (using the GRUB payload) will
automatically switch to a GRUB configuration on the HDD or SSD, if it
exists. You can also load a different GRUB configuration, from any kind
of device that is supported in GRUB (such as a USB flash drive). For
more information, see
[Modifying the GRUB Configuration in Libreboot Systems](../docs/gnulinux/grub_cbfs.md)

What does a flash chip look like?
-----------------------------------------------------------------

SOIC-8 SPI flash chip:

![SOIT-8 SPI flash chip](images/soic8.jpg)

SOIC-16 SPI flash chip:

![SOIT-8 SPI flash chip](images/soic16.jpg)

Who did the logo?
----------------------------------------------------------------

See the [license information](logo/license.md).

The Libreboot logo is available as a [bitmap](logo/logo.png), a
[vector](logo/logo.svg), or a [greyscale vector](logo/logo_grey.svg).

Libreboot Inside stickers are available as a
[PDF](logo/stickers/libreboot-inside-simple-bold-1.60cmx2.00cm-diecut-3.pdf) or
a
[vector](logo/stickers/libreboot-inside-simple-bold-1.60cmx2.00cm-diecut-3.svg)

What other firmware exists outside of libreboot?
==================================================

The main freedom issue on any system, is the boot firmware (usually
referred to as a BIOS or UEFI). Libreboot replaces the boot firmware
with fully free code, but even with libreboot, there may still be other
hardware components in the system (e.g. laptop) that run their own
dedicated firmware, sometimes proprietary. These are on secondary
processors, where the firmware is usually read-only, written for very
specific tasks. While these are unrelated to libreboot, technically
speaking, it makes sense to document some of the issues here.

Note that these issues are not unique to libreboot systems. They apply
universally, to most systems. The issues described below are the most
common (or otherwise critical).

Dealing with these problems will most likely be handled by a separate
project.

### External GPUs

The Video BIOS is present on most video cards. For integrated graphics,
the VBIOS (special kind of OptionROM) is usually embedded
in the main boot firmware. For external graphics, the VBIOS is
usually on the graphics card itself. This is usually proprietary; the
only difference is that SeaBIOS can execute it (alternatively, you embed it
in a coreboot ROM image and have coreboot executes it, if you use a
different payload, such as GRUB).

On current libreboot systems, instead of VBIOS, coreboot native GPU init is used,
which is currently only implemented for Intel GPUs.
Other cards with proper KMS drivers can be initialized once Linux boots,
but copy of VBIOS may be still needed to fetch proper VRAM frequency
and other similar parameters (without executing VBIOS code).

In configurations where SeaBIOS and native GPU init are used together,
a special shim VBIOS is added that uses coreboot linear framebuffer.


### EC (embedded controller) firmware 

Most (all?) laptops have this. The EC (embedded controller) is a small,
separate processor that basically processes inputs/outputs that are
specific to laptops. For example:

-   When you flick the radio on/off switch, the EC will enable/disable
    the wireless devices (wifi, bluetooth, etc) and enable/disable an
    LED that indicates whether it's turned on or not
-   Listen to another chip that produces temperature readings, adjusting
    fan speeds accordingly (or turning the fan(s) on/off).
-   Takes certain inputs from the keyboard, e.g. brightness up/down,
    volume up/down.
-   Detect when the lid is closed or opened, and send a signal
    indicating this.
-   Etc.

Alexander Couzens from coreboot (lynxis on coreboot IRC) is working on a
free EC firmware replacement for the ThinkPads that are supported in
libreboot. See: <https://github.com/lynxis/h8s-ec> (not ready yet).

Most (all?) chromebooks have free EC firmware. Libreboot is currently
looking into supporting a few ARM-based chromebooks.

EC is present on nearly all laptops. Other devices use, depending on complexity,
either EC or variant with firmware in Mask ROM - SuperIO.

### HDD/SSD firmware 

HDDs and SSDs have firmware in them, intended to handle the internal
workings of the device while exposing a simple, standard interface (such
as AHCI/SATA) that the OS software can use, generically. This firmware
is transparent to the user of the drive.

HDDs and SSDs are quite complex, and these days contain quite complex
hardware which is even capable of running an entire operating system (by
this, we mean that the drive itself is capable of running its own
embedded OS), even GNU+Linux or BusyBox/Linux.

SSDs and HDDs are a special case, since they are persistent storage
devices as well as computers.

Example attack that malicious firmware could do: substitute your SSH
keys, allowing unauthorized remote access by an unknown adversary. Or
maybe substitute your GPG keys. SATA drives can also have DMA (through
the controller), which means that they could read from system memory;
the drive can have its own hidden storage, theoretically, where it could
read your LUKS keys and store them unencrypted for future retrieval by
an adversary.

With proper IOMMU and use of USB instead of SATA, it might be possible
to mitigate any DMA-related issues that could arise.

Some proof of concepts have been demonstrated. For HDDs:
<https://spritesmods.com/?art=hddhack&page=1> For SSDs:
<http://www.bunniestudios.com/blog/?p=3554>

Viable free replacement firmware is currently unknown to exist. For
SSDs, the
[OpenSSD](http://www.openssd-project.org/wiki/The_OpenSSD_Project)
project may be interesting.

Apparently, SATA drives themselves don't have DMA but can make use of
it through the controller. This
<http://www.lttconn.com/res/lttconn/pdres/201005/20100521170123066.pdf>
(pages 388-414, 420-421, 427, 446-465, 492-522, 631-638) and this
<http://www.intel.co.uk/content/dam/www/public/us/en/documents/technical-specifications/serial-ata-ahci-spec-rev1_3.pdf>
(pages 59, 67, 94, 99).

The following is based on discussion with Peter Stuge (CareBear\\) in
the coreboot IRC channel on Friday, 18 September 2015, when
investigating whether the SATA drive itself can make use of DMA. The
following is based on the datasheets linked above:

According to those linked documents, FIS type 39h is *"DMA Activate FIS
- Device to Host"*. It mentions *"transfer of data from the host to
the device, and goes on to say: Upon receiving a DMA Activate, if the
host adapter's DMA controller has been programmed and armed, the host
adapter shall initiate the transmission of a Data FIS and shall transmit
in this FIS the data corresponding to the host memory regions indicated
by the DMA controller's context."* FIS is a protocol unit (Frame
Information Structure). Based on this, it seems that a drive can tell
the host controller that it would like for DMA to happen, but unless the
host software has already or will in the future set up this DMA transfer
then nothing happens. **A drive can also send DMA Setup**. If a DMA
Setup FIS is sent first, with the Auto-Activate bit set, then it is
already set up, and the drive can initiate DMA. The document goes on to
say *"Upon receiving a DMA Setup, the receiver of the FIS shall
validate the received DMA Setup request."* - in other words, the host
is supposed to validate; but maybe there's a bug there. The document
goes on to say *"The specific implementation of the buffer identifier
and buffer/address validation is not specified"* - so noone will
actually bother. *"the receiver of the FIS"* - in the case we're
considering, that's the host controller hardware in the chipset and/or
the kernel driver (most likely the kernel driver). All SATA devices have
flash-upgradeable firmware, which can usually be updated by running
software in your operating system; **malicious software running as root
could update this firmware, or the firmware could already be
malicious**. Your HDD or SSD is the perfect place for a malicious
adversary to install malware, because it's a persistent storage device
as well as a computer.

Based on this, it's safe to say that use of USB instead of SATA is
advisable if security is a concern. USB 2.0 has plenty of bandwidth for
many HDDs (a few high-end ones can use more bandwidth than USB 2.0 is
capable of), but for SSDs it might be problematic (unless you're using
USB 3.0, which is not yet usable in freedom. See

Use of USB is also not an absolute guarantee of safety, so do beware.
The attack surface becomes much smaller, but a malicious drive could
still attempt a "fuzzing" attack (e.g. sending malformed USB
descriptors, which is how the tyrant DRM on the Playstation 3 was
broken, so that users could run their own operating system and run
unsigned code). (you're probably safe, unless there's a security flaw
in the USB library/driver that your OS uses. USB is generally considered
one of the safest protocols, precisely because USB devices have no DMA)

Other links:

-   <https://www.vice.com/en_us/article/ypwkwk/the-nsas-undetectable-hard-drive-hack-was-first-demonstrated-a-year-ago>

It is recommended that you use full disk encryption, on HDDs connected
via USB. There are several adapters available online, that allow you to
connect SATA HDDs via USB. Libreboot documents how to install several
distributions with full disk encryption. You can adapt these for use
with USB drives:

-   [Full disk encryption with Debian](../docs/gnulinux/encrypted_debian.md)
-   [Full disk encryption with Parabola](../docs/gnulinux/encrypted_parabola.md)

The current theory (unproven) is that this will at least prevent
malicious drives from wrongly manipulating data being read from or
written to the drive, since it can't access your LUKS key if it's only
ever in RAM, provided that the HDD doesn't have DMA (USB devices don't
have DMA). The worst that it could do in this case is destroy your data.
Of course, you should make sure never to put any keyfiles in the LUKS
header. **Take what this paragraph says with a pinch of salt. This is
still under discussion, and none of this is proven.**

### NIC (ethernet controller) 

Ethernet NICs will typically run firmware inside, which is responsible
for initializing the device internally. Theoretically, it could be
configured to drop packets, or even modify them.

With proper IOMMU, it might be possible to mitigate the DMA-related
issues. A USB NIC can also be used, which does not have DMA.

### CPU microcode 

Implements an instruction set. See 
description. Here we mean microcode built in to the CPU. We are not
talking about the updates supplied by the boot firmware (libreboot does
not include microcode updates, and only supports systems that will work
without it) Microcode can be very powerful. No proof that it's
malicious, but it could theoretically

There isn't really a way to solve this, unless you use a CPU which does
not have microcode. (ARM CPUs don't, but most ARM systems require blobs
for the graphics hardware at present, and typically have other things
like soldered wifi which might require blobs)

CPUs often on modern systems have a processor inside it for things like
power management. ARM for example, has lots of these.

### Sound card 

Sound hardware (integrated or discrete) typically has firmware on it
(DSP) for processing input/output. Again, a USB DAC is a good
workaround.

### Webcam 

Webcams have firmware integrated into them that process the image input
into the camera; adjusting focus, white balancing and so on. Can use USB
webcam hardware, to work around potential DMA issues; integrated webcams
(on laptops, for instance) are discouraged by the libreboot project.

### USB host controller 

Doesn't really apply to current libreboot systems (none of them have
USB 3.0 at the moment), but USB 3.0 host controllers typically rely on
firmware to implement the XHCI specification. Some newer coreboot ports
also require this blob, if you want to use USB 3.0.

This doesn't affect libreboot at the moment, because all current
systems that are supported only have older versions of USB available.
USB devices also don't have DMA (but the USB host controller itself
does).

With proper IOMMU, it might be possible to mitigate the DMA-related
issues (with the host controller).

### WWAN firmware 

Some laptops might have a simcard reader in them, with a card for
handling WWAN, connecting to a 3g/4g (e.g. GSM) network. This is the
same technology used in mobile phones, for remote network access (e.g.
internet).

NOTE: not to be confused with wifi. Wifi is a different technology, and
entirely unrelated.

The baseband processor inside the WWAN chip will have its own embedded
operating system, most likely proprietary. Use of this technology also
implies the same privacy issues as with mobile phones (remote tracking
by the GSM network, by triangulating the signal).

On some laptops, these cards use USB (internally), so won't have DMA,
but it's still a massive freedom and privacy issue. If you have an
internal WWAN chip/card, the libreboot project recommends that you
disable and (ideally, if possible) physically remove the hardware. If
you absolutely must use this technology, an external USB dongle is much
better because it can be easily removed when you don't need it, thereby
disabling any external entities from tracking your location.

Use of ethernet or wifi is recommended, as opposed to mobile networks,
as these are generally much safer.

On all current libreboot laptops, it is possible to remove the WWAN card
and sim card if it exists. The WWAN card is next to the wifi card, and
the sim card (if installed) will be in a slot underneath the battery, or
next to the RAM.

Operating Systems
=================

Can I use GNU+Linux?
--------------------------------------------------

Absolutely! It is well-tested in libreboot, and highly recommended. See
[installing GNU+Linux](../docs/gnulinux/grub_boot_installer.md) and
[booting GNU+Linux](../docs/gnulinux/grub_cbfs.md).

Any recent distribution should work, as long as it uses KMS (kernel mode
setting) for the graphics.

Fedora won't boot? (may also be applicable to Redhat/CentOS)
-----------------------------------------------------------

On Fedora, by default the grub.cfg tries to boot linux in 16-bit mode. You
just have to modify Fedora's GRUB configuration.
Refer to [the GNU+Linux page](docs/gnulinux/index.md#fedora-wont-boot).


Can I use BSD?
----------------------------------

Absolutely! Libreboot has native support for NetBSD, OpenBSD and LibertyBSD.
Other distros are untested.

See:
[docs/bsd/](docs/bsd/)

Are other operating systems compatible?
-------------------------------------------------------------------

Unknown. Probably not.

Does libreboot make my machine 100% free?
==========================================
Libreboot on all devices only provides host hardware init firmware images,
that can be written 25XX SPI NOR Flash. But on many systems there are
a lot more computers running blob firmware.
Some of them are not practicable to replace due to being located on Mask ROM.
Some devices have EC firmware being build as well.
Additionally, besides software components, there are hardware ones
(from ICs to boards) that are not released on OSHW licenses.
We do not have a single device that would be "100% free",
and such absolutes are nearly impossible to reach.

Notable proprietary blobs (not a complete list):

* All devices
	* SATA/PATA Hard Drive/Optical Disc Drive Firmware
  ([often contain powerful ARM based computer](
  http://spritesmods.com/?art=hddhack&page=1))
	* Pendrives and any USB peripherals - they contain a computer
  with code running to at the very least handle the USB protocol
* ThinkPads:
	* EC Firmware (H8S until including Sandy Bridge, later ARC based MEC16xx)
	* TrackPoint Firmware (8051)
	* Penabled devices contain µPD78F0514 MCU on wacom subboard,
  and Atmega (AVR) on led indicator/button board
	* Battery BMS, bq8030 (CoolRISC C816)
* Chomebooks C201PA/C100PA:
	* Battery BMS, bq30z55
	* Elan Touchpad
	* eMMC [flash memory controller](https://en.wikipedia.org/wiki/Flash_memory_controller) firmware

Where can I learn more about electronics
==========================================

* Basics of soldering and rework by PACE  
    Both series of videos are mandatory regardless of your soldering skill.
    * [Basic Soldering](https://www.youtube.com/watch?v=vIT4ra6Mo0s&list=PL926EC0F1F93C1837)
    * [Rework and Repair](https://www.youtube.com/watch?v=HKX-GBe_lUI&list=PL958FF32927823D12)
* [edX course on basics of electronics](https://www.edx.org/course/circuits-and-electronics-1-basic-circuit-analysis)  
    In most countries contents of this course is covered during
    middle and high school. It will also serve well to refresh your memory
    if you haven't used that knowledge ever since.
* Impedance intro
    * [Similiarities of Wave Behavior](https://www.youtube.com/watch?v=DovunOxlY1k)
    * [Reflections in tranmission line](https://www.youtube.com/watch?v=y8GMH7vMAsQ)
    * Stubs:
        * [Wikipedia article on stubs](https://en.wikipedia.org/wiki/Stub_(electronics))
        * [Polar Instruments article on stubs](http://www.polarinstruments.com/support/si/AP8166.html)  
        With external SPI flashing we only care about unintended PCB stubs
* [How to accurately measure header/connector pitch](https://www.microcontrollertips.com/accurately-measure-headerconnector-pitch/)
* Other YouTube channels with useful content about electronics
    * [EEVblog](https://www.youtube.com/channel/UC2DjFE7Xf11URZqWBigcVOQ)
    * [Louis Rossmann](https://www.youtube.com/channel/UCl2mFZoRqjw_ELax4Yisf6w)
    * [mikeselectricstuff](https://www.youtube.com/channel/UCcs0ZkP_as4PpHDhFcmCHyA)
    * [bigclive](https://www.youtube.com/channel/UCtM5z2gkrGRuWd0JQMx76qA)
    * [ElectroBOOM](https://www.youtube.com/channel/UCJ0-OtVpF0wOKEqT2Z1HEtA)
    * [Jeri Ellsworth](https://www.youtube.com/user/jeriellsworth/playlists)
* Boardview files can be open with [OpenBoardview](https://github.com/OpenBoardView/OpenBoardView),
which is free software under MIT license.

Use of youtube-dl with mpv would be recommended for youtube links

Lastly the most important message to everybody gaining this wonderful new hobby - [Secret to Learning Electronics](https://www.youtube.com/watch?v=xhQ7d3BK3KQ)
