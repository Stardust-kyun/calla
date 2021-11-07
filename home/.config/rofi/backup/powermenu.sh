if [ -z $@ ]
then
	echo -e "Lock\nSuspend\nExit\nReboot\nShutdown"
else
killall rofi
	case $1 in
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
		*)
			;;
	esac
fi
