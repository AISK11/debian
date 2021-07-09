#!/bin/bash

# Author: AISK11
# Description: This script shows utilization for "/" directory.
# Created for: i3blocks

USED_SPACE=$(df -m 2> /dev/null | grep "/$" | egrep -o "[0-9]*%" | tr -d "%")

echo "${USED_SPACE}%"
echo "${USED_SPACE}%"

# Color:
if [ ${USED_SPACE} -lt 70 ]; then
    echo "#4BFF57"
elif [ ${USED_SPACE} -lt 80 ]; then
    echo "#FFFF4A"  
elif [ ${USED_SPACE} -lt 90 ]; then
    echo "#FF994A" 
else
    echo "#FF4A4A"
fi
