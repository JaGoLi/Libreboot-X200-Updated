#!/usr/bin/env bash

#  grub-assemble gen.sh: generate GRUB ELF files (coreboot payloads)
#
#	Copyright (C) 2014, 2015 Leah Rowe <info@minifree.org>
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
#

[ "x${DEBUG+set}" = 'xset' ] && set -v
set -u -e

if [ $# != 1 ]; then
	printf "Usage: ./gen.sh mode\n"
	printf "Example: ./gen.sh vesafb\n"
	printf "Example: ./gen.sh txtmode\n"
	printf "You need to specify exactly 1 argument\n"
	exit 1
fi

if [ -f "../../../versiondate" ]; then
	# _src release archive is being used
	versiondate="$(cat ../../../versiondate)"
else
	# git repo is being used
	versiondate="$(git show -s --format=%ct)"
fi

# This is where GRUB is expected to be (outside of the grub-assemble, instead in main checkout)
grubdir="../../../grub"

source "modules.conf"

list_keymaps () {
	for keylayout in keymap/original/*; do
		keymap="${keylayout##*/}"
		printf "/boot/grub/layouts/%s.gkb=keymap/%s.gkb " "${keymap}" "${keymap}"
	done
}
keymaps=$(list_keymaps)

printf "Creating GRUB ELF executable for configuration '%s'\n" "${1}"
if [ "${1}" = "vesafb" ]; then
	# Generate the grub.elf (vesafb)
	$grubdir/grub-mkstandalone \
	  --grub-mkimage="${grubdir}/grub-mkimage" \
	  -O i386-coreboot \
	  -o "grub_vesafb.elf" \
	  -d "${grubdir}/grub-core/" \
	  --fonts= --themes= --locales=  \
	  --modules="${grub_modules}" \
	  --install-modules="${grub_install_modules}" \
	  /boot/grub/grub.cfg="../../../resources/grub/config/grub_memdisk.cfg" \
	  /dejavusansmono.pf2="../../../resources/grub/font/dejavusansmono.pf2" \
	  ${keymaps}
elif [ "${1}" = "txtmode" ]
then
	# Generate the grub.elf (txtmode)
	"${grubdir}/grub-mkstandalone" \
	  --grub-mkimage="${grubdir}/grub-mkimage" \
	  -O i386-coreboot \
	  -o "grub_txtmode.elf" \
	  -d "${grubdir}/grub-core/" \
	  --fonts= --themes= --locales=  \
	  --modules="${grub_modules}" \
	  --install-modules="${grub_install_modules}" \
	  /boot/grub/grub.cfg="../../../resources/grub/config/grub_memdisk.cfg" \
	  /memtest.bin="../../../memtest86plus/memtest.bin" \
	  ${keymaps}
else
	printf "grub-assemble gen.sh: invalid mode '%s'\n" "${1}"
	exit 1
fi
printf "\n\n"
