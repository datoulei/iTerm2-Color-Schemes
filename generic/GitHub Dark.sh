#!/bin/sh
# GitHub Dark

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
put_template 0  "00/00/00"
put_template 1  "f7/81/66"
put_template 2  "56/d3/64"
put_template 3  "e3/b3/41"
put_template 4  "6c/a4/f8"
put_template 5  "db/61/a2"
put_template 6  "2b/74/89"
put_template 7  "ff/ff/ff"
put_template 8  "4d/4d/4d"
put_template 9  "f7/81/66"
put_template 10 "56/d3/64"
put_template 11 "e3/b3/41"
put_template 12 "6c/a4/f8"
put_template 13 "db/61/a2"
put_template 14 "2b/74/89"
put_template 15 "ff/ff/ff"

color_foreground="8b/94/9e"
color_background="10/12/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "8b949e"
  put_template_custom Ph "101216"
  put_template_custom Pi "c9d1d9"
  put_template_custom Pj "3b5070"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "c9d1d9"
  put_template_custom Pm "101216"
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
