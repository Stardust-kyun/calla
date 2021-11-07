#!/bin/bash

PDIR="$HOME/.config/polybar"
DDIR="$HOME/.config/powercord/src/Powercord/themes/discord"
LAUNCH="polybar-msg cmd restart"

#     _             _       ____             _    
#    / \   _ __ ___| |__   |  _ \  __ _ _ __| | __
#   / _ \ | '__/ __| '_ \  | | | |/ _` | '__| |/ /
#  / ___ \| | | (__| | | | | |_| | (_| | |  |   < 
# /_/   \_\_|  \___|_| |_| |____/ \__,_|_|  |_|\_\



if  [[ $1 = "-archdark" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #161616/g' $PDIR/config.ini
sed -i -e 's/fg = .*/fg = #f2f2f2/g' $PDIR/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #bcbcbc/g' $PDIR/config.ini
sed -i -e 's/border-bottom-size = .*/border-bottom-size = 0/g' $PDIR/config.ini
sed -i -e 's/border-color = .*/border-color = #8c8c8c/g' $PDIR/config.ini

# Change Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpaper/WelcomeHomeLight.png --save && betterlockscreen -u $HOME/Pictures/Wallpaper/WelcomeHomeLight.png &

# Change Notifs
sed -i -e 's/background = .*/background = "#1a1a1a"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/foreground = .*/foreground = "#ffffff"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 0/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#b9b9b9"/g' $HOME/.config/dunst/dunstrc

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
sed -i -e 's/dmenu.background: .*/dmenu.background: #1a1a1a/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #bcbcbc/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #1a1a1a/g' $HOME/.Xresources
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
sed -i -e 's/.*#BG/    "#161616" #BG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#FG/    "#b9b9b9" #FG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#BL/    "#525252" #BL/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#WH/    "#b9b9b9" #WH/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#R /    "#7c7c7c" #R /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#G /    "#8e8e8e" #G /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#Y /    "#a0a0a0" #Y /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#B /    "#686868" #B /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#M /    "#747474" #M /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#C /    "#868686" #C /g' $HOME/.config/alacritty/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=MacOSDark/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="MacOSDark"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Dark-MacOSDark/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Dark-MacOSDark"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "MacOSDark"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Dark-MacOSDark"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #161616 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #111111 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #292929 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #0c0c0c !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #242424 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: black !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $DDIR/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/WelcomeHomeLight.png)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #ededed;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #161616;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = true;/g' $HOME/.config/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps inner .*/gaps inner 14/g' $HOME/.config/i3/config
sed -i -e 's/default_border .*/default_border none/g' $HOME/.config/i3/config
sed -i -e 's/default_floating_border .*/default_floating_border none/g' $HOME/.config/i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #8c8c8c/g' $HOME/.config/i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #363636/g' $HOME/.config/i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/window_gap .*/window_gap 12/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/border_width .*/border_width 0/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#8c8c8c"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#363636"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#8c8c8c"/g' $HOME/.config/bspwm/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>MacOSDark<\/name>/g' ~/.config/openbox/rc.xml

# Reconfigure openbox
openbox --reconfigure
~/.config/openbox/autostart

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
sed -i -e 's/bg = .*/bg = #fefefe/g' $PDIR/config.ini
sed -i -e 's/fg = .*/fg = #111111/g' $PDIR/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #444444/g' $PDIR/config.ini
sed -i -e 's/border-bottom-size = .*/border-bottom-size = 0/g' $PDIR/config.ini
sed -i -e 's/border-color = .*/border-color = #8c8c8c/g' $PDIR/config.ini

# Change Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpaper/WelcomeHomeWhite.png --save && betterlockscreen -u $HOME/Pictures/Wallpaper/WelcomeHomeWhite.png &

# Change Notifs
sed -i -e 's/background = .*/background = "#f1f1f1"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/foreground = .*/foreground = "#111111"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 0/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#b9b9b9"/g' $HOME/.config/dunst/dunstrc

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
sed -i -e 's/dmenu.background: .*/dmenu.background: #f1f1f1/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #444444/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #f1f1f1/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #111111/g' $HOME/.Xresources

# Change Spicetify
sed -i -e 's/*.color16: .*/*.color16: #111111/g' $HOME/.Xresources
sed -i -e 's/*.color17: .*/*.color17: #fefefe/g' $HOME/.Xresources
sed -i -e 's/*.color18: .*/*.color18: #444444/g' $HOME/.Xresources
sed -i -e 's/*.color19: .*/*.color19: #f2f2f2/g' $HOME/.Xresources
sed -i -e 's/*.color20: .*/*.color20: #000/g' $HOME/.Xresources

# Update URxvt, Dmenu, and Spicetify
xrdb $HOME/.Xresources
spicetify apply -n

# Change Alacritty
sed -i -e 's/.*#BG/    "#fefefe" #BG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#FG/    "#464646" #FG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#BL/    "#525252" #BL/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#WH/    "#b9b9b9" #WH/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#R /    "#7c7c7c" #R /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#G /    "#8e8e8e" #G /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#Y /    "#a0a0a0" #Y /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#B /    "#686868" #B /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#M /    "#747474" #M /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#C /    "#868686" #C /g' $HOME/.config/alacritty/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=MacOSLight/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="MacOSLight"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Dark-MacOSDark/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Dark-MacOSDark"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "MacOSLight"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Dark-MacOSDark"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #FEFEFE !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #F2F2F2 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #E6E6E6 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #D9D9D9 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #E6E6E6 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #F2F2F2 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #666666 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #111111 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #888 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #707070 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #000 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: black !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: black !important;/g' $DDIR/discord.theme.css

# Kill Nautilus
killall nautilus

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/WelcomeHomeWhite.png)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #121212;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #fefefe;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #0000007f;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = true;/g' $HOME/.config/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps inner .*/gaps inner 14/g' $HOME/.config/i3/config
sed -i -e 's/default_border .*/default_border none/g' $HOME/.config/i3/config
sed -i -e 's/default_floating_border .*/default_floating_border none/g' $HOME/.config/i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #8c8c8c/g' $HOME/.config/i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #363636/g' $HOME/.config/i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/window_gap .*/window_gap 12/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/border_width .*/border_width 0/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#8c8c8c"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#363636"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#8c8c8c"/g' $HOME/.config/bspwm/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>MacOSLight<\/name>/g' ~/.config/openbox/rc.xml

# Reconfigure openbox
openbox --reconfigure
~/.config/openbox/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Arch Light" Scheme'



#  ____                     ____             _    
# |  _ \ _   _ _ __   ___  |  _ \  __ _ _ __| | __
# | | | | | | | '_ \ / _ \ | | | |/ _` | '__| |/ /
# | |_| | |_| | | | |  __/ | |_| | (_| | |  |   < 
# |____/ \__,_|_| |_|\___| |____/ \__,_|_|  |_|\_\



elif  [[ $1 = "-dunedark" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #161616/g' $PDIR/config.ini
sed -i -e 's/fg = .*/fg = #f2f2f2/g' $PDIR/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #bcbcbc/g' $PDIR/config.ini
sed -i -e 's/border-bottom-size = .*/border-bottom-size = 0/g' $PDIR/config.ini
sed -i -e 's/border-color = .*/border-color = #8c8c8c/g' $PDIR/config.ini

# Change Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpaper/MacOSDuneDarkGrey.jpg --save && betterlockscreen -u $HOME/Pictures/Wallpaper/MacOSDuneDarkGrey.jpg &

# Change Notifs
sed -i -e 's/background = .*/background = "#1a1a1a"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/foreground = .*/foreground = "#ffffff"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 0/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#b9b9b9"/g' $HOME/.config/dunst/dunstrc

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
sed -i -e 's/dmenu.background: .*/dmenu.background: #1a1a1a/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #bcbcbc/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #1a1a1a/g' $HOME/.Xresources
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
sed -i -e 's/.*#BG/    "#161616" #BG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#FG/    "#b9b9b9" #FG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#BL/    "#525252" #BL/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#WH/    "#b9b9b9" #WH/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#R /    "#7c7c7c" #R /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#G /    "#8e8e8e" #G /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#Y /    "#a0a0a0" #Y /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#B /    "#686868" #B /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#M /    "#747474" #M /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#C /    "#868686" #C /g' $HOME/.config/alacritty/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=MacOSDark/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="MacOSDark"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Dark-MacOSDark/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Dark-MacOSDark"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "MacOSDark"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Dark-MacOSDark"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #161616 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #111111 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #292929 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #0c0c0c !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #242424 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: black !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $DDIR/discord.theme.css

# Kill Nautilus
killall nautilus

# Change LightDM 
sed -i -e 's/wallpapers\/.*/wallpapers\/MacOSDuneDarkGrey.jpg)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #ededed;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #161616;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $HOME/.config/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps inner .*/gaps inner 14/g' $HOME/.config/i3/config
sed -i -e 's/default_border .*/default_border none/g' $HOME/.config/i3/config
sed -i -e 's/default_floating_border .*/default_floating_border none/g' $HOME/.config/i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #8c8c8c/g' $HOME/.config/i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #363636/g' $HOME/.config/i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/window_gap .*/window_gap 12/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/border_width .*/border_width 0/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#8c8c8c"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#363636"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#8c8c8c"/g' $HOME/.config/bspwm/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>MacOSDark<\/name>/g' ~/.config/openbox/rc.xml

# Reconfigure openbox
openbox --reconfigure
~/.config/openbox/autostart

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
sed -i -e 's/bg = .*/bg = #fefefe/g' $PDIR/config.ini
sed -i -e 's/fg = .*/fg = #111111/g' $PDIR/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #444444/g' $PDIR/config.ini
sed -i -e 's/border-bottom-size = .*/border-bottom-size = 0/g' $PDIR/config.ini
sed -i -e 's/border-color = .*/border-color = #8c8c8c/g' $PDIR/config.ini

# Change Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpaper/WhiteMountains.jpg --save && betterlockscreen -u $HOME/Pictures/Wallpaper/WhiteMountains.jpg &

# Change Notifs
sed -i -e 's/background = .*/background = "#f1f1f1"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/foreground = .*/foreground = "#111111"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 0/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#b9b9b9"/g' $HOME/.config/dunst/dunstrc

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
sed -i -e 's/dmenu.background: .*/dmenu.background: #f1f1f1/g' $HOME/.Xresources
sed -i -e 's/dmenu.foreground: .*/dmenu.foreground: #444444/g' $HOME/.Xresources
sed -i -e 's/dmenu.selbackground: .*/dmenu.selbackground: #f1f1f1/g' $HOME/.Xresources
sed -i -e 's/dmenu.selforeground: .*/dmenu.selforeground: #111111/g' $HOME/.Xresources

# Change Spicetify
sed -i -e 's/*.color16: .*/*.color16: #111111/g' $HOME/.Xresources
sed -i -e 's/*.color17: .*/*.color17: #fefefe/g' $HOME/.Xresources
sed -i -e 's/*.color18: .*/*.color18: #444444/g' $HOME/.Xresources
sed -i -e 's/*.color19: .*/*.color19: #f2f2f2/g' $HOME/.Xresources
sed -i -e 's/*.color20: .*/*.color20: #000/g' $HOME/.Xresources

# Update URxvt, Dmenu, and Spicetify
xrdb $HOME/.Xresources
spicetify apply -n

# Change Alacritty
sed -i -e 's/.*#BG/    "#fefefe" #BG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#FG/    "#464646" #FG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#BL/    "#525252" #BL/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#WH/    "#b9b9b9" #WH/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#R /    "#7c7c7c" #R /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#G /    "#8e8e8e" #G /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#Y /    "#a0a0a0" #Y /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#B /    "#686868" #B /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#M /    "#747474" #M /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#C /    "#868686" #C /g' $HOME/.config/alacritty/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=MacOSLight/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="MacOSLight"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Dark-MacOSDark/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Dark-MacOSDark"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "MacOSLight"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Dark-MacOSDark"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #FEFEFE !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #F2F2F2 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #E6E6E6 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #D9D9D9 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #E6E6E6 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #F2F2F2 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #666666 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #111111 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #888 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #707070 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #000 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: black !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: black !important;/g' $DDIR/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/WhiteMountains.jpg)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #121212;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #fefefe;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #0000007f;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $HOME/.config/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps inner .*/gaps inner 14/g' $HOME/.config/i3/config
sed -i -e 's/default_border .*/default_border none/g' $HOME/.config/i3/config
sed -i -e 's/default_floating_border .*/default_floating_border none/g' $HOME/.config/i3/config
sed -i -e '11 s/set $bg-color .*/set $bg-color #8c8c8c/g' $HOME/.config/i3/config
sed -i -e '12 s/set $inactive-bg-color .*/set $inactive-bg-color #363636/g' $HOME/.config/i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/window_gap .*/window_gap 12/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/border_width .*/border_width 0/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#8c8c8c"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#363636"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#8c8c8c"/g' $HOME/.config/bspwm/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>MacOSLight<\/name>/g' ~/.config/openbox/rc.xml

# Reconfigure openbox
openbox --reconfigure
~/.config/openbox/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Mountain Light" Scheme'


#  _   _            _   ____          _ 
# | \ | | ___   ___| | |  _ \ ___  __| |
# |  \| |/ _ \ / _ \ | | |_) / _ \/ _` |
# | |\  | (_) |  __/ | |  _ <  __/ (_| |
# |_| \_|\___/ \___|_| |_| \_\___|\__,_|



elif  [[ $1 = "-noelred" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #403B47/g' $PDIR/config.ini
sed -i -e 's/fg = .*/fg = #E8D4CF/g' $PDIR/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #E8D4CF/g' $PDIR/config.ini
sed -i -e 's/border-bottom-size = .*/border-bottom-size = 3/g' $PDIR/config.ini
sed -i -e 's/border-color = .*/border-color = #CD9B96/g' $PDIR/config.ini

# Change Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpaper/NoelLemonadeRed.png --save && betterlockscreen -u $HOME/Pictures/Wallpaper/NoelLemonadeRed.png &

# Change Notifs
sed -i -e 's/background = .*/background = "#403B47"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/foreground = .*/foreground = "#E8D4CF"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 3/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#CD9B96"/g' $HOME/.config/dunst/dunstrc

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
sed -i -e 's/.*#BG/    "#403B47" #BG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#FG/    "#E8D4CF" #FG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#BL/    "#443a36" #BL/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#WH/    "#867564" #WH/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#R /    "#CD9C97" #R /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#G /    "#B6A4A0" #G /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#Y /    "#D1AD8D" #Y /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#B /    "#B9B9C4" #B /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#M /    "#B68F95" #M /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#C /    "#675D72" #C /g' $HOME/.config/alacritty/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=NoelRed/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="NoelRed"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=NoelRed/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="NoelRed"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "NoelRed"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "NoelRed"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #403B47 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #433D4A !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #4A4452 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #4A4452 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #453F4D !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #453F4D !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $DDIR/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/NoelLemonadeRed.png)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #121212;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #403B47;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $HOME/.config/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps inner .*/gaps inner 14/g' $HOME/.config/i3/config
sed -i -e 's/default_border .*/default_border pixel 3/g' $HOME/.config/i3/config
sed -i -e 's/default_floating_border .*/default_floating_border pixel 3/g' $HOME/.config/i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #CD9B96/g' $HOME/.config/i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #4D4650/g' $HOME/.config/i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/window_gap .*/window_gap 12/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/border_width .*/border_width 3/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#CD9B96"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#4D4650"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#CD9B96"/g' $HOME/.config/bspwm/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>NoelRed<\/name>/g' ~/.config/openbox/rc.xml

# Reconfigure openbox
openbox --reconfigure
~/.config/openbox/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Noel Red" Scheme'



#  _   _            _   ____  _            
# | \ | | ___   ___| | | __ )| |_   _  ___ 
# |  \| |/ _ \ / _ \ | |  _ \| | | | |/ _ \
# | |\  | (_) |  __/ | | |_) | | |_| |  __/
# |_| \_|\___/ \___|_| |____/|_|\__,_|\___|



elif  [[ $1 = "-noelblue" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #1B1F25/g' $PDIR/config.ini
sed -i -e 's/fg = .*/fg = #EFE3DD/g' $PDIR/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #EFE3DD/g' $PDIR/config.ini
sed -i -e 's/border-bottom-size = .*/border-bottom-size = 3/g' $PDIR/config.ini
sed -i -e 's/border-color = .*/border-color = #BBCCC5/g' $PDIR/config.ini

# Change Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpaper/NoelLemonadeBlue.jpg --save && betterlockscreen -u $HOME/Pictures/Wallpaper/NoelLemonadeBlue.jpg &

# Change Notifs
sed -i -e 's/background = .*/background = "#1B1F25"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/foreground = .*/foreground = "#EFE3DD"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 3/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#BBCCC5"/g' $HOME/.config/dunst/dunstrc

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
sed -i -e 's/.*#BG/    "#1B1F25" #BG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#FG/    "#EFE3DD" #FG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#BL/    "#443a36" #BL/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#WH/    "#867564" #WH/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#R /    "#F1C3B6" #R /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#G /    "#BBCCC5" #G /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#Y /    "#FEE5A6" #Y /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#B /    "#74A298" #B /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#M /    "#A38E8D" #M /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#C /    "#C1D1CE" #C /g' $HOME/.config/alacritty/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=NoelBlue/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="NoelBlue"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=NoelBlue/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="NoelBlue"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "NoelBlue"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "NoelBlue"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #1B1F25 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #1E2229 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #20242B !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #21262E !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #20242B !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #20242B !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $DDIR/discord.theme.css

# Change LightDM
sed -i -e 's/wallpapers\/.*/wallpapers\/NoelLemonadeBlue.jpg)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #121212;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #1B1F25;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $HOME/.config/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps inner .*/gaps inner 14/g' $HOME/.config/i3/config
sed -i -e 's/default_border .*/default_border pixel 3/g' $HOME/.config/i3/config
sed -i -e 's/default_floating_border .*/default_floating_border pixel 3/g' $HOME/.config/i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #BBCCC5/g' $HOME/.config/i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #14181C/g' $HOME/.config/i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/window_gap .*/window_gap 12/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/border_width .*/border_width 3/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#BBCCC5"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#14181C"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#BBCCC5"/g' $HOME/.config/bspwm/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>NoelBlue<\/name>/g' ~/.config/openbox/rc.xml

# Reconfigure openbox
openbox --reconfigure
~/.config/openbox/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Noel Blue" Scheme'



#   ____      _     _       
#  / ___|__ _| |__ (_)_ __  
# | |   / _` | '_ \| | '_ \ 
# | |__| (_| | |_) | | | | |
#  \____\__,_|_.__/|_|_| |_|



elif  [[ $1 = "-cabin" ]]; then

# Change Polybar
sed -i -e 's/bg = .*/bg = #201e1a/g' $PDIR/config.ini
sed -i -e 's/fg = .*/fg = #79695a/g' $PDIR/config.ini
sed -i -e 's/fg-alt = .*/fg-alt = #4f453b/g' $PDIR/config.ini
sed -i -e 's/border-bottom-size = .*/border-bottom-size = 3/g' $PDIR/config.ini
sed -i -e 's/border-color = .*/border-color = #5D6051/g' $PDIR/config.ini

# Change Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpaper/ForestCabin1.png --save && betterlockscreen -u $HOME/Pictures/Wallpaper/ForestCabin1.png &

# Change Notifs
sed -i -e 's/background = .*/background = "#201e1a"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/foreground = .*/foreground = "#79695a"/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_width = .*/frame_width = 3/g' $HOME/.config/dunst/dunstrc
sed -i -e 's/frame_color = .*/frame_color = "#5D6051"/g' $HOME/.config/dunst/dunstrc

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
sed -i -e 's/.*#BG/    "#201e1a" #BG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#FG/    "#79695a" #FG/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#BL/    "#443a36" #BL/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#WH/    "#867564" #WH/g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#R /    "#674441" #R /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#G /    "#5d6051" #G /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#Y /    "#84694e" #Y /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#B /    "#545e5e" #B /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#M /    "#614c4c" #M /g' $HOME/.config/alacritty/alacritty.yml
sed -i -e 's/.*#C /    "#4d5c5c" #C /g' $HOME/.config/alacritty/alacritty.yml

# Change GTK
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name=Cabin/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-theme-name=.*/gtk-theme-name="Cabin"/g' $HOME/.gtkrc-2.0
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Cabin/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Cabin"/g' $HOME/.gtkrc-2.0
sed -i -e 's/Net\/ThemeName .*/Net\/ThemeName "Cabin"/g' $HOME/.xsettingsd
sed -i -e 's/Net\/IconThemeName .*/Net\/IconThemeName "Cabin"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i -e 's/--background-primary: .*/--background-primary: #201e1a !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary: .*/--background-secondary: #1A1815 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-secondary-alt: .*/--background-secondary-alt: #171614 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-tertiary: .*/--background-tertiary: #121210 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-accent: .*/--background-accent: #1A1815 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--background-floating: .*/--background-floating: #1A1815 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-primary: .*/--header-primary: white !important;/g' $DDIR/discord.theme.css
sed -i -e 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $DDIR/discord.theme.css

# Change LightDM 
sed -i -e 's/wallpapers\/.*/wallpapers\/ForestCabin1.png)";/g' /usr/share/lightdm-webkit/themes/arch/main.js
sed -i -e 's/ color: .*/ color: #ededed;/g' /usr/share/lightdm-webkit/themes/arch/index.css

# Change Firefox
sed -i -e 's/--srf-color-primary: .*/--srf-color-primary: #201e1a;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css
sed -i -e 's/--srf-color-transparent: .*/--srf-color-transparent: #ffffff7f;/g' $HOME/.mozilla/firefox/*.default-release/chrome/userChrome.css

# Change Picom
sed -i -e '59 s/shadow = .*/shadow = false;/g' $HOME/.config/picom.conf

#
# i3
#

# Change Gaps + Borders
sed -i -e 's/gaps inner .*/gaps inner 14/g' $HOME/.config/i3/config
sed -i -e 's/default_border .*/default_border pixel 3/g' $HOME/.config/i3/config
sed -i -e 's/default_floating_border .*/default_floating_border pixel 3/g' $HOME/.config/i3/config
sed -i -e 's/set $bg-color .*/set $bg-color #5D6051/g' $HOME/.config/i3/config
sed -i -e 's/set $inactive-bg-color .*/set $inactive-bg-color #191A16/g' $HOME/.config/i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i -e 's/window_gap .*/window_gap 12/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/border_width .*/border_width 3/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/focused_border_color .*/focused_border_color "#5D6051"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/normal_border_color .*/normal_border_color "#191a16"/g' $HOME/.config/bspwm/bspwmrc
sed -i -e 's/presel_feedback_color .*/presel_feedback_color "#5D6051"/g' $HOME/.config/bspwm/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i -e 's/<theme><name>.*/<theme><name>Cabin<\/name>/g' ~/.config/openbox/rc.xml

# Reconfigure openbox
openbox --reconfigure
~/.config/openbox/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Cabin" Scheme'



else
echo "Available options:
-archdark		-archlight		-dunedark		-mountainlight
-noelred		-noelblue		-cabin			"
fi
