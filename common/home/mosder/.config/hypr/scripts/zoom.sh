#!/bin/bash

ZOOM=$(hyprctl repl 'hl.get_config("cursor.zoom_factor")')
ZOOM=$(echo "scale=0; ($ZOOM+1)/1" | bc)
if [[ $ZOOM -gt $MAX_ZOOM ]]; then
	ZOOM=1
fi

hyprctl -q eval "hl.config({ cursor = { zoom_factor = $ZOOM } })"
