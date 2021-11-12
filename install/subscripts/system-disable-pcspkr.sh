#!/bin/bash

## Author AISK
## Description: This script disables pcspkr (that annoying debian beeping).
## Date Created: November 12, 2021
## Last Updated: November 12, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###   Disable pcspkr   ###"
echo -e   "##########################"

### 1. Disable speaker bell for CLI (but still enabled for vim, etc...):
sed -i "s/^# set bell-style none/set bell-style none/" /etc/inputrc &&
echo -e "[+]   Disabled bell-style for CLI in '/etc/inputrc'." || echo -e "[-] ! ERROR! Could not disable bell-style for CLI in '/etc/inputrc'!"

### 2. Blacklist pcspkr module for the whole system:
## If file does not exists:
if [[ ! -e /etc/modprobe.d/blacklist.conf ]]; then
    echo -e "blacklist pcspkr" > /etc/modprobe.d/blacklist.conf &&
    echo -e "[+]   Successfully added pcspkr to '/etc/modprobe.d/blacklist.conf'." || echo -e "[-] ! ERROR! Could not add pcspkr to '/etc/modprobe.d/blacklist.conf'!"
## This file should not be directory:
elif [[ -d /etc/modprobe.d/blacklist.conf ]]; then
    rm -rf /etc/modprobe.d/blacklist.conf
    echo -e "blacklist pcspkr" > /etc/modprobe.d/blacklist.conf &&
    echo -e "[+]   Successfully added pcspkr to '/etc/modprobe.d/blacklist.conf'." || echo -e "[-] ! ERROR! Could not add pcspkr to '/etc/modprobe.d/blacklist.conf'!"
## If file exists, but does not contain "blacklist pcspkr":
## Note: grep returns 1 if does not find match:
elif grep "^blacklist pcspkr$"; then
    echo -e "blacklist pcspkr" >> /etc/modprobe.d/blacklist.conf &&
    echo -e "[+]   Successfully added pcspkr to '/etc/modprobe.d/blacklist.conf'." || echo -e "[-] ! ERROR! Could not add pcspkr to '/etc/modprobe.d/blacklist.conf'!"
fi

### 3. Generate modules.dep and update initramfs:
depmod -a 1> /dev/null &&
update-initramfs -u 1> /dev/null &&
echo -e "[+]   Updated initramfs with blacklisted pcspkr module." || echo -e "[-] ! ERROR! Could not update initramfs with blacklisted pcspkr module!"

## Script end banner:
echo -e   "##########################"

