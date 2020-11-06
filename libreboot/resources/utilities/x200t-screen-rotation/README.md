Screen, stylus and trackpoint rotation
======================================

This folder contains the following bash script: `rotate.sh`


Purpose
-------

Its purpose is to rotate the screen and/or Wacom stylus and/or
trackpoint orientation for more comfortable drawing and writing on a
touch screen. To use them your system should have the commands
`xrandr` and `xsetwacom` available.


Options
-------

The script accepts three command line options

* `-s` Rotates the screen 90 degrees counterclockwise.

* `-p` Sets the stylus input orientation to the same as the screen
  orientation.

* `-t` Sets the trackpoint orientation to the same as the screen
  orientation.

These can be combined, for example with `-stp` for rotating
everything. The order of the options does not matter. The script will
make sure that the screen is rotated first, and then sets the correct
input device orientations.


Why so many options?
--------------------

Different desktop environments do different things automatically. For
example on the MATE-desktop in Parabola, pressing the bezel rotation
button will always rotate the screen (but not the stylus), even when
not using this script. Hence you could use `rotate.sh -pt` to fix the
pen (stylus) and trackpoint orientations.

On other systems the desktop environment might automatically update
the stylus orientation whenever the screen orientation changes. In
this case it is enough to rotate only the screen by `-s`.

Lastly, if your desktop enviroment does absolutely nothing
automatically, use `-spt`. This might be the case for example when
useing LXDE.


Conditions for redistribution
-----------------------------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the the file
COPYING for more details.
