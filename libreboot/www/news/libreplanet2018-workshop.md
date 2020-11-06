% Libreboot installation workshop at FSF LibrePlanet 2018 conference
% Leah Rowe
% 21 March 2018

LibrePlanet is the annual conference held by the Free Software Foundation in
Boston, MA, USA. This year, it's being held at MIT university on March 24th
and 25th. More details about it are here:
<https://libreplanet.org/2018/>

The FSF isn't officially hosting a Libreboot workshop at LibrePlanet
this year. At the 2015 and 2016 LibrePlanet conference, there were workshops
there run by myself and Patrick McDermott, a former member of the Libreboot
project. The FSF has confirmed that they don't have a dedicated room for it
this year, due to increasing number of conference goers.

Therefore, an unofficial workshop is being set up. I've already issued a news
post about this on the libreplanet-discuss mailing list:
<https://lists.gnu.org/archive/html/libreplanet-discuss/2018-03/msg00037.html>

With John Sullivan's blessing:
<https://lists.gnu.org/archive/html/libreplanet-discuss/2018-03/msg00039.html>

If you, the reader, are attending LibrePlanet this year, and you would like to
get a Libreboot system flashed for you, then take it with you to LibrePlanet.
There will be knowledgeable people there who can flash Libreboot for you.

Find one of the people on the list below (list will be updated if more people
volunteer to flash). If it's Kurt, they'll flash for you at the Technoethical
booth. If it's someone else, they can take you into the speakers' lounge (it does
not matter if they're not a speaker). John Sullivan of FSF has approved this.
There are tables, chairs and power sockets in that room.
There are also tables and chairs outside the speakers' lounge, in the common
area at the conference, but I highly recommend using the speakers' lounge.
That's where I took people, on LibrePlanet 2015 and 2016 :)
It's really comfy in there.

John Sullivan of FSF has also confirmed that that there is a dedicated
*alcohol-free social and hacking time* at the FSF office on Saturday 24th
March, between 1900-2130 (7-9:30 PM). You could also flash someone's laptop for
them there, in the conference room at the FSF, or on a table outside. Or the
sysadmin room, if that's OK with them.

I've been asking around. The following people have confirmed so far that they
will be providing Libreboot flashing services at the conference:

- Kurt from Technoethical, an FSF-endorsed Libreboot hardware seller. They will
  also have their own samples. They'll be at the Technoethical booth there.
  IRC nick sensiblemn\_ or sensiblemn on #libreboot IRC
- zyliwax from #libreboot IRC - has confirmed that they will be there
- Patrick McDermott (pehjota) of Libiquity. Patrick is also present at
  LibrePlanet, and has brought flashing equipment. What Patrick said on the
  libreplanet-discuss mailing list: look for the person that is wearing a
  grey Libiquity polo shirt. They posted this picture on the mailing list,
  so you know how to find this person:
  <http://www.libiquity.com/media/images/patrick-mcdermott.jpg>
  - of note: Patrick is bringing CH341A-based programmer, and can flash D8/D16
- You could also find an FSF sysadmin and ask them to flash Libreboot for you.

I would be grateful if anyone else would also be willing to provide flashing.
I myself am not attending the conference physically, unfortunately.

See mailing list post for more info. If you would like to help Kurt and
zyliwax out, please either reply to that mailing list post on
libreplanet-discuss or email me directly:
[leah@libreboot.org](mailto:leah@libreboot.org) and I'll add your name in
the above list.

Basically, all you need for flashing someone's laptop at the conference is:

- Portable SPI flasher (USB powered. SSH into it via your laptop, use the SPI
  flasher's own 3v3, etc). Make sure to use the workaround-mx patch on
  flashrom, so that you can use `--workaround-mx` on Macronix chips, if flashing
  an X200, otherwise flashing will be unreliable (see mailing list post linked
  above) - portability is important, in case you sit down with someone in
  a place without power sockets.
  See guides on libreboot.org for setting up SPI flashers, but ignore the notes
  about external PSUs and instead just wire up the flasher's own 3v3 connection.
  The workaround-mx patch is here:
  <https://notabug.org/consts/libreboot/raw/2caaac00972d9ea56b0fcd7c95897e90283b05b8/projects/flashrom/patches/0005-Workaround-MX25-reliable-operation.patch>
  apply this on flashrom src and build with that. To use it, just pass the
  `--workaround-mx` option in flashrom.
- Screwdrivers (phillips head 0 *and* 00 - sometimes labelled PH0 or PH00,
  respectively)
- Thermal paste and thermal cleaning material, for T400 flashing
  - arctic mx-4 paste recommended. For cleaning material, use anti-static cloth
  and isopropyl alcohol - as pure as possible! ideally close to 100%! 70%
  rubbing alcohol is common in USA, and not suitable for electronics
- Anti-ESD wrist/ankle strap, to protect against damage from electrostatic
  discharge when working with circuit boards.

Optionally:

- Bring DIP8 25xx SPI chips with Libreboot, for ASUS KCMA-D8 or KGPE-D16, for the
  conference goer to put in their D8/D16 when they get home. Also PLCC32 LPC
  1MB (or bigger, with padding at the beginning) chips for ASUS KFSN4-DRE
- Soldering equipment (knife tip, hot air, etc) for X200T flashing. NOTE: FSF has
  soldering equipment in their office, you could ask them to lend it to you
  if you're flashing a laptop there at the FSF office. NOTE2: Kurt from
  Technoethical is also bringing soldering equipment.
