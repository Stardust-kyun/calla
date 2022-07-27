#!/bin/bash
DIR="$HOME/.config/awesome/themes/colors/scripts"
MENU="$(rofi -p "Color Scheme" -sep "|" -dmenu -i <<< "Sakura|Bloom|Shore|Wave|Shuttle")"
case "$MENU" in
	Sakura)
		$DIR/sakura.sh
		;;
	Bloom)
		$DIR/bloom.sh
		;;
	Shore)
		$DIR/shore.sh
	       	;;
	Wave) 
		$DIR/wave.sh
	       	;;
	Shuttle) 
		$DIR/shuttle.sh
	       	;;
esac
