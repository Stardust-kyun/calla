#!/bin/bash

source $HOME/.config/awesome/colors/scripts/desktop.sh

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

# func - background - foreground - selected background - selected foreground
run $BG $FG $BL $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.5' 
# func - foreground - background - black - green - red - blue
lock $FG $BG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'shore' 'shore' 
# func - background - foreground - alt foreground
browser $BG $FG '#4d4d54' 
# func - background - background 2 - background 3 - foreground
chan $BG '#1c1c21' '#1e1e24' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#1c1c21' '#1e1e24' $FG 
# func - background - foreground
zath $BG $FG 
# func - background image - background color - alt foreground - sel foreground
sddm 'shore.jpg' $BG '#878794' $FG
# func - theme
awes 'shore'
