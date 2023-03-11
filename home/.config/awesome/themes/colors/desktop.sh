#!/usr/bin/env bash

# Paths
config="$HOME/.config"
xresources="$HOME/.Xresources"
rofi="$config/rofi/theme.rasi"
gtk="$config/gtk-3.0/settings.ini"
librewolf="$HOME/.librewolf/*.default-release/chrome"
firefox="$HOME/.mozilla/firefox/*.default-release/chrome"
startpage="$config/startpage/css/style.css"
picom="$config/picom.conf"
zathura="$config/zathura/zathurarc"
lightdm="/usr/share/lightdm-webkit/themes/greeter/css/style.css"
awesomewm="$config/awesome"

run() {
sed -i -e "s/bg: .*/bg: $1;/g" \
       -e "s/fg: .*/fg: $2;/g" \
       -e "s/selbg: .*/selbg: $3;/g" \
       -e "s/selfg: .*/selfg: $4;/g" $rofi
}

comp() {
sed -i -e "s/shadow = .*/shadow = $1;/g" \
       -e "s/shadow-radius = .*/shadow-radius = $2;/g" \
       -e "s/shadow-offset-x = .*/shadow-offset-x = $3;/g" \
       -e "s/shadow-offset-y = .*/shadow-offset-y = $4;/g" \
       -e "s/shadow-opacity = .*/shadow-opacity = $5;/g" $picom
killall picom
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
       -e "s/#define C .*/#define C $C/g" $xresources
# Update Xresources, Terminals, and Vim
xrdb $xresources
$awesomewm/themes/colors/livereload.sh
}

gtk() {
sed -i -e "s/gtk-theme-name=.*/gtk-theme-name=$1/g" \
       -e "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=$2/g" $gtk
sed -i -e "s/Net\/ThemeName .*/Net\/ThemeName \"$1\"/g" \
       -e "s/Net\/IconThemeName .*/Net\/IconThemeName \"$2\"/g" $HOME/.xsettingsd
# Apply
xsettingsd &
}

browser() {
sed -i -e "s/--bg: .*/--bg: $1;/g" \
	   -e "s/--bg-alt: .*/--bg-alt: $2;/g" \
       -e "s/--fg: .*/--fg: $3;/g" \
       -e "s/--fg-alt: .*/--fg-alt: $4;/g" $librewolf/userChrome.css
sed -i -e "s/--bg: .*/--bg: $1;/g" \
	   -e "s/--bg-alt: .*/--bg-alt: $2;/g" \
       -e "s/--fg: .*/--fg: $3;/g" \
       -e "s/--fg-alt: .*/--fg-alt: $4;/g" $firefox/userChrome.css
}

css() {
sed -i -e "s/--bg: .*/--bg: $1 !important;/g" \
       -e "s/--bg2: .*/--bg2: $2 !important;/g" \
       -e "s/--bg3: .*/--bg3: $3 !important;/g" \
       -e "s/--fg: .*/--fg: $4 !important;/g" $librewolf/userContent.css
sed -i -e "s/--bg: .*/--bg: $1 !important;/g" \
       -e "s/--bg2: .*/--bg2: $2 !important;/g" \
       -e "s/--bg3: .*/--bg3: $3 !important;/g" \
       -e "s/--fg: .*/--fg: $4 !important;/g" $firefox/userContent.css
sed -i -e "s/--bg: .*/--bg: $1;/g" \
       -e "s/--bg2: .*/--bg2: $2;/g" \
       -e "s/--bg3: .*/--bg3: $3;/g" \
       -e "s/--fg: .*/--fg: $4;/g" $startpage
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
       -e "s/completion-group-fg.*/completion-group-fg		\"$2\"/g" $zathura
}

lightdm() {
sed -i -e "s/--bg: .*/--bg: $1;/g" \
       -e "s/--bg-alt: .*/--bg-alt: $2;/g" \
       -e "s/--bg-alt-hover: .*/--bg-alt-hover: $3;/g" \
       -e "s/--bg-disabled: .*/--bg-disabled: $4;/g" \
       -e "s/--fg: .*/--fg: $5;/g" \
	   -e "s/--fg-alt: .*/--fg-alt: $6;/g" \
       -e "s/--fg-error: .*/--fg-error: $7;/g" \
       -e "s/--image: .*/--image: url(\"\.\.\/src\/$8\.png\");/g" $lightdm
}

awes() {
sed -i "s/require(\"themes\.colors\..*/require(\"themes\.colors\.$1\")/g" $awesomewm/rc.lua
# Restart awesome
awesome-client 'awesome.restart()'
}
