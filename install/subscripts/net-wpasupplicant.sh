#!/bin/bash

## Author AISK
## Description: This script sets up WPA_SUPPLICANT for use.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###   WPA Supplicant   ###"
echo -e   "##########################"

## Install wpasupplicant package with additional wireless tools:
apt install wpasupplicant wireless-tools -y &> /dev/null &&
echo -e "[+]   Packages 'wpasupplicant' and 'wireless-tools' were installed." || echo -e "[-] ! ERROR! Could not install packages 'wpasupplicant' and 'wireless-tools'!"

## Copy wpa_supplicant template to right location:
cp ../config_files/WI-FI/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "[+]   WPA Supplicant configuration file copied to '/etc/wpa_supplicant/wpa_supplicant.conf'." || echo -e "[-] ! ERROR! WPA Supplicant configuration file could not be copied to '/etc/wpa_supplicant/wpa_supplicant.conf'!"

## Change rights for file to be unreadable by normal users:
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "[+]   File permission 0600 were applied for file '/etc/wpa_supplicant/wpa_supplicant.conf'." || echo -e "[-] ERROR! File permission 0600 could not be applied for file '/etc/wpa_supplicant/wpa_supplicant.conf'!"

## Script end banner:
echo -e   "##########################"
