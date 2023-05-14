#!/usr/bin/env bash

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#3a464c"
FG="#d3c6aa"
BL="#293136"
WH="#333c43"
R="#e67e80"
G="#a7c080"
Y="#dbbc7f"
B="#7fbbb3"
M="#d699b6"
C="#83c092"

# func - enable/disable - radius - x offset - y offset - opacity
comp "25" "-25" "-25" ".5" 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk "everforest-dark" "everforest-dark" 
# func - background - alt background - foreground - alt foreground
browser $BG $BL $FG "#333c43" 
# func - background - background 2 - background 3 - foreground
css $BG "#09151a" "#0a191e" $FG 
# func - background - foreground
zath $BG $FG 
# func - theme
awes "everforest-dark"
