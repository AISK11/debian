#!/bin/bash

# Author: AISK11
# Description: This script shows Nvidia GPU utilization in percentage and temperature in degree Celsius.
# Created for: i3blocks
# Dependencies: nvidia-smi inux-headers-amd64 nvidia-driver firmware-misc-nonfree

GPU_UTIL=$(nvidia-smi | grep "Default" | awk '{print $13}' | tr -d "%")
GPU_TEMP=$(nvidia-smi | grep "Default" | awk '{print $3}' | tr -d "C")

# Add leading space in front of variable:
if [ ${#GPU_UTIL} -eq 1 ]; then
    GPU_UTIL="  ${GPU_UTIL}"
elif [ ${#GPU_UTIL} -eq 2 ]; then
    GPU_UTIL=" ${GPU_UTIL}"
fi 

if [ ${#GPU_TEMP} -eq 1 ]; then
    GPU_TEMP="  ${GPU_TEMP}"
elif [ ${#GPU_TEMP} -eq 2 ]; then
    GPU_TEMP=" ${GPU_TEMP}"
fi 

echo "${GPU_UTIL}% ${GPU_TEMP}C"
echo "${GPU_UTIL}% ${GPU_TEMP}C"

# Color:
if [ ${GPU_TEMP} -lt 70 ]; then
    echo "#4BFF57"
elif [ ${GPU_TEMP} -lt 80 ]; then
    echo "#FFFF4A"  
elif [ ${GPU_TEMP} -lt 90 ]; then
    echo "#FF994A" 
else
    echo "#FF4A4A"
fi
