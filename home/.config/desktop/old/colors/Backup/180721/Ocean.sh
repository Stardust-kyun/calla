#!/bin/bash

CONF="$HOME/.config"
POLY="$CONF/polybar"
WALL="$HOME/Pictures/Wallpaper"
NOTI="$CONF/dunst"
ALAC="$CONF/alacritty"
GTK3="$CONF/gtk-3.0"
CORD="$CONF/powercord/src/Powercord/themes/discord"
CHRO="$HOME/.mozilla/firefox/*.default-release/chrome"
EWW="$HOME/.config/eww"
i3="$CONF/i3"
BSP="$CONF/bspwm"
OBOX="$CONF/openbox"



#   ___
#  / _ \  ___ ___  __ _ _ __
# | | | |/ __/ _ \/ _` | '_ \
# | |_| | (_|  __/ (_| | | | |
#  \___/ \___\___|\__,_|_| |_|



# Change Polybar
sed -i -e 's/.*#Launch/#Launch/g' $POLY/launch.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/DarkBeach.jpg --save && betterlockscreen -u $WALL/DarkBeach.jpg &

# Change Notifs
sed -i -e 's/background = .*/background = "#19191e"/g' $NOTI/dunstrc
sed -i -e 's/foreground = .*/foreground = "#6f6f7a"/g' $NOTI/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 3/g' $NOTI/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#6f6f7a"/g' $NOTI/dunstrc
sed -i -e 's/geometry = .*/geometry = "310x100-45+45"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst
 
# Change URxvt
sed -i -e 's/#define FG .*/#define FG #6f6f7a/g' $HOME/.Xresources
sed -i -e 's/#define BG .*/#define BG #19191e/g' $HOME/.Xresources
sed -i -e 's/#define BL .*/#define BL #2f2f34/g' $HOME/.Xresources
sed -i -e 's/#define WH .*/#define WH #6f6f7a/g' $HOME/.Xresources
sed -i -e 's/#define R .*/#define R #524444/g' $HOME/.Xresources
sed -i -e 's/#define G .*/#define G #445244/g' $HOME/.Xresources
sed -i -e 's/#define Y .*/#define Y #525244/g' $HOME/.Xresources
sed -i -e 's/#define B .*/#define B #444452/g' $HOME/.Xresources
sed -i -e 's/#define M .*/#define M #4b4452/g' $HOME/.Xresources
sed -i -e 's/#define C .*/#define C #444b52/g' $HOME/.Xresources

# Change Dmenu
sed -i -e 's/dmenu.background: .*/dmenu.background: #19191e/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #6f6f7a/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #6f6f7a/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #19191e/g' $HOME/.Xresources

# Update URxvt and Dmenu
xrdb $HOME/.Xresources

# Change Alacritty
sed -i -e 's/.*#BG/    "#19191e" #BG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#FG/    "#6f6f7a" #FG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#BL/    "#2f2f34" #BL/g' $ALAC/alacritty.yml
sed -i -e 's/.*#WH/    "#6f6f7a" #WH/g' $ALAC/alacritty.yml
sed -i -e 's/.*#R /    "#524444" #R /g' $ALAC/alacritty.yml
sed -i -e 's/.*#G /    "#445244" #G /g' $ALAC/alacritty.yml
sed -i -e 's/.*#Y /    "#525244" #Y /g' $ALAC/alacritty.yml
sed -i -e 's/.*#B /    "#444452" #B /g' $ALAC/alacritty.yml
sed -i -e 's/.*#M /    "#4b4452" #M /g' $ALAC/alacritty.yml
sed -i -e 's/.*#C /    "#444b52" #C /g' $ALAC/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=Ocean/g' $GTK3/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="Ocean"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Ocean/g' $GTK3/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Ocean"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "Ocean"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Ocean"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #19191e !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #19191e !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #19191e !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #19191e !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #19191e !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #19191e !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/DarkBeach.jpg)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #ededed;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #19191e;/g' $CHRO/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $CHRO/userChrome.css

# Change 4chan
sed -i -e 's/--bg: .*/--bg: #19191e;/g' $CHRO/userContent.css
sed -i -e 's/--bg2: .*/--bg2: #1c1c21;/g' $CHRO/userContent.css
sed -i -e 's/--bg3: .*/--bg3: #1e1e24;/g' $CHRO/userContent.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = true;/g' $CONF/picom.conf

# Change Eww
sed -i -e 's/$bg: .*/$bg: #19191e;/g' $EWW/eww.scss
sed -i -e 's/$bo: .*/$bo: #19191e;/g' $EWW/eww.scss
sed -i -e 's/$fg: .*/$fg: #6f6f7a;/g' $EWW/eww.scss
sed -i -e 's/$fgalt: .*/$fgalt: #2f2f34;/g' $EWW/eww.scss

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps top .*/gaps top 0/g' $i3/config
sed -i -e 's/gaps inner .*/gaps inner 30/g' $i3/config
sed -i -e 's/default_border .*/default_border pixel 3/g' $i3/config
sed -i -e 's/default_floating_border .*/default_floating_border pixel 3/g' $i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #6f6f7a/g' $i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #2f2f34/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/top_padding.*/top_padding 0/g' $BSP/bspwmrc
sed -i -e 's/window_gap .*/window_gap 30/g' $BSP/bspwmrc
sed -i -e 's/border_width .*/border_width 3/g' $BSP/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#6f6f7a"/g' $BSP/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#2f2f34"/g' $BSP/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#6f6f7a"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>Ocean<\/name>/g' $OBOX/rc.xml
sed -i -e 's/<titleLayout>.*/<titleLayout>MLC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i -e 's/<top>.*/<top>30<\/top>/g' $OBOX/rc.xml
sed -i -e 's/<bottom>.*/<bottom>30<\/bottom>/g' $OBOX/rc.xml
sed -i -e 's/<left>.*/<left>30<\/left>/g' $OBOX/rc.xml
sed -i -e 's/<right>.*/<right>30<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Arch Dark" Scheme'
