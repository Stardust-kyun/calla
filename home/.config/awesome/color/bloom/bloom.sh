#!/usr/bin/env bash

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#fffaf5"
FG="#4b4646"
BL="#4b4646"
WH="#ebe6e1"
R="#eb8c8c"
G="#96e6a5"
Y="#f0cd96"
B="#9bb9f0"
M="#d7a0e6"
C="#a0e1d2"

# func - background - foreground - selected background - selected foreground
run $BG $FG $WH $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.1' 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'bloom' 'bloom' 
# func - background - alt background - foreground - alt foreground
browser $BG $WH $FG '#4d4d54' 
# func - background - background 2 - background 3 - foreground
css $BG '#f5f0eb' '#ebe6e1' $FG 
# func - background - foreground
zath $BG $FG 
# func - theme
awes 'bloom'
