#!/bin/bash

var=$(echo -e `cat ~/.config/bin/emoticons.txt` | dmenu -fn 'Roboto' -h '40' -i -l '5' -g '3' -c -bw 3
)

echo "$var" | tr -d "\n" | xclip -selection clipboard

notify-send "$var" "Copied to clipboard!"
