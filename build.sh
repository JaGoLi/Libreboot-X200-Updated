#! /bin/env bash
## Create directory and cd
mkdir libreboot_x200 
cd libreboot_x200

## Get coreboot and extract
wget https://coreboot.org/releases/coreboot-4.13.tar.xz
wget https://coreboot.org/releases/coreboot-blobs-4.13.tar.xz

tar -xvf coreboot-4.13.tar.xz
tar -xvf coreboot-blobs-4.13.tar.xz

## Get libreboot
git clone https://notabug.org/libreboot/libreboot.git
cd libreboot

## Get grub
git clone https://git.savannah.gnu.org/git/grub.git
cp resources/grub/patch/0001-grub-core-normal-main.c-Display-FREE-AS-IN-FREEDOM-n.patch grub/
cd grub

##Compile and install grub
patch -p1 < 0001-grub-core-normal-main.c-Display-FREE-AS-IN-FREEDOM-n.patch
./bootstrap
./configure --with-platform=coreboot
make -j`nproc`
sudo make install

##Generate grub elf
cd ../resources/utilities/grub-assemble
./gen.sh vesafb
cp grub_vesafb.elf ../../../../coreboot-4.13/payload.elf

##Get grub background and config
cd ../../../../coreboot-4.13
wget https://github.com/JaGoLi/libreboot-resources/archive/libreboot_res1.tar.gz
tar -xvf libreboot_res1.tar.gz
mv libreboot-resources-libreboot_res1/* .

##Get coreboot configuration
wget https://github.com/JaGoLi/libreboot-x200-configs/archive/release1.tar.gz
tar -xvf release1.tar.gz
cp libreboot-x200-configs-release1/config_${1}_${2} .config
cp 'libreboot-x200-configs-release1/gbe-ich9m.set' util/bincfg

##Compile utilities
cd util/cbfstool
make -j`nproc`
sudo make install

cd ../nvramtool
make -j`nproc`
sudo make install

cd ../ifdtool
make -j`nproc`
sudo make install

##Generate descriptor and gbe rom
cd ../bincfg
make -j`nproc`
make gen-ifd-x200
make gen-gbe-ich9m
mkdir -p ../../3rdparty/blobs/mainboard/lenovo/x200
cp flashregion_0_fd.bin ../../3rdparty/blobs/mainboard/lenovo/x200/descriptor.bin
cp flashregion_3_gbe.bin ../../3rdparty/blobs/mainboard/lenovo/x200/gbe.bin

## Compile Coreboot
cd ../..
make crossgcc-i386 CPUS=$(nproc)
make -j`nproc`

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
mkdir ../../roms
cp x200.rom ../../roms/x200_${1}_${2}.rom
