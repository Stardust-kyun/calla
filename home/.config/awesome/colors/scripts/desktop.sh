#!/bin/bash

# Paths
CONF="$HOME/.config"
XRES="$HOME/.Xresources"
ROFI="$CONF/rofi/theme.rasi"
GTK3="$CONF/gtk-3.0/settings.ini"
GTK2="$HOME/.gtkrc-2.0"
WOLF="$HOME/.librewolf/*.default-release/chrome"
PAGE="$CONF/startpage/css/style.css"
PICOM="$CONF/picom.conf"
ZATH="$CONF/zathura/zathurarc"
SDDM="/usr/share/sddm/themes/theme/theme.conf"
AWES="$CONF/awesome"

run() {
sed -i -e "s/bg: .*/bg: $1;/g" \
       -e "s/fg: .*/fg: $2;/g" \
       -e "s/selbg: .*/selbg: $3;/g" \
       -e "s/selfg: .*/selfg: $4;/g" $ROFI
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
       -e "s/blue=\".*/blue=\"$6\"/g" $AWES/lock
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
# Update Xresources, Terminals, and Vim
xrdb $XRES
$AWES/bin/livereload
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

browser() {
sed -i -e "s/--bg: .*/--bg: $1;/g" \
       -e "s/--fg: .*/--fg: $2;/g" \
       -e "s/--fg-alt: .*/--fg-alt: $3;/g" $WOLF/userChrome.css
}

chan() {
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

sddm() {
sed -i -e "s/Background=.*/Background=\"$1\"/g" \
       -e "s/BackColor=.*/BackColor=\"$2\"/g" \
       -e "s/MainColor=.*/MainColor=\"$3\"/g" \
       -e "s/AccentColor=.*/AccentColor=\"$4\"/g" $SDDM
}

awes() {
sed -i "s/require(\"colors\..*/require(\"colors\.$1\")/g" $AWES/colors/init.lua
# Restart awesome
awesome-client 'awesome.restart()'
}
