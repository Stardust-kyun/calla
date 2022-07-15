#!/bin/bash

text="#a0a0b4"
back="#000f14"
black="#0a191e"
green="#468264"
red="#824655"
blue="#326482"

function lock(
i3lock \
-c 00000090 \
--indicator \
--clock --time-str='%I:%M %p' --date-str='%a %m/%d' \
--time-size='30' --date-size='30' \
--ind-pos='w/2:h/2' --radius=75 --ring-width=7 \
--time-pos='w/2+200:h/2' --date-pos='w/2-200:h/2' \
--date-color=$text --time-color=$text \
--verif-text='' --wrong-text='' --noinput-text='' \
--ring-color=$text --inside-color=$back --line-color=$back --separator-color=$text --keyhl-color=$black --bshl-color=$black \
--insidever-color=$back --ringver-color=$blue \
--insidewrong-color=$back --ringwrong-color=$red \
)

if [[ $1 = "-l" ]]; then
	lock
elif [[ $1 = "-s" ]]; then
	lock && systemctl suspend
fi
