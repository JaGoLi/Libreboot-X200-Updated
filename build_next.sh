#! /usr/bin/env bash
## Create directory and cd
cd libreboot_x200/coreboot

##Get coreboot configuration
cp libreboot-x200-configs-release2/config_${1}_${2} .config

## Compile Coreboot
make -j`nproc`

## Add files to rom
cp build/coreboot.rom x200.rom
cbfstool x200.rom add -f grub.cfg -n grub.cfg -t raw
cbfstool x200.rom add -f background.jpg -n background.jpg -t raw

## Change nvram settings
nvramtool -C x200.rom -p nvram_settings.cfg

## Export rom to home directory
cp x200.rom ../../roms/x200_${1}_${2}.rom
