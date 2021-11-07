#!/bin/bash

CONF="$HOME/.config"
POLY="$CONF/polybar"
WALL="$HOME/Pictures/Wallpaper"
NOTI="$CONF/dunst"
KITTY="$CONF/kitty"
ALAC="$CONF/alacritty"
VIM="$HOME/.vim"
ROFI="$CONF/rofi"
GTK3="$CONF/gtk-3.0"
CORD="$CONF/powercord/src/Powercord/themes/discord"
FIRE="$HOME/.mozilla/firefox/*.default-release/chrome"
WOLF="$HOME/.librewolf/*.default-release/chrome"
PAGE="$HOME/.config/startpage"
ZATH="$CONF/zathura"
i3="$CONF/i3"
BSP="$CONF/bspwm"
OBOX="$CONF/openbox"



#     _             _       ____             _    
#    / \   _ __ ___| |__   |  _ \  __ _ _ __| | __
#   / _ \ | '__/ __| '_ \  | | | |/ _` | '__| |/ /
#  / ___ \| | | (__| | | | | |_| | (_| | |  |   < 
# /_/   \_\_|  \___|_| |_| |____/ \__,_|_|  |_|\_\



# Change Bar
sed -i 's/bg = .*/bg = #161616/g' $POLY/Arch/config.ini
sed -i 's/fg = .*/fg = #f2f2f2/g' $POLY/Arch/config.ini
sed -i 's/fg-alt = .*/fg-alt = #707070/g' $POLY/Arch/config.ini
sed -i 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/Arch\/config.ini main \& #Launch/g' ~/.config/bin/bar.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/GreyLake.jpg --save && betterlockscreen -u $WALL/GreyLake.jpg &

# Change Notifs
sed -i 's/background = .*/background = "#161616"/g' $NOTI/dunstrc
sed -i 's/foreground = .*/foreground = "#f2f2f2"/g' $NOTI/dunstrc
sed -i 's/frame_width = .*/frame_width = 0/g' $NOTI/dunstrc
sed -i 's/frame_color = .*/frame_color = "#b9b9b9"/g' $NOTI/dunstrc
sed -i 's/geometry = .*/geometry = "310x100-35+95"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change Xresources
sed -i 's/#define FG .*/#define FG #b9b9b9/g' $HOME/.Xresources
sed -i 's/#define BG .*/#define BG #161616/g' $HOME/.Xresources
sed -i 's/#define BL .*/#define BL #525252/g' $HOME/.Xresources
sed -i 's/#define WH .*/#define WH #b9b9b9/g' $HOME/.Xresources
sed -i 's/#define R .*/#define R #7c7c7c/g' $HOME/.Xresources
sed -i 's/#define G .*/#define G #8e8e8e/g' $HOME/.Xresources
sed -i 's/#define Y .*/#define Y #a0a0a0/g' $HOME/.Xresources
sed -i 's/#define B .*/#define B #686868/g' $HOME/.Xresources
sed -i 's/#define M .*/#define M #747474/g' $HOME/.Xresources
sed -i 's/#define C .*/#define C #868686/g' $HOME/.Xresources
sed -i 's/dmenu.background: .*/dmenu.background: #161616/g' $HOME/.Xresources
sed -i 's/dmenu.foreground: .*/dmenu.foreground: #707070/g' $HOME/.Xresources
sed -i 's/dmenu.selbackground: .*/dmenu.selbackground: #161616/g' $HOME/.Xresources
sed -i 's/dmenu.selforeground: .*/dmenu.selforeground: #f2f2f2/g' $HOME/.Xresources

# Change Alacritty
sed -i 's/.*#BG/    "#161616" #BG/g' $ALAC/alacritty.yml
sed -i 's/.*#FG/    "#b9b9b9" #FG/g' $ALAC/alacritty.yml
sed -i 's/.*#BL/    "#525252" #BL/g' $ALAC/alacritty.yml
sed -i 's/.*#WH/    "#b9b9b9" #WH/g' $ALAC/alacritty.yml
sed -i 's/.*#R /    "#7c7c7c" #R /g' $ALAC/alacritty.yml
sed -i 's/.*#G /    "#8e8e8e" #G /g' $ALAC/alacritty.yml
sed -i 's/.*#Y /    "#a0a0a0" #Y /g' $ALAC/alacritty.yml
sed -i 's/.*#B /    "#686868" #B /g' $ALAC/alacritty.yml
sed -i 's/.*#M /    "#747474" #M /g' $ALAC/alacritty.yml
sed -i 's/.*#C /    "#868686" #C /g' $ALAC/alacritty.yml

# Change Kitty
sed -i -e 's/color0 .*/color0 #525252/g' -e 's/color8 .*/color8 #525252/g' $KITTY/kitty.conf
sed -i -e 's/color1 .*/color1 #7c7c7c/g' -e 's/color9 .*/color9 #7c7c7c/g' $KITTY/kitty.conf
sed -i -e 's/color2 .*/color2 #8e8e8e/g' -e 's/color10 .*/color10 #8e8e8e/g' $KITTY/kitty.conf
sed -i -e 's/color3 .*/color3 #a0a0a0/g' -e 's/color11 .*/color11 #a0a0a0/g' $KITTY/kitty.conf
sed -i -e 's/color4 .*/color4 #686868/g' -e 's/color12 .*/color12 #686868/g' $KITTY/kitty.conf
sed -i -e 's/color5 .*/color5 #747474/g' -e 's/color13 .*/color13 #747474/g' $KITTY/kitty.conf
sed -i -e 's/color6 .*/color6 #868686/g' -e 's/color14 .*/color14 #868686/g' $KITTY/kitty.conf
sed -i -e 's/color7 .*/color7 #b9b9b9/g' -e 's/color15 .*/color15 #b9b9b9/g' $KITTY/kitty.conf
sed -i 's/foreground .*/foreground #b9b9b9/g' $KITTY/kitty.conf
sed -i 's/background .*/background #161616/g' $KITTY/kitty.conf
sed -i 's/selection_foreground .*/selection_foreground #161616/g' $KITTY/kitty.conf
sed -i 's/selection_background .*/selection_background #b9b9b9/g' $KITTY/kitty.conf
sed -i 's/cursor .*/cursor #b9b9b9/g' $KITTY/kitty.conf

# Change Vim
sed -i 's/ bg = .*/ bg = "#161616"/g' $VIM/colors/theme.vim
sed -i 's/ fg = .*/ fg = "#b9b9b9"/g' $VIM/colors/theme.vim
sed -i 's/ bl = .*/ bl = "#525252"/g' $VIM/colors/theme.vim
sed -i 's/ wh = .*/ wh = "#b9b9b9"/g' $VIM/colors/theme.vim
sed -i 's/ r  = .*/ r  = "#7c7c7c"/g' $VIM/colors/theme.vim
sed -i 's/ g  = .*/ g  = "#8e8e8e"/g' $VIM/colors/theme.vim
sed -i 's/ y  = .*/ y  = "#a0a0a0"/g' $VIM/colors/theme.vim
sed -i 's/ b  = .*/ b  = "#686868"/g' $VIM/colors/theme.vim
sed -i 's/ m  = .*/ m  = "#747474"/g' $VIM/colors/theme.vim
sed -i 's/ c  = .*/ c  = "#868686"/g' $VIM/colors/theme.vim

# Update Xresources, Terminals, and Vim
xrdb $HOME/.Xresources
$CONF/bin/livereload.sh
vim --remote-send "<C-c>:color theme<CR>" vim

# Change Rofi
sed -i 's/--bg: .*/--bg: #161616;/g' $ROFI/theme.rasi
sed -i 's/--fg: .*/--fg: #707070;/g' $ROFI/theme.rasi
sed -i 's/--selbg: .*/--selbg: #161616;/g' $ROFI/theme.rasi
sed -i 's/--selfg: .*/--selfg: #f2f2f2;/g' $ROFI/theme.rasi

# Change GTK
sed -i 's/gtk-theme-name=.*/gtk-theme-name=ArchDark/g' $GTK3/settings.ini
sed -i 's/gtk-theme-name=.*/gtk-theme-name="ArchDark"/g' $HOME/.gtkrc-2.0
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Arch/g' $GTK3/settings.ini
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Arch"/g' $HOME/.gtkrc-2.0
sed -i 's/Net\/ThemeName .*/Net\/ThemeName "ArchDark"/g' $HOME/.xsettingsd
sed -i 's/Net\/IconThemeName .*/Net\/IconThemeName "Arch"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i 's/--background-primary: .*/--background-primary: #161616 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary: .*/--background-secondary: #161616 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary-alt: .*/--background-secondary-alt: #161616 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-tertiary: .*/--background-tertiary: #161616 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-accent: .*/--background-accent: #161616 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-floating: .*/--background-floating: #161616 !important;/g' $CORD/discord.theme.css
sed -i 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change Firefox
sed -i 's/--bg: .*/--bg: #161616;/g' $FIRE/userChrome.css
sed -i 's/--fg: .*/--fg: #b9b9b9;/g' $FIRE/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #5e5e5e;/g' $FIRE/userChrome.css

# Change Librewolf
sed -i 's/--bg: .*/--bg: #161616;/g' $WOLF/userChrome.css
sed -i 's/--fg: .*/--fg: #b9b9b9;/g' $WOLF/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #5e5e5e;/g' $WOLF/userChrome.css

# Change Startpage
sed -i 's/--bg: .*/--bg: #161616;/g' $PAGE/css/style.css
sed -i 's/--bg2: .*/--bg2: #1A1A1A;/g' $PAGE/css/style.css
sed -i 's/--bg3: .*/--bg3: #1F1F1F;/g' $PAGE/css/style.css
sed -i 's/--fg: .*/--fg: #b9b9b9;/g' $PAGE/css/style.css

# Change 4chan
sed -i 's/--bg: .*/--bg: #161616;/g' $FIRE/userContent.css
sed -i 's/--bg2: .*/--bg2: #1A1A1A;/g' $FIRE/userContent.css
sed -i 's/--bg3: .*/--bg3: #1F1F1F;/g' $FIRE/userContent.css
sed -i 's/--fg: .*/--fg: #b9b9b9;/g' $FIRE/userContent.css
sed -i 's/--bg: .*/--bg: #161616;/g' $WOLF/userContent.css
sed -i 's/--bg2: .*/--bg2: #1A1A1A;/g' $WOLF/userContent.css
sed -i 's/--bg3: .*/--bg3: #1F1F1F;/g' $WOLF/userContent.css
sed -i 's/--fg: .*/--fg: #b9b9b9;/g' $WOLF/userContent.css

# Change Picom
sed -i 's/shadow = .*/shadow = true;/g' $CONF/picom.conf
sed -i 's/shadow-radius = .*/shadow-radius = 15;/g' $CONF/picom.conf
sed -i 's/shadow-offset-x = .*/shadow-offset-x = -15;/g' $CONF/picom.conf
sed -i 's/shadow-offset-y = .*/shadow-offset-y = -15;/g' $CONF/picom.conf
sed -i 's/shadow-opacity = .*/shadow-opacity = 1;/g' $CONF/picom.conf

# Change Zathura
sed -i 's/recolor-lightcolor.*/recolor-lightcolor		"#161616"/g' $ZATH/zathurarc
sed -i 's/recolor-darkcolor.*/recolor-darkcolor		"#b9b9b9"/g' $ZATH/zathurarc
sed -i 's/statusbar-bg.*/statusbar-bg		"#161616"/g' $ZATH/zathurarc
sed -i 's/statusbar-fg.*/statusbar-fg		"#b9b9b9"/g' $ZATH/zathurarc
sed -i 's/default-bg.*/default-bg			"#161616"/g' $ZATH/zathurarc
sed -i 's/default-fg.*/default-fg			"#b9b9b9"/g' $ZATH/zathurarc
sed -i 's/inputbar-bg.*/inputbar-bg			"#161616"/g' $ZATH/zathurarc
sed -i 's/inputbar-fg.*/inputbar-fg			"#b9b9b9"/g' $ZATH/zathurarc
sed -i 's/completion-bg.*/completion-bg		"#161616"/g' $ZATH/zathurarc
sed -i 's/completion-fg.*/completion-fg		"#b9b9b9"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-bg.*/completion-highlight-bg	"#b9b9b9"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-fg.*/completion-highlight-fg	"#161616"/g' $ZATH/zathurarc
sed -i 's/completion-group-bg.*/completion-group-bg		"#161616"/g' $ZATH/zathurarc
sed -i 's/completion-group-fg.*/completion-group-fg		"#b9b9b9"/g' $ZATH/zathurarc

# Change i3lock
sed -i 's/text=".*/text="b9b9b9"/g' $CONF/bin/lock.sh
sed -i 's/back=".*/back="161616"/g' $CONF/bin/lock.sh
sed -i 's/black=".*/black="525252"/g' $CONF/bin/lock.sh
sed -i 's/green=".*/green="8e8e8e"/g' $CONF/bin/lock.sh
sed -i 's/red=".*/red="7c7c7c"/g' $CONF/bin/lock.sh
sed -i 's/blue=".*/blue="686868"/g' $CONF/bin/lock.sh

#
# i3
#

# Change Gaps + Borders
sed -i 's/gaps top .*/gaps top 61/g' $i3/config
sed -i 's/gaps inner .*/gaps inner 19/g' $i3/config
sed -i 's/default_border .*/default_border none/g' $i3/config
sed -i 's/default_floating_border .*/default_floating_border none/g' $i3/config
sed -i 's/set $bg-color .*/set $bg-color #8c8c8c/g' $i3/config
sed -i 's/set $inactive-bg-color .*/set $inactive-bg-color #363636/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i 's/top_padding.*/top_padding 61/g' $BSP/bspwmrc
sed -i 's/window_gap .*/window_gap 19/g' $BSP/bspwmrc
sed -i 's/border_width .*/border_width 0/g' $BSP/bspwmrc
sed -i 's/focused_border_color .*/focused_border_color "#8c8c8c"/g' $BSP/bspwmrc
sed -i 's/normal_border_color .*/normal_border_color "#363636"/g' $BSP/bspwmrc
sed -i 's/presel_feedback_color .*/presel_feedback_color "#8c8c8c"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i 's/<theme><name>.*/<theme><name>ArchDark<\/name>/g' $OBOX/rc.xml
sed -i 's/<titleLayout>.*/<titleLayout>MLC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i 's/<top>.*/<top>80<\/top>/g' $OBOX/rc.xml
sed -i 's/<bottom>.*/<bottom>19<\/bottom>/g' $OBOX/rc.xml
sed -i 's/<left>.*/<left>19<\/left>/g' $OBOX/rc.xml
sed -i 's/<right>.*/<right>19<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Arch Dark" Scheme'
