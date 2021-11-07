#!/bin/bash

source $HOME/.config/desktop/desktop.sh

# Colors
BG="#dedcdf"
FG="#4b4b4b"
BL="#4b4b4b"
WH="#c8c3c8"
R="#cd8c8c"
G="#91c8a0"
Y="#dcbe91"
B="#96a5cd"
M="#b996cd"
C="#96cdbe"

# func - bar - config
bar 'tint2' 'shuttleleft \& tint2 -c \$HOME\/.config\/tint2\/shuttleright \& tint2 -c \$HOME\/.config\/tint2\/shuttlebottom' 
# func - wallpaper
wall 'Shuttle.png' 
# func - background - foreground - frame width - border - width - height - origin - offset
notifs $BG $FG '3' $WH '300' '100' 'top-right' '60x140' 
# func - background - foreground - selected background - selected foreground
run $BG $FG $WH $FG
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.1' 
# func - foreground - background - black - green - red - blue
lock $BG $FG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'Shuttle' 'Shuttle' 
# func - background (edit section for now)
cord $BG
# func - background - foreground - alt foreground
browser $BG $FG '#a5a5a5' 
# func - background - background 2 - background 3 - foreground
chan $BG '#d8d6d9' '#d3d1d4' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#d8d6d9' '#d3d1d4' $FG 
# func - background - foreground
zath $BG $FG
# func - background image - background color - alt foreground - sel foreground
sddm 'Shuttle.png' $BG '#5e5e5e' $FG
# func - theme - title - margins (top bottom left right)
obox 'Shuttle' 'LC' '110' '30' '110' '30' 

# Notify
notify-send 'Desktop' 'Set "Shuttle" Desktop'
