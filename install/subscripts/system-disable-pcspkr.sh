#!/bin/bash

## This script disables pcspkr (that annoying debian beeping).

## Disable speaker bell:
echo -e "set bell-style none" >> /etc/inputrc &&
echo -e "blacklist pcspkr" > /etc/modprobe.d/blacklist.conf &&
depmod -a &> /dev/null &&
update-initramfs -u &> /dev/null &&
echo -e "\n[+] pcspkr disabled." || echo -e "\n[-] ERROR! pcspkr could not be disabled!"
