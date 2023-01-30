#!/bin/bash
DIR="$HOME/.config/awesome/themes/colors/scripts"
MENU="$(rofi -p "color scheme" -sep "|" -dmenu -i <<< "sakura|bloom|shore|wave")"
case "$MENU" in
	sakura)
		$DIR/sakura.sh
		;;
	bloom)
		$DIR/bloom.sh
		;;
	shore)
		$DIR/shore.sh
	    ;;
	wave) 
		$DIR/wave.sh
	    ;;
esac
