#!/bin/bash

## Author AISK
## Description: This script sets up rfkill (it unblocks wlan (wi-fi) and blocks bluetooth.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###   Configure GRUB   ###"
echo -e   "##########################"

## Install rfkill:
apt install rfkill -y &> /dev/null &&
echo -e "[+]   Package 'rfkill' installed." || echo -e "[-] ! ERROR! Package 'rfkill' could not be installed!"

## Block all wireless tehnologies except for Wi-Fi:
rfkill block bluetooth fm gps nfc uwb wimax wwan &&
echo -e "[+]   Following wireless technologies were blocked: bluetooth, fm, gps, nfc, uwb, wimax, wwan." || echo -e "[-] ! ERROR! Could not block one or more of the following tehcnologies: bluetooth, fm, gps, nfc, uwb, wimax, wwan."

## Unblock Wi-Fi
rfkill unblock wlan &&
echo -e "[+]   Wi-Fi (wlan) were unblocked." || echo -e "[-] ! ERROR! Wi-Fi (wlan) could not be unblocked!"

## Script end banner:
echo -e   "##########################"
