#!/bin/bash

s=$(brightnessctl | grep % | awk -F" " '{print $4}')
echo ${s:1:-2}
