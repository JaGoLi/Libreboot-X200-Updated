---
title: Configuring Parabola (Post-Install)
x-toc-enable: true
...

This is the guide for setting up Parabola GNU+Linux-Libre, after completing
the installation steps outlined in [Installing Parabola or Arch GNU+Linux-Libre with Full-Disk Encryption (including /boot)](encrypted_parabola.md).
It will cover installing and configuring a graphical desktop environment,
as well as some applications that make the system more user friendly.

For this example, we chose the *MATE Desktop Environment* as our graphical interface.

*This guide was valid on 2017-06-02. If you see any changes that should
to be made at the present date, please get in touch with the Libreboot
project (or [make those changes yourself](https://libreboot.org/git.html#editing-the-website-and-documentation-wiki-style))!*

While Parabola can seem daunting at first glance (especially for new GNU+Linux users),
with a simple guide, it can provide all the same usability
as any Debian-based GNU+Linux distribution (e.g., Trisquel, Debian, and Devuan),
without hiding any details from the user.

Paradoxically, as you get more advanced, Parabola can actually become
*easier to use*, when you want to set up your system in a special way,
compared to what most distributions provide. You will find over time
that other distributions tend to *get in your way*.

A lot of the steps in this guide will refer to ArchWiki. Arch is
the upstream distribution that Parabola uses. Most of this guide will
also tell you to read wiki articles, other pages, manuals, and so on. In
general, it tries to cherry-pick the most useful information, but
nonetheless, you are encouraged to learn as much as possible.

**NOTE: It might take you a few days to fully install your system how you like,
depending on how much you need to read. Patience is key, especially for new users.**

The ArchWiki will sometimes use bad language, such as calling the whole
system Linux, using the term **open-source**/**closed-source**,
and it will sometimes recommend the use of proprietary software.
You need to be careful about this when reading anything on ArchWiki.

Some of these steps require internet access. To get initial access
for setting up the system (I'll go into networking later),
just connect your system to a router, via an ethernet cable,
and run the following command:

    # systemctl start dhcpcd.service

You can stop it later (if needed), by using systemd's `stop` option:

    # systemctl stop dhcpcd.service

For most people, this should be enough, but if you don't have DHCP enabled
on your network, then you should setup your network connection first:
[Set Up Network Connection in Parabola](#network).

## Configure pacman
`pacman` (*pac*kage *man*ager) is the name of the package management system
in Arch, which Parabola (as a deblobbed, parallel effort) also uses.
Like with `apt-get` on Trisquel, Debian, or Devuan, this can be used to
add, remove, and update the software on your computer.

For more information related to `pacman`, review the following articles on the Arch Wiki:

*    [Configuring pacman](https://wiki.parabolagnulinux.org/Installation_Guide#Configure_pacman)
*    [Using pacman](https://wiki.archlinux.org/index.php/Pacman)
*    [Additional Repositories](https://wiki.parabolagnulinux.org/Official_Repositories)

## Updating Parabola
Parabola is kept up-to-date, using `pacman`. When you are updating Parabola,
make sure to refresh the package list, *before* installing any new updates:

    # pacman -Syy

**NOTE: According to the Wiki,** `-Syy` **is better than** `-Sy` **, because it refreshes
the package list (even if it appears to be up-to-date), which can be useful
when switching to another mirror.**

Then, actually update the system:

    # pacman -Syu

**NOTE: Before installing packages with** `pacman -S`**, always update first,
using the two commands above.**

Keep an eye out on the output, or read it in **/var/log/pacman.log**.
Sometimes, `pacman` will show messages about maintenance steps that you
will need to perform with certain files (typically configurations) after
the update. Also, you should check both the [Parabola home page](https://www.parabola.nu/) and [Arch home page](https://www.archlinux.org/),
to see if they mention any issues. If a new kernel is installed, you should also
update to be able to use it (the currently running kernel will also be fine).

It's generally good enough to update Parabola once every week, or maybe twice.
As a rolling release distribution, it's a never a good idea to leave your installation
too outdated. This is simply because of the way the project works;
old packages are deleted from the repositories quickly, once they are updated.
A system that hasn't been updated for quite a while will mean potentially more
reading of previous posts through the website, and more maintenance work.

The Arch forum can also be useful, if others have the same issue as you.
The *Parabola* IRC channel ([**\#parabola**](https://webchat.freenode.net/) on freenode) can also help you.

Due to this, and the volatile nature of Parabola/Arch, you should only
update when you have at least a couple hours of spare time, in case of
issues that need to be resolved. You should never update, for example,
if you need your system for an important event, like a presentation, or
sending an email to an important person before an allocated deadline,
and so on.

Relax! Packages are well-tested, when new updates are made to
the repositories; separate 'testing' repositories exist for this exact
reason. Despite what many people may tell you, Parabola is fairly
stable and trouble-free, so long as you are aware of how to check for
issues, and are willing to spend some time fixing issues, in the rare
event that they do occur (this is why Arch/Parabola provide such extensive documenatation).

## Maintaining Parabola
Parabola is a very simple distro, in the sense that you are in full
control, and everything is made transparent to you. One consequence is
that you also need to know what you are doing, and what you have done
before. In general, keeping notes (such as what I have done with this
page) can be very useful as a reference in the future (e.g, if you wanted to
re-install it, or install the distro on another computer).

You should also read the ArchWiki article on [System Maintenance](https://wiki.archlinux.org/index.php/System_maintenance),
before continuing. Also, read their article on [enhancing system stability](https://wiki.archlinux.org/index.php/Enhance_system_stability).
This is important, so make sure to read them both!*

Install `smartmontools`; it can be used to check smart data. HDDs use
non-free firmware inside; it's transparent to you, but the smart
data comes from it. Therefore, don't rely on it too much), and then read
the ArchWiki [article](https://wiki.archlinux.org/index.php/S.M.A.R.T.) on it, to learn how to use it:

    # pacman -S smartmontools

### Cleaning the Package Cache
*This section provides a brief overview of how to manage the directory that stores
a cache of all downloaded packages. For more information,
check out the Arch Wiki guide for [Cleaning the Package Cache](https://wiki.archlinux.org/index.php/Pacman#Cleaning_the_package_cache).*

Here's how to use `pacman`, to clean out all old packages that are cached:

    # pacman -Sc

The Wiki cautions that this should be used with care. For example, since
older packages are deleted from the repository, if you encounter issues
and want to revert back to an older package, then it's useful to have the
caches available. Only do this ,if you are sure that you won't need it.

The Wiki also mentions this method for removing everything from the
cache, including currently installed packages that are cached:

    # pacman -Scc

This is inadvisable, since it means re-downloading the package again, if
you wanted to quickly re-install it. This should only be used when disk
space is at a premium.

### pacman Command Equivalents
If you are coming from another GNU+Linux distribution, you probably want to know
the command equivalents for the various `apt-get`-related commands that you often use.
For that information, refer to [Pacman/Rosetta](https://wiki.archlinux.org/index.php/Pacman/Rosetta),
so named, because it serves as a Rosetta Stone to the esoteric pacman language.

## your-freedom
`your-freedom` is a package specific to Parabola, and it is installed by
default. What it does is conflict with packages from Arch that are known
to be non-free (proprietary) software. When migrating from Arch (there
is a guide on the Parabola wiki for migrating (i.e,. converting) an existing
Arch system to a Parabola system), installing it will also
fail, if these packages are installed, citing them as conflicts; the
recommended solution is then to delete the offending packages, and
continue installing `your-freedom`.

## Add a User
This is based on the Arch Wiki guide to [Users and Groups](https://wiki.archlinux.org/index.php/Users_and_Groups).

It is important (for security reasons) to create and use a non-root
(non-admin) user account for everyday use. The default **root** account
is intended only for critical administrative work, since it has complete
access to the entire operating system.

Read the entire document linked to above, and then continue.

Add your user with the `useradd` command (self explanatory):

    # useradd -m -G wheel -s /bin/bash *your_user_name*

Set a password, using `passwd`:

    # passwd *your_user_name*

Like with the installation of Parabola, use of the [*diceware method*](http://world.std.com/~reinhold/diceware.html) is recommended,
for generating secure passphrases.

### Configure sudo
Now that we have a normal user account, we'll want to configure `sudo`,
so that user is able to run commands as **root** (e.g., installing software);
this will be necessary to flash the ROM later on. Refer to ArchWiki's [sudo](https://wiki.archlinux.org/index.php/Sudo) documentation.

The first step is to install the `sudo` package:

    # pacman -S sudo

After installation, we must configure it. To do so, we must modify **/etc/sudoers**.
This file must *always* be modified with the `visudo` command. `visudo` can be
difficult for beginners to use, so we'll want to edit the file with `nano`,
but the trick is that we just can't do this:

    # nano /etc/sudoers

Because, this will cause us to edit the file directly, which is not the way
it was designed to be edited, and could lead to problems with the system.
Instead, to temporarily allow us to use `nano` to edit the file,
we need to type this into the terminal:

    # EDITOR=nano visudo

This will open the **/etc/sudoers** file in `nano`, and we can now safely make changes to it.

To give the user we created earlier to ability to use `sudo`, we need to navigate
to the end of the file, and add this line on the end:

    your_username ALL=(ALL) ALL

Obviously, type in the name of the user you created, instead of **your_username**.
Save the file, and exit `nano`; your user now has the ability to use `sudo`.

## systemd
`systemd` is the name of the program for managing services in Parabola;
It is a good idea to become familiar with it. Read the Arch Wiki article on [systemd](https://wiki.archlinux.org/index.php/systemd),
as well as their [Basic systemctl usage](https://wiki.archlinux.org/index.php/systemd#Basic_systemctl_usage) article,
to gain a full understanding. *This is very important! Make sure to read them.*

An example of a **service** could be a VPN (allowing you to connect to an outside network),
an applet in the system tray that tells you the weather for your city,
a sound manager (to make sure you can hear sound through speakers or headphones),
or DHCP (which allows you to get an IP address, to connect to the internet).
These are just a few examples; there are countless others.

`systemd` is a controversial init system; A [forum post](https://bbs.archlinux.org/viewtopic.php?pid=1149530#p1149530)
has an explanation behind the Arch development team's decision to use it.

The **manpage** should also help:

    # man systemd

The section on **unit types** is especially useful.

According to the wiki, `systemd's` journal keeps logs of a size up to 10% of the
total size that your root partition takes up. On a 60GB root, this would mean 6GB.
That's not exactly practical, and can have performance implications later,
when the log gets too big. Based on instructions from the wiki,
I will reduce the total size of the journal to 50MiB (that's what the wiki recommends).

Open **/etc/systemd/journald.conf**, and find this line:

    #SystemMaxUse=

Change it to this:

    SystemMaxUse=50M

Restart `journald`:

    # systemctl restart systemd-journald

The wiki recommends that if the journal gets too large, you can also
simply delete (`rm -Rf`) everything inside **/var/log/journald**, but
recommends backing it up. This shouldn't be necessary, since you
already set the size limit above, and `systemd` will automatically start
to delete older records, when the journal size reaches it's limit (according to systemd developers).

Finally, the wiki mentions **temporary files**, and the utility for
managing them.

    # man systemd-tmpfiles

To delete the temporary files, you can use the `clean` option:

    # systemd-tmpfiles --clean

According to the **manpage**, this *"cleans all files and directories with
an age parameter"*. According to ArchWiki, this reads information
in **/etc/tmpfiles.d** and **/usr/lib/tmpfiles.d**, to know what actions to perform.
Therefore, it is a good idea to read what's stored in these locations, to get a better understanding.

I looked in **/etc/tmpfiles.d/** and found that it was empty on my system.
However, **/usr/lib/tmpfiles.d** contained some files. The first one was
**etc.conf**, containing information and a reference to this **manpage**:

    # man tmpfiles.d

Read that **manpage**, and then continue studying all the files.

The `systemd` developers tell me that it isn't usually necessary
to manually touch the `systemd-tmpfiles utility`, at all.

## Interesting Repositories
In their [kernels](https://wiki.parabolagnulinux.org/Repositories#kernels) article,
the Parabola wiki mentions a repository called `\[kernels\]`, for custom kernels
that aren't in the default **base**. It might be worth looking into what is available there,
depending on your use case.

I enabled it on my system, to see what was in it. Edit **/etc/pacman.conf**,
and below the **extra** section add:

    [kernels]
    Include = /etc/pacman.d/mirrorlist*

Now, sync with the newly-added repository:

    # pacman -Syy

Lastly, list all available packages in this repository:

    # pacman -Sl kernels

In the end, I decided not to install anything from it,
but I kept the repository enabled regardless.

## Setup a Network Connection in Parabola
Read the ArchWiki guide to [Configuring the Network](https://wiki.archlinux.org/index.php/Configuring_Network).

### Set the Hostname
This should be the same as the hostname that you set in **/etc/hostname**,
when installing Parabola. You should also do it with `systemd`.
If you chose the hostname *parabola*, do it this way:

    # hostnamectl set-hostname parabola

This writes the specified hostname to **/etc/hostname**.
More information can be found in these **manpages**:

    # man hostname
    # info hostname
    # man hostnamectl

Check **/etc/hosts**, to make sure that the hostname that you put in there
during installation is still on each line:

    127.0.0.1 localhost.localdomain localhost parabola
    ::1       localhost.localdomain localhost parabola

You'll note that I set both lines; the second line is for IPv6. Since more and
more ISPs are providing this now, it's good to be have it enabled, just in case.

The `hostname` utility is part of the `inetutils` package, and is in the **core** repository,
installed by default (as part of the **base** package).

### Network Status
According to ArchWiki, [udev](https://wiki.archlinux.org/index.php/Udev) should already detect
the ethernet chipset, and automatically load the driver for it at boot time.
You can check this in the **Ethernet controller** section, when running the `lspci` command:

    # lspci -v

Look at the remaining sections **Kernel driver in use** and **Kernel modules**.
In my case, it was as follows:

    Kernel driver in use: e1000e
    Kernel modules: e1000e

Check that the driver was loaded, by issuing `dmesg | grep module_name`.
In my case, I did:

    # dmesg | grep e1000e

### Network Device Names
According to the ArchWiki guide on [Configuring Network Device Names](https://wiki.archlinux.org/index.php/Configuring_Network#Device_names),
it is important to note that the old interface names that you might be used to
(e.g., `eth0`, `wlan0`, `wwan0`, etc.), if you come from a distribution like Debian or Trisquel,
are no longer applicable. Instead, `systemd` creates device names
starting with `en` (for ethernet), `wl` (for wi-fi), and `ww` (for wwan),
with a fixed identifier that it automatically generates.
An example device name for your ethernet chipset would be `enp0s25`,
and is never supposed to change.

If you want to enable the old names, ArchWiki recommends adding `net.ifnames=0`
to your kernel parameters (in Libreboot context, this would be accomplished by following
the instructions in [How to replace the default GRUB configuration file](grub_cbfs.md)).

For background information, read [Predictable Network Interface Names](http://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/).

To show what the device names are for your system, run the following command:

    # ls /sys/class/net

[Changing the device names](https://wiki.archlinux.org/index.php/Configuring_Network#Change_device_name) is possible,
but for the purposes of this guide, there is no reason to do it.

### Network Setup
Aside from the steps mentioned above, I choose to ignore most of Networking section on the wiki;
this is because I will be installing the *MATE Desktop Environment*, and thus will
be using the `NetworkManger` client (with its accompanying applet) to manage the network.

If you wish to choose a different program, here are some other
[network manager options](https://wiki.archlinux.org/index.php/List_of_applications/Internet#Network_managers)
that you could use.

## Configuring the Graphical Desktop Environment
Since we are going with the *MATE Desktop Environment*, we will primarily be following
the instructions on the [Arch Linux Package Repository](https://wiki.mate-desktop.org/archlinux_custom_repo) page,
but will also refer to the [General Recommendations](https://wiki.archlinux.org/index.php/General_recommendations#Graphical_user_interface)
on ArchWiki.

### Installing Xorg
The first step is to install [**Xorg**](https://wiki.archlinux.org/index.php/Xorg);
this provides an implementation of the `X Window System`, which is used to provide
a graphical intefrace in GNU+Linux:

    # pacman -S xorg-server

We also need to install the driver for our hardware. Since I am using a Thinkpad X200,
I will use `xf86-video-intel`; it should be the same on the other Thinkpads,
as well as the Macbook 1,1 and 2,1.

    # pacman -S xf86-video-intel

For other systems, you can try:

    # pacman -Ss xf86-video- | less

When this is combined with looking at your `lspci` output, you can determine which
driver is needed. By default, `Xorg` will revert to `xf86-video-vesa`,
which is a generic driver, and doesn't provide true hardware acceleration.

Other drivers (not just video) can be found by looking at the `xorg-drivers` group:

    # pacman -Sg xorg-drivers

### Xorg Keyboard Layout
`xorg` uses a different configuration method for keyboard layouts than Parabola,
so you will notice that the layout you set in **/etc/vconsole.conf** earlier might
not actually be the same in `xorg`.

Check ArchWiki's article on [Xorg's keyboard configuration](https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg), for more information.

To see what layout you currently use, try this on a terminal emulator in `xorg`:

    # setxkbmap -print -verbose 10

I'm simply using the default Qwerty (US) keyboard, so there isn't anything I need
to change here; if you do need to make any changes, ArchWiki recommends two ways
of doing it: manually updating [configuration files](https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg#Using_X_configuration_files) or using the [localectl](https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg#Using_localectl) command.

### Installing MATE
Now we have to install the desktop environment itself. According to the Arch Linux Package Repository,
if we want all of the MATE Desktop, we need to install two packages:

    # pacman -Syy mate mate-extra

The last step is to install a Display Manager; for MATE, we will be using `lightdm`
(it's the recommended Display Manager for the MATE Desktop); for this, we'll folow the instructions [on the MATE wiki](https://wiki.mate-desktop.org/archlinux_custom_repo#display_manager_recommended),
with one small change: the `lightdm-gtk3-greeter` package doesn't exist in Parabola's repositories.
So, instead we will install the `lightdm-gtk-greeter` package; it performs the same function.

We'll also need the `accountsservice` package, which gives us the login window itself: 

    # pacman -Syy lightdm-gtk3-greeter accountsservice

After installing all the required packages, we need to make it so that the MATE Desktop Environment
will start automatically, whenever we boot our computer; to do this, we have to enable the display manager, `lightdm`,
as well as the service that will prompt us with a login window, `accounts-daemon`:

    # systemctl enable lightdm
    # systemctl enable accounts-daemon

Now you have installed the *MATE Desktop Environment*,If you wanted
to install another desktop environment, check out some [other options](https://wiki.archlinux.org/index.php/Desktop_environment) on ArchWiki.

### Configuring Network Manager in MATE
Now that we have installed the Mate Desktop environment, and booted into it,
we need to set up the network configuration in our graphical environment.

The MATE Desktop wiki recommends that we use Network Manager; an
article about Network Manager can be found
[on ArchWiki](https://wiki.archlinux.org/index.php/NetworkManager).

We need to install the NetworkManager package:

    # pacman -S networkmanager

We will also need the Network Manager applet, which will allow us to manage our 
networks from the system tray:

    # pacman -S network-manager-applet

Finally, we need to start the service (if we want to use it now), or enable it,
(so that it will activate automatically, at startup).

    # systemctl enable NetworkManager.service

If you need VPN support, you will also want to install the `networkmanager-openvpn` package.

**NOTE: You do not want multiple networking services running at the same time;
they will conflict, so, if using Network Manager, you want to stop/disable any
others from running. Examples of other services that will probably intefere
with Network Manager are** `dhcpcd` **and** `wifi-menu`**.**

You can see all currently-running services with this command:

    #  systemctl --type=service

And you can stop them using this command:

    # systemctl stop service_name.service

If you want to disable those services, meaning that you no longer want them to start
when the computer boots up, you will need to use `systemctl's` `disable` option,
instead of `stop`.

Now you have a fully-functional graphical environment for your Parabola installation,
including networking. All you have to do is reboot, and you will be prompted to log in,
with a familiar graphical login prompt. You can also now, more easily [modify the GRUB configuration](grub_cbfs.md),
install new applications, and/or make whatever other changes you want to your system.

Copyright © 2014, 2015 Leah Rowe <info@minifree.org>

Copyright © 2017 Elijah Smith <esmith1412@posteo.net>

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)

