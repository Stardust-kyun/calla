#!/bin/env bash

source $HOME/.config/awesome/themes/colors/scripts/desktop.sh

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

# func - background - foreground - selected background - selected foreground
run $BG $FG $WH $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.1' 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'wave' 'wave' 
# func - background - foreground - alt foreground
browser $BG $FG '#999999' 
# func - background - background 2 - background 3 - foreground
chan $BG '#ebf5f5' '#e6f0f0' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#ebf5f5' '#e6f0f0' $FG 
# func - background - foreground
zath $BG $FG 
# func - background - alt background - alt background hover - disabled background - foreground - dimmed foreground - error foreground - image
lightdm $BG $WH '#e0ebeb' '#e4f0f0' $FG $WH $R 'wave'
# func - theme
awes 'wave'
