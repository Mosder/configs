#!/usr/bin/bash

WALLPAPER_DIR_2K="$HOME/wallpapers/2k"
WALLPAPER_DIR_HD="$HOME/wallpapers/hd"

# Get random wallpapers
WALLPAPER_2K=$(find $WALLPAPER_DIR_2K -type f | shuf -n 1)
WALLPAPER_HD=$(find $WALLPAPER_DIR_HD -type f | shuf -n 1)

# Create symlinks to new random wallpapers
SYMLINK_2K=$WALLPAPER_DIR_2K/.current
SYMLINK_HD=$WALLPAPER_DIR_HD/.current
rm $SYMLINK_2K
rm $SYMLINK_HD
ln -s $WALLPAPER_2K $SYMLINK_2K
ln -s $WALLPAPER_HD $SYMLINK_HD
