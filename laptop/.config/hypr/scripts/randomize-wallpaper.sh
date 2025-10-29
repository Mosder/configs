#!/usr/bin/bash

WALLPAPER_DIR="$HOME/wallpapers"

# Get a random wallpaper
WALLPAPER=$(find $WALLPAPER_DIR -type f | shuf -n 1)

# Create a symlink to the new random wallpaper
SYMLINK=$WALLPAPER_DIR/.current
rm $SYMLINK
ln -s $WALLPAPER $SYMLINK
