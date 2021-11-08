#!/bin/bash

## This script installs URXVT Terminal emulator and set it as default Terminal emulator.

## Install URXVT Terminal emulator:
apt install rxvt-unicode-256color -y &> /dev/null &&
## Set URXVT as default Termianl Emulator:
update-alternatives --set x-terminal-emulator /usr/bin/urxvt &> /dev/null &&
echo -e "\n[+] 'rxvt-unicode-256color' installed and set as default X-terminal." || echo -e "\n[-] ERROR! Either 'rxvt-unicode-256color' was not installed or was not set as default terminal emulator!"
