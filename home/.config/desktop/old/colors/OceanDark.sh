#!/bin/bash

#   ___
#  / _ \  ___ ___  __ _ _ __
# | | | |/ __/ _ \/ _` | '_ \
# | |_| | (_|  __/ (_| | | | |
#  \___/ \___\___|\__,_|_| |_|

# Paths
CONF="$HOME/.config"
BAR="$CONF/bin/bar.sh"
WALL="$HOME/Pictures/Wallpaper"
NOTI="$CONF/dunst/dunstrc"
XRES="$HOME/.Xresources"
ALAC="$CONF/alacritty/alacritty.yml"
KITTY="$CONF/kitty/kitty.conf"
VIM="$HOME/.vim/colors/theme.vim"
ROFI="$CONF/rofi/theme.rasi"
GTK3="$CONF/gtk-3.0/settings.ini"
GTK2="$HOME/.gtkrc-2.0"
CORD="$CONF/powercord/src/Powercord/themes/discord/discord.theme.css"
FIRE="$HOME/.mozilla/firefox/*.default-release/chrome"
WOLF="$HOME/.librewolf/*.default-release/chrome"
PAGE="$CONF/startpage/css/style.css"
PICOM="$CONF/picom.conf"
ZATH="$CONF/zathura/zathurarc"
LOCK="$CONF/bin/lock.sh"
OBOX="$CONF/openbox"

# Colors
BG="#19191e"
FG="#9999a8"
BL="#2b2b33"
WH="#9999a8"
R="#806060"
G="#608060"
Y="#808060"
B="#606080"
M="#706080"
C="#607080"

bar() {
sed -i "s/.*#Launch/$1 -c \$HOME\/.config\/$1\/$2 #Launch/g" $BAR
}

wall() {
nitrogen --set-zoom-fill $WALL/$1 --save
}

notifs() {
sed -i "s/background = .*/background = \"$1\"/g" $NOTI
sed -i "s/foreground = .*/foreground = \"$2\"/g" $NOTI
sed -i "s/frame_width = .*/frame_width = \"$3\"/g" $NOTI
sed -i "s/frame_color = .*/frame_color = \"$4\"/g" $NOTI
sed -i "s/geometry = .*/geometry = \"$5\"/g" $NOTI
# Restart
sleep 1 && killall dunst
}

run() {
sed -i "s/--bg: .*/--bg: $1;/g" $ROFI
sed -i "s/--fg: .*/--fg: $2;/g" $ROFI
sed -i "s/--selbg: .*/--selbg: $3;/g" $ROFI
sed -i "s/--selfg: .*/--selfg: $4;/g" $ROFI
sed -i "s/dmenu.background: .*/dmenu.background: $1/g" $XRES
sed -i "s/dmenu.foreground: .*/dmenu.foreground: $2/g" $XRES
sed -i "s/dmenu.selbackground: .*/dmenu.selbackground: $3/g" $XRES
sed -i "s/dmenu.selforeground: .*/dmenu.selforeground: $4/g" $XRES
}

comp() {
sed -i "s/shadow = .*/shadow = $1;/g" $PICOM
sed -i "s/shadow-radius = .*/shadow-radius = $2;/g" $PICOM
sed -i "s/shadow-offset-x = .*/shadow-offset-x = $3;/g" $PICOM
sed -i "s/shadow-offset-y = .*/shadow-offset-y = $4;/g" $PICOM
sed -i "s/shadow-opacity = .*/shadow-opacity = $5;/g" $PICOM
}

lock() {
sed -i "s/text=\".*/text=\"$1\"/g" $LOCK
sed -i "s/back=\".*/back=\"$2\"/g" $LOCK
sed -i "s/black=\".*/black=\"$3\"/g" $LOCK
sed -i "s/green=\".*/green=\"$4\"/g" $LOCK
sed -i "s/red=\".*/red=\"$5\"/g" $LOCK
sed -i "s/blue=\".*/blue=\"$6\"/g" $LOCK
}

term() {
# Xresources
sed -i "s/#define FG .*/#define FG $FG/g" $XRES
sed -i "s/#define BG .*/#define BG $BG/g" $XRES
sed -i "s/#define BL .*/#define BL $BL/g" $XRES
sed -i "s/#define WH .*/#define WH $WH/g" $XRES
sed -i "s/#define R .*/#define R $R/g" $XRES
sed -i "s/#define G .*/#define G $G/g" $XRES
sed -i "s/#define Y .*/#define Y $Y/g" $XRES
sed -i "s/#define B .*/#define B $B/g" $XRES
sed -i "s/#define M .*/#define M $M/g" $XRES
sed -i "s/#define C .*/#define C $C/g" $XRES
# Alacritty
sed -i "s/.*#BG/    \"$BG\" #BG/g" $ALAC
sed -i "s/.*#FG/    \"$FG\" #FG/g" $ALAC
sed -i "s/.*#BL/    \"$BL\" #BL/g" $ALAC
sed -i "s/.*#WH/    \"$WH\" #WH/g" $ALAC
sed -i "s/.*#R /    \"$R\" #R /g" $ALAC
sed -i "s/.*#G /    \"$G\" #G /g" $ALAC
sed -i "s/.*#Y /    \"$Y\" #Y /g" $ALAC
sed -i "s/.*#B /    \"$B\" #B /g" $ALAC
sed -i "s/.*#M /    \"$M\" #M /g" $ALAC
sed -i "s/.*#C /    \"$C\" #C /g" $ALAC
# Kitty
sed -i -e "s/color0 .*/color0 $BL/g" -e "s/color8 .*/color8 $BL/g" $KITTY
sed -i -e "s/color1 .*/color1 $R/g" -e "s/color9 .*/color9 $R/g" $KITTY
sed -i -e "s/color2 .*/color2 $G/g" -e "s/color10 .*/color10 $G/g" $KITTY
sed -i -e "s/color3 .*/color3 $Y/g" -e "s/color11 .*/color11 $Y/g" $KITTY
sed -i -e "s/color4 .*/color4 $B/g" -e "s/color12 .*/color12 $B/g" $KITTY
sed -i -e "s/color5 .*/color5 $M/g" -e "s/color13 .*/color13 $M/g" $KITTY
sed -i -e "s/color6 .*/color6 $C/g" -e "s/color14 .*/color14 $C/g" $KITTY
sed -i -e "s/color7 .*/color7 $WH/g" -e "s/color15 .*/color15 $WH/g" $KITTY
sed -i "s/foreground .*/foreground $FG/g" $KITTY
sed -i "s/background .*/background $BG/g" $KITTY
sed -i "s/selection_foreground .*/selection_foreground $BG/g" $KITTY
sed -i "s/selection_background .*/selection_background $FG/g" $KITTY
sed -i "s/cursor .*/cursor $FG/g" $KITTY
# Vim
sed -i "s/ bg = .*/ bg = \"$BG\"/g" $VIM
sed -i "s/ fg = .*/ fg = \"$FG\"/g" $VIM
sed -i "s/ bl = .*/ bl = \"$BL\"/g" $VIM
sed -i "s/ wh = .*/ wh = \"$WH\"/g" $VIM
sed -i "s/ r  = .*/ r  = \"$R\"/g" $VIM
sed -i "s/ g  = .*/ g  = \"$G\"/g" $VIM
sed -i "s/ y  = .*/ y  = \"$Y\"/g" $VIM
sed -i "s/ b  = .*/ b  = \"$B\"/g" $VIM
sed -i "s/ m  = .*/ m  = \"$M\"/g" $VIM
sed -i "s/ c  = .*/ c  = \"$C\"/g" $VIM
# Update Xresources, Terminals, and Vim
xrdb $XRES
$CONF/bin/livereload.sh
vim --remote-send "<C-c>:color theme<CR>" vim
}

gtk() {
sed -i "s/gtk-theme-name=.*/gtk-theme-name=$1/g" $GTK3
sed -i "s/gtk-theme-name=.*/gtk-theme-name=\"$1\"/g" $GTK2
sed -i "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=$2/g" $GTK3
sed -i "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=\"$2\"/g" $GTK2
sed -i "s/Net\/ThemeName .*/Net\/ThemeName \"$1\"/g" $HOME/.xsettingsd
sed -i "s/Net\/IconThemeName .*/Net\/IconThemeName \"$2\"/g" $HOME/.xsettingsd
# Apply
xsettingsd &
}

cord() {
sed -i "s/--background-primary: .*/--background-primary: #19191e !important;/g" $CORD
sed -i "s/--background-secondary: .*/--background-secondary: #19191e !important;/g" $CORD
sed -i "s/--background-secondary-alt: .*/--background-secondary-alt: #19191e !important;/g" $CORD
sed -i "s/--background-tertiary: .*/--background-tertiary: #19191e !important;/g" $CORD
sed -i "s/--background-accent: .*/--background-accent: #19191e !important;/g" $CORD
sed -i "s/--background-floating: .*/--background-floating: #19191e !important;/g" $CORD
sed -i "s/--text-muted: .*/--text-muted: #b6b6b6 !important;/g" $CORD
sed -i "s/--text-normal: .*/--text-normal: #fbfbfb !important;/g" $CORD
sed -i "s/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g" $CORD
sed -i "s/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g" $CORD
sed -i "s/--interactive-active: .*/--interactive-active: #fff !important;/g" $CORD
sed -i "s/--header-primary: .*/--header-primary: white !important;/g" $CORD
sed -i "s/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g" $CORD
}

browser() {
sed -i "s/--bg: .*/--bg: $1;/g" $FIRE/userChrome.css
sed -i "s/--fg: .*/--fg: $2;/g" $FIRE/userChrome.css
sed -i "s/--fg-alt: .*/--fg-alt: $3;/g" $FIRE/userChrome.css
sed -i "s/--bg: .*/--bg: $1;/g" $WOLF/userChrome.css
sed -i "s/--fg: .*/--fg: $2;/g" $WOLF/userChrome.css
sed -i "s/--fg-alt: .*/--fg-alt: $3;/g" $WOLF/userChrome.css
}

chan() {
sed -i "s/--bg: .*/--bg: $1;/g" $FIRE/userContent.css
sed -i "s/--bg2: .*/--bg2: $2;/g" $FIRE/userContent.css
sed -i "s/--bg3: .*/--bg3: $3;/g" $FIRE/userContent.css
sed -i "s/--fg: .*/--fg: $4;/g" $FIRE/userContent.css
sed -i "s/--bg: .*/--bg: $1;/g" $WOLF/userContent.css
sed -i "s/--bg2: .*/--bg2: $2;/g" $WOLF/userContent.css
sed -i "s/--bg3: .*/--bg3: $3;/g" $WOLF/userContent.css
sed -i "s/--fg: .*/--fg: $4;/g" $WOLF/userContent.css
}

page() {
sed -i "s/--bg: .*/--bg: $1;/g" $PAGE
sed -i "s/--bg2: .*/--bg2: $2;/g" $PAGE
sed -i "s/--bg3: .*/--bg3: $3;/g" $PAGE
sed -i "s/--fg: .*/--fg: $4;/g" $PAGE
}

zath() {
sed -i "s/recolor-lightcolor.*/recolor-lightcolor		\"$1\"/g" $ZATH
sed -i "s/recolor-darkcolor.*/recolor-darkcolor		\"$2\"/g" $ZATH
sed -i "s/statusbar-bg.*/statusbar-bg		\"$1\"/g" $ZATH
sed -i "s/statusbar-fg.*/statusbar-fg		\"$2\"/g" $ZATH
sed -i "s/default-bg.*/default-bg			\"$1\"/g" $ZATH
sed -i "s/default-fg.*/default-fg			\"$2\"/g" $ZATH
sed -i "s/inputbar-bg.*/inputbar-bg			\"$1\"/g" $ZATH
sed -i "s/inputbar-fg.*/inputbar-fg			\"$2\"/g" $ZATH
sed -i "s/completion-bg.*/completion-bg		\"$1\"/g" $ZATH
sed -i "s/completion-fg.*/completion-fg		\"$2\"/g" $ZATH
sed -i "s/completion-highlight-bg.*/completion-highlight-bg	\"$2\"/g" $ZATH
sed -i "s/completion-highlight-fg.*/completion-highlight-fg	\"$1\"/g" $ZATH
sed -i "s/completion-group-bg.*/completion-group-bg		\"$1\"/g" $ZATH
sed -i "s/completion-group-fg.*/completion-group-fg		\"$2\"/g" $ZATH
}

obox() {
sed -i "s/<theme><name>.*/<theme><name>$1<\/name>/g" $OBOX/rc.xml
sed -i "s/<titleLayout>.*/<titleLayout>$2<\/titleLayout>/g" $OBOX/rc.xml
sed -i "s/<top>.*/<top>$3<\/top>/g" $OBOX/rc.xml
sed -i "s/<bottom>.*/<bottom>$4<\/bottom>/g" $OBOX/rc.xml
sed -i "s/<left>.*/<left>$5<\/left>/g" $OBOX/rc.xml
sed -i "s/<right>.*/<right>$6<\/right>/g" $OBOX/rc.xml
# Reconfigure
openbox --reconfigure
$OBOX/autostart
}


# func - bar - config
bar 'tint2' 'oceandark' 
# func - wallpaper
wall 'DarkBeach.jpg' 
# func - background - foreground - frame width - geometry
notifs $BG $FG '3' $BL '310x100+45+45' 
# func - background - foreground - selected background - selected foreground
run $BG $FG $BL $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '25' '-25' '-25' '.5' 
# func - foreground - background - black - green - red - blue
lock $FG $BG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'OceanDark' 'OceanDark' 
# func (edit section for now)
cord 
# func - background - foreground - alt foreground
browser $BG $FG '#4d4d54' 
# func - background - background 2 - background 3 - foreground
chan $BG '#1c1c21' '#1e1e24' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#1c1c21' '#1e1e24' $FG 
# func - background - foreground
zath $BG $FG 
# func - theme - title - margins (top bottom left right)
obox 'OceanDark' 'CIML' '20' '20' '20' '105' 

# Notify
notify-send 'Desktop' 'Set "Ocean Dark" Desktop'

#19191e
#9999a8
#3a3a40
#9999a8
#825a5a
#5a825a
#a08c69
#5a5a82
#6e5a82
#5a6e82
