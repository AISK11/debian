#!/bin/bash

## This script install audio control packages:

## Install audio control:
apt install alsa-utils -y &> /dev/null &&

## To fix mic issue:
apt install pulseaudio -y &> /dev/null &&
echo -e "\n[+] Audio control packages were installed." || echo -e "\n[-] ERROR! Audio control packages could not be installed!"
