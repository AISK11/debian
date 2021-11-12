#!/bin/bash

## Author AISK
## Description: This script adds specified user to '/etc/doas.conf' file.
## Date Created: November 12, 2021
## Last Updated: November 12, 2021

### Usage:
## ./user-privileges-doas.sh <USER>


### Global properties:
USER="${1}"


## Script start banner:
echo -e "\n##########################"
echo -e   "###   User Privileges  ###"
echo -e   "##########################"

## Install doas package:
apt install doas -y &> /dev/null &&
echo -e "[+]   Package 'doas' was installed." || echo -e "[-] ! ERROR! Package 'doas' could not be installed!"

## If no user was specified, create clean '/etc/doas.conf' and exit:
if [[ -z ${1} ]]; then
    echo "" > /etc/doas.conf
    echo -e "[*]   No user was specified, skipping."
    exit
fi

## If user was specified, add user to '/etc/doas.conf':
echo -e "## <permit|deny> [nopass|persist] <USER>[:GROUP] [as <USER2>][cmd <COMMAND> [args <ARGUMENTS>]" > /etc/doas.conf &&
echo -e "permit nopass ${USER}" >> /etc/doas.conf &&
echo -e "[+]   User '${USER}' added to '/etc/doas.conf'." || echo -e "[-] ! ERROR! User '${USER}' could not be added to '/etc/doas.conf'!"

## Script end banner:
echo -e   "##########################"

