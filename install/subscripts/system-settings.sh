#!/bin/bash

### Usage:
## ./system-settings.sh <HOSTNAME> <DNSDOMAINNAME> <TIMEZONE>
### Example:
## ./system-settings.sh "debian-pc" "" "Europe/Copenhagen"
## ./system-settings.sh "debian-pc" "net" "Europe/Copenhagen"

### This script sets following properties:
## hostname
## dnsdomainname
## timezone
## locale
## CLI keyboard


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
echo -e "\n[+] Hostname updated with '${HOSTNAME}'." || echo -e "\n[-] ERROR! Could not change hostname with '${HOSTNAME}'!"

## Set domainname:
if [[ ! -z ${DNSDOMAINNAME} ]]; then
    sed -i "s/${HOSTNAME}/&.${DNSDOMAINNAME} ${HOSTNAME}/g" /etc/hosts &&
    echo -e "\n[+] DNSDomainname updated with '${DNSDOMAINNAME}'." || echo -e "\n[-] ERROR! Could not change DNSDomainname with '${DNSDOMAINNAME}'!"
fi

## Set timezone:
timedatectl set-timezone ${TIMEZONE} &&
echo -e "\n[+] Timezone '${TIMEZONE}' updated." || echo -e "\n[-] Error! Timezone '${TIMEZONE}' could not be changed!"

## Set locale:
echo -e "LANG=en_US.UTF-8" > /etc/default/locale &&
echo -e "# First day in a week MON, not SUN:" >> /etc/default/locale &&
echo -e "#LC_TIME=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo -e "# Default paper size:" >> /etc/default/locale &&
echo -e "#LC_PAPER=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo -e "#LC_MEASUREMENT=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo -e "\n[+] Locales updated!" || echo -e "\n[-] ERROR! Locales could not be changed!"

## Set CLI keyboard:
echo -e "XKBMODEL=\"pc105\"" > /etc/default/keyboard &&
echo -e "XKBLAYOUT=\"us\"" >> /etc/default/keyboard &&
echo -e "XKBVARIANT=\"\"" >> /etc/default/keyboard &&
echo -e "XKBOPTIONS=\"\"" >> /etc/default/keyboard &&
echo -e "BACKSPACE=\"guess\"" >> /etc/default/keyboard &&
echo -e "\n[+] CLI keyboard set." || echo -e "\n[-] ERROR! CLI keyboard could not be changed!"
