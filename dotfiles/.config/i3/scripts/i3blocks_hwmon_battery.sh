#!/bin/bash

# Author: AISK11
# Description: This script shows Battery energy in percentage and state.
# Created for: i3blocks
# Dependencies: acpi fonts-font-awesome

BATTERY=$(acpi -b | egrep -o "[0-9]{1,3}%" | tr -d "%")
STATUS=$(acpi -b | awk '{print $3}')

if [ "${STATUS}" = "Discharging," ]; then
    STATUS=" "
else
    STATUS=""
fi


# Add leading space in front of variable:
if [ ${#BATTERY} -eq 1 ]; then
    BATTERY="  ${BATTERY}"
elif [ ${#BATTERY} -eq 2 ]; then
    BATTERY=" ${BATTERY}";
fi

if [ ${#USAGE2} -eq 1 ]; then
    BATTERY=" ${BATTERY}"
fi

# Color:
if [ ${BATTERY} -gt 50 ]; then
    echo " ${BATTERY}% ${STATUS}"
    echo " ${BATTERY}% ${STATUS}"
    echo "#4BFF57"
elif [ ${BATTERY} -gt 30 ]; then
    echo " ${BATTERY}% ${STATUS}"
    echo " ${BATTERY}% ${STATUS}"
    echo "#FFFF4A"  
elif [ ${BATTERY} -gt 15 ]; then
    echo " ${BATTERY}% ${STATUS}"
    echo " ${BATTERY}% ${STATUS}"
    echo "#FF994A" 
else
    echo " ${BATTERY}% ${STATUS}"
    echo " ${BATTERY}% ${STATUS}"

    echo "#FF4A4A"
fi
