#!/bin/bash

# get size and offset of active window
size=$(hyprctl activewindow | grep size: | awk -F" " '{print $2}')
size=${size/,/x}
offset=$(hyprctl activewindow | grep at: | awk -F" " '{print $2}')
offset=${offset/,/+}

# open gui with selected region
flameshot gui --region $size+$offset
