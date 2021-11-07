t=0
 
toggle() {
    t=$(((t + 1) % 3))
}
 
 
trap "toggle" USR1
 
while true; do
    if [ $t -eq 0 ]; then
        date +'%a %d/%m - %I:%M %p'
    elif [ $t -eq 1 ]; then
        # if spotify is started
        if [ "$(pidof spotify)" ]; then
        # status can be: Playing, Paused or Stopped
        status=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus'|egrep -A 1 "string"|cut -b 26-|cut -d '"' -f 1|egrep -v ^$`
	if [ "$status" = "Playing" ]; then
                echo " $(polybar-spotify -f '{artist} - {song}')";
	else
                echo " $(polybar-spotify -f '{artist} - {song}')";
        fi
        else
                echo "Spotify - Not Playing"
        fi
    elif [ $t -eq 2 ]; then
        id=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
        name=$(xprop -id $id | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
        if [[ $name = "" ]]; then
		echo "Empty Workspace"
	else
		echo "$name" || exit 1
	fi
    	fi
        sleep 1 &
    wait
done
