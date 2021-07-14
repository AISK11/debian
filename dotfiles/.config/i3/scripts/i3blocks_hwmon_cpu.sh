#!/bin/bash

# Author: AISK11
# Description: This script shows CPU utilization in percentage.
# Created for: i3blocks
# Dependencies: sysstat

USAGE=$((10000 - $(mpstat 1 1 | tail -n 1 | rev | cut -d' ' -f1 | rev | tr -d .)))
#USAGE=$((10000 - $(mpstat 1 1 | tail -n 1 | awk '{print $13}' | tr -d '.'))) #more effective, cannot be used as awk cant see output after 1 second

USAGE1=$((${USAGE} / 100))
USAGE2=$((${USAGE} % 100))

# Add leading space in front of variable:
if [ ${#USAGE1} -eq 1 ]; then
    USAGE1="  ${USAGE1}"
elif [ ${#USAGE1} -eq 2 ]; then
    USAGE1=" ${USAGE1}";
fi

if [ ${#USAGE2} -eq 1 ]; then
    USAGE2="0${USAGE2}"
fi

echo "${USAGE1}.${USAGE2}%"
echo "${USAGE1}.${USAGE2}%"

# Color:
if [ ${USAGE1} -lt 50 ]; then
    echo "#4BFF57"
elif [ ${USAGE1} -lt 75 ]; then
    echo "#FFFF4A"  
elif [ ${USAGE1} -lt 90 ]; then
    echo "#FF994A" 
else
    echo "#FF4A4A"
fi

# grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'
