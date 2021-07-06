#!/bin/bash

# Author: AISK11
# Description: This script will decrease screen brightness by 10%, but prevent 0% brightness.
# Created for: ~/.config/i3/config:
# bindsym XF86MonBrightnessUp exec xbacklight -inc 10
# bindsym XF86MonBrightnessDown exec ~/.config/i3/scripts/i3_brightness_decrease.sh
# Dependencies: xbacklight

if [ "$(xbacklight -get | cut -d'.' -f1)" -le "10" ]
then
    xbacklight -set 1
else
    xbacklight -dec 10
fi
