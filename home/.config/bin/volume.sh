#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar="─"$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
	if [ $volume -lt 6 ]
    then
        bar='─'
    fi
    # Send the notification
    sh ~/.config/bin/notify-send.sh -i notification-audio-volume-high "$volume%"" ""$bar" -t 2000 -h string:synchronous:"$bar" --replace=555

    # CUSTOM NOTIFICATION BY STARDUST-KYUN
    # sh ~/.config/notify-send.sh -i notification-audio-volume-high "$volume%" --replace=555 -t 2000

}

function send_notificationdown {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar="─"$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
	if [ $volume -lt 6 ]
    then
		bar="─"
    fi
    # Send the notification
    sh ~/.config/bin/notify-send.sh -i notification-audio-volume-high "$volume%"" ""$bar" -t 2000 -h string:synchronous:"$bar" --replace=555

    # CUSTOM NOTIFICATION BY STARDUST-KYUN
    # sh ~/.config/notify-send.sh -i notification-audio-volume-medium "$volume%" --replace=555 -t 2000

}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer -D pulse sset Master 5%+ > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 5%- > /dev/null
	send_notificationdown
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
	   sh ~/.config/bin/notify-send.sh -i notification-audio-volume-muted "Muted"" ""─────────x─────────" --replace=555 -t 2000
   	else
	    send_notification
	fi
	;;
esac

