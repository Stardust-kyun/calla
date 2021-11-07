#!/bin/bash
MENU="$(rofi -p "Power" -sep "|" -dmenu -i <<< "Lock|Suspend|Exit|Reboot|Shutdown")"
case "$MENU" in
	Lock)
		$HOME/.config/bin/lock.sh -l
		;;
	Suspend)
		$HOME/.config/bin/lock.sh -s
		;;
	Exit)
		openbox --exit
		;;
	Reboot)
		systemctl reboot
		;;
	Shutdown)
		systemctl poweroff
		;;
esac
