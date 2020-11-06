#! /bin/sh
set -e

# Copyright (C) 2010 Free Software Foundation, Inc.
#
# This gensymlist.sh is free software; the author
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

#
# Example:
#
# genmod.sh moddep.lst normal.module build-grub-module-verifier normal.mod
#

moddep=$1
infile=$2
outfile=$4

tmpfile=${outfile}.tmp
modname=`echo $infile | sed -e 's@\.module.*$@@'`

if ! grep ^$modname: $moddep >/dev/null; then
    echo "warning: moddep.lst has no dependencies for $modname" >&2
    exit 0
fi

deps=`grep ^$modname: $moddep | sed s@^.*:@@`

# remove old files if any
rm -f $tmpfile $outfile

if test x0 != x1; then
    # stripout .modname and .moddeps sections from input module
    objcopy -R .modname -R .moddeps $infile $tmpfile

    # Attach .modname and .moddeps sections
    t1=`mktemp "${TMPDIR:-/tmp}/tmp.XXXXXXXXXX"` || exit 1
    printf "$modname\0" >$t1

    t2=`mktemp "${TMPDIR:-/tmp}/tmp.XXXXXXXXXX"` || exit 1
    for dep in $deps; do printf "$dep\0" >> $t2; done

    if test -n "$deps"; then
	objcopy --add-section .modname=$t1 --add-section .moddeps=$t2 $tmpfile
    else
	objcopy --add-section .modname=$t1 $tmpfile
    fi
    rm -f $t1 $t2

	if test xcoreboot != xemu; then
	    strip --strip-unneeded \
		-K grub_mod_init -K grub_mod_fini \
		-K _grub_mod_init -K _grub_mod_fini \
		-R .note.gnu.gold-version -R .note.GNU-stack \
		-R .gnu.build.attributes \
		-R .rel.gnu.build.attributes \
		-R .rela.gnu.build.attributes \
		-R .eh_frame -R .rela.eh_frame -R .rel.eh_frame \
		-R .note -R .comment -R .ARM.exidx $tmpfile || exit 1
	fi
	if ! test -z "${TARGET_OBJ2ELF}"; then
	    "${TARGET_OBJ2ELF}" $tmpfile || exit 1
	fi
else
    tmpfile2=${outfile}.tmp2
    t1=${outfile}.t1.c
    t2=${outfile}.t2.c

    # remove old files if any
    rm -f $t1 $t2

    cp $infile $tmpfile

    # Attach .modname and .moddeps sections
    echo "char modname[]  __attribute__ ((section(\"_modname, _modname\"))) = \"$modname\";" >$t1

    for dep in $deps; do echo "char moddep_$dep[] __attribute__ ((section(\"_moddeps, _moddeps\"))) = \"$dep\";" >>$t2; done

    if test -n "$deps"; then
	gcc  -m32 -Wl,-melf_i386 -no-pie -Wl,--build-id=none -ffreestanding -nostdlib -o $tmpfile2 $t1 $t2 $tmpfile -Wl,-r,-d
    else
	gcc  -m32 -Wl,-melf_i386 -no-pie -Wl,--build-id=none -ffreestanding -nostdlib -o $tmpfile2 $t1 $tmpfile -Wl,-r,-d
    fi
    rm -f $t1 $t2 $tmpfile
    mv $tmpfile2 $tmpfile

	cp $tmpfile $tmpfile.bin
	 -felf32 \
	    -nr:_grub_mod_init:grub_mod_init \
	    -nr:_grub_mod_fini:grub_mod_fini \
	    -wd1106 -nu -nd $tmpfile.bin $tmpfile || exit 1
	rm -f $tmpfile.bin
fi
if test xcoreboot != xemu; then
    ./build-grub-module-verifier $tmpfile i386 coreboot
fi
mv $tmpfile $outfile
