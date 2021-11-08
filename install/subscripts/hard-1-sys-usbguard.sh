#!/bin/bash

## This script installs USB Guard.

## Install USB Guard:
apt install usbguard -y &> /dev/null &&
systemctl enable usbguard.service &> /dev/null &&
echo -e "\n[+] USB Guard installed." || echo -e "\n[-] ERROR! USB Guard could not be installed!"
