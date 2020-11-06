#!/usr/bin/env bash

#    Three-finger tap: Enable three-finger tap for "middle click" in GNOME.
#    Copyright (C) 2015  Albin Söderqvist and Eemeli Blåsten
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


echo -e "\nThis program uses synclient to enable three-finger tap"
echo -e "for \`button 2' or \`middle click' in GNOME.\n"
echo -e "Press \`i' to install or any other key to exit.\c"

read -n 1 keypress

if [ "$keypress" = i ]; then
	mkdir -p ~/.config/autostart
	cp three-finger-tap.desktop ~/.config/autostart/three-finger-tap.desktop
	synclient TapButton3=2
	echo -e "\n\nCreated the file"
	echo -e " ~/.config/autostart/three-finger-tap.desktop"
	echo -e "\nInstallation is complete."
        echo -e "To uninstall, simply remove the file shown above."
	exit 0

else
	echo ""
	exit 0
fi

