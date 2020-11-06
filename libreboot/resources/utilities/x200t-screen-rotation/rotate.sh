#!/usr/bin/env bash
#
# rotate.sh: Rotates the screen by 90 degrees counterclockwise and/or
# gives the Wacom stylus input and/or TrackPoint the same orientation.
#
# Copyright (C) 2018  Eemeli Blåsten
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#
#
# Usage: You can run this file with the command line option -s, -p or
# -t, or any combination, for example -sp, -ps, -tp, -tps. The
# behaviour is as follows.
#
# -s: Rotates the screen by 90 degrees. Depending on your desktop
# environment, the stylus input might get rotated or not.
#
# -p: Makes the stylus have the same rotation as the the screen.
#
# -t: Makes the trackpoint have the same rotation as the the screen.
#
# The script requires xrandr and xsetwacom.

rotScreen=0
rotPen=0
rotTP=0
while getopts ":spt" option; do
  case $option in
    s)
      rotScreen=1
      ;;
    p)
      rotPen=1
      ;;
    t)
      rotTP=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


# Find the display name. On some kernels it's LVDS1, on some others it's LVDS-1
display="$(xrandr | grep LVDS | sed 's/1.*/1/')"

# Find the line in "xrandr -q --verbose" output that contains current
# screen orientation and "strip" out current orientation.
getScreenOrientation() {
  rotation="$(xrandr -q --verbose | grep "$display" | egrep -o '\) (normal|left|inverted|right) \(' | egrep -o '(normal|left|inverted|right)')"
  echo $rotation
}

# Find the device name from the STYLUS-entry in "xsetwacom list"
device="$(xsetwacom list | grep STYLUS | sed -E "s/( |\t)*id:.*//")"

# Function to set the stylus orientation to the same as the screen
setStylusToScreenOrientation() {
  screenOrientation=$(getScreenOrientation)
  case "$screenOrientation" in
    normal)
      # rotate to the normal
      xsetwacom set "$device" rotate none
      ;;
    left)
      # rotate to left (counterclockwise)
      xsetwacom set "$device" rotate ccw
      ;;
    inverted)
      # rotate to inverted
      xsetwacom set "$device" rotate half
      ;;
    right)
      # rotate to right
      xsetwacom set "$device" rotate cw
      ;;
  esac
}

# Find the trackpoint device number
trackpointNbr="$(xinput list | grep TrackPoint | sed -E "s/^.*id=//" | sed -E "s/( |\t).*$//")"

# Set the trackpoint rotation to the same as the screen rotation
setTrackpointToScreenOrientation() {
  screenOrientation=$(getScreenOrientation)
  case "$screenOrientation" in
    normal)
      # rotate to the normal
      xinput set-prop "$trackpointNbr" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1
      ;;
    left)
      # rotate to left (counterclockwise)
      xinput set-prop "$trackpointNbr" "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
      ;;
    inverted)
      # rotate to inverted
      xinput set-prop "$trackpointNbr" "Coordinate Transformation Matrix" -1 0 1 0 -1 1 0 0 1
      ;;
    right)
      # rotate to right
      xinput set-prop "$trackpointNbr" "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
      ;;
  esac
}


# Rotate the screen 90 degrees counterclockwise
rotateScreen() {
  screenOrientation=$(getScreenOrientation)
  case "$screenOrientation" in
    normal)
      # rotate to left (counterclockwise)
      xrandr --output "$display" --rotate left
      ;;
    left)
      # rotate to inverted
      xrandr --output "$display" --rotate inverted
      ;;
    inverted)
      # rotate to right
      xrandr --output "$display" --rotate right
      ;;
    right)
      # rotate to the normal orientation
      xrandr --output "$display" --rotate normal
      ;;
  esac
}

if (($rotScreen)); then
  rotateScreen
fi
if (($rotPen)); then
  setStylusToScreenOrientation
fi
if (($rotTP)); then
  setTrackpointToScreenOrientation
fi

# Make sure the stylus acts on the internal display, not an external display
xsetwacom set "$device" MapToOutput "$display"
