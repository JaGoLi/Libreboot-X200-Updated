% Alyssa Rosenzweig has resigned from the Libreboot project
% Leah Rowe
% 1 September 2017

Alyssa Rosenzweig has notified the rest of the team (Andrew Robbins, Paul
Kocialkowski, Leah Rowe and Swift Geek) of her intention to step down from the
core management team, as per [our management guidelines](../management.md),
due to increased pressure from school studies which prevent her from having
time to contribute.

In her email, she wishes the Libreboot project well and states that she intends
to continue contributing in the future.

I, Leah Rowe, wish Alyssa all the best in life, and I'm sure that this will be
felt by the other maintainers in Libreboot, and I'm extremely grateful for the
numerous invaluable contributions that she made to the project.

A note about the hosting infrastructure, and sysadmin tasks
-----------------------------------------------------------

Alyssa was previously acting as the system administrator for the Libreboot
project, in charge of maintaining the project's infrastructure. Additionally,
she was acting as Public Relations manager for the project; in particular, she
was handling Libreboot's application to join the GNU project.

I have since assumed these responsibilities, at least for the time being, and
I will be working alongside the other members of the team going forward.
Since Alyssa had stepped down, nobody was in place to maintain the hosting
infrastructure for the project. Our old hosting provider was giving us issues,
so we switched hosting provider; this means that I'm currently maintaining the
hosting infrastructure for the project, since nobody else was willing to.

The only piece of infrastructure currently missing is the mailing list. We now
have a fully functional mail server, and I will finish studying and installing
GNU Mailman version 3 (the software that will be used for handling the mailing
list). There are currently no repositories available for it on the GNU+Linux
distribution that libreboot.org uses (Debian), so we will have to maintain it
ourselves.

Swift Geek also works alongside me, for sysadmin tasks, and has been
particularly helpful in advising on good practises for the setup of the new
mail server. I myself haven't had time to work on it for a while, but it will
be up soon. The mailing list that Alyssa created was only online for a week,
before we had to switch hosting provider for the project, and nobody had
started using it yet, so downtime for the mailing list hasn't been a huge
issue; people use the Notabug instance, and IRC.

I will issue another news post, once the new mailing list is online. For the
time being, the links to it have been removed on the website.

The mail server itself is online, so the 4 of us on the team now have
libreboot.org email addresses; these are published on the
[governance page](../management.md). If anyone wishes to contact a member of
the project directly via email, we recommend that you use these email
addresses.

Of interest: the new hosting infrastructure for libreboot.org is entirely
libre. The main router on that network is a Libreboot system, with the router software
running on top of GNU+Linux. The server for libreboot.org (web and mail server)
is also a Libreboot system with GNU+Linux; postfix and dovecot for the mail
server, and nginx for the web server. DNS is also planned (the DNS hosting is
currently outsourced).

Of further interest: libreboot.org is now IPv6-ready. All services are
dual stack IPv4+IPv6. Stronger encryption is used in the TLS configuration for
nginx aswell, for HTTPS, and HSTS is enabled by default.

The certificate authority used for TLS is Let's Encrypt. This is used for
HTTPS and for encrypted connections to the mail server.

The new hosting infrastructure is also much more secure than the previous one,
not just because Libreboot powers it but because of special configurations made
on externally accessible services (such as SSH and email).

I am currently looking for a new colocation provider, but the hardware used
for hosting should be stable from now on. I have found one, which I'm looking
into, but I'm also considering other options.
