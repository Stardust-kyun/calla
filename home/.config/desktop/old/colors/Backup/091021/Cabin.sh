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



#   ____      _     _       
#  / ___|__ _| |__ (_)_ __  
# | |   / _` | '_ \| | '_ \ 
# | |__| (_| | |_) | | | | |
#  \____\__,_|_.__/|_|_| |_|



# Change Bar
sed -i 's/bg = .*/bg = #201e1a/g' $POLY/Cabin/config.ini
sed -i 's/fg = .*/fg = #79695a/g' $POLY/Cabin/config.ini
sed -i 's/fg-alt = .*/fg-alt = #4f453b/g' $POLY/Cabin/config.ini
sed -i 's/border-bottom-size = .*/border-bottom-size = 3/g' $POLY/Cabin/config.ini
sed -i 's/border-color = .*/border-color = #5D6051/g' $POLY/Cabin/config.ini
sed -i 's/.*#Launch/polybar -c $HOME\/.config\/polybar\/Cabin\/config.ini main \& #Launch/g' ~/.config/bin/bar.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/ForestCabin1.png --save && betterlockscreen -u $WALL/ForestCabin1.png &

# Change Notifs
sed -i 's/background = .*/background = "#201e1a"/g' $NOTI/dunstrc
sed -i 's/foreground = .*/foreground = "#79695a"/g' $NOTI/dunstrc
sed -i 's/frame_width = .*/frame_width = 3/g' $NOTI/dunstrc
sed -i 's/frame_color = .*/frame_color = "#5D6051"/g' $NOTI/dunstrc
sed -i 's/geometry = .*/geometry = "310x100-25+70"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst

# Change Xresources
sed -i 's/#define FG .*/#define FG #79695a/g' $HOME/.Xresources
sed -i 's/#define BG .*/#define BG #201e1a/g' $HOME/.Xresources
sed -i 's/#define BL .*/#define BL #443a36/g' $HOME/.Xresources
sed -i 's/#define WH .*/#define WH #867564/g' $HOME/.Xresources
sed -i 's/#define R .*/#define R #674441/g' $HOME/.Xresources
sed -i 's/#define G .*/#define G #5d6051/g' $HOME/.Xresources
sed -i 's/#define Y .*/#define Y #84694e/g' $HOME/.Xresources
sed -i 's/#define B .*/#define B #545e5e/g' $HOME/.Xresources
sed -i 's/#define M .*/#define M #614c4c/g' $HOME/.Xresources
sed -i 's/#define C .*/#define C #4d5c5c/g' $HOME/.Xresources
sed -i 's/dmenu.background: .*/dmenu.background: #201e1a/g' $HOME/.Xresources
sed -i 's/dmenu.foreground: .*/dmenu.foreground: #79695a/g' $HOME/.Xresources
sed -i 's/dmenu.selbackground: .*/dmenu.selbackground: #5D6051/g' $HOME/.Xresources
sed -i 's/dmenu.selforeground: .*/dmenu.selforeground: #201e1a/g' $HOME/.Xresources

# Change Alacritty
sed -i 's/.*#BG/    "#201e1a" #BG/g' $ALAC/alacritty.yml
sed -i 's/.*#FG/    "#79695a" #FG/g' $ALAC/alacritty.yml
sed -i 's/.*#BL/    "#443a36" #BL/g' $ALAC/alacritty.yml
sed -i 's/.*#WH/    "#867564" #WH/g' $ALAC/alacritty.yml
sed -i 's/.*#R /    "#674441" #R /g' $ALAC/alacritty.yml
sed -i 's/.*#G /    "#5d6051" #G /g' $ALAC/alacritty.yml
sed -i 's/.*#Y /    "#84694e" #Y /g' $ALAC/alacritty.yml
sed -i 's/.*#B /    "#545e5e" #B /g' $ALAC/alacritty.yml
sed -i 's/.*#M /    "#614c4c" #M /g' $ALAC/alacritty.yml
sed -i 's/.*#C /    "#4d5c5c" #C /g' $ALAC/alacritty.yml

# Change Kitty
sed -i -e 's/color0 .*/color0 #443a36/g' -e 's/color8 .*/color8 #443a36/g' $KITTY/kitty.conf
sed -i -e 's/color1 .*/color1 #674441/g' -e 's/color9 .*/color9 #674441/g' $KITTY/kitty.conf
sed -i -e 's/color2 .*/color2 #5d6051/g' -e 's/color10 .*/color10 #5d6051/g' $KITTY/kitty.conf
sed -i -e 's/color3 .*/color3 #84694e/g' -e 's/color11 .*/color11 #84694e/g' $KITTY/kitty.conf
sed -i -e 's/color4 .*/color4 #545e5e/g' -e 's/color12 .*/color12 #545e5e/g' $KITTY/kitty.conf
sed -i -e 's/color5 .*/color5 #614c4c/g' -e 's/color13 .*/color13 #614c4c/g' $KITTY/kitty.conf
sed -i -e 's/color6 .*/color6 #4d5c5c/g' -e 's/color14 .*/color14 #4d5c5c/g' $KITTY/kitty.conf
sed -i -e 's/color7 .*/color7 #867564/g' -e 's/color15 .*/color15 #867564/g' $KITTY/kitty.conf
sed -i 's/foreground .*/foreground #79695a/g' $KITTY/kitty.conf
sed -i 's/background .*/background #201e1a/g' $KITTY/kitty.conf
sed -i 's/selection_foreground .*/selection_foreground #201e1a/g' $KITTY/kitty.conf
sed -i 's/selection_background .*/selection_background #79695a/g' $KITTY/kitty.conf
sed -i 's/cursor .*/cursor #79695a/g' $KITTY/kitty.conf

# Change Vim
sed -i 's/ bg = .*/ bg = "#201e1a"/g' $VIM/colors/theme.vim
sed -i 's/ fg = .*/ fg = "#79695a"/g' $VIM/colors/theme.vim
sed -i 's/ bl = .*/ bl = "#443a36"/g' $VIM/colors/theme.vim
sed -i 's/ wh = .*/ wh = "#867564"/g' $VIM/colors/theme.vim
sed -i 's/ r  = .*/ r  = "#674441"/g' $VIM/colors/theme.vim
sed -i 's/ g  = .*/ g  = "#5d6051"/g' $VIM/colors/theme.vim
sed -i 's/ y  = .*/ y  = "#84694e"/g' $VIM/colors/theme.vim
sed -i 's/ b  = .*/ b  = "#545e5e"/g' $VIM/colors/theme.vim
sed -i 's/ m  = .*/ m  = "#614c4c"/g' $VIM/colors/theme.vim
sed -i 's/ c  = .*/ c  = "#4d5c5c"/g' $VIM/colors/theme.vim

# Update Xresources, Terminals, and Vim
xrdb $HOME/.Xresources
$CONF/bin/livereload.sh
vim --remote-send "<C-c>:color theme<CR>" vim

# Change Rofi
sed -i 's/--bg: .*/--bg: #201e1a;/g' $ROFI/theme.rasi
sed -i 's/--fg: .*/--fg: #79695a;/g' $ROFI/theme.rasi
sed -i 's/--selbg: .*/--selbg: #5D6051;/g' $ROFI/theme.rasi
sed -i 's/--selfg: .*/--selfg: #201e1a;/g' $ROFI/theme.rasi

# Change GTK
sed -i 's/gtk-theme-name=.*/gtk-theme-name=Cabin/g' $GTK3/settings.ini
sed -i 's/gtk-theme-name=.*/gtk-theme-name="Cabin"/g' $HOME/.gtkrc-2.0
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=Cabin/g' $GTK3/settings.ini
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="Cabin"/g' $HOME/.gtkrc-2.0
sed -i 's/Net\/ThemeName .*/Net\/ThemeName "Cabin"/g' $HOME/.xsettingsd
sed -i 's/Net\/IconThemeName .*/Net\/IconThemeName "Cabin"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i 's/--background-primary: .*/--background-primary: #201e1a !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary: .*/--background-secondary: #201e1a !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary-alt: .*/--background-secondary-alt: #201e1a !important;/g' $CORD/discord.theme.css
sed -i 's/--background-tertiary: .*/--background-tertiary: #201e1a !important;/g' $CORD/discord.theme.css
sed -i 's/--background-accent: .*/--background-accent: #201e1a !important;/g' $CORD/discord.theme.css
sed -i 's/--background-floating: .*/--background-floating: #201e1a !important;/g' $CORD/discord.theme.css
sed -i 's/--text-muted: .*/--text-muted: #b6b6b6 !important;/g' $CORD/discord.theme.css
sed -i 's/--text-normal: .*/--text-normal: #fbfbfb !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-active: .*/--interactive-active: #fff !important;/g' $CORD/discord.theme.css
sed -i 's/--header-primary: .*/--header-primary: white !important;/g' $CORD/discord.theme.css
sed -i 's/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g' $CORD/discord.theme.css

# Change Firefox
sed -i 's/--bg: .*/--bg: #201e1a;/g' $FIRE/userChrome.css
sed -i 's/--fg: .*/--fg: #79695a;/g' $FIRE/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #473e35;/g' $FIRE/userChrome.css

# Change Librewolf
sed -i 's/--bg: .*/--bg: #201e1a;/g' $WOLF/userChrome.css
sed -i 's/--fg: .*/--fg: #79695a;/g' $WOLF/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #473e35;/g' $WOLF/userChrome.css

# Change Startpage
sed -i 's/--bg: .*/--bg: #201e1a;/g' $PAGE/css/style.css
sed -i 's/--bg2: .*/--bg2: #24211D;/g' $PAGE/css/style.css
sed -i 's/--bg3: .*/--bg3: #292621;/g' $PAGE/css/style.css
sed -i 's/--fg: .*/--fg: #79695a;/g' $PAGE/css/style.css

# Change 4chan
sed -i 's/--bg: .*/--bg: #201e1a;/g' $FIRE/userContent.css
sed -i 's/--bg2: .*/--bg2: #24211D;/g' $FIRE/userContent.css
sed -i 's/--bg3: .*/--bg3: #292621;/g' $FIRE/userContent.css
sed -i 's/--fg: .*/--fg: #79695a;/g' $FIRE/userContent.css
sed -i 's/--bg: .*/--bg: #201e1a;/g' $WOLF/userContent.css
sed -i 's/--bg2: .*/--bg2: #24211D;/g' $WOLF/userContent.css
sed -i 's/--bg3: .*/--bg3: #292621;/g' $WOLF/userContent.css
sed -i 's/--fg: .*/--fg: #79695a;/g' $WOLF/userContent.css

# Change Picom
sed -i 's/shadow = .*/shadow = true;/g' $CONF/picom.conf
sed -i 's/shadow-radius = .*/shadow-radius = 15;/g' $CONF/picom.conf
sed -i 's/shadow-offset-x = .*/shadow-offset-x = -15;/g' $CONF/picom.conf
sed -i 's/shadow-offset-y = .*/shadow-offset-y = -15;/g' $CONF/picom.conf
sed -i 's/shadow-opacity = .*/shadow-opacity = 1;/g' $CONF/picom.conf

# Change Zathura
sed -i 's/recolor-lightcolor.*/recolor-lightcolor		"#201e1a"/g' $ZATH/zathurarc
sed -i 's/recolor-darkcolor.*/recolor-darkcolor		"#79695a"/g' $ZATH/zathurarc
sed -i 's/statusbar-bg.*/statusbar-bg		"#201e1a"/g' $ZATH/zathurarc
sed -i 's/statusbar-fg.*/statusbar-fg		"#79695a"/g' $ZATH/zathurarc
sed -i 's/default-bg.*/default-bg			"#201e1a"/g' $ZATH/zathurarc
sed -i 's/default-fg.*/default-fg			"#79695a"/g' $ZATH/zathurarc
sed -i 's/inputbar-bg.*/inputbar-bg			"#201e1a"/g' $ZATH/zathurarc
sed -i 's/inputbar-fg.*/inputbar-fg			"#79695a"/g' $ZATH/zathurarc
sed -i 's/completion-bg.*/completion-bg		"#201e1a"/g' $ZATH/zathurarc
sed -i 's/completion-fg.*/completion-fg		"#79695a"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-bg.*/completion-highlight-bg	"#79695a"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-fg.*/completion-highlight-fg	"#201e1a"/g' $ZATH/zathurarc
sed -i 's/completion-group-bg.*/completion-group-bg		"#201e1a"/g' $ZATH/zathurarc
sed -i 's/completion-group-fg.*/completion-group-fg		"#79695a"/g' $ZATH/zathurarc

# Change i3lock
sed -i 's/text=".*/text="79695a"/g' $CONF/bin/lock.sh
sed -i 's/back=".*/back="201e1a"/g' $CONF/bin/lock.sh
sed -i 's/black=".*/black="443a36"/g' $CONF/bin/lock.sh
sed -i 's/green=".*/green="5d6051"/g' $CONF/bin/lock.sh
sed -i 's/red=".*/red="674441"/g' $CONF/bin/lock.sh
sed -i 's/blue=".*/blue="545e5e"/g' $CONF/bin/lock.sh

#
# i3
#

# Change Gaps + Borders
sed -i 's/gaps top .*/gaps top 43/g' $i3/config
sed -i 's/gaps inner .*/gaps inner 14/g' $i3/config
sed -i 's/default_border .*/default_border pixel 3/g' $i3/config
sed -i 's/default_floating_border .*/default_floating_border pixel 3/g' $i3/config
sed -i 's/set $bg-color .*/set $bg-color #5D6051/g' $i3/config
sed -i 's/set $inactive-bg-color .*/set $inactive-bg-color #191A16/g' $i3/config

# Restart i3
pkill picom && i3-msg restart && picom -b &

#
# bsp
#

# Change Gaps + Borders
sed -i 's/top_padding.*/top_padding 43/g' $BSP/bspwmrc
sed -i 's/window_gap .*/window_gap 12/g' $BSP/bspwmrc
sed -i 's/border_width .*/border_width 3/g' $BSP/bspwmrc
sed -i 's/focused_border_color .*/focused_border_color "#5D6051"/g' $BSP/bspwmrc
sed -i 's/normal_border_color .*/normal_border_color "#191a16"/g' $BSP/bspwmrc
sed -i 's/presel_feedback_color .*/presel_feedback_color "#5D6051"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i 's/<theme><name>.*/<theme><name>Cabin<\/name>/g' $OBOX/rc.xml
sed -i 's/<titleLayout>.*/<titleLayout>LIMC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i 's/<top>.*/<top>55<\/top>/g' $OBOX/rc.xml
sed -i 's/<bottom>.*/<bottom>12<\/bottom>/g' $OBOX/rc.xml
sed -i 's/<left>.*/<left>12<\/left>/g' $OBOX/rc.xml
sed -i 's/<right>.*/<right>12<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Cabin" Scheme'
