#!/bin/bash

source $HOME/.config/desktop/desktop.sh

# Colors
BG="#201e1a"
FG="#79695a"
BL="#443a36"
WH="#867564"
R="#674441"
G="#5d6051"
Y="#84694e"
B="#545e5e"
M="#614c4c"
C="#4d5c5c"

# func - bar - config
bar 'polybar' 'cabin main' 
# func - wallpaper
wall 'Cabin.png' 
# func - background - foreground - frame width - border - width - height - origin - offset
notifs $BG $FG '3' $G '300' '100' 'top-right' '25x70' 
# func - background - foreground - selected background - selected foreground
run $BG $FG $G $BG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.3' 
# func - foreground - background - black - green - red - blue
lock $FG $BG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'Cabin' 'Cabin' 
# func - background (edit section for now)
cord $BG
# func - background - foreground - alt foreground
browser $BG $FG '#473e35' 
# func - background - background 2 - background 3 - foreground
chan $BG '#24211D' '#292621' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#24211D' '#292621' $FG 
# func - background - foreground
zath $BG $FG
# func - background image - background color - alt foreground - sel foreground
sddm 'Cabin.png' $BG '#52473d' $FG
# func - theme - title - margins (top bottom left right)
obox 'Cabin' 'LIMC' '55' '12' '12' '12' 

# Notify
notify-send 'Desktop' 'Set "Cabin" Desktop'
