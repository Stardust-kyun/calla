#!/bin/bash

source $HOME/.config/desktop/desktop.sh

# Colors
BG="#403B47"
FG="#E8D4CF"
BL="#5C5566"
WH="#E8D4CF"
R="#CE9C97"
G="#B6A4A0"
Y="#D1AD8D"
B="#B9B9C4"
M="#B68F95"
C="#675D72"

# func - bar - config
bar 'polybar' 'noel left \& polybar -c \$HOME\/.config\/polybar\/noel right \&' 
# func - wallpaper
wall 'Noel.png' 
# func - background - foreground - frame width - border - width - height - origin - offset
notifs $BG $FG '3' $R '300' '100' 'top-right' '35x120' 
# func - background - foreground - selected background - selected foreground
run $BG $FG $R $BG
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.25' 
# func - foreground - background - black - green - red - blue
lock $FG $BG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'Noel' 'Noel' 
# func - background (edit section for now)
cord $BG
# func - background - foreground - alt foreground
browser $BG $FG '#736966' 
# func - background - background 2 - background 3 - foreground
chan $BG '#433D4A' '#47424F' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#433D4A' '#47424F' $FG 
# func - background - foreground
zath $BG $FG
# func - background image - background color - alt foreground - sel foreground
sddm 'Noel.png' $BG '#bfb0ac' $FG
# func - theme - title - margins (top bottom left right)
obox 'Noel' 'CL' '101' '19' '19' '19' 

# Notify
notify-send 'Desktop' 'Set "Noel" Desktop'
