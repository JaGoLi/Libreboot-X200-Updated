% Libreboot installation workshop at FSF LibrePlanet 2019 conference
% Leah Rowe
% 19 March 2018

LibrePlanet is the annual conference held by the Free Software Foundation in
Boston, MA, USA. This year, it's being held at MIT university on March 23th
and 24th. More details about it are here:
<https://libreplanet.org/2019/>

The FSF isn't officially hosting a Libreboot workshop at LibrePlanet
this year. At the 2015 and 2016 LibrePlanet conference, there were workshops
there run by myself and Patrick McDermott, a former member of the Libreboot
project.

This year, like [last year](libreplanet2018-workshop.md), the intention is to
provide Libreboot flashing for conference goers on an unofficial basis. If
you have SPI flashing hardware and would like to help out, then email Leah Rowe
on [leah@libreboot.org](mailto:leah@libreboot.org) and your name will be added
here. If you can provide a photo to be shared on this page, that will further
assist attendees in finding you at the conference.

If you, the reader, are attending LibrePlanet this year, and you would like to
get a Libreboot system flashed for you, then take it with you to LibrePlanet.
There will be knowledgeable people there who can flash Libreboot for you.

I, Leah Rowe, would be grateful to anyone who can answer my call. I'm looking
for people who can provide a Libreboot installation service at the FSF conference
during the weekend.

Recommended areas to go for flashing peoples laptops/desktops at the conference:

- Speakers lounge (behind the reception desk). There is normally space in there
  and nobody actually checks whether you are a speaker. If you volunteer to
  help with stuff it should be fine.

- Tables outside the conference rooms (NOTE: no power sockets. Bring extension
  cables and duct tape, so you can tape the power cables to the ground to
  prevent trip hazards).

- FSF office (before the conference, e.g. on Thursday, March 21st or Friday,
  March 22nd. Or Monday, March 25th at the FSF office. The FSF has an open door
  policy, so any person can show up to their office on 51 Franklin Street, 5th
  Floor, Boston MA 02110. Either use the conference room if it's free, or use
  the lobby area at the back of the office. The sysadmin office will probably be
  good too, if the sysadmins let you in there

- Any room that is used for lightning talks (do it in the back, and be quiet
  so as to not disturb any talks that are in progress).

I would be grateful if anyone else would also be willing to provide flashing.
I myself am not attending the conference physically, unfortunately.

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
  if you're flashing a laptop there at the FSF office.
