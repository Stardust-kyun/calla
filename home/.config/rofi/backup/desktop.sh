#!/bin/bash
CDIR="$HOME/.config/colors"
if [ -z $@ ]
then
 	echo -e "Arch Dark\nArch Light\nOcean Dark\nOcean Light\nNoel Red\nCabin"
else
	killall rofi
	case $1 in
		Arch\ Dark) 
			$CDIR/ArchDark.sh
		       	;;
		Arch\ Light)
		       	$CDIR/ArchLight.sh
		       	;;
		Ocean\ Dark)
			$CDIR/OceanDark.sh
		       	;;
		Ocean\ Light) 
			$CDIR/OceanLight.sh
		       	;;
		Noel\ Red) 
			$CDIR/NoelRed.sh
		       	;;
		Cabin) 
			$CDIR/Cabin.sh
		       	;;
	esac
fi
