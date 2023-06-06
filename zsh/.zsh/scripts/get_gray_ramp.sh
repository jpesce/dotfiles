#!/bin/bash

# Use to calculate gray ramp
black=("20" "20" "20")
white=("cc" "cc" "cc")

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
