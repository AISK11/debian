#!/bin/bash

##################################################################
# Author: AISK11

# Packages installed:
# sudo apt install doas macchanger wpa_supplicant dhcpcd
# Usage: this is personal script that run wlan0 interface and require additional config to work
##################################################################

doas rfkill unblock wlan
doas macchanger -Ab wlan0
doas rm -rf /var/lib/dhcpcd/*
doas ip l set wlan0 up
doas systemctl start wpa_supplicant.service
doas systemctl start dhcpcd.service
doas wpa_supplicant -B -D wext -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
doas dhcpcd wlan0
