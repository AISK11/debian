#!/bin/bash

# Author: AISK11
# Description: This script shows audio usage and volume.
# Created for: i3blocks
# Dependencies: alsa

AUDIO_STATUS=$(amixer get Master | tail -n 1 | grep -w -o "on\|off")

if [ "${AUDIO_STATUS}" = "off" ]; then
    echo " off"
    echo " off"
    echo "#FF4A4A"
else
    AUDIO_VOLUME=$(amixer get Master | tail -n 1 | egrep -o "[0-9]{1,3}%" | tr -d "%")
    # Add leading space in front of variable:
    if [ ${#AUDIO_VOLUME} -eq 1 ]; then
        AUDIO_VOLUME="  ${AUDIO_VOLUME}"
    elif [ ${#AUDIO_VOLUME} -eq 2 ]; then
        AUDIO_VOLUME=" ${AUDIO_VOLUME}";
    fi
    echo "${AUDIO_VOLUME}%"
    echo "${AUDIO_VOLUME}%"
    echo "#FFFFFF"    
fi
