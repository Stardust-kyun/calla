#!/usr/bin/env bash

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#eae4ca"
FG="#5c6a72"
BL="#708089"
WH="#f3ead3"
R="#f85552"
G="#8da101"
Y="#dfa000"
B="#3a94c5"
M="#df69ba"
C="#35a77c"

# func - enable/disable - radius - x offset - y offset - opacity
comp "25" "-25" "-25" ".5" 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk "everforest-light" "everforest-light" 
# func - background - alt background - foreground - alt foreground
browser $BG $BL $FG "#f3ead3" 
# func - background - background 2 - background 3 - foreground
css $BG "#09151a" "#0a191e" $FG 
# func - background - foreground
zath $BG $FG 
# func - theme
awes "everforest-light"
