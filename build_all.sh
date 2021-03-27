#! /usr/bin/env bash

#Clear existing builds
rm -rf libreboot_x200 roms

#Build all targets
./build.sh 16mb microcode
./build_next.sh 8mb microcode
./build_next.sh 4mb microcode
./build_next.sh 16mb free
./build_next.sh 8mb free
./build_next.sh 4mb free
