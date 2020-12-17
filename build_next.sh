#! /bin/env bash
## Create directory and cd
cd libreboot_x200/coreboot-4.13

##Get coreboot configuration
cp libreboot-x200-configs-release1/config_${1}_${2} .config

## Compile Coreboot
make

## Add files to rom
cp build/coreboot.rom x200.rom
cbfstool x200.rom add -f grub.cfg -n grub.cfg -t raw
cbfstool x200.rom add -f background.jpg -n background.jpg -t raw

## Change nvram settings
nvramtool -C x200.rom -w debug_level=Spew
nvramtool -C x200.rom -w bluetooth=Disable
nvramtool -C x200.rom -w power_management_beeps=Disable
nvramtool -C x200.rom -w low_battery_beep=Disable
nvramtool -C x200.rom -w gfx_uma_size=352M

## Export rom to home directory
cp x200.rom ../../roms/x200_${1}_${2}.rom
