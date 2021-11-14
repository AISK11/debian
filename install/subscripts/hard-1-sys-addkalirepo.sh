#!/bin/bash

## Author AISK
## Description: This script adds kali repository.
## Date Created: November 14, 2021
## Last Updated: November 14, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "### Add Kali repository###"
echo -e   "##########################"

## Add kali repository:
apt install gnupg -y &> /dev/null &&
echo -e "[+]   Package 'gnupg' installed." || echo -e "[-] ! ERROR! Package 'gnupg' could not be installed!"

## Add kali repository to debian sources:
bash -c 'echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list' &&
echo -e "[+]   Kali repository added to '/etc/apt/sources.list'." || echo -e "[-] ! ERROR! Could not add kali repository to '/etc/apt/sources.list'!"

## Add kali key for kali repo:
wget 'https://archive.kali.org/archive-key.asc' &> /dev/null &&
apt-key add "./archive-key.asc" &> /dev/null &&
rm "./archive-key.asc" &&
echo -e "[+]   Added kali key from 'https://archive.kali.org/archive-key.asc'." || echo -e "[-] ! ERROR! Could not add kali key from 'https://archive.kali.org/archive-key.asc'!"

## Assign low prio to kali pkgs:
touch '/etc/apt/preferences' &&
echo "Package: *" > '/etc/apt/preferences' &&
echo "Pin: release a=kali-rolling" >> '/etc/apt/preferences' &&
echo "Pin-Priority: 50" >> '/etc/apt/preferences' &&
echo -e "[+]   Assigned low priority (50) for kali packages in '/etc/apt/preferences'." || echo -e "[-]   Low priority (50) could not be assigned for kali packages in '/etc/apt/preferences'!"

## Script end banner:
echo -e   "##########################"
