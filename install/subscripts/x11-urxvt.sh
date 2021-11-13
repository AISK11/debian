#!/bin/bash

## Author AISK
## Description: This script installs URXVT Terminal emulator and set it as default Terminal emulator.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###        URXVT       ###"
echo -e   "##########################"

## Install URXVT Terminal emulator:
apt install rxvt-unicode-256color -y &> /dev/null &&
echo -e "[+]   Package 'rxvt-unicode-256color' was installed." || echo -e "[-] ! ERROR! Package 'rxvt-unicode-256color' could not be installed!"

## Set URXVT as default Termianl Emulator:
update-alternatives --set x-terminal-emulator /usr/bin/urxvt &> /dev/null &&
echo -e "[+]   URXVT was set as default x-terminal-emulator." || echo -e "[-] ! ERROR! Could not set URXVT as default x-terminal-emulator!"

## Script end banner:
echo -e   "##########################"
