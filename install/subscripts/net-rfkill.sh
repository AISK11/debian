#!/bin/bash

## This script sets up rfkill (it unblocks wlan (wi-fi) and blocks bluetooth.

apt install rfkill -y &> /dev/null &&
rfkill block bluetooth uwb wimax wwan gps fm nfc &&
rfkill unblock wlan &&
#dpkg --purge bluez bluetooth &&
echo -e "\n[+] Rfkill set up." || echo -e "\n[-] ERROR! Rfkill could not be set up!"
