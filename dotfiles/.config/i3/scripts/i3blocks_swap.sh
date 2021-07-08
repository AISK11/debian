#!/bin/bash

# Author: AISK11
# Description: This script shows how much SWAP is used in percentage.
# Created for: i3blocks

SWAP_TOTAL=$(free -k | grep -i "swap" | tr -s " " | cut -d" " -f2)
SWAP_USED=$(free -k | grep -i "swap" | tr -s " " | cut -d" " -f3)

PERCENTAGE=$((SWAP_USED * 100 / SWAP_TOTAL))

# Add leading space in front of variable:
if [ ${#PERCENTAGE} -eq 1 ]; then
    PERCENTAGE="  ${PERCENTAGE}"
elif [ ${#PERCENTAGE} -eq 2 ]; then
    PERCENTAGE=" ${PERCENTAGE}";
fi

echo "${PERCENTAGE}"
echo "${PERCENTAGE}"

# Color
if [[ ${PERCENTAGE} -lt 33 ]]; then
    echo "#4BFF57"
elif [[ ${PERCENTAGE} -lt 66 ]]; then
    echo "#FFFF4A" 
elif [[ ${PERCENTAGE} -lt 90 ]]; then
    echo "#FF994A" 
else
    echo "#FF4A4A"
fi
