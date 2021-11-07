#!/bin/bash

CDIR="$HOME/.config/colors"

MENU=$(echo -e "Arch Dark\nArch Light\nNoel Red\nCabin\nCherry\nOcean Dark\nOcean Light" | dmenu -h '40' -i -l '5' -c -bw 3 -g '2'
)
case "$MENU" in
	## Colors
	Arch\ Dark) $CDIR/ArchDark.sh ;;
	Arch\ Light) $CDIR/ArchLight.sh ;;
	Noel\ Red) $CDIR/NoelRed.sh ;;
	Cabin) $CDIR/Cabin.sh ;;
	Cherry) $CDIR/Cherry.sh ;;
	Ocean\ Dark) $CDIR/OceanDark.sh ;;
	Ocean\ Light) $CDIR/OceanLight.sh ;;
esac
