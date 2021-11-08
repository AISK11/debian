#!/bin/bash

## This script sets up WPA_SUPPLICANT for use.

## Install wpasupplicant package with additional wireless tools:
apt install wpasupplicant wireless-tools -y &> /dev/null &&
## Copy wpa_supplicant template to right location:
cp ./files/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf &&
## Change rights for file to be unreadable by normal users:
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "[+] Installed and set up wpasupplicant template in '/etc/wpa_supplicant/wpa_supplicant.conf'." || echo -e "[-] ERROR! Could not install 'wpasupplicant' or set up template file '/etc/wpa_supplicant/wpa_supplicant.conf'!"
