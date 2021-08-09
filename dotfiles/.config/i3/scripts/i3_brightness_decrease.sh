#!/bin/bash

# Author: AISK11
# Description: This script will decrease screen brightness by 10%, but prevent 0% brightness.
# Created for: ~/.config/i3/config:
# bindsym XF86MonBrightnessUp exec doas light -A 10
# bindsym XF86MonBrightnessDown exec ~/.config/i3/scripts/i3_brightness_decrease.sh
# Dependencies: light

if [ "$(light -G | cut -d '.' -f 1)" -le "10" ]
then
    doas light -S 1
else
    doas light -U 10
fi
