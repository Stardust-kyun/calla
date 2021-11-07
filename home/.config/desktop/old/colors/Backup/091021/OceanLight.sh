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
sed -i 's/.*#Launch/tint2 -c $HOME\/.config\/tint2\/oceanlight #Launch/g' ~/.config/bin/bar.sh

# Change Wallpaper
nitrogen --set-zoom-fill $WALL/Ocean.jpg --save

# Change Notifs
sed -i 's/background = .*/background = "#f0fafa"/g' $NOTI/dunstrc
sed -i 's/foreground = .*/foreground = "#262626"/g' $NOTI/dunstrc
sed -i 's/frame_width = .*/frame_width = 3/g' $NOTI/dunstrc
sed -i 's/frame_color = .*/frame_color = "#dde6e6"/g' $NOTI/dunstrc
sed -i 's/geometry = .*/geometry = "310x100-35+35"/g' $NOTI/dunstrc

# Restart Dunst
sleep 1 && killall dunst
 
# Change Xresources
sed -i 's/#define FG .*/#define FG #262626/g' $HOME/.Xresources
sed -i 's/#define BG .*/#define BG #f0fafa/g' $HOME/.Xresources
sed -i 's/#define BL .*/#define BL #404040/g' $HOME/.Xresources
sed -i 's/#define WH .*/#define WH #dde6e6/g' $HOME/.Xresources
sed -i 's/#define R .*/#define R #e68383/g' $HOME/.Xresources
sed -i 's/#define G .*/#define G #a5e1af/g' $HOME/.Xresources
sed -i 's/#define Y .*/#define Y #ffd29b/g' $HOME/.Xresources
sed -i 's/#define B .*/#define B #83b4e6/g' $HOME/.Xresources
sed -i 's/#define M .*/#define M #e1aae1/g' $HOME/.Xresources
sed -i 's/#define C .*/#define C #8cd7d2/g' $HOME/.Xresources
sed -i 's/dmenu.background: .*/dmenu.background: #f0fafa/g' $HOME/.Xresources
sed -i 's/dmenu.foreground: .*/dmenu.foreground: #262626/g' $HOME/.Xresources
sed -i 's/dmenu.selbackground: .*/dmenu.selbackground: #dde6e6/g' $HOME/.Xresources
sed -i 's/dmenu.selforeground: .*/dmenu.selforeground: #262626/g' $HOME/.Xresources

# Change Alacritty
sed -i 's/.*#BG/    "#f0fafa" #BG/g' $ALAC/alacritty.yml
sed -i 's/.*#FG/    "#262626" #FG/g' $ALAC/alacritty.yml
sed -i 's/.*#BL/    "#404040" #BL/g' $ALAC/alacritty.yml
sed -i 's/.*#WH/    "#dde6e6" #WH/g' $ALAC/alacritty.yml
sed -i 's/.*#R /    "#e68383" #R /g' $ALAC/alacritty.yml
sed -i 's/.*#G /    "#a5e1af" #G /g' $ALAC/alacritty.yml
sed -i 's/.*#Y /    "#ffd29b" #Y /g' $ALAC/alacritty.yml
sed -i 's/.*#B /    "#83b4e6" #B /g' $ALAC/alacritty.yml
sed -i 's/.*#M /    "#e1aae1" #M /g' $ALAC/alacritty.yml
sed -i 's/.*#C /    "#8cd7d2" #C /g' $ALAC/alacritty.yml

# Change Kitty
sed -i -e 's/color0 .*/color0 #404040/g' -e 's/color8 .*/color8 #404040/g' $KITTY/kitty.conf
sed -i -e 's/color1 .*/color1 #e68383/g' -e 's/color9 .*/color9 #e68383/g' $KITTY/kitty.conf
sed -i -e 's/color2 .*/color2 #a5e1af/g' -e 's/color10 .*/color10 #a5e1af/g' $KITTY/kitty.conf
sed -i -e 's/color3 .*/color3 #ffd29b/g' -e 's/color11 .*/color11 #ffd29b/g' $KITTY/kitty.conf
sed -i -e 's/color4 .*/color4 #83b4e6/g' -e 's/color12 .*/color12 #83b4e6/g' $KITTY/kitty.conf
sed -i -e 's/color5 .*/color5 #e1aae1/g' -e 's/color13 .*/color13 #e1aae1/g' $KITTY/kitty.conf
sed -i -e 's/color6 .*/color6 #8cd7d2/g' -e 's/color14 .*/color14 #8cd7d2/g' $KITTY/kitty.conf
sed -i -e 's/color7 .*/color7 #dde6e6/g' -e 's/color15 .*/color15 #dde6e6/g' $KITTY/kitty.conf
sed -i 's/foreground .*/foreground #262626/g' $KITTY/kitty.conf
sed -i 's/background .*/background #f0fafa/g' $KITTY/kitty.conf
sed -i 's/selection_foreground .*/selection_foreground #f0fafa/g' $KITTY/kitty.conf
sed -i 's/selection_background .*/selection_background #262626/g' $KITTY/kitty.conf
sed -i 's/cursor .*/cursor #262626/g' $KITTY/kitty.conf

# Change Vim
sed -i 's/ bg = .*/ bg = "#f0fafa"/g' $VIM/colors/theme.vim
sed -i 's/ fg = .*/ fg = "#262626"/g' $VIM/colors/theme.vim
sed -i 's/ bl = .*/ bl = "#404040"/g' $VIM/colors/theme.vim
sed -i 's/ wh = .*/ wh = "#dde6e6"/g' $VIM/colors/theme.vim
sed -i 's/ r  = .*/ r  = "#e68383"/g' $VIM/colors/theme.vim
sed -i 's/ g  = .*/ g  = "#a5e1af"/g' $VIM/colors/theme.vim
sed -i 's/ y  = .*/ y  = "#ffd29b"/g' $VIM/colors/theme.vim
sed -i 's/ b  = .*/ b  = "#83b4e6"/g' $VIM/colors/theme.vim
sed -i 's/ m  = .*/ m  = "#e1aae1"/g' $VIM/colors/theme.vim
sed -i 's/ c  = .*/ c  = "#8cd7d2"/g' $VIM/colors/theme.vim

# Update Xresources, Terminals, and Vim
xrdb $HOME/.Xresources
$CONF/bin/livereload.sh
vim --remote-send "<C-c>:color theme<CR>" vim

# Change Rofi
sed -i 's/--bg: .*/--bg: #f0fafa;/g' $ROFI/theme.rasi
sed -i 's/--fg: .*/--fg: #262626;/g' $ROFI/theme.rasi
sed -i 's/--selbg: .*/--selbg: #dde6e6;/g' $ROFI/theme.rasi
sed -i 's/--selfg: .*/--selfg: #262626;/g' $ROFI/theme.rasi

# Change GTK
sed -i 's/gtk-theme-name=.*/gtk-theme-name=OceanLight/g' $GTK3/settings.ini
sed -i 's/gtk-theme-name=.*/gtk-theme-name="OceanLight"/g' $HOME/.gtkrc-2.0
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name=OceanLight/g' $GTK3/settings.ini
sed -i 's/gtk-icon-theme-name=.*/gtk-icon-theme-name="OceanLight"/g' $HOME/.gtkrc-2.0
sed -i 's/Net\/ThemeName .*/Net\/ThemeName "OceanLight"/g' $HOME/.xsettingsd
sed -i 's/Net\/IconThemeName .*/Net\/IconThemeName "OceanLight"/g' $HOME/.xsettingsd

# Apply GTK
xsettingsd & disown

# Change Powercord
sed -i 's/--background-primary: .*/--background-primary: #f0fafa !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary: .*/--background-secondary: #f0fafa !important;/g' $CORD/discord.theme.css
sed -i 's/--background-secondary-alt: .*/--background-secondary-alt: #f0fafa !important;/g' $CORD/discord.theme.css
sed -i 's/--background-tertiary: .*/--background-tertiary: #f0fafa !important;/g' $CORD/discord.theme.css
sed -i 's/--background-accent: .*/--background-accent: #f0fafa !important;/g' $CORD/discord.theme.css
sed -i 's/--background-floating: .*/--background-floating: #f0fafa !important;/g' $CORD/discord.theme.css
sed -i 's/--text-muted: .*/--text-muted: #666666 !important;/g' $CORD/discord.theme.css
sed -i 's/--text-normal: .*/--text-normal: #111111 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-normal: .*/--interactive-normal: #888888 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-hover: .*/--interactive-hover: #707070 !important;/g' $CORD/discord.theme.css
sed -i 's/--interactive-active: .*/--interactive-active: #000000 !important;/g' $CORD/discord.theme.css
sed -i 's/--header-primary: .*/--header-primary: black !important;/g' $CORD/discord.theme.css
sed -i 's/--header-secondary: .*/--header-secondary: black !important;/g' $CORD/discord.theme.css

# Change Firefox
sed -i 's/--bg: .*/--bg: #f0fafa;/g' $FIRE/userChrome.css
sed -i 's/--fg: .*/--fg: #262626;/g' $FIRE/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #999999;/g' $FIRE/userChrome.css

# Change Librewolf
sed -i 's/--bg: .*/--bg: #f0fafa;/g' $WOLF/userChrome.css
sed -i 's/--fg: .*/--fg: #262626;/g' $WOLF/userChrome.css
sed -i 's/--fg-alt: .*/--fg-alt: #999999;/g' $WOLF/userChrome.css

# Change Startpage
sed -i 's/--bg: .*/--bg: #f0fafa;/g' $PAGE/css/style.css
sed -i 's/--bg2: .*/--bg2: #ebf5f5;/g' $PAGE/css/style.css
sed -i 's/--bg3: .*/--bg3: #e6f0f0;/g' $PAGE/css/style.css
sed -i 's/--fg: .*/--fg: #262626;/g' $PAGE/css/style.css

# Change 4chan
sed -i 's/--bg: .*/--bg: #f0fafa;/g' $FIRE/userContent.css
sed -i 's/--bg2: .*/--bg2: #ebf5f5;/g' $FIRE/userContent.css
sed -i 's/--bg3: .*/--bg3: #e6f0f0;/g' $FIRE/userContent.css
sed -i 's/--fg: .*/--fg: #262626;/g' $FIRE/userContent.css
sed -i 's/--bg: .*/--bg: #f0fafa;/g' $WOLF/userContent.css
sed -i 's/--bg2: .*/--bg2: #ebf5f5;/g' $WOLF/userContent.css
sed -i 's/--bg3: .*/--bg3: #e6f0f0;/g' $WOLF/userContent.css
sed -i 's/--fg: .*/--fg: #262626;/g' $WOLF/userContent.css

# Change Picom
sed -i 's/shadow = .*/shadow = true;/g' $CONF/picom.conf
sed -i 's/shadow-radius = .*/shadow-radius = 25;/g' $CONF/picom.conf
sed -i 's/shadow-offset-x = .*/shadow-offset-x = -25;/g' $CONF/picom.conf
sed -i 's/shadow-offset-y = .*/shadow-offset-y = -25;/g' $CONF/picom.conf
sed -i 's/shadow-opacity = .*/shadow-opacity = .1;/g' $CONF/picom.conf

# Change Zathura
sed -i 's/recolor-lightcolor.*/recolor-lightcolor		"#f0fafa"/g' $ZATH/zathurarc
sed -i 's/recolor-darkcolor.*/recolor-darkcolor		"#262626"/g' $ZATH/zathurarc
sed -i 's/statusbar-bg.*/statusbar-bg		"#f0fafa"/g' $ZATH/zathurarc
sed -i 's/statusbar-fg.*/statusbar-fg		"#262626"/g' $ZATH/zathurarc
sed -i 's/default-bg.*/default-bg			"#f0fafa"/g' $ZATH/zathurarc
sed -i 's/default-fg.*/default-fg			"#262626"/g' $ZATH/zathurarc
sed -i 's/inputbar-bg.*/inputbar-bg			"#f0fafa"/g' $ZATH/zathurarc
sed -i 's/inputbar-fg.*/inputbar-fg			"#262626"/g' $ZATH/zathurarc
sed -i 's/completion-bg.*/completion-bg		"#f0fafa"/g' $ZATH/zathurarc
sed -i 's/completion-fg.*/completion-fg		"#262626"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-bg.*/completion-highlight-bg	"#262626"/g' $ZATH/zathurarc
sed -i 's/completion-highlight-fg.*/completion-highlight-fg	"#f0fafa"/g' $ZATH/zathurarc
sed -i 's/completion-group-bg.*/completion-group-bg		"#f0fafa"/g' $ZATH/zathurarc
sed -i 's/completion-group-fg.*/completion-group-fg		"#262626"/g' $ZATH/zathurarc

# Change i3lock
sed -i 's/text=".*/text="f0fafa"/g' $CONF/bin/lock.sh
sed -i 's/back=".*/back="262626"/g' $CONF/bin/lock.sh
sed -i 's/black=".*/black="404040"/g' $CONF/bin/lock.sh
sed -i 's/green=".*/green="a5e1af"/g' $CONF/bin/lock.sh
sed -i 's/red=".*/red="e68383"/g' $CONF/bin/lock.sh
sed -i 's/blue=".*/blue="83b4e6"/g' $CONF/bin/lock.sh

#
# i3
#

# Change Gaps + Borders
sed -i 's/gaps top .*/gaps top 0/g' $i3/config
sed -i 's/gaps inner .*/gaps inner 30/g' $i3/config
sed -i 's/default_border .*/default_border pixel 3/g' $i3/config
sed -i 's/default_floating_border .*/default_floating_border pixel 3/g' $i3/config
sed -i 's/set $bg-color .*/set $bg-color #9999a8/g' $i3/config
sed -i 's/set $inactive-bg-color .*/set $inactive-bg-color #3a3a40/g' $i3/config

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
sed -i 's/normal_border_color .*/normal_border_color "#3a3a40"/g' $BSP/bspwmrc
sed -i 's/presel_feedback_color .*/presel_feedback_color "#9999a8"/g' $BSP/bspwmrc

# Restart bsp
bspc wm -r

#
# openbox
#

# Change Theme
sed -i 's/<theme><name>.*/<theme><name>OceanLight<\/name>/g' $OBOX/rc.xml
sed -i 's/<titleLayout>.*/<titleLayout>MIC<\/titleLayout>/g' $OBOX/rc.xml

# Change Window Bounds
sed -i 's/<top>.*/<top>20<\/top>/g' $OBOX/rc.xml
sed -i 's/<bottom>.*/<bottom>20<\/bottom>/g' $OBOX/rc.xml
sed -i 's/<left>.*/<left>100<\/left>/g' $OBOX/rc.xml
sed -i 's/<right>.*/<right>20<\/right>/g' $OBOX/rc.xml

# Reconfigure openbox
openbox --reconfigure
$OBOX/autostart

# Notify
sleep 1.3 && notify-send 'Color Script' 'Set "Ocean Light" Scheme'

#f0fafa
#262626
#404040
#dde6e6
#e68383
#a5e1af
#ffe19b
#83b4e6
#e1aae1
#8cd7d2
