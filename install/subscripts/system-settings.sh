#!/bin/bash

## Author AISK

## Description: This script sets following properties:
## hostname
## dnsdomainname
## timezone
## locale
## CLI keyboard

## Date Created: November 12, 2021
## Last Updated: November 12, 2021

### Usage:
## ./system-settings.sh <HOSTNAME> <DNSDOMAINNAME> <TIMEZONE>
### Example:
## ./system-settings.sh "debian-pc" "" "Europe/Copenhagen"
## ./system-settings.sh "debian-pc" "net" "Europe/Copenhagen"

# Script start banner:
echo -e "\n##########################"
echo -e   "### Set Local Settings ###"
echo -e   "##########################"

### Global properties:
## Set hostname:
if [[ -z ${1} ]]; then
    HOSTNAME="$(hostname)"
else
    HOSTNAME=${1}
fi
## Set dnsdomainname:
DNSDOMAINNAME="${2}"
## Set timezone:
if [[ -z ${3} ]]; then
    TIMEZONE="UTC"
else
    TIMEZONE="${3}"
fi


## Set hostname:
echo -e "${HOSTNAME}" > /etc/hostname &&
sed -i "s/127\.0\.1\.1.*/127\.0\.1\.1\t${HOSTNAME}/g" /etc/hosts &&
echo -e "[+]   Hostname updated with '${HOSTNAME}' in '/etc/hostname' and '/etc/hosts'." || echo -e "[-] ! ERROR! Could not change hostname with '${HOSTNAME}' in '/etc/hostname' and '/etc/hosts'!"

## Set domainname:
if [[ ! -z ${DNSDOMAINNAME} ]]; then
    sed -i "s/${HOSTNAME}/&.${DNSDOMAINNAME} ${HOSTNAME}/g" /etc/hosts &&
    echo -e "[+]   DNSDomainname updated with '${DNSDOMAINNAME}' in '/etc/hosts'." || echo -e "\n[-] ! ERROR! Could not change DNSDomainname with '${DNSDOMAINNAME}' in '/etc/hosts'!"
fi

## Set timezone:
timedatectl set-timezone ${TIMEZONE} 1> /dev/null &&
echo -e "[+]   Timezone '${TIMEZONE}' updated." || echo -e "[-] ! ERROR! Timezone '${TIMEZONE}' could not be changed!"

## Set locale:
echo -e "LANG=en_US.UTF-8" > /etc/default/locale &&
echo -e "# First day in a week MON, not SUN:" >> /etc/default/locale &&
echo -e "#LC_TIME=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo -e "# Default paper size:" >> /etc/default/locale &&
echo -e "#LC_PAPER=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo -e "#LC_MEASUREMENT=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo -e "[+]   Locales updated." || echo -e "[-] ! ERROR! Locales could not be changed!"

## Set CLI keyboard:
echo -e "XKBMODEL=\"pc105\"" > /etc/default/keyboard &&
echo -e "XKBLAYOUT=\"us\"" >> /etc/default/keyboard &&
echo -e "XKBVARIANT=\"\"" >> /etc/default/keyboard &&
echo -e "XKBOPTIONS=\"\"" >> /etc/default/keyboard &&
echo -e "BACKSPACE=\"guess\"" >> /etc/default/keyboard &&
echo -e "[+]   CLI keyboard set." || echo -e "[-] ! ERROR! CLI keyboard could not be changed!"

## Script end banner:
echo -e   "##########################"
