#!/usr/bin/env bash

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#19191e"
FG="#9999a8"
BL="#2b2b33"
WH="#9999a8"
R="#825a5a"
G="#5a825a"
Y="#968264"
B="#505a82"
M="#735a87"
C="#5a7387"

# func - enable/disable - radius - x offset - y offset - opacity
comp "25" "-25" "-25" ".5" 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk "shore" "shore" 
# func - background - alt background - foreground - alt foreground
browser $BG $BL $FG "#9999a875" 
# func - background - background 2 - background 3 - foreground
css $BG "#1c1c21" "#1e1e24" $FG 
