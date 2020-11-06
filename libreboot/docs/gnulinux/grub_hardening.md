---
title: GRUB hardening
...

This guide deals with various ways in which you can harden your GRUB
configuration, for security purposes. These steps are optional, but
highly recommended by the Libreboot project.

GRUB secure boot with GPG
=========================

This uses the free implementation of the GPG standard for encryption and
signing/verifying data. We will be using this for checking the signature
of a Linux kernel at boot time. More information about GPG can be found
on the [GPG project website](https://www.gnu.org/software/gnupg/). GRUB
has some GPG support built in, for checking signatures.

This tutorial assumes you have a libreboot image (rom) that you wish to
modify, to which we shall henceforth refer to as "my.rom". This
tutorial modifies grubtest.cfg, this means signing and password
protection will work after switching to it in the main boot menu and
bricking due to incorrect configuration will be impossible. After you
are satisfied with the setup, you should transfer the new settings to
grub.cfg to make your machine actually secure.

First extract the old grubtest.cfg and remove it from the libreboot
image:

    cbfstool my.rom extract -n grubtest.cfg -f my.grubtest.cfg
    cbfstool my.rom remove -n grubtest.cfg

Helpful links:

-   [GRUB manual](https://www.gnu.org/software/grub/manual/html_node/Security.html#Security)
-   [GRUB info pages](http://git.savannah.gnu.org/cgit/grub.git/tree/docs/grub.texi)
-   [SATA connected storage considered dangerous.](../../faq.md#hddssd-firmware)
-   [Coreboot GRUB security howto](https://www.coreboot.org/GRUB2#Security)

GRUB Password
=============

The security of this setup depends on a good GRUB password as GPG
signature checking can be disabled through the interactive console:

    set check_signatures=no

This is good in that it allows you to occasionally boot unsigned liveCDs
and such. You may think of supplying signatures on an usb key, but the
signature checking code currently looks for
</path/to/filename>.sig when verifying </path/to/filename>
and as such it is not possible to supply signatures in an alternate
location.

Note that this is not your LUKS password, but it's a password that you
have to enter in order to use "restricted" functionality (such as
console). This protects your system from an attacker simply booting a
live USB and re-flashing your firmware. *This should be different than
your LUKS passphrase and user password.*

Use of the *diceware method* is recommended, for generating secure
passphrases (as opposed to passwords). Diceware method involves using
dice to generate random numbers, which are then used as an index to pick
a random word from a large dictionary of words. You can use any language
(e.g. English, German). Look it up on a search engine. Diceware method
is a way to generate secure passphrases that are very hard (almost
impossible, with enough words) to crack, while being easy enough to
remember. On the other hand, most kinds of secure passwords are hard to
remember and easier to crack. Diceware passphrases are harder to crack
because of far higher entropy (there are many words available to use,
but only about 50 commonly used symbols in pass*words*).

-->
The GRUB password can be entered in two ways:

-   plaintext
-   protected with [PBKDF2](https://en.wikipedia.org/wiki/Pbkdf2)

We will (obviously) use the later. Generating the PBKDF2 derived key is
done using the `grub-mkpasswd-pbkdf2` utility. You can get it by
installing GRUB version 2. Generate a key by giving it a password:
    grub-mkpasswd-pbkdf2

Its output will be a string of the following form:

    grub.pbkdf2.sha512.10000.HEXDIGITS.MOREHEXDIGITS

Now open my.grubtest.cfg and put the following before the menu entries
(prefered above the functions and after other directives). Of course use
the pbdkf string that you had generated yourself:

    set superusers="root"
    password_pbkdf2 root grub.pbkdf2.sha512.10000.711F186347156BC105CD83A2ED7AF1EB971AA2B1EB2640172F34B0DEFFC97E654AF48E5F0C3B7622502B76458DA494270CC0EA6504411D676E6752FD1651E749.8DD11178EB8D1F633308FD8FCC64D0B243F949B9B99CCEADE2ECA11657A757D22025986B0FA116F1D5191E0A22677674C994EDBFADE62240E9D161688266A711

Obviously, replace it with the correct hash that you actually got for
the password that you entered. Meaning, not the hash that you see above!

As enabling password protection as above means that you have to input it
on every single boot, we will make one menu entry work without it.
Remember that we will have GPG signing active, thus a potential attacker
will not be able to boot an arbitrary operating system. We do this by
adding option `--unrestricted` to a menuentry definition:

    menuentry 'Load Operating System (incl. fully encrypted disks)  [o]' --hotkey='o' --unrestricted {
    ...

Another good thing to do, if we chose to load signed on-disk GRUB
configurations, is to remove (or comment out) `unset superusers` in
function try\_user\_config:

    function try_user_config {
       set root="${1}"
       for dir in boot grub grub2 boot/grub boot/grub2; do
          for name in '' autoboot_ libreboot_ coreboot_; do
             if [ -f /"${dir}"/"${name}"grub.cfg ]; then
                #unset superusers
                configfile /"${dir}"/"${name}"grub.cfg
             fi
          done
       done
    }

Why? We allowed booting normally without entering a password above. When
we unset superusers and then load a signed GRUB configuration file, we
can easily use the command line as password protection will be
completely disabled. Disabling signature checking and booting whatever
an attacker wants is then just a few GRUB commands away.

As far as basic password setup is concerned we are done and we can now
move on to signing.

GPG keys
========

First generate a GPG keypair to use for signing. Option RSA (sign only)
is ok.

Warning: GRUB does not read ASCII armored keys. When attempting to
trust ... a key filename it will print error: bad signature

    mkdir --mode 0700 keys
    gpg --homedir keys --gen-key
    gpg --homedir keys --export-secret-keys --armor > boot.secret.key # backup
    gpg --homedir keys --export > boot.key

Now that we have a key, we can sign some files with it. We have to sign:

-   a kernel
-   (if we have one) an initramfs
-   (if we wish to transfer control to it) an on-disk grub.cfg
-   grubtest.cfg (this is so one can go back to grubtest.cfg after
    signature checking is enforced. You can always get back to grub.cfg
    by pressing ESC, but afterwards grubtest.cfg is not signed and it
    will not load.

Suppose that we have a pair of `my.kernel` and `my.initramfs` and an
on-disk `libreboot_grub.cfg`. We sign them by issuing the following
commands:

    gpg --homedir keys --detach-sign my.initramfs
    gpg --homedir keys --detach-sign my.kernel
    gpg --homedir keys --detach-sign libreboot_grub.cfg
    gpg --homedir keys --detach-sign my.grubtest.cfg

Of course some further modifications to my.grubtest.cfg will be
required. We have to trust the key and enable signature enforcement (put
this before menu entries):

    trust (cbfsdisk)/boot.key
    set check_signatures=enforce

What remains now is to include the modifications into the image (rom):

    cbfstool my.rom add -n boot.key -f boot.key -t raw
    cbfstool my.rom add -n grubtest.cfg -f my.grubtest.cfg -t raw
    cbfstool my.rom add -n grubtest.cfg.sig -f my.grubtest.cfg.sig -t raw

... and flashing it.

Copyright © 2017 Fedja Beader <fedja@protonmail.ch>\

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License Version 1.3 or any later
version published by the Free Software Foundation
with no Invariant Sections, no Front Cover Texts, and no Back Cover Texts.
A copy of this license is found in [../fdl-1.3.md](../fdl-1.3.md)
