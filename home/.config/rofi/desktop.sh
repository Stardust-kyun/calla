#!/bin/bash
DIR="$HOME/.config/desktop"
MENU="$(rofi -p "Desktop" -sep "|" -dmenu -i <<< "Sakura Dark|Ocean Dark|Mountain Dark|Noel|Cabin|Sakura Light|Ocean Light|Mountain Light|Chon|Shuttle")"
# MENU="$(rofi -p "Desktop" -sep "|" -dmenu -i <<< `ls $HOME/.config/desktop/ | grep .sh | sed -e 's/desktop.sh//g' -e 's/.sh/|/g' | tr -d "\n" | sed 's/.$//'`)"
case "$MENU" in
	Sakura\ Dark)
		$DIR/SakuraDark.sh
		;;
	Sakura\ Light)
		$DIR/SakuraLight.sh
		;;
	Ocean\ Dark)
		$DIR/OceanDark.sh
	       	;;
	Ocean\ Light) 
		$DIR/OceanLight.sh
	       	;;
	Mountain\ Dark) 
		$DIR/MountainDark.sh
	       	;;
	Mountain\ Light)
	       	$DIR/MountainLight.sh
	       	;;
	Noel) 
		$DIR/Noel.sh
	       	;;
	Chon) 
		$DIR/Chon.sh
	       	;;
	Cabin) 
		$DIR/Cabin.sh
	       	;;
	Shuttle) 
		$DIR/Shuttle.sh
	       	;;
esac
