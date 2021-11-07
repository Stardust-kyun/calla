#!/bin/bash

source $HOME/.config/desktop/desktop.sh

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

# func - bar - config
bar 'tint2' 'sakuralight' 
# func - wallpaper
wall 'SakuraLight.jpg' 
# func - background - foreground - frame width - border - width - height - origin - offset
notifs $BG $FG '3' $WH '300' '100' 'top-right' '30x30' 
# func - background - foreground - selected background - selected foreground
run $BG $FG $WH $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.1' 
# func - foreground - background - black - green - red - blue
lock $BG $FG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'SakuraLight' 'SakuraLight' 
# func - background (edit section for now)
cord $BG
# func - background - foreground - alt foreground
browser $BG $FG '#4d4d54' 
# func - background - background 2 - background 3 - foreground
chan $BG '#f5f0eb' '#ebe6e1' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#f5f0eb' '#ebe6e1' $FG 
# func - background - foreground
zath $BG $FG 
# func - background image - background color - alt foreground - sel foreground
sddm 'SakuraLight.jpg' $BG '#595353' $FG
# func - theme - title - margins (top bottom left right)
obox 'SakuraLight' 'LC' '10' '70' '10' '10' 

# Notify
notify-send 'Desktop' 'Set "Sakura Light" Desktop'
