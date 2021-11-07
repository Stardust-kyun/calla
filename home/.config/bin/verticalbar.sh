#!/bin/bash
PDIR="$HOME/.config/polybar"
LAUNCH="polybar-msg cmd restart"
POS=$(cat $PDIR/config.ini | grep 'bottom = false')

if [[ "$POS" = "bottom = false" ]]; then

# Change Polybar Position
sed -i -e '15 s/false/true/g' $PDIR/config.ini
# Change Window Positions
sed -i -e '382 s/top/bottom/g' $HOME/.i3/config
# Change Dmenu Position
sed -i -e 's/-y 0/-y 1040/g' $HOME/.config/amenu
# Restart i3
i3-msg restart
i3-msg fullscreen toggle && sleep 0.5 && i3-msg fullscreen toggle

else

# Change Polybar Position
sed -i -e '15 s/true/false/g' $PDIR/config.ini
# Change Window Positions
sed -i -e '382 s/bottom/top/g' $HOME/.i3/config
# Change Dmenu Position
sed -i -e 's/-y 1040/-y 0/g' $HOME/.config/amenu
# Restart i3
i3-msg restart
i3-msg fullscreen toggle && sleep 0.5 && i3-msg fullscreen toggle

fi
