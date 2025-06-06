#!/bin/sh
# Monokai Pro Machine

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
put_template 0  "27/31/36"
put_template 1  "ff/6d/7e"
put_template 2  "a2/e5/7b"
put_template 3  "ff/ed/72"
put_template 4  "ff/b2/70"
put_template 5  "ba/a0/f8"
put_template 6  "7c/d5/f1"
put_template 7  "f2/ff/fc"
put_template 8  "6b/76/78"
put_template 9  "ff/6d/7e"
put_template 10 "a2/e5/7b"
put_template 11 "ff/ed/72"
put_template 12 "ff/b2/70"
put_template 13 "ba/a0/f8"
put_template 14 "7c/d5/f1"
put_template 15 "f2/ff/fc"

color_foreground="f2/ff/fc"
color_background="27/31/36"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2fffc"
  put_template_custom Ph "273136"
  put_template_custom Pi "7cd5f1"
  put_template_custom Pj "545f62"
  put_template_custom Pk "f2fffc"
  put_template_custom Pl "b8c4c3"
  put_template_custom Pm "b8c4c3"
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
