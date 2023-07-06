#!/usr/bin/env bash

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#000f14"
FG="#a0a0b4"
BL="#0a191e"
WH="#a0a0b4"
R="#824655"
G="#468264"
Y="#827d50"
B="#326482"
M="#645078"
C="#327d7d"

# func - enable/disable - radius - x offset - y offset - opacity
comp "25" "-25" "-25" ".5" 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk "sakura" "sakura" 
# func - background - alt background - foreground - alt foreground
browser $BG $BL $FG "#a0a0b475" 
# func - background - background 2 - background 3 - foreground
css $BG "#09151a" "#0a191e" $FG 
