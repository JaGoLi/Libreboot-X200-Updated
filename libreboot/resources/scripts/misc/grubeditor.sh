#!/usr/bin/env bash
#
# grubeditor.sh -- conveniently edit grub{test}.cfg files by automating their
# extraction with cbfstool and the user's editor of choice.
#
#  Copyright (C) 2017 Zyliwax <zyliwax@protonmail.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# THIS BLOCK IS EXPERIMENTAL
# Allow debugging by running DEBUG= ${0}.
[[ "x${DEBUG+set}" = 'xset' ]] && set -v
# -u kills the script if any variables are unassigned
# -e kills the script if any function returns not-zero
#set -u

##############
# HELP COMMAND
##############

show_help() {
    cat << HELPSCREEN
$0 -- conveniently edit grub{test}.cfg files in Libreboot
ROM image files by automating their extraction with cbfstool
and the user's editor of choice.

Usage:

$0 [OPTIONS] [ROMFILE]

Options:

-h | --help: show usage help

-r | --realcfg: generate grub.cfg instead of grubtest.cfg

-i | --inplace: do not create a modified romfile, instead
modify the existing file

-e | --editor [/path/to/]editor: open the cfg file with
/path/to/editor instead of the value of \$EDITOR

-s | --swapcfg: swap grub.cfg and grubtest.cfg

-d | --diffcfg: diff grub.cfg and grubtest.cfg

-D | --differ [/path/to/]differ: use /path/to/differ instead
of "diff", can be an interactive program like vimdiff

-x | --extract: extract either grub.cfg or grubtest.cfg
depending on -r option
HELPSCREEN
}

# Version number of script
geversion="0.2.0"

# Define the list of available option in both short and long form.
shortopts="hvrie:sdD:x"
longopts="help,version,realcfg,inplace,editor:,swapcfgs,diffcfgs,differ:,extract"

# Variables for modifying the program's operation
edit_realcfg=0
edit_inplace=0
do_swapcfgs=0
do_diffcfgs=0
do_extract=0
# Path to cbfstool, filled by detect_architecture
# (Possible to provide explicitly and disclaim warranty?)
cbfstool=""
# Editor variables
use_editor=""
default_editor="vi"
editor_rawarg=""
# Differ variables
use_differ=""
default_differ="diff"
differ_rawarg=""
# Last but not least, the rom file itself
romfile=""

############################
#### PRIMARY FUNCTIONS #####
############################
# The script effectively lives in a series of function definitions, which are
# provided here before their calls to ensure that they have been declared.
#
# Please scroll to the bottom of the script to see how this cascade of
# functions gets initiated.

################
# OPTION SCRAPER
################

get_options() {
    # Test for enhanced getopt.
    getopt --test > /dev/null
    if [[ $? -ne 4 ]]; then
        echo "Your environment lacks enhanced getopt, so you cannot run this script properly."
        exit 205
    fi

    # Parse the command line options based on the previously defined values. 
    parsedopts=$(getopt --options $shortopts --longoptions $longopts --name "$0" -- "$@")
    if [[ $? -ne 0 ]]; then # getopt didn't approve of your arguments
        echo "Unrecognized options."
        exit 206
    fi

    # Use eval set to properly quote the arguments
    eval set -- "$parsedopts"

    # Interpret the arguments one-by-one until you run out.
    while [[ 1 ]]; do
        case "$1" in
            -h|--help)
                show_help
                # I return non-zero here just so nobody thinks we successfully edited grub{,test}.cfg
                exit 200
                ;;
            -v|--version)
                show_version
                # I return non-zero here just so nobody thinks we successfully edited grub{,test}.cfg
                exit 201
                ;;
            -r|--realcfg)
                edit_realcfg=1
                shift
                ;;
            -i|--inplace)
                edit_inplace=1
                shift
                ;;
            -e|--editor)
                editor_rawarg="$2" 
                shift 2
                ;;
            -s|--swapcfgs)
                do_swapcfgs=1
                shift
                ;;
            -d|--diffcfgs)
                do_diffcfgs=1
                shift
                ;;
            -D|--differ)
                differ_rawarg="$2" 
                shift 2
                ;;
            -x|--extract)
                do_extract=1
                shift
                ;;
            --)
                # Stop interpreting arguments magically.
                shift
                break
                ;;
            *)
                echo "Something went wrong while interpreting the arguments!"
                echo "I hit \"$1\" and don't know what to do with it."
                exit 209
                ;;
        esac
    done
    
    # The only option remaining should be the input file. Ensure it was
    # provided before proceeding with the rest of the script and capture it if
    # it was.
    if [[ $# -ne 1 ]]; then
        echo "You have specified multiple (or no) input files, which is unsupported."
        echo "Please rerun this command with just a single filename to remove any chance for ambiguity."
        exit 210
    fi
    romfile="$1"
}

determine_architecture() {
    # The cbfstool in _util is packed only for i686, x86_64, and armv7l. This
    # procedure is necessary for this process to not fail. After this process
    # is over, the variable $cbfstool gets filled with the appropriate value
    # for use by the rest of the script.
    arch="$(uname -m)"
    case "$arch" in
        armv7l|i686|x86_64)
            echo "Supported architecture \"$arch\" detected. You may proceed."
            cbfstool="${0%/*}/cbfstool/$arch/cbfstool"
            ;;
        *) 
            echo "Unsupported architecture \"$arch\" detected! You may not proceed."
            exit 230
            ;;
    esac
}

determine_operation() {
    if [[ $do_swapcfgs -eq 1 ]]; then
        swap_configs
        exit $?
    elif [[ $do_diffcfgs -eq 1 ]]; then
        diff_configs
        exit $?
    elif [[ $do_extract -eq 1 ]]; then
        extract_config
        exit $?
    else
        edit_config
        exit $?
    fi
}

################
# VERSION SHOWER
################

show_version() {
    echo "$0 $geversion"
}

##########################
# EXTERNAL COMMAND FINDERS
##########################

find_differ() {
    found_differ=0

    if [[ -n "$differ_rawarg" ]]; then
        which "$differ_rawarg" &> /dev/null
        if [[ $? -eq 0 ]]; then
            echo "Using differ \"$differ_rawarg\"..."
            use_differ="$differ_rawarg"
            found_differ=1
        else
            echo "The provided \"$differ_rawarg\" is not a valid command!"
            echo "Defaulting to $default_differ..."
            use_differ="$default_differ"
        fi
    fi
    
    if [[ $found_differ -eq 1 ]]; then 
        return
    else
        echo "Defaulting to $default_differ..."
        use_differ="$default_differ"
    fi
}

find_editor() {
    found_editor=0

    if [[ -n "$editor_rawarg" ]]; then
        which "$editor_rawarg" &> /dev/null
        if [[ $? -eq 0 ]]; then
            echo "Using editor \"$editor_rawarg\"..."
            use_editor="$editor_rawarg"
            found_editor=1
        else
            echo "The provided \"$editor_rawarg\" is not a valid command!"
            echo "Defaulting to $default_editor..."
            use_editor="$default_editor"
        fi
    fi
    
    if [[ $found_editor -eq 1 ]]; then 
        return
    else
        if [[ -n "$EDITOR" ]]; then
            which "$EDITOR" &> /dev/null
            if [[ $? -ne 0 ]]; then
                echo "Your \$EDITOR is defined as $EDITOR, but is not a valid command!"
                echo "(This is bad. I highly suggest fixing this in your ~/.bashrc.)"
                echo "Defaulting to $default_editor..."
                use_editor="$default_editor"
            else
                echo "Using your defined \$EDITOR \"$EDITOR\"..."
                use_editor="$EDITOR"
            fi
        else
            echo "\$EDITOR blank, defaulting to $default_editor..."
            use_editor="$default_editor"
        fi
    fi
}

#######################
# FILE NAMING FUNCTIONS
#######################

random_tempcfg() {
    # Inputs:
    # $1 is a descriptive label for the file
    # $2 is directory (becomes /tmp if not set)
    [[ -n "$1" ]] && label="$1" || label="tempfile"
    [[ -n "$2" ]] && savedir="${2%/}" || savedir="/tmp"

    # Hardcoded string size for multiple good reasons (no processing weird
    # input, prevent malicious overflows, etc.)
    size=5

    # Loop forever until a free filename is found.
    while [[ 1 ]]; do
        # Read data from /dev/urandom and convert into random ASCII strings.
        rand="$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w $size | head -n 1)"

        # Build a complete filename with a hardcoded extension.
        possible="$savedir/${label}_${rand}.tmp.cfg"

        # See if file doesn't exist and return it as string or keep going.
        if [[ ! -f "$possible" ]]; then
            echo "$possible" 
            break
        fi
    done
}

modified_romfile() {
    # Inputs:
    # $1 is the path to the file, optional
    # $2 provides an optional description of the modification
    [[ -n "$1" ]] && fullname="$1" || fullname=""
    [[ -n "$2" ]] && operation="$2" || operation="altered"

    # Attempt to extract an extension from the file (it's probably .rom but
    # can't assume so). $extension will not include prefixing dot, just the
    # extension itself!
    if [[ "$fullname" = *.* ]]; then
        extension="${fullname##*.}"
    else
        extension=""
    fi

    # Break up full path into containing directory and raw filename, providing
    # an attempt at graceful failure if they are absent.
    if [[ -z "$fullname" ]]; then
        dirname="/tmp"
        filename="grubedited"
    else
        dirname="$(dirname "$fullname")"
        if [[ -z "$extension" ]]; then
            filename="$(basename "$fullname")"
        else
            filename="$(basename "$fullname" ".$extension")"
        fi
    fi

    # Loop forever until a free filename is found.
    while [[ 1 ]]; do
        # Grab the current date.
        now="$(date +"%Y%m%d_%H%M%S")"

        # Build a complete filename with a hardcoded extension.
        possible="$dirname/${filename}-${now}-${operation}.${extension}"

        # See if file doesn't exist and return it as string or keep going.
        if [[ ! -f "$possible" ]]; then
            echo "$possible" 
            break
        fi
    done
}

###########################
# PRIMARY PROGRAM FUNCTIONS
###########################

swap_configs() {
    # Procedure:
    # 1. Call cbfstool twice, once each to extract grub.cfg and grubtest.cfg.
    # 2. If --inplace not specified, copy $romfile to a new file and implement
    # remaining steps on this copy. Otherwise, implement remaining steps on
    # $romfile.
    # 3. Call cbfstool twice, once each to delete grub.cfg and grubtest.cfg
    # from romfile.
    # 4. Call cbfstool twice, once to embed grubtest.cfg as grub.cfg into
    # romfile and again to embed grub.cfg as grubtest.cfg into romfile.
    # 5. Delete the extracted grub.cfg and grubtest.cfg files.
    # 6. You're done!

    # Extract config files from provided romfile.
    real2test="$(random_tempcfg "real2test")"
    test2real="$(random_tempcfg "test2real")"
    "$cbfstool" "$romfile" extract -n grub.cfg -f "$real2test"
    "$cbfstool" "$romfile" extract -n grubtest.cfg -f "$test2real"

    # Determine whether to edit inplace or make a copy.
    if [[ $edit_inplace -eq 1 ]]; then
        outfile="$romfile"
    else
        outfile="$(modified_romfile "$romfile" "swapped")"
        cp "$romfile" "$outfile"
        echo "Saving modified romfile to $outfile"
    fi

    # Since we are swapping the configs, we must modify their "load test config"
    # options or else they will simply reference themselves, rendering the user
    # unable to (easily) load the other config.
    sed -i -e 's/Load test configuration (grubtest.cfg)/Load test configuration (grub.cfg)/' "$real2test" 
    sed -i -e 's/configfile \/grubtest.cfg/configfile \/grub.cfg/' "$real2test" 
    sed -i -e 's/Load test configuration (grub.cfg)/Load test configuration (grubtest.cfg)/' "$test2real" 
    sed -i -e 's/configfile \/grub.cfg/configfile \/grubtest.cfg/' "$test2real" 

    # Remove config files from the output file.
    "$cbfstool" "$outfile" remove -n grub.cfg
    "$cbfstool" "$outfile" remove -n grubtest.cfg

    # Embed new configs into the output file.
    "$cbfstool" "$outfile" add -t raw -n grub.cfg -f "$test2real"
    "$cbfstool" "$outfile" add -t raw -n grubtest.cfg -f "$real2test"
    
    # Delete the tempfiles.
    rm "$test2real" "$real2test"
}

diff_configs() {
    # Procedure:
    # 1. Call cbfstool twice, once to extract grub.cfg and grubtest.cfg.
    # 2. Execute $use_differ grub.cfg grubtest.cfg #.
    # 3. Delete the extracted grub.cfg and grubtest.cfg files.
    # 4. You're done!

    # Determine the differ command to use.
    find_differ

    grubcfg="$(random_tempcfg "grubcfg")"
    grubtestcfg="$(random_tempcfg "grubtestcfg")"

    # Extract config files from provided romfile.
    "$cbfstool" "$romfile" extract -n grub.cfg -f "$grubcfg"
    "$cbfstool" "$romfile" extract -n grubtest.cfg -f "$grubtestcfg"

    # Run the differ command with real as first option, test as second option.
    "$use_differ" "$grubcfg" "$grubtestcfg"

    # Delete the temporary copies of the configuration files.
    rm "$grubcfg"
    rm "$grubtestcfg"
}

edit_config() {
    # Procedure:
    # 1. If --realcfg specified, set $thisconfig to "grub.cfg". Otherwise,
    # set $thisconfig to "grubtest.cfg".
    # 2. Call cbfstool once to extract $thisconfig from $romfile.
    # 3. Run $use_editor $thisconfig.
    # 4. If $use_editor returns zero, proceed with update procedure:
    # 5. Call cbfstool once to extract $thisconfig from $romfile.
    # 6. Quietly diff the extracted file with the edited file. If diff returns
    # zero, take no action: warn the user that the files were the same, delete
    # both files, then skip the remaining steps (you're done)! Otherwise, the
    # files are different and you must continue with the update procedure.
    # 7. If --inplace not specified, copy $romfile to a new filename and
    # implement remaining steps on this copy. Otherwise, implement remaining
    # steps on $romfile.
    # 8. Call cbfstool once to delete internal pre-update $thisconfig from
    # the rom file.
    # 9. Call cbfstool once to embed the updated $thisconfig that was just
    # edited into the rom file.
    # 10. Alert the user of success (either explicitly or by not saying
    # anything, either way return zero).
    # 11. You're done!

    # Determine the editor command to use.
    find_editor

    # Determine whether we are editing the real config or the test config.
    if [[ $edit_realcfg -eq 1 ]]; then
        thisconfig="grub.cfg"
    else
        thisconfig="grubtest.cfg"
    fi

    # Extract the desired configuration file from the romfile.
    tmp_editme="$(random_tempcfg "${thisconfig%.cfg}")"
    "$cbfstool" "$romfile" extract -n "$thisconfig" -f "$tmp_editme"

    # Launch the editor!
    "$use_editor" "$tmp_editme"

    # Did the user commit the edit?
    if [[ $? -eq 0 ]]; then
        # See if it actually changed from what exists in the cbfs.
        tmp_refcfg="/tmp/${thisconfig%.cfg}_ref.cfg"
        "$cbfstool" "$romfile" extract -n "$thisconfig" -f "$tmp_refcfg"
        # Diff the files as quietly as possible.
        diff -q "$tmp_editme" "$tmp_refcfg" &> /dev/null
        if [[ $? -ne 0 ]]; then
            # The files differ, so it won't be frivolous to update the config.
            # See if the user wants to edit the file in place.
            # (This code should really be genericized and placed in a function
            # to avoid repetition.)
            if [[ $edit_inplace -eq 1 ]]; then
                outfile="$romfile"
            else
                if [[ $edit_realcfg -eq 1 ]]; then
                    op="realcfg"
                else
                    op="testcfg"
                fi
                outfile="$(modified_romfile "$romfile" "${op}_edited")"
                cp "$romfile" "$outfile"
                echo "Saving modified romfile to $outfile"
            fi
            # Remove the old config, add in the new one.
            "$cbfstool" "$outfile" remove -n "$thisconfig"
            "$cbfstool" "$outfile" add -t raw -n "$thisconfig" -f "$tmp_editme"
        else
            echo "No changes to config file. Not updating the ROM image."
        fi
        # We are done with the config files. Delete them.
        rm "$tmp_editme"
        rm "$tmp_refcfg"
    fi
}

extract_config() {
    # This simply extracts a given config and responds to
    # the -r flag.

    # Determine whether we are extracting the real config or the test config.
    if [[ $edit_realcfg -eq 1 ]]; then
        thisconfig="grub.cfg"
    else
        thisconfig="grubtest.cfg"
    fi

    # Extract to a unique filename.
    tmp_extractme="$(random_tempcfg "${thisconfig%.cfg}" "$(dirname "$romfile")")"
    "$cbfstool" "$romfile" extract -n "$thisconfig" -f "$tmp_extractme"
    err=$?

    # Determine if cbfstool reported success.
    if [[ $err -ne 0 ]]; then
        echo "cbfstool reported an error ($err). If it succeeded anyway, check $tmp_extractme."
    else
        echo "Extracted $thisconfig from $romfile to file $tmp_extractme."
    fi
}

#################################
#### PRIMARY EXECUTION FLOW #####
#################################
# Run through the primary function cascade.
get_options $@
determine_architecture
determine_operation
