#!/bin/bash

# Author: AISK11
# Description: This script shows Battery energy in percentage and state.
# Created for: i3blocks
# Dependencies: acpi

BATTERY=$(acpi -b | egrep -o "[0-9]{1,3}%" | tr -d "%")
STATUS=$(acpi -b | awk '{print $3}')

if [ "${STATUS}" = "Charging," ]; then
    STATUS="+"
else
    STATUS="-"
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

echo "${BATTERY}% ${STATUS}"
echo "${BATTERY}% ${STATUS}"

# Color:
if [ ${BATTERY} -gt 50 ]; then
    echo "#4BFF57"
elif [ ${BATTERY} -gt 30 ]; then
    echo "#FFFF4A"  
elif [ ${BATTERY} -gt 15 ]; then
    echo "#FF994A" 
else
    echo "#FF4A4A"
fi
