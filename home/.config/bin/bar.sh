#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar tint2

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
while pgrep -u $UID -x tint2 >/dev/null; do sleep 1; done

# Launch bar
tint2 -c $HOME/.config/tint2/sakuradark #Launch
