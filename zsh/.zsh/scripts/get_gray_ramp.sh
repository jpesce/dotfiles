#!/bin/bash

# This script generates a grayscale color ramp for terminal colors 232-255.
# It calculates 24 evenly spaced intermediate colors between a given black and
# white color, which can be customized via command line arguments. The output
# is formatted as put_template commands that can be used to set terminal colors
# in `set_custom_colors.sh`.
#
# The colors 232-255 in the 256-color terminal palette are reserved for a
# grayscale ramp, making this script useful for customizing the terminal's
# grayscale appearance.
#
# Colors must be provided as 6-digit hex values with or without the # prefix.
#
# Usage: ./get_gray_ramp.sh [black_color] [white_color]
# Example: ./get_gray_ramp.sh #202020 #ffffff
# Example: ./get_gray_ramp.sh 202020 ffffff

# Default colors
DEFAULT_BLACK="202020"
DEFAULT_WHITE="cccccc"

# Parse first and second command line arguments
black=${1:-$DEFAULT_BLACK}
white=${2:-$DEFAULT_WHITE}

# Remove # prefix if present
black=${black#\#}
white=${white#\#}

# Validate input colors
if ! [[ $black =~ ^[0-9a-fA-F]{6}$ ]] || ! [[ $white =~ ^[0-9a-fA-F]{6}$ ]]; then
  echo "Error: Colors must be 6-digit hex values (e.g., #202020 or 202020)"
  exit 1
fi

# Split colors into RGB components
black=(${black:0:2} ${black:2:2} ${black:4:2})
white=(${white:0:2} ${white:2:2} ${white:4:2})

for color in {232..255}; do
  current_step=$((color-232))
  current_rgb=""

  for channel in {0..2}; do
    black_channel=$((16#${black[$channel]}))
    white_channel=$((16#${white[$channel]}))

    current_channel=$(echo "${black_channel} + (((${white_channel}-${black_channel})/23)*${current_step})" | bc -l)
    current_channel=$(echo "(${current_channel}+0.5)/1" | bc)
    current_rgb[channel]=$(printf "%02X\n" $current_channel)
  done
  current_rgb=$(printf "/%s" ${current_rgb[@]})
  current_rgb=${current_rgb:1}
  current_rgb=$(echo ${current_rgb} | tr '[:upper:]' '[:lower:]')

  echo "put_template" $color \"$current_rgb\"
done
