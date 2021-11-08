#!/bin/bash

## This script configures 'dhcpcd' as DHCP client:

## Download DHCPCD5:
apt install dhcpcd5 -y &> /dev/null &&
## Do not start DHCPCD on startup:
systemctl disable dhcpcd.service &&
## Copy DHCPCD config:
cp ./files/dhcpcd.conf /etc/dhcpcd.conf &&
## Uninstall previous DHCP Client:
dpkg --purge isc-dhcp-client isc-dhcp-common &&
echo -e "\n[+] DHCPCD5 installed and set up in '/etc/dhpcd.conf'." || echo -e "\n[-] ERROR! DHCPCD5 could not be installed and set up in '/etc/dhcpcd.conf'!"
