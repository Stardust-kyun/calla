#!/bin/bash

for os in /etc/os-release /usr/lib/os-release; do
	[ -f $os ] && . $os && break
done
os=$( echo ${PRETTY_NAME} | tr '[:upper:]' '[:lower:]')

read -r _ _ version _ < /proc/version
kr=${version%%-*}

pa=$(pacman -Q | wc -l)

sh=$(basename $SHELL)

wm=$(echo $XDG_SESSION_DESKTOP)

echo "<openbox_pipe_menu>"
echo "<item label=\"os - ${os}\"/>"
echo "<item label=\"kr - ${kr}\"/>"
echo "<item label=\"pa - ${pa}\"/>"
echo "<item label=\"sh - ${sh}\"/>"
echo "<item label=\"wm - ${wm}\"/>"
echo "</openbox_pipe_menu>"
