#!/bin/bash

source $HOME/.config/awesome/colors/scripts/desktop.sh

# Colors
BG="#fefefe"
FG="#464646"
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
run $BG $WH $BG $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '20' '-20' '-20' '.25' 
# func - foreground - background - black - green - red - blue
lock $BG $FG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'MountainLight' 'Mountain' 
# func - background - foreground - alt foreground
browser $BG $FG '#5e5e5e' 
# func - background - background 2 - background 3 - foreground
chan $BG '#1A1A1A' '#1F1F1F' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#1A1A1A' '#1F1F1F' $FG 
# func - background - foreground
zath $BG $FG
# func - background image - background color - alt foreground - sel foreground
sddm 'MountainLight.jpg' $BG $WH $FG
# func - theme
awes 'mountainlight'

# Notify
notify-send 'Color Scheme' 'Set "Mountain Light" Color Scheme'
