---
title: Information about sending patches for review
x-toc-enable: true
...

Download Libreboot from the Git repository like so:

    $ git clone https://notabug.org/libreboot/libreboot.git

You can submit your patches via
[Notabug pull requests](#how-to-submit-your-patches-via-pull-requests).

Libreboot development is done using the Git version control system.
Refer to the [official Git documentation](https://git-scm.com/doc) if you don't
know how to use Git.

Editing the website and documentation, wiki-style
-------------------------------------------------

The website and documentation is inside the `www` directory in the
[Git repository](#how-to-download-libreboot-from-the-git-repository), in
Pandoc flavoured Markdown. The website is generated into static HTML via Pandoc
with the following scripts in that directory:

- index.sh: generates the news feed (on the News section of the website)
- publish.sh: converts an .md file to an .html file
- Makefile: with calls to index.sh and publish.sh, compiles the entire
  Libreboot website

Use any standard text editor (e.g. Vim, Emacs, Nano, Gedit) to edit the files,
commit the changes and
[send patches](#how-to-submit-your-patches-via-pull-requests).

Optionally, you can install a web server (e.g. lighttpd, nginx) locally and
set the document root to the *www* directory in your local Git repository.
With this configuration, you can then generate your local version of the
website and view it by typing `localhost` in your browser's URL bar.

Privacy of contributors (you do not have to reveal your name or identity!)
-------------------------------------------------------------------------

Contributions that you make are publicly recorded, in a Git repository which
everyone can access. This includes the name and email address of the
contributor.

In Git, for author name and email address, you do not have to use identifying
data. You can use Libreboot Contributor and your email address could be
specified as contributor@libreboot.org. You are permitted to do this, if
you wish to maintain privacy. We believe in privacy. If you choose to remain
anonymous, we will honour this.

Of course, you can use whichever name and/or email address you like.

For enhanced privacy, we recommend that you use a [trustworthy VPN
provider](https://torrentfreak.com/which-vpn-services-keep-you-anonymous-in-2019/)
and route all of your traffic through Tor (on top of the VPN). The
[Tor website](https://torproject.org/) has instructions on it for routing
traffic through the Tor network.

Legally speaking, all copyright is automatic under the Berne Convention of
international copyright law. It does not matter which name, or indeed whether
you even declare a copyright (but we do require that certain copyright
licenses are used - read more about that on this same page).

If you use a different name and email address on your commits/patches, then you
should be fairly anonymous. Use
[git log](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History)
and [git show](https://git-scm.com/docs/git-show) to confirm that before you
push changes to a public Git repository.

General guidelines for submitting patches
-----------------------------------------

We require all patches to be submitted under a free license:
<https://www.gnu.org/licenses/license-list.html>.

- GNU General Public License v3 is highly recommended
- For documentation, we require GNU Free Documentation License v1.3 or higher

*Always* declare a license on your work! Not declaring a license means that
the default, restrictive copyright laws apply, which would make your work
non-free.

GNU+Linux is generally recommended as the OS of choice, for Libreboot
development.

General code review guidelines
------------------------------

Any member of the public can
[submit a patch](#how-to-submit-your-patches-via-pull-requests).
Members with push access must *never* push directly to the master branch;
issue a Pull Request, and wait for someone else to merge. Never merge your own
work!

Your patch will be reviewed for quality assurance, and merged if accepted.

How to download Libreboot from the Git repository
-------------------------------------------------

In your terminal:

    $ git clone https://notabug.org/libreboot/libreboot.git

A new directory named `libreboot` will have been created, containing
libreboot.

How to submit your patches (via pull requests)
----------------------------------------------

Make an account on <https://notabug.org/> and navigate (while logged in) to
<https://notabug.org/libreboot/libreboot>. Click *Fork* and in your account,
you will have your own repository of Libreboot. Clone your repository, make
whatever changes you like to it and then push to your repository, in your
account on NotABug.

Now, navigate to <https://notabug.org/libreboot/libreboot/pulls> and click
*New Pull Request*. 

You can submit your patches there. Alternative, you can log onto the Libreboot
IRC channel and notify the channel of which patches you want reviewed, if you
have your own Git repository with the patches.

Once you have issued a Pull Request, the Libreboot maintainers will be notified
via email. If you do not receive a fast enough response from the project, then
you could also notify the project via the #libreboot channel on Freenode.
