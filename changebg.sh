#! /usr/bin/env bash

##Rename image file
mv ${2} background.jpg

## Build cbfstool
cd libreboot_x200/coreboot-4.14/util/cbfstool
make -j`nproc`
sudo make install
cd ../../../..

## Add new background to rom
cbfstool ${1} remove -n background.jpg
cbfstool ${1} add -n background.jpg -f background.jpg -t raw
mv ${1} newbg_${1}
