#!/bin/bash

if [[ $1 == "--status" ]]; then
	if [[ $(dunstctl is-paused) == "true" ]]; then
		echo ""
	else
		echo ""
	fi
elif [[ $1 == "--toggle" ]]; then
	dunstctl set-paused toggle
fi
