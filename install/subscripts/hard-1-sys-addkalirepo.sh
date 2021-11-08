#!/bin/bash

## This script adds kali repository.

## Add kali repository:
apt install gnupg -y &> /dev/null &&
bash -c 'echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list' &&
wget 'https://archive.kali.org/archive-key.asc' &> /dev/null &&
apt-key add "./archive-key.asc" &> /dev/null &&
## Assign low prio to kali pkgs:
touch '/etc/apt/preferences' &&
echo "Package: *" > '/etc/apt/preferences' &&
echo "Pin: release a=kali-rolling" >> '/etc/apt/preferences' &&
echo "Pin-Priority: 50" >> '/etc/apt/preferences' &&
rm "./archive-key.asc" &&
echo -e "\n[+] Kali repository added!" || echo -e "\n[-] ERROR! Kali repository could not be added!"
