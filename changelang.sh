#! /usr/bin/env bash
## Copy grub config
cp libreboot_x200/coreboot/grub.cfg .

## Modify grub config
sed -i "34s/usqwerty/${2}/" 'grub.cfg'

## Build cbfstool
cd libreboot_x200/coreboot/util/cbfstool
make -j`nproc`
sudo make install
cd ../../../..

## Add new grub configuration to rom
cbfstool ${1} remove -n grub.cfg
cbfstool ${1} add -n grub.cfg -f grub.cfg -t raw
mv ${1} ${2}_${1}
