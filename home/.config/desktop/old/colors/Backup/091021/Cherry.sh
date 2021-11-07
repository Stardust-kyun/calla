#!/bin/bash

CONF="$HOME/.config"
POLY="$CONF/polybar"
WALL="$HOME/Pictures/Wallpaper"
NOTI="$CONF/dunst"
KITTY="$CONF/kitty"
ALAC="$CONF/alacritty"
VIM="$HOME/.vim"
GTK3="$CONF/gtk-3.0"
CORD="$CONF/powercord/src/Powercord/themes/discord"
FIRE="$HOME/.mozilla/firefox/*.default-release/chrome"
WOLF="$HOME/.librewolf/*.default-release/chrome"
ZATH="$CONF/zathura"
i3="$CONF/i3"
BSP="$CONF/bspwm"
OBOX="$CONF/openbox"



#   ____ _
#  / ___| |__   ___ _ __ _ __ _   _
# | |   | '_ \ / _ \ '__| '__| | | |
# | |___| | | |  __/ |  | |  | |_| |
#  \____|_| |_|\___|_|  |_|   \__, |
#                             |___/



# Change Bar
sed -i 's/.*#Launch/tint2 -c $HOME\/.config\/tint2\/cherry #Launch/g' ~/.config/bin/bar.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/CherryBlossoms.png --save && betterlockscreen -u $WALL/CherryBlossoms.png &

# Change Notifs
sed -i 's/background = .*/background = "#f5f5f5"/g' $NOTI/dunstrc
sed -i 's/foreground = .*/foreground = "#303030"/g' $NOTI/dunstrc
sed -i 's/frame_width = .*/frame_width = 3/g' $NOTI/dunstrc
sed -i 's/frame_color = .*/frame_color = "#D29BB4"/g' $NOTI/dunstrc
sed -i 's/geometry = .*/geometry = "310x100-45+45"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst
 
# Change URxvt
sed -i 's/#define FG .*/#define FG #303030/g' $HOME/.Xresources
sed -i 's/#define BG .*/#define BG #f5f5f5/g' $HOME/.Xresources
sed -i 's/#define BL .*/#define BL #151515/g' $HOME/.Xresources
sed -i 's/#define WH .*/#define WH #d0d0d0/g' $HOME/.Xresources
sed -i 's/#define R .*/#define R #ac4142/g' $HOME/.Xresources
sed -i 's/#define G .*/#define G #90a959/g' $HOME/.Xresources
sed -i 's/#define Y .*/#define Y #f4bf75/g' $HOME/.Xresources
sed -i 's/#define B .*/#define B #6a9fb5/g' $HOME/.Xresources
sed -i 's/#define M .*/#define M #aa759f/g' $HOME/.Xresources
sed -i 's/#define C .*/#define C #75b5aa/g' $HOME/.Xresources

# Change Kitty
sed -i -e 's/color0 .*/color0 #151515/g' -e 's/color8 .*/color8 #151515/g' $KITTY/kitty.conf
sed -i -e 's/color1 .*/color1 #ac4142/g' -e 's/color9 .*/color9 #ac4142/g' $KITTY/kitty.conf
sed -i -e 's/color2 .*/color2 #90a959/g' -e 's/color10 .*/color10 #90a959/g' $KITTY/kitty.conf
sed -i -e 's/color3 .*/color3 #f4bf75/g' -e 's/color11 .*/color11 #f4bf75/g' $KITTY/kitty.conf
sed -i -e 's/color4 .*/color4 #6a9fb5/g' -e 's/color12 .*/color12 #6a9fb5/g' $KITTY/kitty.conf
sed -i -e 's/color5 .*/color5 #aa759f/g' -e 's/color13 .*/color13 #aa759f/g' $KITTY/kitty.conf
sed -i -e 's/color6 .*/color6 #75b5aa/g' -e 's/color14 .*/color14 #75b5aa/g' $KITTY/kitty.conf
sed -i -e 's/color7 .*/color7 #d0d0d0/g' -e 's/color15 .*/color15 #d0d0d0/g' $KITTY/kitty.conf
sed -i 's/foreground .*/foreground #303030/g' $KITTY/kitty.conf
sed -i 's/background .*/background #f5f5f5/g' $KITTY/kitty.conf
sed -i 's/selection_foreground .*/selection_foreground #f5f5f5/g' $KITTY/kitty.conf
sed -i 's/selection_background .*/selection_background #303030/g' $KITTY/kitty.conf
sed -i 's/cursor .*/cursor #303030/g' $KITTY/kitty.conf

# Change Alacritty
sed -i 's/.*#BG/    "#f5f5f5" #BG/g' $ALAC/alacritty.yml
sed -i 's/.*#FG/    "#303030" #FG/g' $ALAC/alacritty.yml
sed -i 's/.*#BL/    "#151515" #BL/g' $ALAC/alacritty.yml
sed -i 's/.*#WH/    "#d0d0d0" #WH/g' $ALAC/alacritty.yml
sed -i 's/.*#R /    "#ac4142" #R /g' $ALAC/alacritty.yml
sed -i 's/.*#G /    "#90a959" #G /g' $ALAC/alacritty.yml
sed -i 's/.*#Y /    "#f4bf75" #Y /g' $ALAC/alacritty.yml
sed -i 's/.*#B /    "#6a9fb5" #B /g' $ALAC/alacritty.yml
sed -i 's/.*#M /    "#aa759f" #M /g' $ALAC/alacritty.yml
sed -i 's/.*#C /    "#75b5aa" #C /g' $ALAC/alacritty.yml

# Change Dmenu
sed -i 's/dmenu.background: .*/dmenu.background: #f5f5f5/g' $HOME/.Xresources
sed -i 's/dmenu.foreground: .*/dmenu.foreground: #303030/g' $HOME/.Xresources
sed -i 's/dmenu.selbackground: .*/dmenu.selbackground: #D29BB4/g' $HOME/.Xresources
sed -i 's/dmenu.selforeground: .*/dmenu.selforeground: #f5f5f5/g' $HOME/.Xresources

# Change Vim
sed -i 's/ bg = .*/ bg = "#f5f5f5"/g' $VIM/colors/theme.vim
sed -i 's/ fg = .*/ fg = "#303030"/g' $VIM/colors/theme.vim
sed -i 's/ bl = .*/ bl = "#151515"/g' $VIM/colors/theme.vim
sed -i 's/ wh = .*/ wh = "#d0d0d0"/g' $VIM/colors/theme.vim
sed -i 's/ r  = .*/ r  = "#ac4142"/g' $VIM/colors/theme.vim
sed -i 's/ g  = .*/ g  = "#90a959"/g' $VIM/colors/theme.vim
sed -i 's/ y  = .*/ y  = "#f4bf75"/g' $VIM/colors/theme.vim
sed -i 's/ b  = .*/ b  = "#6a9fb5"/g' $VIM/colors/theme.vim
sed -i 's/ m  = .*/ m  = "#aa759f"/g' $VIM/colors/theme.vim
sed -i 's/ c  = .*/ c  = "#75b5aa"/g' $VIM/colors/theme.vim

# Update Terminals, Dmenu, and Vim
xrdb $HOME/.Xresources
$CONF/bin/livereload.sh
vim --remote-send "<C-c>:color theme<CR>" vim

# Change GTK
sed -i 's/gtk-theme-name=.*/gtk-theme-name=Cherry/g' $GTK3/settings.ini
sed -i 's/gtk-theme-name=.*/gtk-theme-name="Cherry"/g' $HOME/.gtkrc-2.0
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Cherry/g' $GTK3/settings.ini
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Cherry"/g' $HOME/.gtkrc-2.0
sed -i 's/Net\/ThemeName .*/Net\/ThemeName "Cherry"/g' $HOME/.xsettingsd
sed -i 's/Net\/IconThemeName .*/Net\/IconThemeName "Cherry"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i 's/--background-primary: .*/--background-primary: #f5f5f5 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary: .*/--background-secondary: #f5f5f5 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary-alt: .*/--background-secondary-alt: #f5f5f5 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-tertiary: .*/--background-tertiary: #f5f5f5 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-accent: .*/--background-accent: #f5f5f5 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-floating: .*/--background-floating: #f5f5f5 !important;/g' $CORD/discord.theme.css
sed -i 's/--text-muted: .*/--text-muted: #666666 !important;/g' $CORD/discord.theme.css
sed -i 's/--text-normal: .*/--text-normal: #111111 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-normal: .*/--interactive-normal: #888 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-hover: .*/--interactive-hover: #707070 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-active: .*/--interactive-active: #000 !important;/g' $CORD/discord.theme.css
sed -i 's/--header-primary: .*/--header-primary: black !important;/g' $CORD/discord.theme.css
sed -i 's/--header-secondary: .*/--header-secondary: black !important;/g' $CORD/discord.theme.css

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
sed -i 's/shadow-radius = .*/shadow-radius = 25;/g' $CONF/picom.conf
sed -i 's/shadow-offset-x = .*/shadow-offset-x = -25;/g' $CONF/picom.conf
sed -i 's/shadow-offset-y = .*/shadow-offset-y = -25;/g' $CONF/picom.conf
sed -i 's/shadow-opacity = .*/shadow-opacity = .1;/g' $CONF/picom.conf

# Change Zathura
sed -i 's/recolor-lightcolor.*/recolor-lightcolor		"#f5f5f5"/g' $ZATH/zathurarc
sed -i 's/recolor-darkcolor.*/recolor-darkcolor		"#303030"/g' $ZATH/zathurarc
sed -i 's/statusbar-bg.*/statusbar-bg		"#f5f5f5"/g' $ZATH/zathurarc
sed -i 's/statusbar-fg.*/statusbar-fg		"#303030"/g' $ZATH/zathurarc
sed -i 's/default-bg.*/default-bg			"#f5f5f5"/g' $ZATH/zathurarc
sed -i 's/default-fg.*/default-fg			"#303030"/g' $ZATH/zathurarc
sed -i 's/inputbar-bg.*/inputbar-bg			"#f5f5f5"/g' $ZATH/zathurarc
sed -i 's/inputbar-fg.*/inputbar-fg			"#303030"/g' $ZATH/zathurarc
sed -i 's/completion-bg.*/completion-bg		"#f5f5f5"/g' $ZATH/zathurarc
sed -i 's/completion-fg.*/completion-fg		"#303030"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-bg.*/completion-highlight-bg	"#303030"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-fg.*/completion-highlight-fg	"#f5f5f5"/g' $ZATH/zathurarc
sed -i 's/completion-group-bg.*/completion-group-bg		"#f5f5f5"/g' $ZATH/zathurarc
sed -i 's/completion-group-fg.*/completion-group-fg		"#303030"/g' $ZATH/zathurarc

# Change i3lock
sed -i 's/text=".*/text="f5f5f5"/g' $CONF/bin/lock.sh
sed -i 's/back=".*/back="303030"/g' $CONF/bin/lock.sh
sed -i 's/black=".*/black="151515"/g' $CONF/bin/lock.sh
sed -i 's/green=".*/green="90a959"/g' $CONF/bin/lock.sh
sed -i 's/red=".*/red="ac4142"/g' $CONF/bin/lock.sh
sed -i 's/blue=".*/blue="6a9fb5"/g' $CONF/bin/lock.sh

#
# i3
#

# Change Gaps + Borders
sed -i 's/gaps top .*/gaps top 0/g' $i3/config
sed -i 's/gaps inner .*/gaps inner 30/g' $i3/config
sed -i 's/default_border .*/default_border pixel 3/g' $i3/config
sed -i 's/default_floating_border .*/default_floating_border pixel 3/g' $i3/config
sed -i 's/set $bg-color .*/set $bg-color #D29BB4/g' $i3/config
sed -i 's/set $inactive-bg-color .*/set $inactive-bg-color #d0d0d0/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i 's/top_padding.*/top_padding 0/g' $BSP/bspwmrc
sed -i 's/window_gap .*/window_gap 30/g' $BSP/bspwmrc
sed -i 's/border_width .*/border_width 3/g' $BSP/bspwmrc
sed -i 's/focused_border_color .*/focused_border_color "#D29BB4"/g' $BSP/bspwmrc
sed -i 's/normal_border_color .*/normal_border_color "#d0d0d0"/g' $BSP/bspwmrc
sed -i 's/presel_feedback_color .*/presel_feedback_color "#D29BB4"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i 's/<theme><name>.*/<theme><name>Cherry<\/name>/g' $OBOX/rc.xml
sed -i 's/<titleLayout>.*/<titleLayout>ILM<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i 's/<top>.*/<top>30<\/top>/g' $OBOX/rc.xml
sed -i 's/<bottom>.*/<bottom>80<\/bottom>/g' $OBOX/rc.xml
sed -i 's/<left>.*/<left>30<\/left>/g' $OBOX/rc.xml
sed -i 's/<right>.*/<right>30<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Cherry" Scheme'
