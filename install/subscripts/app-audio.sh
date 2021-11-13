#!/bin/bash

## Author AISK
## Description: This script install audio control packages.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

echo -e "\n##########################"
echo -e   "###        Audio       ###"
echo -e   "##########################"

## Install audio control:
apt install alsa-utils -y &> /dev/null &&
echo -e "[+]   Package 'alsa-utils' was installed." || echo -e "[-] ! ERROR! Package 'alsa-utils' could not be installed!"

## To fix mic issue:
apt install pulseaudio -y &> /dev/null &&
echo -e "[+]   Package 'pulseaudio' was installed (to fix mic issues)." || echo -e "[-] ! ERROR! Package 'pulseaudio' could not be installed (Mic issues can appear)!"

## Script end banner:
echo -e   "##########################"
