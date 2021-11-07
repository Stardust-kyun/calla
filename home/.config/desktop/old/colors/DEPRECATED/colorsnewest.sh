#!/bin/bash

CONF="$HOME/.config"
POLY="$CONF/polybar"
WALL="$HOME/Pictures/Wallpaper"
NOTI="$CONF/dunst"
ALAC="$CONF/alacritty"
GTK3="$CONF/gtk-3.0"
CORD="$CONF/powercord/src/Powercord/themes/discord"
CHRO="$HOME/.mozilla/firefox/*.default-release/chrome"
i3="$CONF/i3"
BSP="$CONF/bspwm"
OBOX="$CONF/openbox"



#     _             _       ____             _    
#    / \   _ __ ___| |__   |  _ \  __ _ _ __| | __
#   / _ \ | '__/ __| '_ \  | | | |/ _` | '__| |/ /
#  / ___ \| | | (__| | | | | |_| | (_| | |  |   < 
# /_/   \_\_|  \___|_| |_| |____/ \__,_|_|  |_|\_\



if  [[ $1 = "-archdark" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #161616/g' $POLY/Arch/config.ini
sed -i -e 's/fg = .*/fg = #f2f2f2/g' $POLY/Arch/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #707070/g' $POLY/Arch/config.ini
sed -i -e 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/Arch\/config.ini main \& #Launch/g' $POLY/launch.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/WelcomeHomeLight.png --save && betterlockscreen -u $WALL/WelcomeHomeLight.png &

# Change Notifs
sed -i -e 's/background = .*/background = "#161616"/g' $NOTI/dunstrc
sed -i -e 's/foreground = .*/foreground = "#f2f2f2"/g' $NOTI/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 0/g' $NOTI/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#b9b9b9"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change URxvt
sed -i -e 's/#define FG .*/#define FG #b9b9b9/g' $HOME/.Xresources
sed -i -e 's/#define BG .*/#define BG #161616/g' $HOME/.Xresources
sed -i -e 's/#define R .*/#define R #7c7c7c/g' $HOME/.Xresources
sed -i -e 's/#define G .*/#define G #8e8e8e/g' $HOME/.Xresources
sed -i -e 's/#define Y .*/#define Y #a0a0a0/g' $HOME/.Xresources
sed -i -e 's/#define B .*/#define B #686868/g' $HOME/.Xresources
sed -i -e 's/#define M .*/#define M #747474/g' $HOME/.Xresources
sed -i -e 's/#define C .*/#define C #868686/g' $HOME/.Xresources

# Change Dmenu
sed -i -e 's/dmenu.background: .*/dmenu.background: #161616/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #707070/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #161616/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #f2f2f2/g' $HOME/.Xresources

# Change Spicetify
sed -i -e 's/*.color16: .*/*.color16: #f2f2f2/g' $HOME/.Xresources
sed -i -e 's/*.color17: .*/*.color17: #161616/g' $HOME/.Xresources
sed -i -e 's/*.color18: .*/*.color18: #707070/g' $HOME/.Xresources
sed -i -e 's/*.color19: .*/*.color19: #111111/g' $HOME/.Xresources
sed -i -e 's/*.color20: .*/*.color20: #FFF/g' $HOME/.Xresources

# Update URxvt, Dmenu, and Spicetify
xrdb $HOME/.Xresources
spicetify apply -n

# Change Alacritty
sed -i -e 's/.*#BG/    "#161616" #BG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#FG/    "#b9b9b9" #FG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#BL/    "#525252" #BL/g' $ALAC/alacritty.yml
sed -i -e 's/.*#WH/    "#b9b9b9" #WH/g' $ALAC/alacritty.yml
sed -i -e 's/.*#R /    "#7c7c7c" #R /g' $ALAC/alacritty.yml
sed -i -e 's/.*#G /    "#8e8e8e" #G /g' $ALAC/alacritty.yml
sed -i -e 's/.*#Y /    "#a0a0a0" #Y /g' $ALAC/alacritty.yml
sed -i -e 's/.*#B /    "#686868" #B /g' $ALAC/alacritty.yml
sed -i -e 's/.*#M /    "#747474" #M /g' $ALAC/alacritty.yml
sed -i -e 's/.*#C /    "#868686" #C /g' $ALAC/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=ArchDark/g' $GTK3/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="ArchDark"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Arch/g' $GTK3/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Arch"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "ArchDark"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Arch"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #161616 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #161616 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #161616 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #161616 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #161616 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #161616 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/WelcomeHomeLight.png)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #ededed;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #161616;/g' $CHRO/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $CHRO/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = true;/g' $CONF/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps top .*/gaps top 61/g' $i3/config
sed -i -e 's/gaps inner .*/gaps inner 19/g' $i3/config
sed -i -e 's/default_border .*/default_border none/g' $i3/config
sed -i -e 's/default_floating_border .*/default_floating_border none/g' $i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #8c8c8c/g' $i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #363636/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/top_padding.*/top_padding 61/g' $BSP/bspwmrc
sed -i -e 's/window_gap .*/window_gap 19/g' $BSP/bspwmrc
sed -i -e 's/border_width .*/border_width 0/g' $BSP/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#8c8c8c"/g' $BSP/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#363636"/g' $BSP/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#8c8c8c"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>ArchDark<\/name>/g' $OBOX/rc.xml
sed -i -e 's/<titleLayout>.*/<titleLayout>MLC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i -e 's/<top>.*/<top>80<\/top>/g' $OBOX/rc.xml
sed -i -e 's/<bottom>.*/<bottom>19<\/bottom>/g' $OBOX/rc.xml
sed -i -e 's/<left>.*/<left>19<\/left>/g' $OBOX/rc.xml
sed -i -e 's/<right>.*/<right>19<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Arch Dark" Scheme'



#     _             _       _     _       _     _   
#    / \   _ __ ___| |__   | |   (_) __ _| |__ | |_ 
#   / _ \ | '__/ __| '_ \  | |   | |/ _` | '_ \| __|
#  / ___ \| | | (__| | | | | |___| | (_| | | | | |_ 
# /_/   \_\_|  \___|_| |_| |_____|_|\__, |_| |_|\__|
#                                   |___/           



elif  [[ $1 = "-archlight" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #fefefe/g' $POLY/Arch/config.ini
sed -i -e 's/fg = .*/fg = #111111/g' $POLY/Arch/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #787878/g' $POLY/Arch/config.ini
sed -i -e 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/Arch\/config.ini main \& #Launch/g' $POLY/launch.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/WelcomeHomeWhite.png --save && betterlockscreen -u $WALL/WelcomeHomeWhite.png &

# Change Notifs
sed -i -e 's/background = .*/background = "#fefefe"/g' $NOTI/dunstrc
sed -i -e 's/foreground = .*/foreground = "#111111"/g' $NOTI/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 0/g' $NOTI/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#b9b9b9"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change URxvt
sed -i -e 's/#define FG .*/#define FG #464646/g' $HOME/.Xresources
sed -i -e 's/#define BG .*/#define BG #fefefe/g' $HOME/.Xresources
sed -i -e 's/#define R .*/#define R #7c7c7c/g' $HOME/.Xresources
sed -i -e 's/#define G .*/#define G #8e8e8e/g' $HOME/.Xresources
sed -i -e 's/#define Y .*/#define Y #a0a0a0/g' $HOME/.Xresources
sed -i -e 's/#define B .*/#define B #686868/g' $HOME/.Xresources
sed -i -e 's/#define M .*/#define M #747474/g' $HOME/.Xresources
sed -i -e 's/#define C .*/#define C #868686/g' $HOME/.Xresources

# Change Dmenu
sed -i -e 's/dmenu.background: .*/dmenu.background: #fefefe/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #787878/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #fefefe/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #111111/g' $HOME/.Xresources

# Change Spicetify
sed -i -e 's/*.color16: .*/*.color16: #111111/g' $HOME/.Xresources
sed -i -e 's/*.color17: .*/*.color17: #fefefe/g' $HOME/.Xresources
sed -i -e 's/*.color18: .*/*.color18: #787878/g' $HOME/.Xresources
sed -i -e 's/*.color19: .*/*.color19: #f2f2f2/g' $HOME/.Xresources
sed -i -e 's/*.color20: .*/*.color20: #000/g' $HOME/.Xresources

# Update URxvt, Dmenu, and Spicetify
xrdb $HOME/.Xresources
spicetify apply -n

# Change Alacritty
sed -i -e 's/.*#BG/    "#fefefe" #BG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#FG/    "#464646" #FG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#BL/    "#525252" #BL/g' $ALAC/alacritty.yml
sed -i -e 's/.*#WH/    "#b9b9b9" #WH/g' $ALAC/alacritty.yml
sed -i -e 's/.*#R /    "#7c7c7c" #R /g' $ALAC/alacritty.yml
sed -i -e 's/.*#G /    "#8e8e8e" #G /g' $ALAC/alacritty.yml
sed -i -e 's/.*#Y /    "#a0a0a0" #Y /g' $ALAC/alacritty.yml
sed -i -e 's/.*#B /    "#686868" #B /g' $ALAC/alacritty.yml
sed -i -e 's/.*#M /    "#747474" #M /g' $ALAC/alacritty.yml
sed -i -e 's/.*#C /    "#868686" #C /g' $ALAC/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=ArchLight/g' $GTK3/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="ArchLight"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Arch/g' $GTK3/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Arch"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "ArchLight"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Arch"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #FEFEFE !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #FEFEFE !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #FEFEFE !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #FEFEFE !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #FEFEFE !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #FEFEFE !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #666666 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #111111 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #888 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #707070 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #000 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: black !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: black !important;/g' $CORD/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/WelcomeHomeWhite.png)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #121212;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #fefefe;/g' $CHRO/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #0000007f;/g' $CHRO/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = true;/g' $CONF/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps top .*/gaps top 61/g' $i3/config
sed -i -e 's/gaps inner .*/gaps inner 19/g' $i3/config
sed -i -e 's/default_border .*/default_border none/g' $i3/config
sed -i -e 's/default_floating_border .*/default_floating_border none/g' $i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #8c8c8c/g' $i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #363636/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/top_padding.*/top_padding 61/g' $BSP/bspwmrc
sed -i -e 's/window_gap .*/window_gap 19/g' $BSP/bspwmrc
sed -i -e 's/border_width .*/border_width 0/g' $BSP/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#8c8c8c"/g' $BSP/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#363636"/g' $BSP/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#8c8c8c"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>ArchLight<\/name>/g' $OBOX/rc.xml
sed -i -e 's/<titleLayout>.*/<titleLayout>MLC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i -e 's/<top>.*/<top>80<\/top>/g' $OBOX/rc.xml
sed -i -e 's/<bottom>.*/<bottom>19<\/bottom>/g' $OBOX/rc.xml
sed -i -e 's/<left>.*/<left>19<\/left>/g' $OBOX/rc.xml
sed -i -e 's/<right>.*/<right>19<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Arch Light" Scheme'



#  ____                     ____             _    
# |  _ \ _   _ _ __   ___  |  _ \  __ _ _ __| | __
# | | | | | | | '_ \ / _ \ | | | |/ _` | '__| |/ /
# | |_| | |_| | | | |  __/ | |_| | (_| | |  |   < 
# |____/ \__,_|_| |_|\___| |____/ \__,_|_|  |_|\_\



elif  [[ $1 = "-dunedark" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #161616/g' $POLY/Arch/config.ini
sed -i -e 's/fg = .*/fg = #f2f2f2/g' $POLY/Arch/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #bcbcbc/g' $POLY/Arch/config.ini
sed -i -e 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/Arch\/config.ini main \& #Launch/g' $POLY/launch.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/MacOSDuneDarkGrey.jpg --save && betterlockscreen -u $WALL/MacOSDuneDarkGrey.jpg &

# Change Notifs
sed -i -e 's/background = .*/background = "#161616"/g' $NOTI/dunstrc
sed -i -e 's/foreground = .*/foreground = "#f2f2f2"/g' $NOTI/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 0/g' $NOTI/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#b9b9b9"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change URxvt
sed -i -e 's/#define FG .*/#define FG #b9b9b9/g' $HOME/.Xresources
sed -i -e 's/#define BG .*/#define BG #161616/g' $HOME/.Xresources
sed -i -e 's/#define R .*/#define R #7c7c7c/g' $HOME/.Xresources
sed -i -e 's/#define G .*/#define G #8e8e8e/g' $HOME/.Xresources
sed -i -e 's/#define Y .*/#define Y #a0a0a0/g' $HOME/.Xresources
sed -i -e 's/#define B .*/#define B #686868/g' $HOME/.Xresources
sed -i -e 's/#define M .*/#define M #747474/g' $HOME/.Xresources
sed -i -e 's/#define C .*/#define C #868686/g' $HOME/.Xresources

# Change Dmenu
sed -i -e 's/dmenu.background: .*/dmenu.background: #161616/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #707070/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #161616/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #f2f2f2/g' $HOME/.Xresources

# Change Spicetify
sed -i -e 's/*.color16: .*/*.color16: #f2f2f2/g' $HOME/.Xresources
sed -i -e 's/*.color17: .*/*.color17: #161616/g' $HOME/.Xresources
sed -i -e 's/*.color18: .*/*.color18: #bcbcbc/g' $HOME/.Xresources
sed -i -e 's/*.color19: .*/*.color19: #111111/g' $HOME/.Xresources
sed -i -e 's/*.color20: .*/*.color20: #FFF/g' $HOME/.Xresources

# Update URxvt, Dmenu, and Spicetify
xrdb $HOME/.Xresources
spicetify apply -n

# Change Alacritty
sed -i -e 's/.*#BG/    "#161616" #BG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#FG/    "#b9b9b9" #FG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#BL/    "#525252" #BL/g' $ALAC/alacritty.yml
sed -i -e 's/.*#WH/    "#b9b9b9" #WH/g' $ALAC/alacritty.yml
sed -i -e 's/.*#R /    "#7c7c7c" #R /g' $ALAC/alacritty.yml
sed -i -e 's/.*#G /    "#8e8e8e" #G /g' $ALAC/alacritty.yml
sed -i -e 's/.*#Y /    "#a0a0a0" #Y /g' $ALAC/alacritty.yml
sed -i -e 's/.*#B /    "#686868" #B /g' $ALAC/alacritty.yml
sed -i -e 's/.*#M /    "#747474" #M /g' $ALAC/alacritty.yml
sed -i -e 's/.*#C /    "#868686" #C /g' $ALAC/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=ArchDark/g' $GTK3/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="ArchDark"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Arch/g' $GTK3/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Arch"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "ArchDark"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Arch"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #161616 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #111111 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #292929 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #0c0c0c !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #242424 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: black !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change LightDM 
sed -i -e 's/wallpapers\/.*/wallpapers\/MacOSDuneDarkGrey.jpg)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #ededed;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #161616;/g' $CHRO/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $CHRO/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $CONF/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps top .*/gaps top 61/g' $i3/config
sed -i -e 's/gaps inner .*/gaps inner 19/g' $i3/config
sed -i -e 's/default_border .*/default_border none/g' $i3/config
sed -i -e 's/default_floating_border .*/default_floating_border none/g' $i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #8c8c8c/g' $i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #363636/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/top_padding.*/top_padding 61/g' $BSP/bspwmrc
sed -i -e 's/window_gap .*/window_gap 19/g' $BSP/bspwmrc
sed -i -e 's/border_width .*/border_width 0/g' $BSP/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#8c8c8c"/g' $BSP/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#363636"/g' $BSP/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#8c8c8c"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>ArchDark<\/name>/g' $OBOX/rc.xml
sed -i -e 's/<titleLayout>.*/<titleLayout>MLC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i -e 's/<top>.*/<top>80<\/top>/g' $OBOX/rc.xml
sed -i -e 's/<bottom>.*/<bottom>19<\/bottom>/g' $OBOX/rc.xml
sed -i -e 's/<left>.*/<left>19<\/left>/g' $OBOX/rc.xml
sed -i -e 's/<right>.*/<right>19<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Dune Dark" Scheme'



#  __  __                   _        _         _     _       _     _   
# |  \/  | ___  _   _ _ __ | |_ __ _(_)_ __   | |   (_) __ _| |__ | |_ 
# | |\/| |/ _ \| | | | '_ \| __/ _` | | '_ \  | |   | |/ _` | '_ \| __|
# | |  | | (_) | |_| | | | | || (_| | | | | | | |___| | (_| | | | | |_ 
# |_|  |_|\___/ \__,_|_| |_|\__\__,_|_|_| |_| |_____|_|\__, |_| |_|\__|
#                                                      |___/



elif  [[ $1 = "-mountainlight" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #fefefe/g' $POLY/Arch/config.ini
sed -i -e 's/fg = .*/fg = #111111/g' $POLY/Arch/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #787878/g' $POLY/Arch/config.ini
sed -i -e 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/Arch\/config.ini main \& #Launch/g' $POLY/launch.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/WhiteMountains.jpg --save && betterlockscreen -u $WALL/WhiteMountains.jpg &

# Change Notifs
sed -i -e 's/background = .*/background = "#fefefe"/g' $NOTI/dunstrc
sed -i -e 's/foreground = .*/foreground = "#111111"/g' $NOTI/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 0/g' $NOTI/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#b9b9b9"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change URxvt
sed -i -e 's/#define FG .*/#define FG #464646/g' $HOME/.Xresources
sed -i -e 's/#define BG .*/#define BG #fefefe/g' $HOME/.Xresources
sed -i -e 's/#define R .*/#define R #7c7c7c/g' $HOME/.Xresources
sed -i -e 's/#define G .*/#define G #8e8e8e/g' $HOME/.Xresources
sed -i -e 's/#define Y .*/#define Y #a0a0a0/g' $HOME/.Xresources
sed -i -e 's/#define B .*/#define B #686868/g' $HOME/.Xresources
sed -i -e 's/#define M .*/#define M #747474/g' $HOME/.Xresources
sed -i -e 's/#define C .*/#define C #868686/g' $HOME/.Xresources

# Change Dmenu
sed -i -e 's/dmenu.background: .*/dmenu.background: #fefefe/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #787878/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #fefefe/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #111111/g' $HOME/.Xresources

# Change Spicetify
sed -i -e 's/*.color16: .*/*.color16: #111111/g' $HOME/.Xresources
sed -i -e 's/*.color17: .*/*.color17: #fefefe/g' $HOME/.Xresources
sed -i -e 's/*.color18: .*/*.color18: #787878/g' $HOME/.Xresources
sed -i -e 's/*.color19: .*/*.color19: #f2f2f2/g' $HOME/.Xresources
sed -i -e 's/*.color20: .*/*.color20: #000/g' $HOME/.Xresources

# Update URxvt, Dmenu, and Spicetify
xrdb $HOME/.Xresources
spicetify apply -n

# Change Alacritty
sed -i -e 's/.*#BG/    "#fefefe" #BG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#FG/    "#464646" #FG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#BL/    "#525252" #BL/g' $ALAC/alacritty.yml
sed -i -e 's/.*#WH/    "#b9b9b9" #WH/g' $ALAC/alacritty.yml
sed -i -e 's/.*#R /    "#7c7c7c" #R /g' $ALAC/alacritty.yml
sed -i -e 's/.*#G /    "#8e8e8e" #G /g' $ALAC/alacritty.yml
sed -i -e 's/.*#Y /    "#a0a0a0" #Y /g' $ALAC/alacritty.yml
sed -i -e 's/.*#B /    "#686868" #B /g' $ALAC/alacritty.yml
sed -i -e 's/.*#M /    "#747474" #M /g' $ALAC/alacritty.yml
sed -i -e 's/.*#C /    "#868686" #C /g' $ALAC/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=ArchLight/g' $GTK3/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="ArchLight"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Arch/g' $GTK3/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Arch"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "ArchLight"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Arch"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #FEFEFE !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #F2F2F2 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #E6E6E6 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #D9D9D9 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #E6E6E6 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #F2F2F2 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #666666 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #111111 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #888 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #707070 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #000 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: black !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: black !important;/g' $CORD/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/WhiteMountains.jpg)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #121212;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #fefefe;/g' $CHRO/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #0000007f;/g' $CHRO/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $CONF/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps top .*/gaps top 61/g' $i3/config
sed -i -e 's/gaps inner .*/gaps inner 19/g' $i3/config
sed -i -e 's/default_border .*/default_border none/g' $i3/config
sed -i -e 's/default_floating_border .*/default_floating_border none/g' $i3/config
sed -i -e '11 s/set $bg-color .*/set $bg-color #8c8c8c/g' $i3/config
sed -i -e '12 s/set $inactive-bg-color .*/set $inactive-bg-color #363636/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/top_padding.*/top_padding 61/g' $BSP/bspwmrc
sed -i -e 's/window_gap .*/window_gap 19/g' $BSP/bspwmrc
sed -i -e 's/border_width .*/border_width 0/g' $BSP/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#8c8c8c"/g' $BSP/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#363636"/g' $BSP/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#8c8c8c"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>ArchLight<\/name>/g' $OBOX/rc.xml
sed -i -e 's/<titleLayout>.*/<titleLayout>MLC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i -e 's/<top>.*/<top>80<\/top>/g' $OBOX/rc.xml
sed -i -e 's/<bottom>.*/<bottom>19<\/bottom>/g' $OBOX/rc.xml
sed -i -e 's/<left>.*/<left>19<\/left>/g' $OBOX/rc.xml
sed -i -e 's/<right>.*/<right>19<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Mountain Light" Scheme'


#  _   _            _   ____          _ 
# | \ | | ___   ___| | |  _ \ ___  __| |
# |  \| |/ _ \ / _ \ | | |_) / _ \/ _` |
# | |\  | (_) |  __/ | |  _ <  __/ (_| |
# |_| \_|\___/ \___|_| |_| \_\___|\__,_|



elif  [[ $1 = "-noelred" ]]; then

# Change Polybar
sed -i -e 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/NoelRed\/config.ini left \& polybar -c $HOME\/.config\/polybar\/NoelRed\/config.ini right \& #Launch/g' $POLY/launch.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/NoelLemonadeRed.png --save && betterlockscreen -u $WALL/NoelLemonadeRed.png &

# Change Notifs
sed -i -e 's/background = .*/background = "#403B47"/g' $NOTI/dunstrc
sed -i -e 's/foreground = .*/foreground = "#E8D4CF"/g' $NOTI/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 3/g' $NOTI/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#CD9B96"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change URxvt
sed -i -e 's/#define FG .*/#define FG #E8D4CF/g' $HOME/.Xresources
sed -i -e 's/#define BG .*/#define BG #403B47/g' $HOME/.Xresources
sed -i -e 's/#define R .*/#define R #CE9C97/g' $HOME/.Xresources
sed -i -e 's/#define G .*/#define G #B6A4A0/g' $HOME/.Xresources
sed -i -e 's/#define Y .*/#define Y #D1AD8D/g' $HOME/.Xresources
sed -i -e 's/#define B .*/#define B #B9B9C4/g' $HOME/.Xresources
sed -i -e 's/#define M .*/#define M #B68F95/g' $HOME/.Xresources
sed -i -e 's/#define C .*/#define C #675D72/g' $HOME/.Xresources

# Change Dmenu
sed -i -e 's/dmenu.background: .*/dmenu.background: #403B47/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #E8D4CF/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #CD9B96/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #403B47/g' $HOME/.Xresources

# Change Spicetify
sed -i -e 's/*.color16: .*/*.color16: #e8d4cf/g' $HOME/.Xresources
sed -i -e 's/*.color17: .*/*.color17: #403b47/g' $HOME/.Xresources
sed -i -e 's/*.color18: .*/*.color18: #e8d4cf/g' $HOME/.Xresources
sed -i -e 's/*.color19: .*/*.color19: #433d4a/g' $HOME/.Xresources
sed -i -e 's/*.color20: .*/*.color20: #FFF/g' $HOME/.Xresources

# Update URxvt, Dmenu, and Spicetify
xrdb $HOME/.Xresources
spicetify apply -n

# Change Alacritty
sed -i -e 's/.*#BG/    "#403B47" #BG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#FG/    "#E8D4CF" #FG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#BL/    "#443a36" #BL/g' $ALAC/alacritty.yml
sed -i -e 's/.*#WH/    "#867564" #WH/g' $ALAC/alacritty.yml
sed -i -e 's/.*#R /    "#CD9C97" #R /g' $ALAC/alacritty.yml
sed -i -e 's/.*#G /    "#B6A4A0" #G /g' $ALAC/alacritty.yml
sed -i -e 's/.*#Y /    "#D1AD8D" #Y /g' $ALAC/alacritty.yml
sed -i -e 's/.*#B /    "#B9B9C4" #B /g' $ALAC/alacritty.yml
sed -i -e 's/.*#M /    "#B68F95" #M /g' $ALAC/alacritty.yml
sed -i -e 's/.*#C /    "#675D72" #C /g' $ALAC/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=NoelRed/g' $GTK3/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="NoelRed"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=NoelRed/g' $GTK3/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="NoelRed"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "NoelRed"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "NoelRed"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #403B47 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #403B47 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #403B47 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #403B47 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #403B47 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #403B47 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/NoelLemonadeRed.png)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #121212;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #403B47;/g' $CHRO/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $CHRO/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $CONF/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps top .*/gaps top 82/g' $i3/config
sed -i -e 's/gaps inner .*/gaps inner 19/g' $i3/config
sed -i -e 's/default_border .*/default_border pixel 3/g' $i3/config
sed -i -e 's/default_floating_border .*/default_floating_border pixel 3/g' $i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #CD9B96/g' $i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #4D4650/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/top_padding.*/top_padding 82/g' $BSP/bspwmrc
sed -i -e 's/window_gap .*/window_gap 19/g' $BSP/bspwmrc
sed -i -e 's/border_width .*/border_width 3/g' $BSP/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#CD9B96"/g' $BSP/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#4D4650"/g' $BSP/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#CD9B96"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>NoelRed<\/name>/g' $OBOX/rc.xml
sed -i -e 's/<titleLayout>.*/<titleLayout>LIMC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i -e 's/<top>.*/<top>101<\/top>/g' $OBOX/rc.xml
sed -i -e 's/<bottom>.*/<bottom>19<\/bottom>/g' $OBOX/rc.xml
sed -i -e 's/<left>.*/<left>19<\/left>/g' $OBOX/rc.xml
sed -i -e 's/<right>.*/<right>19<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Noel Red" Scheme'



#  _   _            _   ____  _            
# | \ | | ___   ___| | | __ )| |_   _  ___ 
# |  \| |/ _ \ / _ \ | |  _ \| | | | |/ _ \
# | |\  | (_) |  __/ | | |_) | | |_| |  __/
# |_| \_|\___/ \___|_| |____/|_|\__,_|\___|



elif  [[ $1 = "-noelblue" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #1B1F25/g' $POLY/Cabin/config.ini
sed -i -e 's/fg = .*/fg = #EFE3DD/g' $POLY/Cabin/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #EFE3DD/g' $POLY/Cabin/config.ini
sed -i -e 's/border-bottom-size = .*/border-bottom-size = 3/g' $POLY/Cabin/config.ini
sed -i -e 's/border-color = .*/border-color = #BBCCC5/g' $POLY/Cabin/config.ini
sed -i -e 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/Cabin\/config.ini main \& #Launch/g' $POLY/launch.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/NoelLemonadeBlue.jpg --save && betterlockscreen -u $WALL/NoelLemonadeBlue.jpg &

# Change Notifs
sed -i -e 's/background = .*/background = "#1B1F25"/g' $NOTI/dunstrc
sed -i -e 's/foreground = .*/foreground = "#EFE3DD"/g' $NOTI/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 3/g' $NOTI/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#BBCCC5"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change URxvt
sed -i -e 's/#define FG .*/#define FG #EFE3DD/g' $HOME/.Xresources
sed -i -e 's/#define BG .*/#define BG #1B1F25/g' $HOME/.Xresources
sed -i -e 's/#define R .*/#define R #F1C3B6/g' $HOME/.Xresources
sed -i -e 's/#define G .*/#define G #BBCCC5/g' $HOME/.Xresources
sed -i -e 's/#define Y .*/#define Y #FEE5A6/g' $HOME/.Xresources
sed -i -e 's/#define B .*/#define B #74A298/g' $HOME/.Xresources
sed -i -e 's/#define M .*/#define M #A38E8D/g' $HOME/.Xresources
sed -i -e 's/#define C .*/#define C #C1D1CE/g' $HOME/.Xresources

# Change Dmenu
sed -i -e 's/dmenu.background: .*/dmenu.background: #1B1F25/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #EFE3DD/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #BBCCC5/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #1B1F25/g' $HOME/.Xresources

# Change Spicetify
sed -i -e 's/*.color16: .*/*.color16: #efe3dd/g' $HOME/.Xresources
sed -i -e 's/*.color17: .*/*.color17: #1b1f25/g' $HOME/.Xresources
sed -i -e 's/*.color18: .*/*.color18: #efe3dd/g' $HOME/.Xresources
sed -i -e 's/*.color19: .*/*.color19: #1e2229/g' $HOME/.Xresources
sed -i -e 's/*.color20: .*/*.color20: #FFF/g' $HOME/.Xresources

# Update URxvt, Dmenu, and Spicetify
xrdb $HOME/.Xresources
spicetify apply -n

# Change Alacritty
sed -i -e 's/.*#BG/    "#1B1F25" #BG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#FG/    "#EFE3DD" #FG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#BL/    "#443a36" #BL/g' $ALAC/alacritty.yml
sed -i -e 's/.*#WH/    "#867564" #WH/g' $ALAC/alacritty.yml
sed -i -e 's/.*#R /    "#F1C3B6" #R /g' $ALAC/alacritty.yml
sed -i -e 's/.*#G /    "#BBCCC5" #G /g' $ALAC/alacritty.yml
sed -i -e 's/.*#Y /    "#FEE5A6" #Y /g' $ALAC/alacritty.yml
sed -i -e 's/.*#B /    "#74A298" #B /g' $ALAC/alacritty.yml
sed -i -e 's/.*#M /    "#A38E8D" #M /g' $ALAC/alacritty.yml
sed -i -e 's/.*#C /    "#C1D1CE" #C /g' $ALAC/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=NoelBlue/g' $GTK3/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="NoelBlue"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=NoelBlue/g' $GTK3/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="NoelBlue"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "NoelBlue"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "NoelBlue"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #1B1F25 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #1E2229 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #20242B !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #21262E !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #20242B !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #20242B !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/NoelLemonadeBlue.jpg)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #121212;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #1B1F25;/g' $CHRO/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $CHRO/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $CONF/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps top .*/gaps top 43/g' $i3/config
sed -i -e 's/gaps inner .*/gaps inner 14/g' $i3/config
sed -i -e 's/default_border .*/default_border pixel 3/g' $i3/config
sed -i -e 's/default_floating_border .*/default_floating_border pixel 3/g' $i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #BBCCC5/g' $i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #14181C/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/top_padding.*/top_padding 43/g' $BSP/bspwmrc
sed -i -e 's/window_gap .*/window_gap 12/g' $BSP/bspwmrc
sed -i -e 's/border_width .*/border_width 3/g' $BSP/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#BBCCC5"/g' $BSP/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#14181C"/g' $BSP/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#BBCCC5"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>NoelBlue<\/name>/g' $OBOX/rc.xml
sed -i -e 's/<titleLayout>.*/<titleLayout>LIMC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i -e 's/<top>.*/<top>55<\/top>/g' $OBOX/rc.xml
sed -i -e 's/<bottom>.*/<bottom>12<\/bottom>/g' $OBOX/rc.xml
sed -i -e 's/<left>.*/<left>12<\/left>/g' $OBOX/rc.xml
sed -i -e 's/<right>.*/<right>12<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Noel Blue" Scheme'



#   ____      _     _       
#  / ___|__ _| |__ (_)_ __  
# | |   / _` | '_ \| | '_ \ 
# | |__| (_| | |_) | | | | |
#  \____\__,_|_.__/|_|_| |_|



elif  [[ $1 = "-cabin" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #201e1a/g' $POLY/Cabin/config.ini
sed -i -e 's/fg = .*/fg = #79695a/g' $POLY/Cabin/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #4f453b/g' $POLY/Cabin/config.ini
sed -i -e 's/border-bottom-size = .*/border-bottom-size = 3/g' $POLY/Cabin/config.ini
sed -i -e 's/border-color = .*/border-color = #5D6051/g' $POLY/Cabin/config.ini
sed -i -e 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/Cabin\/config.ini main \& #Launch/g' $POLY/launch.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/ForestCabin1.png --save && betterlockscreen -u $WALL/ForestCabin1.png &

# Change Notifs
sed -i -e 's/background = .*/background = "#201e1a"/g' $NOTI/dunstrc
sed -i -e 's/foreground = .*/foreground = "#79695a"/g' $NOTI/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 3/g' $NOTI/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#5D6051"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change URxvt
sed -i -e 's/#define FG .*/#define FG #79695a/g' $HOME/.Xresources
sed -i -e 's/#define BG .*/#define BG #201e1a/g' $HOME/.Xresources
sed -i -e 's/#define R .*/#define R #674441/g' $HOME/.Xresources
sed -i -e 's/#define G .*/#define G #5d6051/g' $HOME/.Xresources
sed -i -e 's/#define Y .*/#define Y #84694e/g' $HOME/.Xresources
sed -i -e 's/#define B .*/#define B #545e5e/g' $HOME/.Xresources
sed -i -e 's/#define M .*/#define M #614c4c/g' $HOME/.Xresources
sed -i -e 's/#define C .*/#define C #4d5c5c/g' $HOME/.Xresources

# Change Dmenu
sed -i -e 's/dmenu.background: .*/dmenu.background: #201e1a/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #79695a/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #5D6051/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #201e1a/g' $HOME/.Xresources

# Change Spicetify
sed -i -e 's/*.color16: .*/*.color16: #79695a/g' $HOME/.Xresources
sed -i -e 's/*.color17: .*/*.color17: #201e1a/g' $HOME/.Xresources
sed -i -e 's/*.color18: .*/*.color18: #827161/g' $HOME/.Xresources
sed -i -e 's/*.color19: .*/*.color19: #1a1815/g' $HOME/.Xresources
sed -i -e 's/*.color20: .*/*.color20: #FFF/g' $HOME/.Xresources

# Update URxvt, Dmenu, and Spicetify
xrdb $HOME/.Xresources
spicetify apply -n

# Change Alacritty
sed -i -e 's/.*#BG/    "#201e1a" #BG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#FG/    "#79695a" #FG/g' $ALAC/alacritty.yml
sed -i -e 's/.*#BL/    "#443a36" #BL/g' $ALAC/alacritty.yml
sed -i -e 's/.*#WH/    "#867564" #WH/g' $ALAC/alacritty.yml
sed -i -e 's/.*#R /    "#674441" #R /g' $ALAC/alacritty.yml
sed -i -e 's/.*#G /    "#5d6051" #G /g' $ALAC/alacritty.yml
sed -i -e 's/.*#Y /    "#84694e" #Y /g' $ALAC/alacritty.yml
sed -i -e 's/.*#B /    "#545e5e" #B /g' $ALAC/alacritty.yml
sed -i -e 's/.*#M /    "#614c4c" #M /g' $ALAC/alacritty.yml
sed -i -e 's/.*#C /    "#4d5c5c" #C /g' $ALAC/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=Cabin/g' $GTK3/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="Cabin"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Cabin/g' $GTK3/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Cabin"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "Cabin"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Cabin"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #201e1a !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #201e1a !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #201e1a !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #201e1a !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #201e1a !important;/g' $CORD/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #201e1a !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change LightDM 
sed -i -e 's/wallpapers\/.*/wallpapers\/ForestCabin1.png)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #ededed;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #201e1a;/g' $CHRO/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $CHRO/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $CONF/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps top .*/gaps top 43/g' $i3/config
sed -i -e 's/gaps inner .*/gaps inner 14/g' $i3/config
sed -i -e 's/default_border .*/default_border pixel 3/g' $i3/config
sed -i -e 's/default_floating_border .*/default_floating_border pixel 3/g' $i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #5D6051/g' $i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #191A16/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/top_padding.*/top_padding 43/g' $BSP/bspwmrc
sed -i -e 's/window_gap .*/window_gap 12/g' $BSP/bspwmrc
sed -i -e 's/border_width .*/border_width 3/g' $BSP/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#5D6051"/g' $BSP/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#191a16"/g' $BSP/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#5D6051"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>Cabin<\/name>/g' $OBOX/rc.xml
sed -i -e 's/<titleLayout>.*/<titleLayout>LIMC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i -e 's/<top>.*/<top>55<\/top>/g' $OBOX/rc.xml
sed -i -e 's/<bottom>.*/<bottom>12<\/bottom>/g' $OBOX/rc.xml
sed -i -e 's/<left>.*/<left>12<\/left>/g' $OBOX/rc.xml
sed -i -e 's/<right>.*/<right>12<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Cabin" Scheme'



else
echo "Available options:
-archdark		-archlight		-dunedark		-mountainlight
-noelred		-noelblue		-cabin			"
fi
