#!/bin/bash

## This script install Xorg and xinit to be able to execute WM or DE:

## Install xorg and xinit packages:
apt install xorg x11-xserver-utils xinit -y &>/dev/null &&
echo -e "[+] Xorg installed." || echo -e "[-] ERROR! Xorg was not installed successfully!"
