#!/bin/bash

# Author: AISK11
# Description: This script shows how much RAM is used (buff/cache) in percentage.
# Created for: i3blocks

# https://github.com/KittyKatt/screenFetch/issues/386#issuecomment-249312716
# USED_MEM = MemTotal + Shmem - MemFree - Buffers - Cached - SReclaimable
# values are in kb from /proc/meminfo

MemTotal=$(cat /proc/meminfo | grep "MemTotal" | tr -s ' ' | cut -d' ' -f2)
Shmem=$(cat /proc/meminfo | grep "Shmem:" | tr -s ' ' | cut -d' ' -f2)
MemFree=$(cat /proc/meminfo | grep "MemFree" | tr -s ' ' | cut -d' ' -f2)
Buffers=$(cat /proc/meminfo | grep "Buffers" | tr -s ' ' | cut -d' ' -f2)
Cached=$(cat /proc/meminfo | grep "^Cached" | tr -s ' ' | cut -d' ' -f2)
SReclaimable=$(cat /proc/meminfo | grep "SReclaimable" | tr -s ' ' | cut -d' ' -f2)

USED_MEM=$((${MemTotal} + ${Shmem} - ${MemFree} - ${Buffers} - ${Cached} - ${SReclaimable}))
MEM_PERCENTAGE=$((USED_MEM * 100 / MemTotal))


# Debug:
#echo "|${Shmem}|"

# Add leading space in front of variable:
if [ ${#MEM_PERCENTAGE} -eq 1 ]; then
    MEM_PERCENTAGE="  ${MEM_PERCENTAGE}"
elif [ ${#MEM_PERCENTAGE} -eq 2 ]; then
    MEM_PERCENTAGE=" ${MEM_PERCENTAGE}";
fi

echo "${MEM_PERCENTAGE}%"
echo "${MEM_PERCENTAGE}%"

# Color
if [[ ${MEM_PERCENTAGE} -lt 50 ]]; then
    echo "#4BFF57"
elif [[ ${MEM_PERCENTAGE} -lt 75 ]]; then
    echo "#FFFF4A" 
elif [[ ${MEM_PERCENTAGE} -lt 90 ]]; then
    echo "#FF994A" 
else
    echo "#FF4A4A"
fi
