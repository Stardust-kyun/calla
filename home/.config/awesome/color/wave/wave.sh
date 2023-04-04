#!/usr/bin/env bash

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#f0fafa"
FG="#262626"
BL="#404040"
WH="#dce6e6"
R="#e68383"
G="#a0e6af"
Y="#ffcd96"
B="#83b4e6"
M="#e1aae1"
C="#8cd7d2"

# func - enable/disable - radius - x offset - y offset - opacity
comp "25" "-25" "-25" ".1" 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk "wave" "wave" 
# func - background - alt background - foreground - alt foreground
browser $BG $WH $FG "#26262675" 
# func - background - background 2 - background 3 - foreground
css $BG "#ebf5f5" "#e6f0f0" $FG 
# func - background - foreground
zath $BG $FG 
# func - theme
awes "wave"
