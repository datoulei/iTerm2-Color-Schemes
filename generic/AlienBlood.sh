#!/bin/sh
# AlienBlood

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
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

# 16 color space
put_template 0  "11/26/16"
put_template 1  "7f/2b/27"
put_template 2  "2f/7e/25"
put_template 3  "71/7f/24"
put_template 4  "2f/6a/7f"
put_template 5  "47/58/7f"
put_template 6  "32/7f/77"
put_template 7  "64/7d/75"
put_template 8  "3c/48/12"
put_template 9  "e0/80/09"
put_template 10 "18/e0/00"
put_template 11 "bd/e0/00"
put_template 12 "00/aa/e0"
put_template 13 "00/58/e0"
put_template 14 "00/e0/c4"
put_template 15 "73/fa/91"

color_foreground="63/7d/75"
color_background="0f/16/10"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "637d75"
  put_template_custom Ph "0f1610"
  put_template_custom Pi "7afa87"
  put_template_custom Pj "1d4125"
  put_template_custom Pk "73fa91"
  put_template_custom Pl "73fa91"
  put_template_custom Pm "0f1610"
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background
