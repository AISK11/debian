#!/bin/bash

#################################################################
# Author: AISK11                                                #
#                                                               #
# Dependencies:                                                 #
# sudo apt install doas macchanger dhcpcd                       #
#                                                               #
# Usage:                                                        #
# this is personal script that run ${INTERFACE} and requires    #
# additional config to work                                     #
#################################################################

INTERFACE="eth0"

## Bring everything down in case of a restart:
doas dhcpcd --release ${INTERFACE} && echo "[+] DHCP released for interface '${INTERFACE}'." || echo "[-] ERROR! DHCP was not released for interface '${INTERFACE}'!"
doas ip a flush ${INTERFACE} && echo "[+] IP flushed for interface '${INTERFACE}'." || echo "[-] ERROR! IP was not flushed for interface '${INTERFACE}'!"
doas systemctl stop dhcpcd.service && echo "[+] Service 'dhcpcd.service' stopped." || echo "[-] ERROR! Service 'dhcpcd.service' was not stopped!"
doas ip l set ${INTERFACE} down && echo "[+] Interface '${INTERFACE}' state is DOWN." || echo "[-] ERROR! Interface '${INTERFACE}' state was not set to DOWN!"

## Start everything:
doas macchanger -A ${INTERFACE} && echo "[+] MAC address changed for interface '${INTERFACE}'." || echo "[-] ERROR! MAC address for interface '${INTERFACE}' was not changed!"
doas rm -rf /var/lib/dhcpcd/* && echo "[+] All leased addresses were removed in directory '/var/lib/dhcpcd/'." || echo "[-] ERROR! Lease addresses in directory '/var/lib/dhcpcd/' were not removed!"
doas ip l set ${INTERFACE} up && echo "[+] Interface '${INTERFACE}' state is UP." || echo "[-] ERROR! Interface '${INTERFACE}' state was not set to UP!"
doas systemctl start dhcpcd.service && echo "[+] Service 'dhcpcd.service' started." || echo "[-] ERROR! Sercice 'dhcpcd.service' was not started!"
doas dhcpcd ${INTERFACE} && echo "[+] DHCP started for interface '${INTERFACE}'." || echo "[-] ERROR! DHCP was not started for interface '${INTERFACE}'!"

## print when interface is rdy to communicate:
echo "[*] Establishing connection..."
while [[ -z $(ip r | grep "${INTERFACE}") ]]; do
    #echo "[*] Waiting for connection to be established"
    sleep 1
done

echo "[+] Connection was established for interface '${INTERFACE}'!"
exit
