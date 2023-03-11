#!/usr/bin/env bash
dir="$HOME/.config/awesome/themes/colors"
schemes="$(ls $dir | sed 's/.*\.sh//g' | tr -s '\n')"
menu="$(rofi -p "color scheme" -sep "\n" -dmenu -i <<< "$schemes")"

sh -c "$dir/$menu/$menu.sh"
