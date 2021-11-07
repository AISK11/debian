#!/bin/bash

## This script disables pcspkr (that annoying debian beeping).

### blacklist pcspkr module:
## If file does not exists:
if [[ ! -e /etc/modprobe.d/blacklist.conf ]]; then
    echo -e "blacklist pcspkr" > /etc/modprobe.d/blacklist.conf
## This file should not be directory:
elif [[ -d /etc/modprobe.d/blacklist.conf ]]; then
    rm -rf /etc/modprobe.d/blacklist.conf
    echo -e "blacklist pcspkr" > /etc/modprobe.d/blacklist.conf
## If file exists, but does not contain "blacklist pcspkr":
## grep returns 1 if does not find match:
elif grep "^blacklist pcspkr$"; then
    echo -e "blacklist pcspkr" >> /etc/modprobe.d/blacklist.conf
fi

### Disable speaker bell:
sed -i "s/^# set bell-style none/set bell-style none/" /etc/inputrc &&

### Generate modules.dep and map files:
depmod -a &> /dev/null &&
update-initramfs -u &> /dev/null &&
echo -e "\n[+] pcspkr disabled." || echo -e "\n[-] ERROR! pcspkr could not be disabled!"
