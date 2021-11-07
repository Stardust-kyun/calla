#!/bin/bash
xOUT=$(xinput --list-props "Synaptics tm2964-001" | grep "Device Enabled")
xSTATE=${xOUT:$((${#xOUT} - 1)):1}
if [[ "$xSTATE" = "1" ]]; then
   xinput --disable "Synaptics tm2964-001" && notify-send -i input-touchpad-off "Touchpad Disabled"
else
   xinput --enable "Synaptics tm2964-001" && notify-send -i input-touchpad-on "Touchpad Enabled"
fi
