#!/bin/bash

var=$(echo -e "L to Lock\nS to Suspend\nE to Exit\nR to Reboot\nSH to Shutdown" | dmenu -h '40' -i -l '5' -c -bw 3
)

if [[ $var == "L to Lock" ]]; then
	$HOME/.config/bin/lock.sh -l
elif [[ $var == "S to Suspend" ]]; then
	$HOME/.config/bin/lock.sh -s
elif [[ $var == "E to Exit" ]]; then
	bspc quit & disown
	i3-msg exit & disown
	openbox --exit & disown
	awesome-client command "awesome.quit()" & disown
elif [[ $var == "R to Reboot" ]]; then
	systemctl reboot
elif [[ $var == "SH to Shutdown" ]]; then
	systemctl poweroff
fi
