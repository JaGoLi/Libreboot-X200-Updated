% swiftgeek and Andrew Robbins removed from the Libreboot project
% Leah Rowe
% 30 March 2021

As the title suggests, Andrew Robbins and swiftgeek (Sebastian Grzywna) are no
longer a part of the Libreboot project. While I am sad to see them go, I say
one thing freely: I wish both of them well. I'm extremely grateful for the work
that they have done over the years; their passion, their burning desire to help
others and their energy for Free Software is inspiring. Swiftgeek in particular
has given me a lot of advice on things over the years. I *hope that they do*
continue their work, and I've already told swiftgeek that I will provide him
with the money/resources if he needs it, to help him set up physical hosting
infrastructure for a new project forked from Libreboot. I will do it without a
moment's hesitation.

I also told swiftgeek that I would be happy to continue working with him, if
he wished. So far I have not yet spoken to Andrew, but he learned of my recent
decisions and has now denounced me on his website; I am not angry with him for
this, in fact I would be angry if I were him. I will address his article later
in this post. Unfortunately, Andrew's article means that I do not wish to talk
to him anymore.

Their work that they did in Libreboot is now archived. It will be preserved, in
the Git repository, for historical purposes. If they wish to continue with the
development on their version of libreboot, they may do so; in fact, I would not
want to stop them! I merely disagreed on a lot of technical levels with the
way their *build system* (the Paper build system) was implemented. Their build
system is, as of today, an unfinished re-write of Libreboot that began in 2016
by PaulK when he was a Libreboot project member, then continued in 2017 by
Andrew Robbins under the guidance of swiftgeek.

On 28 March 2021, I decided that I was nonetheless unhappy with their progress;
they had failed to produce a release in the last few years, and my gut instinct
told me that they would not make a new release at all for at least another few
year. They would have kept being awesome, implementing all kinds of cool
whacky features but their *Paper build system* (which is what it's called, the
version they worked on) would have only got endlessly more complex. I did not
want their code in Libreboot anymore.

In [my last post earlier today](libreboot202104xx.md) I announced the
extensive amounts of work that I've done on coreboot and related software, in
preparation for a new Libreboot release; in that post, I described all of the
major improvements and what is left to be done for the next Libreboot release
ETA late April 2021 / early June 2021. I only started this work in early
December 2020; I scrapped the re-write (Paper build system) and continued where
I left off back in September 2016, continuing development
of *lbmk* (libreboot-make). lbmk is much simpler and easier to maintain than
Paper, and my argument to swiftgeek has always been that it could easily
implement all of the advanced features Paper has (Paper is badly designed, 
but has nice features). I will indeed be doing this! For example: uboot
integration in Libreboot, for ARM devices.

In 5 months I've made a lot of progress; I am
mere *weeks* away from having a totally new Libreboot release ready.
Nothing has changed since that last post, in fact it's even still the same day,
and the above is merely a summary, but a development has happened:

Andrew's article
----------------

Andrew Robbins is rightly angry at me right now. I do not expect his
forgiveness ever, but I would like to address some of the points he has made in
an article about me. The article is here:

http://web.archive.org/web/20210330215036/https://www.andrewrobbins.info/libreboot.html

The only point I wish to address is:

Yes, I made an arrangement with Andrew to set up an LLC for himself in
USA (LLC = limited liability company). I told him that I would be shipping him
laptops that I buy from USA suppliers, then he would install libreboot on those
and ship them to my USA customer, and I would pay him 75% of the additional
profits generated (because it's sales I wouldn't otherwise get: the 25% would
cover my admin fees and overheads, while he gets the lion share of the profit).

In Andrew's article, he says that I was *stringing him along* so let me be
clear: although Andrew clearly no longer trusts me, I am still willing to do
this with him. I told him in the beginning that it had nothing to do with his
position in the Libreboot project; it just made good business sense, and it
still does. I would not reduce my workload by doing this with him: I would
keep my workload the same while giving *him* a workload for him to make his
own money.

Many months ago on IRC, I also proposed to swiftgeek that we start a repair
company. Similar to Louis Rossman's macbook repair company, but for Thinkpads;
swiftgeek has great knowledge of ThinkPad repair, and I could find him
customers.

I understand Andrew's anger, and fully expected it. I did not take the
decisions I made in Libreboot lightly; I made those decisions because I think
they were (are) the right decisions to make, for the good of the project.

When I bring that new release out, I will be re-opening the Libreboot
infrastructure for new outside contributors, including those who wish to have
review/push/pull access. I intend to move away from the current notabug.org
Git hosting and switch to a self-hosted GitLab CE instance.

Needless to say, I reject Andrew's calls for me to hand over control of the
Libreboot project. I'm back, and I have great plans for the project. I intend
to implement them all, fully.

Closing remarks
---------------

I will say once again:

I wish swiftgeek and Andrew all the best, in whatever they choose to do.
Sadly, I know all too well that Andrew and Swiftgeek will never trust me; such
is even stated in Andrew's article.

Their work in Libreboot's Git repository will be fully preserved. They are free
to continue their work, and I hope they succeed! Another coreboot distro can
only be a good thing!

I have nothing else to say. I wasn't sure whether I should address any of this
at all, but I think I made the right choice.
