#!/bin/bash

ZOOM=$(hyprctl getoption cursor:zoom_factor | grep float | awk -F" " '{print $2}')
ZOOM=$(echo "scale=0; ($ZOOM+1)/1" | bc)
if [[ $ZOOM -gt $MAX_ZOOM ]]; then
	ZOOM=1
fi

hyprctl -q keyword cursor:zoom_factor $ZOOM
