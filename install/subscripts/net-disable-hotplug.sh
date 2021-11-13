#!/bin/bash

## Author AISK
## Description: This script disables autostart and autoconnect of network interfaces.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###  Interface hotplug ###"
echo -e   "##########################"

## Global interface list:
declare -a INTERFACE_LIST=("eth0" "wlan0")

## Loopback is specific interface and it should autostart:
echo -e "auto lo" > /etc/network/interfaces &&
echo -e "iface lo inet loopback" >> /etc/network/interfaces &&
echo -e "[+]   Loopback interface 'lo' was successfully set to autostart in '/etc/network/interfaces'." || echo -e "[-] ! ERROR! Loopback interface 'lo0' could not be set to autostart in '/etc/network/interfaces'!"

## Disable interfaces for auto connectivity:
for INTERFACE in "${INTERFACE_LIST[@]}"; do
    echo -e "#allow ${INTERFACE} hotplug" >> /etc/network/interfaces &&
    echo -e "iface ${INTERFACE} inet manual" >> /etc/network/interfaces &&
    echo -e "[+]   Interface '${INTERFACE}' disabled autostart in '/etc/network/interfaces'." || echo -e "[-] ! ERROR! Interface '${INTERFACE}' could not be disabled for autostart in '/etc/network/interfaces'!"
done

## Script end banner:
echo -e   "##########################"
