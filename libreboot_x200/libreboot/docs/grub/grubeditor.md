# GRUB EDITOR

Libreboot ROM images now support fluid _grub.cfg_ and _grubtest.cfg_
configuration editing with the grubeditor.sh script! Instead of manually running
cbfstool to manipulate these configuration files, this script will handle the
work for you so you can focus on actually modifying your GRUB configuration
files to your setup's needs.

At the time of this writing, grubeditor.sh supports extracting and editing
either the grub.cfg or grubtest.cfg file in any cbfstool-compatible Libreboot
ROM image that contains these files, even ones that have been previously
modified. It can also swap these configuration files in an existing ROM image,
handy if you have a working grubtest.cfg and want to make it the default or if
you broke the main grub.cfg and know that your grubtest.cfg still works. Lastly,
it can also run diff on these two configuration files to show you how they
differ.

## Requirements

grubeditor.sh requires an x86, x86\_64, or armv7l environment, since these are
the environments for which cbfstools binaries are provided. Additionally,
grubeditor.sh needs a Bash environment with extended getopt functionality that
can run the **diff** command and write to /tmp. Lastly, the script expects to
live in the top directory of the Libreboot utilities package so it can properly
call cbfstool.

Chances are that you already meet these requirements if you are on a Linux
environment of the listed architectures and downloaded the Libreboot utilities
package from an official source. If not, it shouldn't be too hard to use a
Linux LiveCD of your choice which provides these essentials.

Optionally, you should make sure your EDITOR variable is set. Otherwise,
grubeditor.sh will default to using vi, which may not exist on your system. You
can override this default or the contents of your EDITOR variable using the
**-e** or **--editor** command.

## Usage help

grubeditor.sh takes a number of options, the only one which is required being a
valid Libreboot ROM image that uses the GRUB2 payload and contains both
_grub.cfg_ and _grubtest.cfg_ files. Additional options should come _before_ the
ROM image file on the command line.

grubeditor.sh supports combining several short options with a single hyphen
like **-ris**, but you can also list them separately like **-r -i -s**. Long
options must always be written as standalone arguments.

You can use the **-h** or **--help** option to view a brief summary of the
options available. Consider this guide a more extensive version of this screen.

Lastly, you can check which version of grubeditor.sh you are using with the
**-v** or **--version** option.

## Editing configuration files

Invoked without any arguments except for the ROM image, grubeditor.sh will
attempt to extract the _grubtest.cfg_ file from the provided ROM image and
launch it in your editor of choice. If you make changes to the file,
grubeditor.sh will incorporate your changes into a new ROM image with the same
name in the same directory, except that the new ROM file will end with
".modified". You can then flash this ROM image to your platform's BIOS chip.

If you would prefer to edit the actual _grub.cfg_ configuration file, use the
**-r** or the **--realcfg** option. Everything else will work the same except
that your editor will open the _grub.cfg_ instead. 

If you would prefer to overwrite your existing ROM image instead of creating a
new one ending in ".modified" use the **-i** or **--inplace** option.
Naturally, you can combine this option with the **-r/--realcfg** option
described above.

## Swapping grub.cfg and grubtest.cfg

grubeditor.sh supports swapping the _grub.cfg_ and _grubtest.cfg_ configuration
files with the **-s** or **--swap** option. This will create a new ROM image
alongside the existing ROM image ending with ".modified" which has these files
swapped. Naturally, you can request this operation overwrite the existing file
instead using the **-i/--inplace** option.

Note that the script will automatically modify the "Load test configuration
(grubtest.cfg)" menu entry in both configuration files during this operation.
If this was not done, these entries would end up being self-referential after
the rename, breaking their intended functionality of changing between the
configuration files.

For best results, please do not modify this section without studying the source
code of _grubeditor.sh_ and making sure your edits do not impact the script's
ability to perform this modification

## Swapping grub.cfg and grubtest.cfg

grubeditor.sh supports comparing _grub.cfg_ and _grubtest.cfg_ files for
differences with the **-d** or **--diffcfg** option. This uses the diff command
by default, but if you want to use another program (e.g. vimdiff), you can
specify it with the **-D** or **--differ** option. Note that this mode is only
intended to show differences in the files and does not support updating the
configs themselves, so any changes you make in an interactive differ will be
ignored.

## Extracting a configuration file

You can simply extract a configuration file using the **-x** or **--extract**
option. This option is responsive to the **-r/--realcfg** option for choosing
between grubtest.cfg and grub.cfg.

## Pending development

TODO:
-   allow injecting configuration files to complement the extractor.
-   detect potentially devastating corner cases, however rare they may actually be
-   i can't specify a quoted command line with arguments to -e or -D, why?
-   support editing both config files if using an interactive differ
-   work with other types of files besides the grub configuration files.

## Conclusion

I hope that grubeditor.sh will significantly ease modifying your configuration
files in your Libreboot ROM files.

Should you find any bugs or want any feature requests, please don't hesitate to
email me or bug me on IRC.
