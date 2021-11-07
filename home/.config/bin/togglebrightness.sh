#!/bin/bash
BRIGHT=$(light | awk '{print int($1+0.5)}')
if [[ "$BRIGHT" = "100" ]]; then
	light -S 0
else 
	light -S 100
fi
