#!/usr/bin/env bash

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#100e13"
FG="#8da4a6"
BL="#15131a"
WH="#8da4a6"
R="#833c42"
G="#437e44"
Y="#99782e"
B="#4d7588"
M="#6a3c83"
C="#3c837e"

# func - background - foreground - selected background - selected foreground
run $BG $FG $BL $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.5' 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'sakura' 'sakura' 
# func - background - alt background - foreground - alt foreground
browser $BG $BL $FG '#4d4d54' 
# func - background - background 2 - background 3 - foreground
css $BG '#09151a' '#0a191e' $FG 
# func - background - foreground
zath $BG $FG 
# func - theme
awes 'winter'
