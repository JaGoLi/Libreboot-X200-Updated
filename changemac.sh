#! /bin/env bash
## Copy template file
cd libreboot_x200/coreboot-4.13
cp 'libreboot-x200-configs-release1/gbe-ich9m.set' util/bincfg

## Install ifdtool on system
cd util/ifdtool
sudo make install

## Go to bincfg and make changes
cd ../bincfg
make clean
make

sed -i "6s/0x00/0x${2}/" 'gbe-ich9m.set'
sed -i "7s/0x4c/0x${3}/" 'gbe-ich9m.set'
sed -i "8s/0x69/0x${4}/" 'gbe-ich9m.set'
sed -i "9s/0x62/0x${5}/" 'gbe-ich9m.set'
sed -i "10s/0x72/0x${6}/" 'gbe-ich9m.set'
sed -i "11s/0x65/0x${7}/" 'gbe-ich9m.set'

make gen-gbe-ich9m
cp flashregion_3_gbe.bin ../../../../gbe.bin 
cd ../../../..

## Add gbe to rom
ifdtool -i GbE:gbe.bin ${1}
mv ${1}.new newmac_${1}
