#!/bin/dash

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
BG="#fefefe"
FG="#464646"
BL="#525252"
WH="#b9b9b9"
R="#7c7c7c"
G="#8e8e8e"
Y="#a0a0a0"
B="#686868"
M="#747474"
C="#868686"

bar() {
sed -i "s/.*#Launch/$1 -c \$HOME\/.config\/$1\/$2 #Launch/g" $BAR
}

wall() {
nitrogen --set-zoom-fill $WALL/$1 --save
}

notifs() {
sed -i -e "s/background = .*/background = \"$1\"/g" \
       -e "s/foreground = .*/foreground = \"$2\"/g" \
       -e "s/frame_width = .*/frame_width = \"$3\"/g" \
       -e "s/frame_color = .*/frame_color = \"$4\"/g" \
       -e "s/geometry = .*/geometry = \"$5\"/g" $NOTI
# Restart
killall dunst
}

run() {
sed -i -e "s/--bg: .*/--bg: $1;/g" \
       -e "s/--fg: .*/--fg: $2;/g" \
       -e "s/--selbg: .*/--selbg: $3;/g" \
       -e "s/--selfg: .*/--selfg: $4;/g" $ROFI
sed -i -e "s/dmenu.background: .*/dmenu.background: $1/g" \
       -e "s/dmenu.foreground: .*/dmenu.foreground: $2/g" \
       -e "s/dmenu.selbackground: .*/dmenu.selbackground: $3/g" \
       -e "s/dmenu.selforeground: .*/dmenu.selforeground: $4/g" $XRES
}

comp() {
sed -i -e "s/shadow = .*/shadow = $1;/g" \
       -e "s/shadow-radius = .*/shadow-radius = $2;/g" \
       -e "s/shadow-offset-x = .*/shadow-offset-x = $3;/g" \
       -e "s/shadow-offset-y = .*/shadow-offset-y = $4;/g" \
       -e "s/shadow-opacity = .*/shadow-opacity = $5;/g" $PICOM
killall picom
}

lock() {
sed -i -e "s/text=\".*/text=\"$1\"/g" \
       -e "s/back=\".*/back=\"$2\"/g" \
       -e "s/black=\".*/black=\"$3\"/g" \
       -e "s/green=\".*/green=\"$4\"/g" \
       -e "s/red=\".*/red=\"$5\"/g" \
       -e "s/blue=\".*/blue=\"$6\"/g" $LOCK
}

term() {
# Xresources
sed -i -e "s/#define FG .*/#define FG $FG/g" \
       -e "s/#define BG .*/#define BG $BG/g" \
       -e "s/#define BL .*/#define BL $BL/g" \
       -e "s/#define WH .*/#define WH $WH/g" \
       -e "s/#define R .*/#define R $R/g" \
       -e "s/#define G .*/#define G $G/g" \
       -e "s/#define Y .*/#define Y $Y/g" \
       -e "s/#define B .*/#define B $B/g" \
       -e "s/#define M .*/#define M $M/g" \
       -e "s/#define C .*/#define C $C/g" $XRES
# Alacritty
sed -i -e "s/.*#BG/    \"$BG\" #BG/g" \
       -e "s/.*#FG/    \"$FG\" #FG/g" \
       -e "s/.*#BL/    \"$BL\" #BL/g" \
       -e "s/.*#WH/    \"$WH\" #WH/g" \
       -e "s/.*#R /    \"$R\" #R /g" \
       -e "s/.*#G /    \"$G\" #G /g" \
       -e "s/.*#Y /    \"$Y\" #Y /g" \
       -e "s/.*#B /    \"$B\" #B /g" \
       -e "s/.*#M /    \"$M\" #M /g" \
       -e "s/.*#C /    \"$C\" #C /g" $ALAC
# Kitty
sed -i -e "s/color0 .*/color0 $BL/g" -e "s/color8 .*/color8 $BL/g" \
       -e "s/color1 .*/color1 $R/g" -e "s/color9 .*/color9 $R/g" \
       -e "s/color2 .*/color2 $G/g" -e "s/color10 .*/color10 $G/g" \
       -e "s/color3 .*/color3 $Y/g" -e "s/color11 .*/color11 $Y/g" \
       -e "s/color4 .*/color4 $B/g" -e "s/color12 .*/color12 $B/g" \
       -e "s/color5 .*/color5 $M/g" -e "s/color13 .*/color13 $M/g" \
       -e "s/color6 .*/color6 $C/g" -e "s/color14 .*/color14 $C/g" \
       -e "s/color7 .*/color7 $WH/g" -e "s/color15 .*/color15 $WH/g" \
       -e "s/foreground .*/foreground $FG/g" \
       -e "s/background .*/background $BG/g" \
       -e "s/selection_foreground .*/selection_foreground $BG/g" \
       -e "s/selection_background .*/selection_background $FG/g" \
       -e "s/cursor .*/cursor $FG/g" $KITTY
# Vim
sed -i -e "s/ bg = .*/ bg = \"$BG\"/g" \
       -e "s/ fg = .*/ fg = \"$FG\"/g" \
       -e "s/ bl = .*/ bl = \"$BL\"/g" \
       -e "s/ wh = .*/ wh = \"$WH\"/g" \
       -e "s/ r  = .*/ r  = \"$R\"/g" \
       -e "s/ g  = .*/ g  = \"$G\"/g" \
       -e "s/ y  = .*/ y  = \"$Y\"/g" \
       -e "s/ b  = .*/ b  = \"$B\"/g" \
       -e "s/ m  = .*/ m  = \"$M\"/g" \
       -e "s/ c  = .*/ c  = \"$C\"/g" $VIM
# Update Xresources, Terminals, and Vim
xrdb $XRES
$CONF/bin/livereload.sh
vim --remote-send "<C-c>:color theme<CR>" vim
}

gtk() {
sed -i -e "s/gtk-theme-name=.*/gtk-theme-name=$1/g" \
       -e "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=$2/g" $GTK3
sed -i -e "s/gtk-theme-name=.*/gtk-theme-name=\"$1\"/g" \
       -e "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=\"$2\"/g" $GTK2
sed -i -e "s/Net\/ThemeName .*/Net\/ThemeName \"$1\"/g" \
       -e "s/Net\/IconThemeName .*/Net\/IconThemeName \"$2\"/g" $HOME/.xsettingsd
# Apply
xsettingsd &
}

cord() {
sed -i -e "s/--background-primary: .*/--background-primary: $1 !important;/g" \
       -e "s/--background-secondary: .*/--background-secondary: $1 !important;/g" \
       -e "s/--background-secondary-alt: .*/--background-secondary-alt: $1 !important;/g" \
       -e "s/--background-tertiary: .*/--background-tertiary: $1 !important;/g" \
       -e "s/--background-accent: .*/--background-accent: $1 !important;/g" \
       -e "s/--background-floating: .*/--background-floating: $1 !important;/g" \
       -e "s/--text-muted: .*/--text-muted: #b6b6b6 !important;/g" \
       -e "s/--text-normal: .*/--text-normal: #fbfbfb !important;/g" \
       -e "s/--interactive-normal: .*/--interactive-normal: #c8c8c8 !important;/g" \
       -e "s/--interactive-hover: .*/--interactive-hover: #dcddde !important;/g" \
       -e "s/--interactive-active: .*/--interactive-active: #fff !important;/g" \
       -e "s/--header-primary: .*/--header-primary: white !important;/g" \
       -e "s/--header-secondary: .*/--header-secondary: #c9c9c9 !important;/g" $CORD
}

browser() {
sed -i -e "s/--bg: .*/--bg: $1;/g" \
       -e "s/--fg: .*/--fg: $2;/g" \
       -e "s/--fg-alt: .*/--fg-alt: $3;/g" $FIRE/userChrome.css
sed -i -e "s/--bg: .*/--bg: $1;/g" \
       -e "s/--fg: .*/--fg: $2;/g" \
       -e "s/--fg-alt: .*/--fg-alt: $3;/g" $WOLF/userChrome.css
}

chan() {
sed -i -e "s/--bg: .*/--bg: $1;/g" \
       -e "s/--bg2: .*/--bg2: $2;/g" \
       -e "s/--bg3: .*/--bg3: $3;/g" \
       -e "s/--fg: .*/--fg: $4;/g" $FIRE/userContent.css
sed -i -e "s/--bg: .*/--bg: $1;/g" \
       -e "s/--bg2: .*/--bg2: $2;/g" \
       -e "s/--bg3: .*/--bg3: $3;/g" \
       -e "s/--fg: .*/--fg: $4;/g" $WOLF/userContent.css
}

page() {
sed -i -e "s/--bg: .*/--bg: $1;/g" \
       -e "s/--bg2: .*/--bg2: $2;/g" \
       -e "s/--bg3: .*/--bg3: $3;/g" \
       -e "s/--fg: .*/--fg: $4;/g" $PAGE
}

zath() {
sed -i -e "s/recolor-lightcolor.*/recolor-lightcolor		\"$1\"/g" \
       -e "s/recolor-darkcolor.*/recolor-darkcolor		\"$2\"/g" \
       -e "s/statusbar-bg.*/statusbar-bg		\"$1\"/g" \
       -e "s/statusbar-fg.*/statusbar-fg		\"$2\"/g" \
       -e "s/default-bg.*/default-bg			\"$1\"/g" \
       -e "s/default-fg.*/default-fg			\"$2\"/g" \
       -e "s/inputbar-bg.*/inputbar-bg			\"$1\"/g" \
       -e "s/inputbar-fg.*/inputbar-fg			\"$2\"/g" \
       -e "s/completion-bg.*/completion-bg		\"$1\"/g" \
       -e "s/completion-fg.*/completion-fg		\"$2\"/g" \
       -e "s/completion-highlight-bg.*/completion-highlight-bg	\"$2\"/g" \
       -e "s/completion-highlight-fg.*/completion-highlight-fg	\"$1\"/g" \
       -e "s/completion-group-bg.*/completion-group-bg		\"$1\"/g" \
       -e "s/completion-group-fg.*/completion-group-fg		\"$2\"/g" $ZATH
}

obox() {
sed -i -e "s/<theme><name>.*/<theme><name>$1<\/name>/g" \
       -e"s/<titleLayout>.*/<titleLayout>$2<\/titleLayout>/g" \
       -e"s/<top>.*/<top>$3<\/top>/g" \
       -e"s/<bottom>.*/<bottom>$4<\/bottom>/g" \
       -e"s/<left>.*/<left>$5<\/left>/g" \
       -e"s/<right>.*/<right>$6<\/right>/g" $OBOX/rc.xml
# Reconfigure
openbox --reconfigure
$OBOX/autostart
}

# func - bar - config
bar 'polybar' 'archlight main' 
# func - wallpaper
wall 'WhiteMountains.jpg' 
# func - background - foreground - frame width - geometry
notifs $BG $FG '0' $FG '310x100-35+95' 
# func - background - foreground - selected background - selected foreground
run $BG $WH $BG $FG 
# func - enable/disable - radius - x offset - y offset - opacity
comp 'true' '15' '-15' '-15' '1' 
# func - foreground - background - black - green - red - blue
lock $BG $FG $BL $G $R $B 
# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk 'ArchLight' 'Arch' 
# func - background (edit section for now)
cord $BG
# func - background - foreground - alt foreground
browser $BG $FG '#5e5e5e' 
# func - background - background 2 - background 3 - foreground
chan $BG '#1A1A1A' '#1F1F1F' $FG 
# func - background - background 2 - background 3 - foreground
page $BG '#1A1A1A' '#1F1F1F' $FG 
# func - background - foreground
zath $BG $FG 
# func - theme - title - margins (top bottom left right)
obox 'ArchLight' 'MLC' '80' '19' '19' '19' 

# Notify
notify-send 'Desktop' 'Set "Arch Light" Desktop'
