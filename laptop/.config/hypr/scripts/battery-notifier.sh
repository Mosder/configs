#!/bin/bash

while true; do
	# get battery status
	acpi_info=$(acpi)
	stat=$(echo $acpi_info | awk -F" " '{print $3}')
	stat=${stat::-1}
	perc=$(echo $acpi_info | awk -F" " '{print $4}')
	perc=${perc::-2}

	# check if battery is discharging
	if [[ $stat == Discharging ]]; then
		# send notification if low power
		if [[ $perc -le 15 ]]; then
			notify-send -a Battery BATTERY\ CRITICAL\  -h int:value:$perc -u critical
		elif [[ $perc -le 30 ]]; then
			notify-send -a Battery Battery\ low\  -h int:value:$perc
		fi
	fi

	# calculate time until next check using interpolating polynomial
	#  of points (battery %, time [s] until next check):
	# 	(100, 600)
	# 	(50, 120)
	# 	(30, 60)
	# 	(15, 30)
	# 	(0, 0)
	x1=$(echo "scale=10; 188/85*$perc" | bc)
	x2=$(echo "scale=10; -603/29750*$perc*$perc" | bc)
	x3=$(echo "scale=10; 113/297500*$perc*$perc*$perc" | bc)
	x4=$(echo "scale=10; 3/1487500*$perc*$perc*$perc*$perc" | bc)
	sleep_time=$(echo $x1+$x2+$x3+$x4 | bc | awk -F"." '{print $1}')

	# sleep for calculated time
	sleep $sleep_time
done
