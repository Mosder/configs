#!/usr/bin/bash

WALLPAPER_DIR="$HOME/wallpapers"

# Get random wallpapers
WALLPAPER_MAIN=$(find $WALLPAPER_DIR -type f | shuf -n 1)
WALLPAPER_SECOND=$(find $WALLPAPER_DIR -type f | shuf -n 1)

# Create symlinks to new random wallpapers
SYMLINK_MAIN=$WALLPAPER_DIR/.current_main
SYMLINK_SECOND=$WALLPAPER_DIR/.current_second
rm $SYMLINK_MAIN
rm $SYMLINK_SECOND
ln -s $WALLPAPER_MAIN $SYMLINK_MAIN
ln -s $WALLPAPER_SECOND $SYMLINK_SECOND
