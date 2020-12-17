---
title: Installing Trisquel GNU+Linux with Full-Disk Encryption (including /boot)
x-toc enable: true
...

This guide is written for the Trisquel 7.0 (Belenos) GNU+Linux distribution, but it should also work for Trisquel 6.0 (Toutatis).

## Gigabyte GA-G41M-ES2L

To boot the Trisquel net installer, make sure to specify fb=false on the linux
kernel parameters in GRUB. This will boot the installer in text mode instead
of using a framebuffer.

## Boot the Installation Media
Boot your operating system, with the installation media. If you don't know how to do so, refer to [How to Prepare and Boot a USB Installer in Libreboot Systems](grub_boot_installer.md).

When the Trisquel GRUB screen appears, select the `Install Trisquel in Text Mode` option.

## Select a Language
The first part of the installation is to select your system's language; I chose `English`.

## Select Your Location
You will need to select your location; I choose `United States`.

## Configure the Keyboard
You need to select the right layout for your keyboard; if you want to installer to do it automatically, choose `Yes`, and it will ask you whether or not a series of keys are present on your keyboard. Simply choose `Yes` or `No`, accordingly.

If you don't want the installer to automatically detect your keyboard layout, choose `No`, and simply select it from a list.

## Configure the Network

### Choose the Network Inteface
You will need to select the network interface to be used for the installation. If you have an ethernet (i.e., wired) connection, choose `etho0`; otherwise, choose `wlan0` (for wireless).

If you choose `wlan0`, enter the passphrase that corresponds to your wireless network's WPA/WPA2 key (Your wireless network should have a password, and no modern router should be using the [WEP protocol](https://en.wikipedia.org/wiki/Wired_Equivalent_Privacy)).

### Choose Your Hostname
You will need to choose a hostname for the system, which identifies your computer to the network; it can be anything, but it must only consist of numbers, uppercase and lowercase letters, and dashes `-`.

### Choose a Mirror of the Trisquel Archive
Choose the server from where you will download the Trisquel packages needed for the installation. The choices are separated by country; simply select the one that is closest to where you are.

After you select the country, you will be taken to a list of different individual servers. If there is more than one option, choose the one that is closest to you; otherwise, select whichever one is available.

The last step of setting up the network will be entering an HTTP proxy (if you need one to access the network). If you have one, type it here; otherwise, press `Tab`, and then choose `Continue` (using the arrow keys).

## Loading Additional Components
Now the installer needs to download some more packages, to continue the installation. Depending on your network bandwidth, this could take up to a few minutes to complete.

## Set Up Users and Passwords
Enter the full name of the user here. You can use your real name, or just a pseudonym; then, choose `Continue`.

Then it will ask you to enter a *username*. Pick whatever you like, and enter it here. Select `Continue`.

Choose a passphrase (better than a password). The [diceware](http://world.std.com/~reinhold/diceware.html) method is highly recommended for coming up with one.

I recommend combining the *diceware* method with something personal about yourself. An example of this would be to choose four words from the *diceware* list, and then come up with a fifth "word" (i.e., a combination of characters that is unique to you, like some name plus a number/special character); this combination dramatically increases the security of a *diceware* passphrase (i.e., even if someone had the entire *diceware* word list, they couldn't figure out your passphrase through brute force).

**NOTE: This would be difficult for a person to do, even if you *only* used words from the list**.

For example, say that your cat's name is **Max**, and he is three years old; you could do something like this:

    diceware_word_1 diceware_word_2 diceware_word_3 diceware_word_4 Max=3old

This has a large degree of randomness (due to the usage of the *diceware* method), and also contains a unique piece of personal information that someone would need to know you, in order to guess; it's a very potent combination.

After entering this password twice, choose `Continue`.

It will now ask you if you want to encrypt your home directory. Remember, this is *NOT* to be confused with encrypting your entire disk (the purpose of this guide); it will just be the files that reside in `~`, and it uses a different encryption protocol (`ecryptfs`). If you want to encrypt your home directory here, choose `Yes`; however, since we are going to encrypt the entire installation, that would not only be redundant, but it would also add a noticeable performance penalty, for little security gain in most use cases. This is therefore optional, and *NOT* recommended. Choose `No`.

## Configure the Clock
The installer will try to auto-detect your time zone; if it chooses correctly, select `Yes`; otherwise, choose `No`, and it will prompt you to select the correct one.

## Partition Disks
Now it's time to partition the disk; you will be shown several options; choose `Manual` partitioning.

1. Use the arrow keys to select the drive (look for a matching size and manufacturer name in the description), and press `Enter`. It will ask you if you want to create a new, empty partition table on the device; choose `Yes`.

2. Your drive will now show as having a single partition, labeled `#1`; select it (it will say `FREE SPACE` beside it), and press `Enter`.

3. Choose `Create a new partition`. By default, the partition size will be the whole drive; leave it as-is, and select `Continue`.

4. When it asks for partition type, go with `Primary`; you'll be taken to a screen with a list of information about your new partition; make sure to fill out each field as follows (using the up and down arrows to navigate, and `Enter` to modify an option):

    * Use as: `physical volume for encryption`
    * Encryption method: `Device-mapper (dm-crypt)`
    * Encryption: `aes`
    * key size: `256`
    * IV algorithm: `xts-plain64`
    * Encryption key: `passphrase`
    * Erase data: `Yes`

        For the `Erase data` field, only choose `No`, if this is either a new drive that doesn't have any of your plaintext data, or else if it previously had full-disk encryption.

5. Choose `Done setting up the partition`. It will take you back to the main partitioning menu.

6. Choose `Configure encrypted volumes`; the installer will ask if you want to write the changes to disk, and configure the encrypted volumes; choose `Yes`.

7. Select `Create encrypted volumes`.

8. Select your partition with the arrow keys (pressing `Spacebar` will make an `*` appear between the brackets; that's how you know it's been selected). Press `Tab`, and choose `Continue`.

9. Select `Finish`. You will be asked if you really want to erase the drive; choose `Yes` (Erase will take a long time, so be patient. If your old system were encrypted, just let this run for about a minute, and then choose `Cancel`; this will make sure that the LUKS header is completely wiped out).

10. Now you need to enter a passphrase for encrypting the entire disk. Make sure that this is different from your user password that you created earlier, but still use the [diceware](http://world.std.com/~reinhold/diceware.html) method to create it. You will have to enter the password twice; afterwards, you will be returned to the main partitioning menu.

11. You will now see your encrypted device at the top of the device list. It will begin with something like this: `Encrypted volume (sdXY_crypt)`. Choose the partition labeled `#1`.

12. Change the value of `Use as` to `physical volume for LVM`. Then choose `Done setting up the partition`; you will be taken back to the main partitioning menu.

13. Choose `Configure the Logical Volume Manager`. You will be asked if you want to `Keep current partition layout and configure LVM`; choose `Yes`.

14. Choose `Create volume group`. You will have to enter a name for the group; use **grubcrypt**. Select the encrypted partition as the device (by pressing `Spacebar`, which will make an `*` appear between the brackets; that's how you know it's been selected). Press `Tab`, and choose `Continue`.

15. Choose `Create logical volume`. Select the volume group you created in the previous step (i.e., **grubcrypt**), and name it **trisquel**; make the size the entire drive minus 2048 MB (for the swap space). Press `Enter`.

16. Choose `Create logical volume` again, and select **grubcrypt**. Name this one **swap**, and make the size the default value (it should be about 2048MB). Press `Enter`, and then choose `Finish`.

17. Now you are back at the main partitioning screen. You will simply set the mount points and filesystems to use for each partition you just created. Under `LVM VG grubcrypt, LV trisquel`, select the first partition: `#1`. Change the values in this section to reflect the following; then choose `Done setting up partition`:

    * use as: `ext4`
    * mount point: `/`

18. Under `LVM VG grubcrypt, LV swap`, select the first partition: `#1`. Change the value of `use as` to `swap area`. Choose `Done setting up partition`.

19. Finally, when back at the main partitioning screen, choose `Finish partitioning and write changes to disk`. It will ask you to verify that you want to do this; choose `Yes`.

## Installing the Base System
The hardest part of the installation is done; the installer will now download and install the packages necessary for your system to boot/run. The rest of the process will be mostly automated, but there will be a few things that you have to do yourself.

### Choose a Kernel
It will ask you which kernel you want to use; choose `linux-generic`.

**NOTE: After installation, if you want the most up-to-date version of the Linux kernel (Trisquel's kernel is sometimes outdated, even in the testing distro), you might consider using [this repository](https://jxself.org/linux-libre/) instead. These kernels are also deblobbed, like Trisquel's (meaning there are no binary blobs present).**

### Update Policy
You have to select a policy for installing security updates; I recommend that you choose `Install security updates automatically`, but you can choose not to, if you prefer.

### Choose a Desktop Environment
When prompted to choose a desktop environment, use the arrow keys to navigate the choices, and press `Spacebar` to choose an option; here are some guidelines:

* If you want *GNOME*, choose **Trisquel Desktop Environment**
* If you want *LDXE*, choose **Trisquel-mini Desktop Environment**
* If you want *KDE*, choose **Triskel Desktop Environment**

You might also want to choose some of the other package groups (or none of them, if you want a basic shell); it's up to you. Once you've chosen the option you want, press `Tab`, and then choose `Continue`.

## Install the GRUB boot loader to the master boot record
The installer will ask you if you want to install the GRUB bootloader to the master boot record; choose `No`. You do not need to install GRUB at all, since in Libreboot, you are using the GRUB payload on the ROM to boot your system.

The next window will prompt you to enter a `Device for boot loader installation`. Leave the line blank; press `Tab`, and choose `Continue`.

## System Clock
The installer will ask if your system clock is set to UTC; choose `Yes`.

## Finishing the Installation
The installer will now give you a message that the installation is complete. Choose `Continue`, remove the installation media, and the system will automatically reboot.

## Booting your system
At this point, you will have finished the installation. At your GRUB boot screen, press `C` to get to the command line, and enter the following commands at the `grub>` prompt:

    grub> cryptomount -a
    grub> set root='lvm/grubcrypt-trisquel'
    grub> linux /vmlinuz root=/dev/mapper/grubcrypt-trisquel \
    >cryptdevice=/dev/mapper/grubcrypt-trisquel:root
    grub> initrd /initrd.img
    grub> boot

Without specifying a device, **cryptomount's** `-a` parameter tries to unlock *all* detected LUKS volumes (i.e., any LUKS-encrypted device that is connected to the system). You can also specify `-u` (for a UUID). Once logged into the operating system, you can find the UUID by using the `blkid` command:

    $ sudo blkid

## ecryptfs
If you didn't encrypt your home directory, then you can safely ignore this section; if you did choose to encrypt it, then after you log in, you'll need to run this command:

    $ sudo ecryptfs-unwrap-passphrase

This will be needed in the future, if you ever need to recover your home directory from another system. Write it down, or (preferably) store it using a password manager (I recommend `keepass`,`keepasX`, or `keepassXC`).

## Modify grub.cfg (CBFS)
The last step of the proccess is to modify your **grub.cfg** file (in the firmware), and flash the new configuration, [using this tutorial](grub_cbfs.md); this is so that you don't have to manually type in the commands above, every single time you want to boot your computer. You can also make your GRUB configuration much more secure, by following [this guide](grub_hardening.md).

## Troubleshooting
During boot, some Thinkpads have a faulty DVD drive, which can cause the `cryptomount -a` command to fail, as well as the error `AHCI transfer timed out` (when the Thinkpad X200 is connected to an UltraBase). For both issues, the workaround was to remove the DVD drive (if using the UltraBase, then the whole device must be removed).

Copyright © 2014, 2015 Leah Rowe <info@minifree.org>

Copyright © 2017 Elijah Smith <esmith1412@posteo.net>

Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License Version 1.3 or any later version published by the Free Software Foundation with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts. A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
