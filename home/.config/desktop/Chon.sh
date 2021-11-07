#!/bin/bash

source $HOME/.config/desktop/desktop.sh

# Colors
BG="#ffffff"
FG="#737373"
BL="#737373"
WH="#e6e6e6"
R="#fab0b5"
G="#abfabf"
Y="#ffe1b4"
B="#b0e3fa"
M="#f5b4ff"
C="#affae1"

# func - bar - config
bar 'tint2' 'chon' 
# func - wallpaper
wall 'Chon.png' 
# func - background - foreground - frame width - border - width - height - origin - offset
notifs $BG $FG '3' $B '300' '100' 'top-left' '35x105' 
# func - background - foreground - selected background - selected foreground
run $BG $FG $B $FG
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.1' 
# func - foreground - background - black - green - red - blue
lock $BG $FG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'Chon' 'Chon' 
# func - background (edit section for now)
cord $BG
# func - background - foreground - alt foreground
browser $BG $FG '#b3b3b3' 
# func - background - background 2 - background 3 - foreground
chan $BG '#f7f7f7' '#f0f0f0' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#f7f7f7' '#f0f0f0' $FG 
# func - background - foreground
zath $BG $FG
# func - background image - background color - alt foreground - sel foreground
sddm 'Chon.png' $BG '#8c8c8c' $FG
# func - theme - title - margins (top bottom left right)
obox 'Chon' 'LMIC' '90' '20' '20' '20' 

# Notify
notify-send 'Desktop' 'Set "Chon" Desktop'
