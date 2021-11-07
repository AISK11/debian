#!/bin/bash

### Usage:
## ./user-privileges-doas.sh <USER>

##This script adds specified user to '/etc/doas.conf' file.

### Global properties:
USER="${1}"


## Install doas package:
apt install doas -y &> /dev/null &&
echo -e "\n[+] Package 'doas' was installed." || echo -e "\n[-] ERROR! Package 'doas' could not be installed!"

## If no user was specified, create clean '/etc/doas.conf' and exit:
if [[ -z ${1} ]]; then
    echo "" > /etc/doas.conf
    echo -e "[*] No user was specified, skipping."
    exit
fi

## If user was specified, add user to '/etc/doas.conf':
echo -e "permit nopass ${USER}" > /etc/doas.conf &&
echo -e "\n[+] User '${USER}' added to '/etc/doas.conf'." || echo -e "\n[-] ERROR! User '${USER}' could not be added to '/etc/doas.conf'!"
