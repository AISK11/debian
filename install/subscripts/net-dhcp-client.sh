#!/bin/bash

## Author AISK
## Description: This script configures 'dhcpcd' as DHCP client.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "### DHCP client config ###"
echo -e   "##########################"

## Download DHCPCD5:
apt install dhcpcd5 -y &> /dev/null &&
echo -e "[+]   Package 'dhcpcd5' was installed." || echo -e "[-] ! ERROR! Could not install package 'dhcpcd5'!"

## Do not start DHCPCD on startup:
systemctl disable dhcpcd.service 1> /dev/null &&
echo -e "[+]   Disabled autostart for service 'dhcpcd.service'." || echo -e "[-] ! ERROR! Could not disable autostart for service 'dhcpcd.service'!"

## Copy DHCPCD config:
cp ../config_files/DHCP/dhcpcd.conf /etc/dhcpcd.conf &&
echo -e "[+]   Config file for dhcpcd was copied to '/etc/dhcpcd.conf'" || echo -e "[-] ! ERROR! Config file for dhcpcd could not be copied to '/etc/dhcpcd.conf'!"

## Uninstall previous DHCP Client:
dpkg --purge isc-dhcp-client isc-dhcp-common &> /dev/null &&
echo -e "[+]   Default DHCP client packages 'isc-dhcp-client' and 'isc-dhcp-common' were purged." || echo -e "[-] ! Default DHCP client packages 'isc-dhcp-client' and 'isc-dhcp-common' could not be purged!"

## Script end banner:
echo -e   "##########################"
