#!/bin/bash

#################################################
# Script to autoconfigure my settings fo debian #
# Author: AISK11                                #
#################################################
## Fresh debian install required without DE!
## Execute this script with root privileges!

## EDIT VARIABLES:
USER="changeme" # CHANGE! e.g. 'aisk'
HOSTNAME="$(hostname)"
DNSDOMAINNAME="" # e.g. "net" -> HOSTNAME.net
TIMEZONE="Europe/Copenhagen"
HOME="/home/${USER}"
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin"

ISVIRTUAL=0 # CHANGE if this is a virtual machine!

## Check if valid USER variable was set.
if [[ "${USER}" = "changeme" ]]; then
    echo "You need to change variable for USER!"
    exit 1
## If exists, $? returns 0, otherwise returns 1:
elif ! $(id "${USER}" &>/dev/null); then
    echo "User '${USER}' does not exists!"
    exit 1
fi


#####################
# POST-INSTALLATION #
#####################
## Disable speaker bell:
bash ./subscripts/system-disable-pcspkr.sh

## Add contrib and non-free packages to debian:
bash ./subscripts/system-packages-nonfree.sh

## Update system:
bash ./subscripts/system-update.sh

#####################
#       GRUB        #
#####################
## Set up GRUB Bootloader:
bash ./subscripts/system-grub.sh

#####################
#   Local Settings  #
#####################
## Set up local settings:
## Hostname
## DNSDomainname
## Timezone
## Locale
## CLI Keyboard
bash ./subscripts/system-settings.sh "${HOSTNAME}" "${DNSDOMAINNAME}" "${TIMEZONE}"

#####################
#  User Privileges  #
#####################
## Add user to '/etc/doas.conf':
bash ./subscripts/user-privileges-doas.sh "${USER}"

####################
#    NETWORKING    #
####################
## Install iwlwifi driver
## requires 'bash ./subscripts/system-packages-nonfree.sh'
#if [[ "${ISVIRTUAL}" -eq 0 ]]; then
#    bash ./subscripts/driver-network-iwlwifi.sh
#else
#    echo -n "[*] Virtual Machine settings set, skipping installing 'iwlwifi' driver."
#fi



## Disable networking service (is unnecessary):
#systemctl disable networking.service &> /dev/null &&
#echo -e "\n[+] 'networking.service' disabled." || echo -e "\n[-] ERROR! Could not disable 'networking.service'!"

## Block bluetooth and unblock WiFi:
#apt install rfkill -y &&
#rfkill block bluetooth &&
#rfkill unblock wlan &&
# dpkg --purge bluez bluetooth &&
#echo -e "\n[+] Bluetooth was blocked and WiFi unblocked." || echo -e "\n[-] Error while setting up rfkill!"






