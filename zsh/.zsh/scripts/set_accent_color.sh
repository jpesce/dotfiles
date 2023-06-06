#!/bin/bash

# Create put_template function according to environment
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

# In vim, `:r!%:p:h/get_gray_ramp.sh` to input the gray ramp below
put_template 232 "19/19/19"
put_template 233 "21/21/21"
put_template 234 "29/29/29"
put_template 235 "30/30/30"
put_template 236 "38/38/38"
put_template 237 "40/40/40"
put_template 238 "48/48/48"
put_template 239 "4f/4f/4f"
put_template 240 "57/57/57"
put_template 241 "5f/5f/5f"
put_template 242 "67/67/67"
put_template 243 "6f/6f/6f"
put_template 244 "76/76/76"
put_template 245 "7e/7e/7e"
put_template 246 "86/86/86"
put_template 247 "8e/8e/8e"
put_template 248 "96/96/96"
put_template 249 "9d/9d/9d"
put_template 250 "a5/a5/a5"
put_template 251 "ad/ad/ad"
put_template 252 "b5/b5/b5"
put_template 253 "bc/bc/bc"
put_template 254 "c4/c4/c4"
put_template 255 "cc/cc/cc"

# Add accent color to color 16
put_template 16 "92/b6/b1" # Pale Aqua
# put_template 16  "72/de/c2" # Nataniev sea-foam aqua
# put_template 16 "b0/ba/95" # Pale Green
# put_template 16 "8a/b8/98" # Green
# put_template 16 "95/d6/c0" # Green
# put_template 16 "95/c6/d6" # Blue
# put_template 16 "d6/cc/95" # Yellow
# put_template 16 "d6/95/95" # Red
# put_template 16 "aa/95/d6" # Purple
