#!/bin/bash
PDIR="$HOME/.config/polybar"
LAUNCH="polybar-msg cmd restart"
BG=$(cat $PDIR/config.ini | grep 'bg =')

if [[ "$BG" = "bg = #161616" ]]; then

# Change Polybar Color
sed -i -e 's/bg = .*/bg = #fefefe/g' $PDIR/config.ini 
sed -i -e 's/fg = .*/fg = #111111/g' $PDIR/config.ini 
sed -i -e 's/fg-alt = .*/fg-alt = #444444/g' $PDIR/config.ini 
# Restart Polybar
$LAUNCH &
# Change Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpaper/WelcomeHomeWhite.png &
# Change Dmenu Color
sed -i -e 's/#161616/#fefefe/g' $HOME/.config/bin/amenu 
sed -i -e 's/#ffffff/#111111/g' $HOME/.config/bin/amenu
# Change Notifs
sed -i -e '184,195 s/#1a1a1a/#f1f1f1/g' $HOME/.config/dunst/dunstrc
sed -i -e '184,195 s/#ffffff/#111111/g' $HOME/.config/dunst/dunstrc
# Restart Dunst
sleep 1 && killall dunst
# Change URxvt
sed -i -e '49 s/16/fe/g' $HOME/.Xresources
sed -i -e '12,14 s/b9/46/g' $HOME/.Xresources
sed -i -e '13 s/16/fe/g' $HOME/.Xresources
# Restart URxvt
xrdb $HOME/.Xresources
# Change GTK
sed -i -e '2 s/Dark/Light/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e '5 s/Dark/Light/g' $HOME/.gtkrc-2.0
killall nautilus

# Notify
notify-send 'Color Scheme' 'Set Light Scheme'

# Restart i3
# i3-msg restart 

else 

# Change Polybar Color
sed -i -e 's/bg = .*/bg = #161616/g' $PDIR/config.ini 
sed -i -e 's/fg = .*/fg = #f2f2f2/g' $PDIR/config.ini 
sed -i -e 's/fg-alt = .*/fg-alt = #bcbcbc/g' $PDIR/config.ini 
# Restart Polybar
$LAUNCH &
# Change Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpaper/WelcomeHomeLight.png &
# Change Dmenu Color
sed -i -e 's/#fefefe/#161616/g' $HOME/.config/bin/amenu 
sed -i -e 's/#111111/#ffffff/g' $HOME/.config/bin/amenu
# Change Notifs
sed -i -e '184,195 s/#f1f1f1/#1a1a1a/g' $HOME/.config/dunst/dunstrc
sed -i -e '184,195 s/#111111/#ffffff/g' $HOME/.config/dunst/dunstrc
# Restart Dunst
sleep 1 && killall dunst
# Change URxvt
sed -i -e '49 s/fe/16/g' $HOME/.Xresources
sed -i -e '12,14 s/46/b9/g' $HOME/.Xresources
sed -i -e '13 s/fe/16/g' $HOME/.Xresources
# Restart URxvt
xrdb $HOME/.Xresources
# Change GTK
sed -i -e '2 s/Light/Dark/g' $HOME/.config/gtk-3.0/settings.ini
sed -i -e '5 s/Light/Dark/g' $HOME/.gtkrc-2.0
killall nautilus

# Notify
notify-send 'Color Scheme' 'Set Dark Scheme'

# Restart i3
# i3-msg restart 

fi

