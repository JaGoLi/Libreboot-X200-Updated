---
title: Guix System with Full Disk Encryption on Libreboot
...

Objective
=========

To provide step-by-step guide for setting up guix system (stand-alone guix)
with full disk encryption (including /boot) on devices powered by libreboot.

Scope
=====

Any users, for their generalised use cases, need not stumble away from this
guide to accomplish the setup.

Advanced users, for deviant use cases, will have to explore outside this
guide for customisation; although this guide provides information that is
of paramount use.

Process
=======

Preparation
-----------

In your current GNU/Linux System, open terminal as root user.

Insert USB drive and get the USB device name /dev/sdX, where “X” is the
variable to make a note of.

`lsblk`

Unmount the USB drive just in case if it’s auto-mounted.

`umount /dev/sdX`

Download the latest (a.b.c) Guix System ISO Installer Package (sss) and
it’s GPG Signature; where “a.b.c” is the variable for version number and
“sss” is the variable for system architecture.

`wget https://ftp.gnu.org/gnu/guix/guix-system-install-a.b.c.sss-linux.iso.xz`

`wget https://ftp.gnu.org/gnu/guix/guix-system-install-a.b.c.sss-linux.iso.xz.sig`

Import required public key.

`gpg --keyserver pool.sks-keyservers.net --recv-keys 3CE464558A84FDC69DB40CFB090B11993D9AEBB5`

Verify the GPG Signature of the downloaded package.

`gpg --verify guix-system-install-a.b.c.sss-linux.iso.xz.sig`

Extract the ISO Image from the downloaded package.

`xz -d guix-system-install-a.b.c.sss-linux.iso.xz`

Write the extracted ISO Image to the USB drive.

`dd if=guix-system-install-a.b.c.sss-linux.iso of=/dev/sdX; sync`

Reboot the device.

`reboot`

Pre-Installation
----------------

On reboot, as soon as you see the Libreboot Graphic Art, press arrow keys
to change the menu entry.

Choose “Search for GRUB2 configuration on external media [s]” and wait
for the Guix System from USB drive to load.

Set your keyboard layout lo, where “lo” is the two-letter keyboard layout
code (example: us or uk).

`loadkeys lo`

Unblock network interfaces (if any).

`rfkill unblock all`

Get the names of your network interfaces.

`ifconfig -a`

Bring your required network interface nwif (wired or wireless) up, where
“nwif” is the variable for interface name. For wired connections,
this should be enough.

`ifconfig nwif up`

For wireless connection, create a configuration file using text editor,
where “fname” is the variable for any desired filename.

`nano fname.conf`

Choose, type and save ONE of the following snippets, where ‘nm’ is the
name of the network you want to connect, ‘pw’ is the corresponding
network’s password or passphrase and ‘un’ is user identity.

For most private networks:
```
network={
  ssid="nm"
  key_mgmt=WPA-PSK
  psk="pw"
}
```

(or)

For most public networks:
```
network={
  ssid="nm"
  key_mgmt=NONE
}
```

(or)

For most organisational networks:
```
network={
  ssid="nm"
  scan_ssid=1
  key_mgmt=WPA-EAP
  identity="un"
  password="pw"
  eap=PEAP
  phase1="peaplabel=0"
  phase2="auth=MSCHAPV2"
}
```

Connect to the configured network, where “fname” is the filename and
“nwif” is the network interface name.

`wpa_supplicant -c fname.conf -i nwif -B`

Assign an IP address to your network interface, where “nwif” is the
network interface name.

`dhclient -v nwif`

Obtain the device name /dev/sdX in which you would like to deploy and
install Guix System, where “X” is the variable to make a note of.

`lsblk`

Wipe the respective device. Wait for the command operation to finish.

`dd if=/dev/urandom of=/dev/sdX; sync`

Load device-mapper module in the current kernel.

`modprobe dm_mod`

Partition the respective device. Just do, GPT --> New --> Write --> Quit;
defaults will be set.

`cfdisk /dev/sdX`

Encrypt the respective partition.

`cryptsetup -v --cipher serpent-xts-plain64 --key-size 512 --hash whirlpool --iter-time 500 --use-random --verify-passphrase luksFormat /dev/sdX1`

Obtain and note down the “LUKS UUID”.

`cryptsetup luksUUID /dev/sdX1`

Open the respective encrypted partition, where “partname” is any
desired partition name.

`cryptsetup luksOpen /dev/sdX1 partname`

Make filesystem on the respective partition, where “fsname” is any
desired filesystem name.

`mkfs.btrfs -L fsname /dev/mapper/partname`

Mount the respective filesystem under the current system.

`mount LABEL=fsname /mnt`

Create a swap file and make it readable cum writable only by root.

`dd if=/dev/zero of=/mnt/swapfile bs=1MiB count=2048`

`chmod 600 /mnt/swapfile`

`mkswap /mnt/swapfile`

`swapon /mnt/swapfile`

Installation
------------

Make the installation packages to be written on the respective
mounted filesystem.

`herd start cow-store /mnt`

Create the required directory.

`mkdir /mnt/etc`

Create, edit and save the configuration file by typing the following
code snippet. WATCH-OUT for variables in the code snippet and
replace them with your relevant values.

`nano /mnt/etc/config.scm`

Snippet:

```
(use-modules
	(gnu)
	(gnu system nss))
(use-service-modules
	xorg
	desktop)
(use-package-modules
	certs
	gnome)
(operating-system
	(host-name "hostname")
	(timezone "Zone/SubZone")
	(locale "ab_XY.1234")
	(keyboard-layout
		(keyboard-layout
			"xy"
			"altgr-intl"))
	(bootloader
		(bootloader-configuration
			(bootloader
				(bootloader
					(inherit grub-bootloader)
					(installer #~(const #t))))
			(keyboard-layout keyboard-layout)))
	(mapped-devices
		(list
			(mapped-device
				(source
					(uuid "luks-uuid"))
					(target "partname")
					(type luks-device-mapping))))
	(file-systems
		(append
			(list
				(file-system
					(device
						(file-system-label "fsname"))
					(mount-point "/")
					(type "btrfs")
					(dependencies mapped-devices)))
			%base-file-systems))
	(users
		(append
			(list
				(user-account
					(name "username")
					(comment "Full Name")
					(group "users")
					(supplementary-groups '("wheel" "netdev" "audio" "video" "lp" "cdrom" "tape" "kvm"))))
			%base-user-accounts))
	(packages
		(append
			(list
				nss-certs)
			%base-packages))
	(services
		(append
			(list
				(extra-special-file "/usr/bin/env"
					(file-append coreutils "/bin/env"))
				(set-xorg-configuration
					(xorg-configuration
						(keyboard-layout keyboard-layout)))
				(service gnome-desktop-service-type))
			%desktop-services))
	(name-service-switch %mdns-host-lookup-nss))
```
    
Initialise new Guix System.

`guix system init /mnt/etc/config.scm /mnt`

Reboot the device.

`reboot`

Post-Installation
------------

On reboot, as soon as you see the Libreboot Graphic Art, choose
the option 'Load Operating System [o]'

Enter LUKS Key, for libreboot's grub, as prompted.

You may have to go through warning prompts by repeatedly
pressing the "enter/return" key.

You will now see guix's grub menu from which you can go with the
default option.

Enter LUKS Key again, for kernel, as prompted.

Upon GNOME Login Screen, login as "root" with password field empty.

Open terminal from the GNOME Dash.

Set passkey for "root" user. Follow the prompts.

`passwd root`

Set passkey for "username" user. Follow the prompts.

`passwd username`

Update the guix distribution. Wait for the process to finish.

`guix pull`

Update the search paths.

`export PATH="$HOME/.config/guix/current/bin:$PATH"`

`export INFOPATH="$HOME/.config/guix/current/share/info:$INFOPATH"`

Update the guix system. Wait for the process to finish.

`guix system reconfigure /etc/config.scm`

Reboot the device.

`reboot`

Conclusion
==========

Everything should be stream-lined from now. You can follow your
regular boot steps without requiring manual intervention. You can
start logging in as regualar user with the respective "username".

You will have to periodically (at your convenient time) login as root
and do the update/upgrade part of post-installation section, to keep your
guix distribution and guix system updated.

That is it! You have now setup guix system with full-disk encryption
on your device powered by libreboot. Enjoy!

References
==========

[1] Guix Manual (http://guix.gnu.org/manual/en/).

[2] Libreboot Documentation (https://libreboot.org/docs/).

Acknowledgements
================

[1] Thanks to Guix Developer, Clement Lassieur (clement@lassieur.org),
for helping me with the Guile Scheme Code for the Bootloader Configuration.

[2] Thanks to Libreboot Founder and Developer,
Leah Rowe (leah@libreboot.org), for helping me to understand the
libreboot’s functionalities better.

License
=======

Copyright (C) 2019  RAGHAV "RG" GURURAJAN (raghavgururajan@disroot.org).

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.

A copy of the license can be found at
"https://www.gnu.org/licenses/fdl-1.3.en.html".