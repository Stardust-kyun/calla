#!/bin/bash

source $HOME/.config/desktop/desktop.sh

# Colors
BG="#f0fafa"
FG="#262626"
BL="#404040"
WH="#dce6e6"
R="#e68383"
G="#a0e6af"
Y="#ffcd96"
B="#83b4e6"
M="#e1aae1"
C="#8cd7d2"

# func - bar - config
bar 'tint2' 'oceanlight' 
# func - wallpaper
wall 'OceanLight.jpg' 
# func - background - foreground - frame width - border - width - height - origin - offset
notifs $BG $FG '3' $WH '300' '100' 'top-right' '45x45' 
# func - background - foreground - selected background - selected foreground
run $BG $FG $WH $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.1' 
# func - foreground - background - black - green - red - blue
lock $BG $FG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'OceanLight' 'OceanLight' 
# func (edit section for now)
cord $BG
# func - background - foreground - alt foreground
browser $BG $FG '#999999' 
# func - background - background 2 - background 3 - foreground
chan $BG '#ebf5f5' '#e6f0f0' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#ebf5f5' '#e6f0f0' $FG 
# func - background - foreground
zath $BG $FG 
# func - background image - background color - alt foreground - sel foreground
sddm 'OceanLight.jpg' $BG '#3b3b3b' $FG
# func - theme - title - margins (top bottom left right)
obox 'OceanLight' 'MIC' '20' '20' '105' '20' 

# Notify
notify-send 'Desktop' 'Set "Ocean Light" Desktop'

# Colors
# BG="#f0fafa"
# FG="#262626"
# BL="#404040"
# WH="#dde6e6"
# R="#e68383"
# G="#a5e1af"
# Y="#ffd29b"
# B="#83b4e6"
# M="#e1aae1"
# C="#8cd7d2"

