#!/bin/bash

##################################################################
# Author: AISK11

# Packages installed:
# sudo apt install scrot xclip
# Description: This script make png print screen in ${DIRECTORY} with time as a name.
# Created for: ~/.config/i3/config:
# bindsym Print exec ~/.config/i3/scripts/i3_prtsc.sh
##################################################################

DIRECTORY="/home/$(whoami)/.screenshots/"
FILENAME="$(date '+%Y-%m-%d_%H:%M:%S').png"

if [[ ! -d ${DIRECTORY} ]]; then
    mkdir -p ${DIRECTORY} 
fi

if [[ "$1" = "-p" ]]; then
    scrot --silent --pointer ${DIRECTORY}${FILENAME}
else
    scrot --silent ${DIRECTORY}${FILENAME}
fi

# select print screened image to clipboard:
xclip -selection clipboard -target image/png -i ${DIRECTORY}${FILENAME} 
