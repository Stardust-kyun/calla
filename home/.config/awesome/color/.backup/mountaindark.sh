#!/bin/bash

source $HOME/.config/awesome/colors/scripts/desktop.sh

# Colors
BG="#161616"
FG="#b9b9b9"
BL="#525252"
WH="#b9b9b9"
R="#7c7c7c"
G="#8e8e8e"
Y="#a0a0a0"
B="#686868"
M="#747474"
C="#868686"

# func - background - foreground - frame width - border - width - height - origin - offset
notifs $BG $FG '3' $BG
# func - background - foreground - selected background - selected foreground
run $BG $BL $BG $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '20' '-20' '-20' '.5' 
# func - foreground - background - black - green - red - blue
lock $FG $BG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'MountainDark' 'Mountain' 
# func - background - foreground - alt foreground
browser $BG $FG '#5e5e5e' 
# func - background - background 2 - background 3 - foreground
chan $BG '#1A1A1A' '#1F1F1F' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#1A1A1A' '#1F1F1F' $FG 
# func - background - foreground
zath $BG $FG 
# func - background image - background color - alt foreground - sel foreground
sddm 'MountainDark.jpg' $BG $BL $FG
# func - theme
awes 'mountaindark'

# Notify
notify-send 'Color Scheme' 'Set "Mountain Dark" Color Scheme'
