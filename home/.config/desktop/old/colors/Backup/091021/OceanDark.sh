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



#   ___
#  / _ \  ___ ___  __ _ _ __
# | | | |/ __/ _ \/ _` | '_ \
# | |_| | (_|  __/ (_| | | | |
#  \___/ \___\___|\__,_|_| |_|



# Change Bar
sed -i 's/.*#Launch/tint2 -c $HOME\/.config\/tint2\/oceandark #Launch/g' ~/.config/bin/bar.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/DarkBeach.jpg --save

# Change Notifs
sed -i 's/background = .*/background = "#19191e"/g' $NOTI/dunstrc
sed -i 's/foreground = .*/foreground = "#9999a8"/g' $NOTI/dunstrc
sed -i 's/frame_width = .*/frame_width = 3/g' $NOTI/dunstrc
sed -i 's/frame_color = .*/frame_color = "#2b2b33"/g' $NOTI/dunstrc
sed -i 's/geometry = .*/geometry = "310x100+45+45"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst
 
# Change Xresources
sed -i 's/#define FG .*/#define FG #9999a8/g' $HOME/.Xresources
sed -i 's/#define BG .*/#define BG #19191e/g' $HOME/.Xresources
sed -i 's/#define BL .*/#define BL #2b2b33/g' $HOME/.Xresources
sed -i 's/#define WH .*/#define WH #9999a8/g' $HOME/.Xresources
sed -i 's/#define R .*/#define R #806060/g' $HOME/.Xresources
sed -i 's/#define G .*/#define G #608060/g' $HOME/.Xresources
sed -i 's/#define Y .*/#define Y #808060/g' $HOME/.Xresources
sed -i 's/#define B .*/#define B #606080/g' $HOME/.Xresources
sed -i 's/#define M .*/#define M #706080/g' $HOME/.Xresources
sed -i 's/#define C .*/#define C #607080/g' $HOME/.Xresources
sed -i 's/dmenu.background: .*/dmenu.background: #19191e/g' $HOME/.Xresources
sed -i 's/dmenu.foreground: .*/dmenu.foreground: #9999a8/g' $HOME/.Xresources
sed -i 's/dmenu.selbackground: .*/dmenu.selbackground: #9999a8/g' $HOME/.Xresources
sed -i 's/dmenu.selforeground: .*/dmenu.selforeground: #19191e/g' $HOME/.Xresources

# Change Alacritty
sed -i 's/.*#BG/    "#19191e" #BG/g' $ALAC/alacritty.yml
sed -i 's/.*#FG/    "#9999a8" #FG/g' $ALAC/alacritty.yml
sed -i 's/.*#BL/    "#2b2b33" #BL/g' $ALAC/alacritty.yml
sed -i 's/.*#WH/    "#9999a8" #WH/g' $ALAC/alacritty.yml
sed -i 's/.*#R /    "#806060" #R /g' $ALAC/alacritty.yml
sed -i 's/.*#G /    "#608060" #G /g' $ALAC/alacritty.yml
sed -i 's/.*#Y /    "#808060" #Y /g' $ALAC/alacritty.yml
sed -i 's/.*#B /    "#606080" #B /g' $ALAC/alacritty.yml
sed -i 's/.*#M /    "#706080" #M /g' $ALAC/alacritty.yml
sed -i 's/.*#C /    "#607080" #C /g' $ALAC/alacritty.yml

# Change Kitty
sed -i -e 's/color0 .*/color0 #2b2b33/g' -e 's/color8 .*/color8 #2b2b33/g' $KITTY/kitty.conf
sed -i -e 's/color1 .*/color1 #806060/g' -e 's/color9 .*/color9 #806060/g' $KITTY/kitty.conf
sed -i -e 's/color2 .*/color2 #608060/g' -e 's/color10 .*/color10 #608060/g' $KITTY/kitty.conf
sed -i -e 's/color3 .*/color3 #808060/g' -e 's/color11 .*/color11 #808060/g' $KITTY/kitty.conf
sed -i -e 's/color4 .*/color4 #606080/g' -e 's/color12 .*/color12 #606080/g' $KITTY/kitty.conf
sed -i -e 's/color5 .*/color5 #706080/g' -e 's/color13 .*/color13 #706080/g' $KITTY/kitty.conf
sed -i -e 's/color6 .*/color6 #607080/g' -e 's/color14 .*/color14 #607080/g' $KITTY/kitty.conf
sed -i -e 's/color7 .*/color7 #9999a8/g' -e 's/color15 .*/color15 #9999a8/g' $KITTY/kitty.conf
sed -i 's/foreground .*/foreground #9999a8/g' $KITTY/kitty.conf
sed -i 's/background .*/background #19191e/g' $KITTY/kitty.conf
sed -i 's/selection_foreground .*/selection_foreground #19191e/g' $KITTY/kitty.conf
sed -i 's/selection_background .*/selection_background #9999a8/g' $KITTY/kitty.conf
sed -i 's/cursor .*/cursor #9999a8/g' $KITTY/kitty.conf

# Change Vim
sed -i 's/ bg = .*/ bg = "#19191e"/g' $VIM/colors/theme.vim
sed -i 's/ fg = .*/ fg = "#9999a8"/g' $VIM/colors/theme.vim
sed -i 's/ bl = .*/ bl = "#2b2b33"/g' $VIM/colors/theme.vim
sed -i 's/ wh = .*/ wh = "#9999a8"/g' $VIM/colors/theme.vim
sed -i 's/ r  = .*/ r  = "#806060"/g' $VIM/colors/theme.vim
sed -i 's/ g  = .*/ g  = "#608060"/g' $VIM/colors/theme.vim
sed -i 's/ y  = .*/ y  = "#808060"/g' $VIM/colors/theme.vim
sed -i 's/ b  = .*/ b  = "#606080"/g' $VIM/colors/theme.vim
sed -i 's/ m  = .*/ m  = "#706080"/g' $VIM/colors/theme.vim
sed -i 's/ c  = .*/ c  = "#607080"/g' $VIM/colors/theme.vim

# Update Xresources, Terminals, and Vim
xrdb $HOME/.Xresources
$CONF/bin/livereload.sh
vim --remote-send "<C-c>:color theme<CR>" vim

# Change Rofi
sed -i 's/--bg: .*/--bg: #19191e;/g' $ROFI/theme.rasi
sed -i 's/--fg: .*/--fg: #9999a8;/g' $ROFI/theme.rasi
sed -i 's/--selbg: .*/--selbg: #2b2b33;/g' $ROFI/theme.rasi
sed -i 's/--selfg: .*/--selfg: #9999a8;/g' $ROFI/theme.rasi

# Change GTK
sed -i 's/gtk-theme-name=.*/gtk-theme-name=OceanDark/g' $GTK3/settings.ini
sed -i 's/gtk-theme-name=.*/gtk-theme-name="OceanDark"/g' $HOME/.gtkrc-2.0
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=OceanDark/g' $GTK3/settings.ini
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="OceanDark"/g' $HOME/.gtkrc-2.0
sed -i 's/Net\/ThemeName .*/Net\/ThemeName "OceanDark"/g' $HOME/.xsettingsd
sed -i 's/Net\/IconThemeName .*/Net\/IconThemeName "OceanDark"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i 's/--background-primary: .*/--background-primary: #19191e !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary: .*/--background-secondary: #19191e !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary-alt: .*/--background-secondary-alt: #19191e !important;/g' $CORD/discord.theme.css
sed -i 's/--background-tertiary: .*/--background-tertiary: #19191e !important;/g' $CORD/discord.theme.css
sed -i 's/--background-accent: .*/--background-accent: #19191e !important;/g' $CORD/discord.theme.css
sed -i 's/--background-floating: .*/--background-floating: #19191e !important;/g' $CORD/discord.theme.css
sed -i 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change Firefox
sed -i 's/--bg: .*/--bg: #19191e;/g' $FIRE/userChrome.css
sed -i 's/--fg: .*/--fg: #9999a8;/g' $FIRE/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #4d4d54;/g' $FIRE/userChrome.css

# Change Librewolf
sed -i 's/--bg: .*/--bg: #19191e;/g' $WOLF/userChrome.css
sed -i 's/--fg: .*/--fg: #9999a8;/g' $WOLF/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #4d4d54;/g' $WOLF/userChrome.css

# Change Startpage
sed -i 's/--bg: .*/--bg: #19191e;/g' $PAGE/css/style.css
sed -i 's/--bg2: .*/--bg2: #1c1c21;/g' $PAGE/css/style.css
sed -i 's/--bg3: .*/--bg3: #1e1e24;/g' $PAGE/css/style.css
sed -i 's/--fg: .*/--fg: #9999a8;/g' $PAGE/css/style.css

# Change 4chan
sed -i 's/--bg: .*/--bg: #19191e;/g' $FIRE/userContent.css
sed -i 's/--bg2: .*/--bg2: #1c1c21;/g' $FIRE/userContent.css
sed -i 's/--bg3: .*/--bg3: #1e1e24;/g' $FIRE/userContent.css
sed -i 's/--fg: .*/--fg: #9999a8;/g' $FIRE/userContent.css
sed -i 's/--bg: .*/--bg: #19191e;/g' $WOLF/userContent.css
sed -i 's/--bg2: .*/--bg2: #1c1c21;/g' $WOLF/userContent.css
sed -i 's/--bg3: .*/--bg3: #1e1e24;/g' $WOLF/userContent.css
sed -i 's/--fg: .*/--fg: #9999a8;/g' $WOLF/userContent.css

# Change Picom
sed -i 's/shadow = .*/shadow = true;/g' $CONF/picom.conf
sed -i 's/shadow-radius = .*/shadow-radius = 25;/g' $CONF/picom.conf
sed -i 's/shadow-offset-x = .*/shadow-offset-x = -25;/g' $CONF/picom.conf
sed -i 's/shadow-offset-y = .*/shadow-offset-y = -25;/g' $CONF/picom.conf
sed -i 's/shadow-opacity = .*/shadow-opacity = .5;/g' $CONF/picom.conf

# Change Zathura
sed -i 's/recolor-lightcolor.*/recolor-lightcolor		"#19191e"/g' $ZATH/zathurarc
sed -i 's/recolor-darkcolor.*/recolor-darkcolor		"#9999a8"/g' $ZATH/zathurarc
sed -i 's/statusbar-bg.*/statusbar-bg		"#19191e"/g' $ZATH/zathurarc
sed -i 's/statusbar-fg.*/statusbar-fg		"#9999a8"/g' $ZATH/zathurarc
sed -i 's/default-bg.*/default-bg			"#19191e"/g' $ZATH/zathurarc
sed -i 's/default-fg.*/default-fg			"#9999a8"/g' $ZATH/zathurarc
sed -i 's/inputbar-bg.*/inputbar-bg			"#19191e"/g' $ZATH/zathurarc
sed -i 's/inputbar-fg.*/inputbar-fg			"#9999a8"/g' $ZATH/zathurarc
sed -i 's/completion-bg.*/completion-bg		"#19191e"/g' $ZATH/zathurarc
sed -i 's/completion-fg.*/completion-fg		"#9999a8"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-bg.*/completion-highlight-bg	"#9999a8"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-fg.*/completion-highlight-fg	"#19191e"/g' $ZATH/zathurarc
sed -i 's/completion-group-bg.*/completion-group-bg		"#19191e"/g' $ZATH/zathurarc
sed -i 's/completion-group-fg.*/completion-group-fg		"#9999a8"/g' $ZATH/zathurarc

# Change i3lock
sed -i 's/text=".*/text="9999a8"/g' $CONF/bin/lock.sh
sed -i 's/back=".*/back="19191e"/g' $CONF/bin/lock.sh
sed -i 's/black=".*/black="3a3a40"/g' $CONF/bin/lock.sh
sed -i 's/green=".*/green="608060"/g' $CONF/bin/lock.sh
sed -i 's/red=".*/red="806060"/g' $CONF/bin/lock.sh
sed -i 's/blue=".*/blue="606080"/g' $CONF/bin/lock.sh

#
# i3
#

# Change Gaps + Borders
sed -i 's/gaps top .*/gaps top 0/g' $i3/config
sed -i 's/gaps inner .*/gaps inner 30/g' $i3/config
sed -i 's/default_border .*/default_border pixel 3/g' $i3/config
sed -i 's/default_floating_border .*/default_floating_border pixel 3/g' $i3/config
sed -i 's/set $bg-color .*/set $bg-color #9999a8/g' $i3/config
sed -i 's/set $inactive-bg-color .*/set $inactive-bg-color #2b2b33/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i 's/top_padding.*/top_padding 0/g' $BSP/bspwmrc
sed -i 's/window_gap .*/window_gap 30/g' $BSP/bspwmrc
sed -i 's/border_width .*/border_width 3/g' $BSP/bspwmrc
sed -i 's/focused_border_color .*/focused_border_color "#9999a8"/g' $BSP/bspwmrc
sed -i 's/normal_border_color .*/normal_border_color "#2b2b33"/g' $BSP/bspwmrc
sed -i 's/presel_feedback_color .*/presel_feedback_color "#9999a8"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i 's/<theme><name>.*/<theme><name>OceanDark<\/name>/g' $OBOX/rc.xml
sed -i 's/<titleLayout>.*/<titleLayout>CIML<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i 's/<top>.*/<top>20<\/top>/g' $OBOX/rc.xml
sed -i 's/<bottom>.*/<bottom>20<\/bottom>/g' $OBOX/rc.xml
sed -i 's/<left>.*/<left>20<\/left>/g' $OBOX/rc.xml
sed -i 's/<right>.*/<right>105<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Ocean Dark" Scheme'

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
