#!/bin/bash

source $HOME/.config/desktop/desktop.sh

# Colors
BG="#faebe6"
FG="#73645a"
BL="#5C5566"
WH="#E8D4CF"
R="#f5beaf"
G="#e6b487"
Y="#facd7d"
B="#B9B9C4"
M="#B68F95"
C="#675D72"

# func - bar - config (refer to desktop.sh)
bar 'polybar' 'noelred left \& polybar -c \$HOME\/.config\/polybar\/noelred right \&' 
# func - wallpaper
wall 'NoelYellowAlt.jpg' 
# func - background - foreground - frame width - border - width - height - origin - offset
notifs $BG $FG '3' $R '3' '100' 'top-right' '35x120' 
# func - background - foreground - selected background - selected foreground
run $BG $FG $R $BG
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.25' 
# func - foreground - background - black - green - red - blue
lock $FG $BG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'NoelRed' 'NoelRed' 
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
# func - theme - title - margins (top bottom left right)
obox 'NoelRed' 'CL' '101' '19' '19' '19' 

# Notify
notify-send 'Desktop' 'Set "Noel Yellow" Desktop'
