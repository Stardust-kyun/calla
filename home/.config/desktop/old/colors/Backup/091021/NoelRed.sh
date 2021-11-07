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



#  _   _            _   ____          _ 
# | \ | | ___   ___| | |  _ \ ___  __| |
# |  \| |/ _ \ / _ \ | | |_) / _ \/ _` |
# | |\  | (_) |  __/ | |  _ <  __/ (_| |
# |_| \_|\___/ \___|_| |_| \_\___|\__,_|



# Change Bar
sed -i 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/NoelRed\/config.ini left \& polybar -c $HOME\/.config\/polybar\/NoelRed\/config.ini right \& #Launch/g' ~/.config/bin/bar.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/NoelRed.png --save && betterlockscreen -u $WALL/NoelRed.png &

# Change Notifs
sed -i 's/background = .*/background = "#403B47"/g' $NOTI/dunstrc
sed -i 's/foreground = .*/foreground = "#E8D4CF"/g' $NOTI/dunstrc
sed -i 's/frame_width = .*/frame_width = 3/g' $NOTI/dunstrc
sed -i 's/frame_color = .*/frame_color = "#CD9B97"/g' $NOTI/dunstrc
sed -i 's/geometry = .*/geometry = "310x100-35+120"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change Xresources
sed -i 's/#define FG .*/#define FG #E8D4CF/g' $HOME/.Xresources
sed -i 's/#define BG .*/#define BG #403B47/g' $HOME/.Xresources
sed -i 's/#define BL .*/#define BL #5C5566/g' $HOME/.Xresources
sed -i 's/#define WH .*/#define WH #E8D4CF/g' $HOME/.Xresources
sed -i 's/#define R .*/#define R #CE9C97/g' $HOME/.Xresources
sed -i 's/#define G .*/#define G #B6A4A0/g' $HOME/.Xresources
sed -i 's/#define Y .*/#define Y #D1AD8D/g' $HOME/.Xresources
sed -i 's/#define B .*/#define B #B9B9C4/g' $HOME/.Xresources
sed -i 's/#define M .*/#define M #B68F95/g' $HOME/.Xresources
sed -i 's/#define C .*/#define C #675D72/g' $HOME/.Xresources
sed -i 's/dmenu.background: .*/dmenu.background: #403B47/g' $HOME/.Xresources
sed -i 's/dmenu.foreground: .*/dmenu.foreground: #E8D4CF/g' $HOME/.Xresources
sed -i 's/dmenu.selbackground: .*/dmenu.selbackground: #CD9B97/g' $HOME/.Xresources
sed -i 's/dmenu.selforeground: .*/dmenu.selforeground: #403B47/g' $HOME/.Xresources

# Change Alacritty
sed -i 's/.*#BG/    "#403B47" #BG/g' $ALAC/alacritty.yml
sed -i 's/.*#FG/    "#E8D4CF" #FG/g' $ALAC/alacritty.yml
sed -i 's/.*#BL/    "#5C5566" #BL/g' $ALAC/alacritty.yml
sed -i 's/.*#WH/    "#E8D4CF" #WH/g' $ALAC/alacritty.yml
sed -i 's/.*#R /    "#CD9C97" #R /g' $ALAC/alacritty.yml
sed -i 's/.*#G /    "#B6A4A0" #G /g' $ALAC/alacritty.yml
sed -i 's/.*#Y /    "#D1AD8D" #Y /g' $ALAC/alacritty.yml
sed -i 's/.*#B /    "#B9B9C4" #B /g' $ALAC/alacritty.yml
sed -i 's/.*#M /    "#B68F95" #M /g' $ALAC/alacritty.yml
sed -i 's/.*#C /    "#675D72" #C /g' $ALAC/alacritty.yml

# Change Kitty
sed -i -e 's/color0 .*/color0 #5C5566/g' -e 's/color8 .*/color8 #5C5566/g' $KITTY/kitty.conf
sed -i -e 's/color1 .*/color1 #CD9C97/g' -e 's/color9 .*/color9 #CD9C97/g' $KITTY/kitty.conf
sed -i -e 's/color2 .*/color2 #B6A4A0/g' -e 's/color10 .*/color10 #B6A4A0/g' $KITTY/kitty.conf
sed -i -e 's/color3 .*/color3 #D1AD8D/g' -e 's/color11 .*/color11 #D1AD8D/g' $KITTY/kitty.conf
sed -i -e 's/color4 .*/color4 #B9B9C4/g' -e 's/color12 .*/color12 #B9B9C4/g' $KITTY/kitty.conf
sed -i -e 's/color5 .*/color5 #B68F95/g' -e 's/color13 .*/color13 #B69F95/g' $KITTY/kitty.conf
sed -i -e 's/color6 .*/color6 #675D72/g' -e 's/color14 .*/color14 #675D72/g' $KITTY/kitty.conf
sed -i -e 's/color7 .*/color7 #E8D4CF/g' -e 's/color15 .*/color15 #E8D4CF/g' $KITTY/kitty.conf
sed -i 's/foreground .*/foreground #E8D4CF/g' $KITTY/kitty.conf
sed -i 's/background .*/background #403B47/g' $KITTY/kitty.conf
sed -i 's/selection_foreground .*/selection_foreground #403B47/g' $KITTY/kitty.conf
sed -i 's/selection_background .*/selection_background #E8D4CF/g' $KITTY/kitty.conf
sed -i 's/cursor .*/cursor #E8D4CF/g' $KITTY/kitty.conf

# Change Vim
sed -i 's/ bg = .*/ bg = "#403B47"/g' $VIM/colors/theme.vim
sed -i 's/ fg = .*/ fg = "#E8D4CF"/g' $VIM/colors/theme.vim
sed -i 's/ bl = .*/ bl = "#5C5566"/g' $VIM/colors/theme.vim
sed -i 's/ wh = .*/ wh = "#E8D4CF"/g' $VIM/colors/theme.vim
sed -i 's/ r  = .*/ r  = "#CD9C97"/g' $VIM/colors/theme.vim
sed -i 's/ g  = .*/ g  = "#B6A4A0"/g' $VIM/colors/theme.vim
sed -i 's/ y  = .*/ y  = "#D1AD8D"/g' $VIM/colors/theme.vim
sed -i 's/ b  = .*/ b  = "#B9B9C4"/g' $VIM/colors/theme.vim
sed -i 's/ m  = .*/ m  = "#B68F95"/g' $VIM/colors/theme.vim
sed -i 's/ c  = .*/ c  = "#675D72"/g' $VIM/colors/theme.vim

# Update Xresources, Terminals, and Vim
xrdb $HOME/.Xresources
$CONF/bin/livereload.sh
vim --remote-send "<C-c>:color theme<CR>" vim

# Change Rofi
sed -i 's/--bg: .*/--bg: #403B47;/g' $ROFI/theme.rasi
sed -i 's/--fg: .*/--fg: #E8D4CF;/g' $ROFI/theme.rasi
sed -i 's/--selbg: .*/--selbg: #CD9B97;/g' $ROFI/theme.rasi
sed -i 's/--selfg: .*/--selfg: #403B47;/g' $ROFI/theme.rasi

# Change GTK
sed -i 's/gtk-theme-name=.*/gtk-theme-name=NoelRed/g' $GTK3/settings.ini
sed -i 's/gtk-theme-name=.*/gtk-theme-name="NoelRed"/g' $HOME/.gtkrc-2.0
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=NoelRed/g' $GTK3/settings.ini
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="NoelRed"/g' $HOME/.gtkrc-2.0
sed -i 's/Net\/ThemeName .*/Net\/ThemeName "NoelRed"/g' $HOME/.xsettingsd
sed -i 's/Net\/IconThemeName .*/Net\/IconThemeName "NoelRed"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i 's/--background-primary: .*/--background-primary: #403B47 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary: .*/--background-secondary: #403B47 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary-alt: .*/--background-secondary-alt: #403B47 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-tertiary: .*/--background-tertiary: #403B47 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-accent: .*/--background-accent: #403B47 !important;/g' $CORD/discord.theme.css
sed -i 's/--background-floating: .*/--background-floating: #403B47 !important;/g' $CORD/discord.theme.css
sed -i 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change Firefox
sed -i 's/--bg: .*/--bg: #403B47;/g' $FIRE/userChrome.css
sed -i 's/--fg: .*/--fg: #E8D4CF;/g' $FIRE/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #736966;/g' $FIRE/userChrome.css

# Change Librewolf
sed -i 's/--bg: .*/--bg: #403B47;/g' $WOLF/userChrome.css
sed -i 's/--fg: .*/--fg: #E8D4CF;/g' $WOLF/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #736966;/g' $WOLF/userChrome.css

# Change Startpage
sed -i 's/--bg: .*/--bg: #403B47;/g' $PAGE/css/style.css
sed -i 's/--bg2: .*/--bg2: #433D4A;/g' $PAGE/css/style.css
sed -i 's/--bg3: .*/--bg3: #47424F;/g' $PAGE/css/style.css
sed -i 's/--fg: .*/--fg: #E8D4CF;/g' $PAGE/css/style.css

# Change 4chan
sed -i 's/--bg: .*/--bg: #403B47;/g' $FIRE/userContent.css
sed -i 's/--bg2: .*/--bg2: #433D4A;/g' $FIRE/userContent.css
sed -i 's/--bg3: .*/--bg3: #47424F;/g' $FIRE/userContent.css
sed -i 's/--fg: .*/--fg: #E8D4CF;/g' $FIRE/userContent.css
sed -i 's/--bg: .*/--bg: #403B47;/g' $WOLF/userContent.css
sed -i 's/--bg2: .*/--bg2: #433D4A;/g' $WOLF/userContent.css
sed -i 's/--bg3: .*/--bg3: #47424F;/g' $WOLF/userContent.css
sed -i 's/--fg: .*/--fg: #E8D4CF;/g' $WOLF/userContent.css

# Change Picom
sed -i 's/shadow = .*/shadow = true;/g' $CONF/picom.conf
sed -i 's/shadow-radius = .*/shadow-radius = 15;/g' $CONF/picom.conf
sed -i 's/shadow-offset-x = .*/shadow-offset-x = -15;/g' $CONF/picom.conf
sed -i 's/shadow-offset-y = .*/shadow-offset-y = -15;/g' $CONF/picom.conf
sed -i 's/shadow-opacity = .*/shadow-opacity = 1;/g' $CONF/picom.conf

# Change Zathura
sed -i 's/recolor-lightcolor.*/recolor-lightcolor		"#403B47"/g' $ZATH/zathurarc
sed -i 's/recolor-darkcolor.*/recolor-darkcolor		"#E8D4CF"/g' $ZATH/zathurarc
sed -i 's/statusbar-bg.*/statusbar-bg		"#403B47"/g' $ZATH/zathurarc
sed -i 's/statusbar-fg.*/statusbar-fg		"#E8D4CF"/g' $ZATH/zathurarc
sed -i 's/default-bg.*/default-bg			"#403B47"/g' $ZATH/zathurarc
sed -i 's/default-fg.*/default-fg			"#E8D4CF"/g' $ZATH/zathurarc
sed -i 's/inputbar-bg.*/inputbar-bg			"#403B47"/g' $ZATH/zathurarc
sed -i 's/inputbar-fg.*/inputbar-fg			"#E8D4CF"/g' $ZATH/zathurarc
sed -i 's/completion-bg.*/completion-bg		"#403B47"/g' $ZATH/zathurarc
sed -i 's/completion-fg.*/completion-fg		"#E8D4CF"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-bg.*/completion-highlight-bg	"#E8D4CF"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-fg.*/completion-highlight-fg	"#403B47"/g' $ZATH/zathurarc
sed -i 's/completion-group-bg.*/completion-group-bg		"#403B47"/g' $ZATH/zathurarc
sed -i 's/completion-group-fg.*/completion-group-fg		"#E8D4CF"/g' $ZATH/zathurarc

# Change i3lock
sed -i 's/text=".*/text="E8D4CF"/g' $CONF/bin/lock.sh
sed -i 's/back=".*/back="403B47"/g' $CONF/bin/lock.sh
sed -i 's/black=".*/black="5C5566"/g' $CONF/bin/lock.sh
sed -i 's/green=".*/green="B6A4A0"/g' $CONF/bin/lock.sh
sed -i 's/red=".*/red="CD9C97"/g' $CONF/bin/lock.sh
sed -i 's/blue=".*/blue="B9B9C4"/g' $CONF/bin/lock.sh

#
# i3
#

# Change Gaps + Borders
sed -i 's/gaps top .*/gaps top 82/g' $i3/config
sed -i 's/gaps inner .*/gaps inner 19/g' $i3/config
sed -i 's/default_border .*/default_border pixel 3/g' $i3/config
sed -i 's/default_floating_border .*/default_floating_border pixel 3/g' $i3/config
sed -i 's/set $bg-color .*/set $bg-color #CD9B97/g' $i3/config
sed -i 's/set $inactive-bg-color .*/set $inactive-bg-color #4D4650/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i 's/top_padding.*/top_padding 82/g' $BSP/bspwmrc
sed -i 's/window_gap .*/window_gap 19/g' $BSP/bspwmrc
sed -i 's/border_width .*/border_width 3/g' $BSP/bspwmrc
sed -i 's/focused_border_color .*/focused_border_color "#CD9B97"/g' $BSP/bspwmrc
sed -i 's/normal_border_color .*/normal_border_color "#4D4650"/g' $BSP/bspwmrc
sed -i 's/presel_feedback_color .*/presel_feedback_color "#CD9B97"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i 's/<theme><name>.*/<theme><name>NoelRed<\/name>/g' $OBOX/rc.xml
sed -i 's/<titleLayout>.*/<titleLayout>CL<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i 's/<top>.*/<top>101<\/top>/g' $OBOX/rc.xml
sed -i 's/<bottom>.*/<bottom>19<\/bottom>/g' $OBOX/rc.xml
sed -i 's/<left>.*/<left>19<\/left>/g' $OBOX/rc.xml
sed -i 's/<right>.*/<right>19<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Noel Red" Scheme'
