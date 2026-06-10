#!/bin/bash

ITERS=3

# get address of the window to return to
address=$(hyprctl activewindow | awk -F" " 'NR==1 {print $2}')

# define move directions
dir1=$1
dir2=r
if [[ $dir1 == u ]]; then
	dir2=d
fi

# move max to the left/top
prev_window=""
window=$(hyprctl activewindow | awk -F" " 'NR==1 {print $2}')
while [[ $window != $prev_window ]]; do
	hyprctl dispatch movefocus $dir1
	prev_window=$window
	window=$(hyprctl activewindow | awk -F" " 'NR==1 {print $2}')
done

# get start location
at=$(hyprctl activewindow | awk -F" " 'NR==4 {print $2}')
if [[ $dir1 == l ]]; then
	start_location=$(echo $at | awk -F"," '{print $1}')
else
	start_location=$(echo $at | awk -F"," '{print $2}')
fi

# count windows in the line
window_count=0
prev_window=""
while [[ $window != $prev_window ]]; do
	hyprctl dispatch movefocus $dir2
	prev_window=$window
	window=$(hyprctl activewindow | awk -F" " 'NR==1 {print $2}')
	window_count=$(($window_count+1))
done

# get end location
at=$(hyprctl activewindow | awk -F" " 'NR==4 {print $2}')
size=$(hyprctl activewindow | awk -F" " 'NR==5 {print $2}')
if [[ $dir1 == l ]]; then
	at=$(echo $at | awk -F"," '{print $1}')
	size=$(echo $size | awk -F"," '{print $1}')
else
	at=$(echo $at | awk -F"," '{print $2}')
	size=$(echo $size | awk -F"," '{print $2}')
fi
end_location=$(($at+$size))

# calculate full size and size per window
full_size=$(($end_location - $start_location))
size_per_window=$(($full_size / $window_count))

# set sizes
i=0
while [[ $i -lt $ITERS ]]; do
	i=$(($i+1))
	window=0
	while [[ $window -lt $window_count ]]; do
		window=$(($window+1))
		size=$(hyprctl activewindow | awk -F" " 'NR==5 {print $2}')
		if [[ $dir1 == l ]]; then
			#other_side=$(echo $size | awk -F"," '{print $2}')
			#hyprctl dispatch resizeactive exact $size_per_window $other_side
			size=$(echo $size | awk -F"," '{print $1}')
			diff=$(($size_per_window - $size))
			hyprctl dispatch resizeactive $diff 0
		else
			#other_side=$(echo $size | awk -F"," '{print $1}')
			#hyprctl dispatch resizeactive exact $other_side $size_per_window
			size=$(echo $size | awk -F"," '{print $2}')
			diff=$(($size_per_window - $size))
			hyprctl dispatch resizeactive 0 $diff
		fi
		hyprctl dispatch movefocus $dir1
	done
	temp=$dir1
	dir1=$dir2
	dir2=$temp
done

# return to starting window
hyprctl dispatch focuswindow address:0x$address
