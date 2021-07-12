#!/bin/bash

# Author: AISK11
# Description: This script shows MICrophone usage and volume.
# Created for: i3blocks
# Dependencies: alsa

MIC_STATUS=$(amixer get Capture | tail -n 1 | grep -w -o "on\|off")

if [ "${MIC_STATUS}" = "off" ]; then
    echo " off"
    echo " off"
    echo "#FFFFFF"
else
    MIC_VOLUME=$(amixer get Capture | tail -n 1 | egrep -o "[0-9]{1,3}%" | tr -d "%" )
    # Add leading space in front of variable:
    if [ ${#MIC_VOLUME} -eq 1 ]; then
        MIC_VOLUME="  ${MIC_VOLUME}"
    elif [ ${#MIC_VOLUME} -eq 2 ]; then
        MIC_VOLUME=" ${MIC_VOLUME}";
    fi
    echo "${MIC_VOLUME}%"
    echo "${MIC_VOLUME}%"
    echo "#FF4A4A"
fi
