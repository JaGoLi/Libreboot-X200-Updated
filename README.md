# Libreboot-X200-Updated
Libreboot for the X200 with an updated version of coreboot and libreboot, fixing bugs and security issues.

## Information
The build is using coreboot stable version 4.13 and a recent version of GRUB 2.05 that has the patches for the "boothole" vulnerability. The resulting bios should be free of many minor bugs presnet in older versions of libreboot. I have personally tested it on two x200s and am very pleased with the results. The user experience is exactly the same as previous versions of libreboot with same grub configruation, but with a modernized background.

## IMPORTANT: To microcode or not?
In this repository, there are builds in the **roms** folder without any proprietary blobs ending with **free**, and there are builds that only have the microcode for the CPU as a proprietary blob ending with **microcode**. I would personally recommend users to first try and install on their machines the completely free rom, as it is in the original spirit of the libreboot project to have no blobs at all. However, I have experienced random crashes after long periods of use on both my test machines when the microcode isn't present. These crashes are also present on the builds from the official libreboot website. If this happens on your computer, and you want to make a small compromise when it comes to free software, the microcode builds will eliminate those crashes.

## Further improvements
By default, all the builds allocate slightly more vram to the integrated GPU: 352M. This is a bit more than the 256M on official librbeoot builds. I have personally found that this tweak makes 1080p video playback even smoother, and very feasible even within a browser. Also, I have disabled the beep noises when a charger is plugged in and when there is a low battery. I personally found those to be distracting, especially when the information can be found on the indicator leds. All of these settings can be modified without recompiling the rom using the `nvramtool` command.

# Installation
## Download
Select your rom within the **roms** directory and ending with **free** for builds without microcode, and select your rom ending with **microcode** for builds with microcode. Make sure that the size of the rom corresponds to your chip size.
## Flashing
If libreboot is not currently installed on the target computer, the flashing proceedure is detailed very well on the libreboot website. Simply use the rom from this repository instead of the one from the website.<br><br>
If libreboot is currently installed on the system: boot the computer with the following linux kernel parameter: `iomem=relaxed`.<br><br>
Then, once inside of the operating system, make sure that a recent version of `flashrom` is installed, finally run the following command:<br>
`sudo flashrom -c "chip_name" -p internal:boardmismatch=force,laptop=force_I_want_a_brick -w name_of_selected_rom`
## Changing the mac address
For the release using coreboot 4.13 and onwards, the project is now using the `bincfg` utility provided by coreboot in order to generate the gbe rom and descriptor file. This change was made because the old `ich9gen` utility has not been updated in over two years. The new utility is still 100% free software, so there shouldn't be any concerns about proprietary components. Also the process for changing the macaddress has been streamlined, requiring mainly one command in order to do the whole process.<br> <br>
Below is an example on how to make the change. It assumes that one is already at the root of the cloned git repository, and the mac address is `00:4c:69:62:72:65`. Pay close attention to how the mac address is entered into the command, instad of being delimited by `:` markers, there are spaces between sets of two characters. Finally, make sure to enter the arguments in the same order as in the example and without errors, as I have not implemented error-handling as of yet. 
1. `cp roms/x200_8mb_free.rom x200.rom`
2. `./changemac.sh x200.rom 00 4c 69 62 72 65`

The rom with the changed macaddress will be generated with the prefix `newmac_`, so in this case the rom to flash will be `newmac_x200.rom`
## Changing the background image
There is now a utility to easily change the background displayed on the grub menu. To make the change, place the desired image at the root of the cloned git repository. The supplied image MUST BE A JPEG, otherwise there will potentially be errors and undefined behavior! Also, copy the rom that will be modified to the root of the git repository and navigate there. Then, run the script with the arguments such that the name of the rom comes first, and is then followed by the name of the image. Here is an example:
1.  `cp roms/x200_8mb_free.rom x200.rom`
2.  `cp ~/Downloads/my_background.jpg .`
3.  `./changebg.sh x200.rom my_background.jpg`

The rom with the changed background will appear with the prefix `newbg_`. In this case, it will be `newbg_x200.rom`.
## Changing the keyboard layout in GRUB
As per request, I have created a utility to change the keyboard layout. The supported options are currently the same as libreboot: `deqwertz`, `esqwerty`, `frazerty`, `frdvbepo`, `itqwerty`, `svenska`, `ukdvorak`, `ukqwerty`, `usdvorak`, `usqwerty`(default) . <br> <br>
The proceedure is very similar to changing the mac address. It assumes that one is already at the root of the cloned git repository. Make sure that the arguments are passed in the same order as the example, and that there are no errors in the filename or keymap. The name of the keymap has to be EXACTLY matching one of those listed above. Here is an exmaple changing the keymap to `frazerty`:
1. `cp roms/x200_8mb_free.rom x200.rom`
2. `./changelang.sh x200.rom frazerty`

The rom with the changed keymap will appear as `frazerty_x200.rom`.

# Building from source
In order to make changes more efficently, I automated the entire build process for these images. This has the added side-benefit of allowing people to easily build the images for themselves if they have security concerns about downloading the binaries directly. The process is all done through the script `build.sh` that is under 100 lines in length and easily-readable.

In order to build, simply download the script inside an empty directory and select the size of the rom as the first argument, such as `8mb` and then select the **free** version or the **microcode** version by passing the title as a second argument. An example is given below:<br>
1. `mkdir x200_build && cd x200_build`
2. `wget https://github.com/JaGoLi/Libreboot-X200-Updated/raw/main/build.sh`
3. `./build.sh 8mb free`

The subsequent rom will be titled `x200_8mb_free.rom` and it will be placed inside the newly-created `roms` folder.
