#!/bin/bash

CDIR="$HOME/.config/colors"

MENU=$(echo -e "> Arch Dark\n> Arch Light\n> Noel Red\n> Cabin\n> Ocean" | dmenu -i -fn 'FiraCode' -h '40' -i -l '5' -c -bw 3 
)
            case "$MENU" in
				## Colors
				*Arch\ Dark) $CDIR/ArchDark.sh ;;
				*Arch\ Light) $CDIR/ArchLight.sh ;;
				*Noel\ Red) $CDIR/NoelRed.sh ;;
				*Cabin) $CDIR/Cabin.sh ;;
				*Ocean) $CDIR/Ocean.sh ;;
            esac
