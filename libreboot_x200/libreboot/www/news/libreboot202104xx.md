% New Libreboot release, ETA late April 2021 / early June 2021
% Leah Rowe
% 30 March 2021

Rapid progress is being made towards a new Libreboot release. It should be done
by late April or early June 2021. Many new boards will be supported, with lots
of bugs fixed, new features added and the latest coreboot/GRUB/SeaBIOS versions
used on all boards. The Libreboot website will be massively overhauled.

I, Leah Rowe, have re-taken full control of the Libreboot project after 4 years
delay in bringing out a new release. Long story in short, Libreboot began a new
and ambitious re-write of its build system in 2017; as of 2021, that build
system is still not ready; the design is fundamentally flawed and the code is
unmaintainable so I have scrapped the rewrite entirely. The work will be
preserved, for reference, but it has otherwise been abandoned.

I, Leah Rowe, was not responsible for that re-write. The design of that
re-written build system is fundamentally flawed, and it has too many bugs. The
people working on it kept adding too many new features without fixing
fundamental issues. I have revoked all of their access to project
infrastructure; Libreboot is now lead by me. I have a completely different idea
for how to run the project and what a *coreboot distro* should be.

I, Leah Rowe, stepped down from Libreboot development in 2017. Since late 2020,
I've been actively developing Libreboot again. I have been working on another
project, forked via Libreboot 20160907 build system `lbmk` but on documentation
from December 2020. That project is: <http://osboot.org/> - if Libreboot seems
dead to you right now, it's because I've been doing the work exclusively in
osboot, with the intention of adapting that work back into Libreboot.

osboot has very different goals than Libreboot, but the build system there is
vastly improved. I have focused on adding all *libre-friendly* boards to osboot
which means anything that Libreboot does support, or can support. I am
presently using a version of coreboot from December 2020, with patches applied
on top to improve certain functionality on specific boards.

osboot *does not comply* with Libreboot policy; it permits binary blobs. The
purpose of osboot is to provide support for coreboot targets that aren't
yet easy to support in Libreboot, for those who wish to use such hardware. This
is because in many cases, such people will insist on using what hardware they
already have, or they have a need for newer hardware. The coreboot software has
support for lots of hardware. In my opinion, these people will likely not just
install upstream coreboot with a payload; they will want something pre-built
for them that is easy to install, with user-friendly instructions and support.
In other words, they want a *coreboot distro* like Libreboot. In the name
of *harm reduction*, I provide the osboot project precisely for such people, so
as to reduce the amount of non-free software they use; the idea is that osboot
is better, for those people, than using a *completely* non-free machine. osboot
also contains support for most libreboot targets at this point, and the rest
will be added soon; on *those* (and all other x86 machines), microcode updates
are included by default. *Most* boards that coreboot supports do still require
binary blobs; the ones that Libreboot supports represent a small minority of
coreboot targets! This is a sad reality, which has limited the Libreboot
project's possibilities for years.

I wanted to start something like osboot for a long time. Well, I'm nearly done
adding all *libre-friendly* x86 boards to it; in addition to ones already in
Libreboot, I've added others such as the ThinkPad R500. More will be added
soon. I have made vast improvements to the build system (compared to Libreboot
20160907), so all I need to do now is add all the configs for those libre
friendly boards and ensure that adequate documentation is provided. I can then
provide a release with pre-compiled ROM images and full source code.

As soon as this is ready, I will *fork osboot* to create `osboot-libre`. This
will be FSF-endorseable and comply with the same criteria as Libreboot. The
reason is because I want to create a source-based, rolling release coreboot
distro with configurability similar to what you'd find in emerge and the
OpenWRT build system. However, that's for much later:

osboot-libre will be used as a reference to then create a new Libreboot release.
The *source-based coreboot distro* aspect will not be implemented in osboot or
osboot-libre until the new Libreboot release is ready.

Aside from specific board support, here are some nice improvements currently
in the osboot build system compared to Libreboot 20160907:

* Generally it is much more cleanly written, and more modular
* You no longer have to manually run individual commands within lbmk (in osboot
  it's called osbmk. osboot-make): each command checks if previous commands
  required were run, and runs them if not. **This means you can just type a
  single command to build a ROM image if you wish!**
* Makefile included, making the build system even easier to use. The Makefile
  contains no logic, it just runs osbmk (osboot-make) commands
* Vastly improved `grub.cfg`: un-hardcodes a lot of functionality, improved
  usability on i945 targets such as X60/T60/macbook21, USB HDD support out of
  the box
* GRUB module missing errors fixed; all standard GRUB modules now included
* LUKS2 now supported in the GRUB payload.
* Geli now supported in the GRUB payload. (FreeBSD encryption thing)
* The documentation is much cleaner
* Tianocore payload supported, for UEFI
* SeaBIOS now included as standard, on all ROM images; on images with the GRUB
  payload, SeaBIOS is an option in the boot menu.
* The build system is *much* easier to use when adding new board configs
* Each `board.cfg` for each board defines what payloads it is to use, what
  architecture, etc. Coreboot trees are now handled on a directory basis,
  instead of creating multiple branches in a newly initialized Git repository;
  this is less efficient on disk space, but it is simpler to maintain, so now
  the priority is to minimize how ever many coreboot revisions are used.
* Boards can link to other boards; for example, X200 could use the same setup
  as T400. However, in this case the specific board would still have it's own
  specific coreboot configuration files.
* Build system highly optimized; unnecessary steps are skipped. If you just
  want to build for 1 board, you can! Only the things necessary for that board
  will be compiled by osbmk, at least automatically that is!
* In general, it is a *much more automated* automated build system!

Check the hardware support compared to Libreboot:
<https://osboot.org/docs/hardware/> (NOTE: some of the machines listed there
cannot be added to Librbeboot, but you can see that a lot of Libreboot-friendly
hardware is already present in osboot. Only those targets that can run blob
free will be in Libreboot, and coreboot supports of lot more of such hardware
nowadays).

Plans:

* Scrap libreboot.git
* Split build system into `lbmk.git`
* Split web/docs to into `lbwww.git`
* Split images into `lbwww-img`
* Split utils into separate repositories e.g. `ich9utils.git`

This splitting of the repositories will make each part of Libreboot much more
easily maintainable by contributors. This splitting up of the repository has
already been implemented in osboot!

**The entire `libreboot.org` website will be -->nuked<-- as will the account on 
notabug.org. I intend to set up a self-hosted GitLab CE on libreboot.org.**

Stay tuned! The new site and new project will be much better.

PS:

Codes of conduct are stupid
---------------------------

Libreboot has abolished its Code of Conduct. I no longer believe that a CoC is
effective; in reality, it does not prevent bad behaviour and it discourages
people from joining the project. CoCs are ultimately counter-productive. It's
obvious when someone is behaving badly; common sense will prevail!

All I want is code. Your code.

The particular code of conduct that Libreboot adopted was the Contributor
Covenant by Coraline Ada Ehmke. At the time, I did not know of her. Recently,
I *have* learned about her. She is pure evil. She regularly harasses people on
the internet, while hiding behind her minority status as a transgender person
so that people are less likely to criticize her. She acts like a total fascist,
going around the internet looking for people that disagree with her political
views; she then attempts to *cancel* those people. See: cancel culture.

Coraline: I am transgender, and I'm deeply saddened by your views. You do not
represent us, and I reject your ideas entirely. Your so-called *Ethical Source*
movement pushes non-free licenses; specifically, these licenses, so-called
Ethical licenses, place huge restrictions on the usage of the software. If a
person uses a program under such licensing, the author can literally deny you
access if they happen to disagree with your political views. I believe that all
people should have freedom in their computing, even if I dislike their views.

This is why I revoked the code of conduct (Contributor Covenant) on
libreboot.org. I do not wish for *Libreboot* to be associated with her. Every
time someone reads a copy of the Contributor Covenant, Coraline's influence to
distribute non-free software licenses becomes stronger.

I, Leah Rowe, oppose non-free software and I *reject* Coraline Ada's ideology.
Libreboot will not be implementing another code of conduct. I initially was
going to, but there is no need.
