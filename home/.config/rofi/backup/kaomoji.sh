#!/bin/bash
echo -e "
¯\_(ツ)_/¯\n
(っ´ω\`)っ❤\n
(╥﹏╥)\n
(ˊᵕˋ)\n
٩(^ᴗ^)۶\n
(๑•́ ヮ •̀๑)\n
(づ｡◕‿◕｡)づ\n
(●´ω｀●)\n
(≧◡≦)\n
( ๑>ᴗ<๑ )\n
(´,,•ω•,,)❤\n
"

notify-send "$1" "Copied to clipboard!" && echo $1 | tr -d "\n" | xclip -selection clipboard && killall rofi
