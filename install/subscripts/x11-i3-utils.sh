#!/bin/bash

## Author AISK
## Description: This script install other X11 i3 utilities.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###      X11 utils     ###"
echo -e   "##########################"

## Install X11 i3 utilities:
apt install i3blocks i3lock numlockx rofi feh scrot compton light xclip lxappearance -y &> /dev/null &&
echo -e "[+]   Packages 'i3blocks i3lock numlockx rofi feh scrot compton light xclip lxappearance' were installed." || echo -e "[-] ! ERROR! Packages 'i3blocks i3lock numlockx rofi feh scrot compton light xclip lxappearance' could not be installed!"

## Script end banner:
echo -e   "##########################"
