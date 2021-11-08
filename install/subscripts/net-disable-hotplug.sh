#!/bin/bash

## This script disables autostart and autoconnect of network interfaces:

## Global interface list:
declare -a INTERFACE_LIST=("eth0" "wlan0")

## Loopback is specific interface and it should autostart:
echo -e "auto lo" > /etc/network/interfaces &&
echo -e "iface lo inet loopback" >> /etc/network/interfaces &&
echo -e "\n[+] Loopback interface 'lo' was successfully set up in '/etc/network/interfaces'" || echo -e "\n[-] ERROR! Loopback interface 'lo0' could not be set up!"

## Disable interfaces for auto connectivity:
for INTERFACE in "${INTERFACE_LIST[@]}"; do
    echo -e "#allow ${INTERFACE} hotplug" >> /etc/network/interfaces &&
    echo -e "iface ${INTERFACE} inet manual" >> /etc/network/interfaces &&
    echo -e "[+] Interface '${INTERFACE}' disabled for autoconnectivity in '/etc/network/interfaces'." || echo -e "[-] ERROR! Interface '${INTERFACE}' could not be disabled for autoconnectivity in '/etc/network/interfaces'!"
done
