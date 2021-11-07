#!/bin/bash

#################################################
# Script to autoconfigure my settings fo debian #
# Author: AISK11                                #
#################################################
## Fresh debian install required without DE!
## Execute this script with root privileges!

## EDIT VARIABLES:
USER="changeme" # CHANGE
HOSTNAME="$(hostname)"
DNSDOMAINNAME="" # e.g. "net" -> HOSTNAME.net
TIMEZONE="Europe/Copenhagen"
HOME="/home/${USER}"
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin"

if [[ "${USER}" = "changeme" ]]; then
    echo "You need to change variable for USER!"
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

