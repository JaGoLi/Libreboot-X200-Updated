---
title: Downloads
...

**The latest stable release is 20160907, released on 2016-09-07 and can
be found at [\#https](#https).**

Information about specific changes in each Libreboot release, can be found
at [docs/release.md](docs/release.md)

If you're more interested in libreboot development, go to the
[libreboot development page](../git.md), which also includes links to the
Git repositories.

GPG signing key
---------------

Releases are signed with GPG.

    gpg --recv-keys 0x969A979505E8C5B2

Full key fingerprint: CDC9 CAE3 2CB4 B7FC 84FD  C804 969A 9795 05E8 C5B2

The GPG key can also be downloaded with this exported dump of the
pubkey: [lbkey.asc](lbkey.asc).

    $ sha512sum -c sha512sum.txt
    $ gpg --verify sha512sum.txt.sig

Do you have a mirror?
---------------------

Let us know! We will add it here.

If you wish to create a new mirror of the Libreboot releases, you can use
*rsync*. See: [rsync mirror list](#rsync).

HTTPS mirrors {#https}
-------------

These mirrors are recommended, since they use TLS (https://) encryption.

<https://www.mirrorservice.org/sites/libreboot.org/release/> (University
of Kent, UK)

<https://mirrors.mit.edu/libreboot/> (MIT university, USA)

<https://mirror.math.princeton.edu/pub/libreboot/> (Princeton
university, USA)

<https://mirror.splentity.com/libreboot/> (Splentity Software, USA)

<https://mirror.sugol.org/libreboot/> (sugol.org)
(formerly nephelai.zanity.net/mirror/libreboot)

<https://mirrors.qorg11.net/libreboot/> (qorg11.net, Spain)

<https://elgrande74.net/libreboot/> (elgrande74.net, France)

<https://mirror.koddos.net/libreboot/> (koddos.net, Netherlands)

<https://mirror.swordarmor.fr/libreboot/> (swordarmor.fr, France)

<https://mirror-hk.koddos.net/libreboot/> (koddos.net, Hong Kong)

<https://mirror.cyberbits.eu/libreboot/> (cyberbits.eu, France)

RSYNC mirrors {#rsync}
-------------

Useful for mirroring Libreboot's entire set of release archives. You can put
an rsync command into crontab and pull the files into a directory on your
web server.

*It is highly recommended that you use the libreboot.org mirror*, if you wish
to host an official mirror. Otherwise, if you simply want to create your own
local mirror, you should use one of the other mirrors, which sync from
libreboot.org.

<rsync://rsync.libreboot.org/mirrormirror/> (Libreboot project official mirror)

<rsync://rsync.mirrorservice.org/libreboot.org/release/> (University of Kent,
UK)

<rsync://mirror.math.princeton.edu/pub/libreboot/> (Princeton university, USA)

<rsync://qorg11.net/mirrors/libreboot/> (qorg11.net, Spain)

<rsync://ftp.linux.ro/libreboot/> (linux.ro, Romania)

<rsync://mirror.koddos.net/libreboot/> (koddos.net, Netherlands)

<rsync://mirror-hk.koddos.net/libreboot/> (koddos.net, Hong Kong)

Are you running a mirror? Contact the libreboot project, and the link will be
added to this page!

HTTP mirrors {#http}
------------

WARNING: these mirrors are non-HTTPS which means that they are
unencrypted. Your traffic could be subject to interference by
adversaries. Make especially sure to check the GPG signatures, assuming
that you have the right key. Of course, you should do this anyway, even
if using HTTPS.

<http://mirror.linux.ro/libreboot/> (linux.ro, Romania)

<http://mirror.helium.in-berlin.de/libreboot/> (in-berlin.de, Germany)

FTP mirrors {#ftp}
-----------

WARNING: FTP is also unencrypted, like HTTP. The same risks are present.

<ftp://ftp.mirrorservice.org/sites/libreboot.org/release/> (University
of Kent, UK)

<ftp://ftp.linux.ro/libreboot/> (linux.ro, Romania)

Statically linked
------------------

Libreboot includes statically linked executables. If you need the
sources for those statically linked dependencies inside the executables,
then you can contact the libreboot project using the details on the home
page; source code will be provided. You can download this source code
from [the "ccsource" directory](ccsource/) on libreboot.org.
