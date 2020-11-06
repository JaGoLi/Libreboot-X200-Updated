[Update](https://yro.slashdot.org/story/17/07/19/1459244/amd-has-no-plans-to-release-psp-code): unfortunatly AMD has no plans to release the source code and instead trusts third-party "hackers" to audit the "feature", too much pressure from govererment agencies? who knows?

---
title: We call on AMD to release source code and specs for Ryzen platform
...

Recently in the Libreboot project, we've been informed about the new
Ryzen platforms being released and sold by AMD. They are currently
taking input from the community. Here are ways you can contact AMD to
tell them that you demand libre hardware:

-   <https://www.reddit.com/r/Amd/comments/5x4hxu/we_are_amd_creators_of_athlon_radeon_and_other/def5h1b/>
-   <https://twitter.com/amd?lang=en>
-   <https://www.facebook.com/AMD/>
-   <https://community.amd.com/places?filterID=all%7Eobjecttype%7Espace>
-   <https://www.amd.com/en-us/who-we-are/contact> (has contact links
    for multiple countries)

-   **AMD's CEO, Lisa Su, can be contacted directly via email. Tell her
    that you demand libre hardware: <lisa.su@amd.com>**

Libreboot aims to provide fully *free software* initialization firmware
on Intel, AMD, ARM, POWER and RISC-V platforms, and already does so on
some older platforms.

As documented in the [Libreboot FAQ section](../faq.md#amd), AMD is
currently uncooperative in the libre software movement. Specifically, it
releases non-free binary-only firmware for its platforms, along with
tyrant technologies like the [AMD Platform Security
Processor](../faq.md#amdpsp).

We in the Libreboot project call on AMD to release source code and start
cooperating with our upstream, [coreboot](https://coreboot.org/) (and
[librecore](http://librecore.info)) for its new Ryzen platform and
existing Zen platforms. This includes source code for all initialization
firmware (typically referred to as the BIOS or UEFI firmware, by some
members of the community), and in particular, the *AMD Platform Security
Processor*, to allow the free/libre software community to use AMD
hardware that is entirely freedom-respecting. If it's not too much to
ask, we also would like source code and signing keys, including for the
PSP and microcode for the CPU.

We would also like to have board design guides, datasheets and
footprints for CPUs/southbridges and so on.

We especially need the signing keys to be released, for those components
which are signed (PSP, CPU microcode, SMU, etc). This will make
utilising any released source code possible (at present, some components
will not run unless the firmware is signed by a certain signature,
usually under lock and key by the hardware manufacturer).

We in the community need freedom-respecting hardware! We call on AMD to
work with us in the Libreboot, Coreboot and Librecore projects on
bringing about a world where computing technology is no longer under
lock and key from the manufacturer, and instead in the control and
ownership of users.

This has several benefits for AMD. There is currently a huge demand in
the market for libre hardware. At present, the only companies providing
it are ones like libreboot suppliers where systems are sold with entirely free
software, including the boot firmware and operating system, without any signed
firmware for which no keys are available to the public.

The problem? These companies are selling much older systems that are
made libre mostly through reverse engineering. At present, the systems
sold by such companies are using older hardware designs from 5-10 years
ago, which means that most people who wish to use all libre software
cannot do so, due to practicality concerns. There are some people who
will use these older systems, but that is not without a huge sacrifice
to their convenience since they end up using older, obsolete hardware
and certain tasks (especially serious software development) becomes
impractical for a lot of people.

AMD has the power to reverse this trend, and there is a potential for a
great amount of profit to be made. The free/libre and open source
software communities would jump head over heels to support such a move.
In other words, AMD can make money from investing in the libre software
community.

There is even a precedent already set. AMD previously did release source
code for all of their newer platforms, to the coreboot project, but then
they stopped. We're calling for this to resume, and to expand further
than before.

Here are some examples of popular campaigns, some of which were
successful:

-   <https://www.crowdsupply.com/sutajio-kosagi/novena>
-   <https://www.crowdsupply.com/eoma68/micro-desktop>
-   <https://www.crowdsupply.com/raptor-computing-systems/talos-secure-workstation>

In all of these cases, the campaigns were popular and this was despite
the hardware either being low-end and unsuitable for most people, or too
expensive for most people to afford.

Then look at the popularity of the Libreboot project.

Just imagine what would happen if AMD started to produce cheap,
affordable libre hardware, to the point where Libreboot could start
supporting newer systems from AMD. The possibilities are endless! People
would jump towards AMD and AMD's sales would go through the roof, while
we in the libre hardware community would finally have systems from a
manufacturer that cares for our freedoms to use our computers without
proprietary software.

Even low-end hardware like the BeagleBone or Raspberry Pi ([which can be
liberated](https://blog.rosenzweig.io/blobless-linux-on-the-pi.md))
shows that libre technology is profitable, and desired by the community.

Then look at the Google Chromebooks. These devices come with coreboot
preinstalled by default! There are even some ARM chromebooks that we
support in Libreboot, which are still produced and sold brand new by
resellers (e.g. Amazon, Newegg, etc). These devices are sold in the
millions! This just shows that it's not only possible, but profitable,
for AMD to start releasing systems which respect the freedom of users.

It's not just commercial benefits that are made possible. There are all
kinds of possibilities for scientific research if systems are libre at
the hardware/firmware level. For instance, at present, universities do
not teach BIOS / boot firmware development in their computer science
courses, because this technology is currently restricted by
manufacturers and available only to a privileged few.

AMD has the power to do the right thing. We in Libreboot call on AMD to
work with us in building a world where users of technology can use their
computers without relying on any proprietary software. We want - need -
a world of highly secure, libre, owner-controlled hardware, from
companies that care about software freedom.

We in the Libreboot project are available to contact, using the details
on the homepage. We look forward to working with AMD :)

