#!/bin/bash

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# Use to calculate gray ramp
# black=("20" "20" "20")
# white=("cc" "cc" "cc")

# for color in {232..255}; do
#   current_step=$((color-232))
#   current_rgb=""

#   for channel in {0..2}; do
#     black_channel=$((16#${black[$channel]}))
#     white_channel=$((16#${white[$channel]}))

#     current_channel=$(echo "${black_channel} + (((${white_channel}-${black_channel})/23)*${current_step})" | bc -l)
#     current_channel=$(echo "(${current_channel}+0.5)/1" | bc)
#     current_rgb[channel]=$(printf "%02X\n" $current_channel)
#   done
#   current_rgb=$(printf "/%s" ${current_rgb[@]})
#   current_rgb=${current_rgb:1}
#   current_rgb=$(echo ${current_rgb} | tr '[:upper:]' '[:lower:]')

#   echo $color \"$current_rgb\"
# done

put_template 232 "20/20/20"
put_template 233 "27/27/27"
put_template 234 "2f/2f/2f"
put_template 235 "36/36/36"
put_template 236 "3e/3e/3e"
put_template 237 "45/45/45"
put_template 238 "4d/4d/4d"
put_template 239 "54/54/54"
put_template 240 "5c/5c/5c"
put_template 241 "63/63/63"
put_template 242 "6b/6b/6b"
put_template 243 "72/72/72"
put_template 244 "7a/7a/7a"
put_template 245 "81/81/81"
put_template 246 "89/89/89"
put_template 247 "90/90/90"
put_template 248 "98/98/98"
put_template 249 "9f/9f/9f"
put_template 250 "a7/a7/a7"
put_template 251 "ae/ae/ae"
put_template 252 "b6/b6/b6"
put_template 253 "bd/bd/bd"
put_template 254 "c5/c5/c5"
put_template 255 "cc/cc/cc"

# put_template 16  "72/de/c2" # Nataniev sea-foam aqua
put_template 16 "b0/ba/95" # Pale Green
# put_template 16 "95/d6/c0" # Green
# put_template 16 "95/c6/d6" # Blue
# put_template 16 "d6/cc/95" # Yellow
# put_template 16 "d6/95/95" # Red
# put_template 16 "aa/95/d6" # Purple
