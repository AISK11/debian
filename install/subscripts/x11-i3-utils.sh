#!/bin/bash

## This script install other X11 i3 utilities.

## Install X11 i3 utilities:
apt install i3blocks i3lock numlockx rofi feh scrot compton light xclip lxappearance -y &> /dev/null &&
echo -e "\n[+] i3 utilities were installed." || echo -e "\n[-] ERROR! i3 utilities could not be installed!"
