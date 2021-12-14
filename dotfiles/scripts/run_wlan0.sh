#!/bin/bash

#################################################################
# Author: AISK11                                                #
#                                                               #
# Dependencies:                                                 #
# sudo apt install doas macchanger wpa_supplicant dhcpcd        #
#                                                               #
# Usage:                                                        #
# this is personal script that run ${INTERFACE} and requires    #
# additional config to work                                     #
#################################################################

INTERFACE="wlan0"

## Bring everything down in case of a restart:
doas dhcpcd --release ${INTERFACE} && echo "[+] DHCP released for interface '${INTERFACE}'." || echo "[*] DHCP was not released for interface '${INTERFACE}'."
doas ip a flush ${INTERFACE} && echo "[+] IP flushed for interface '${INTERFACE}'." || echo "[-] ERROR! IP was not flushed for interface '${INTERFACE}'!"
doas systemctl stop dhcpcd.service && echo "[+] Service 'dhcpcd.service' stopped." || echo "[-] ERROR! Service 'dhcpcd.service' was not stopped!"
doas systemctl stop wpa_supplicant.service && echo "[+] Service 'wpa_supplicant.service' stopped." || echo "[-] ERROR! Service 'wpa_supplicant.service' was not stopped!"
doas ip l set ${INTERFACE} down && echo "[+] Interface '${INTERFACE}' state is DOWN." || echo "[-] ERROR! Interface '${INTERFACE}' state was not set to DOWN!"

## Start everything:
doas rfkill unblock wlan && echo "[+] WLAN unblocked in rfkill." || echo "[-] ERROR! WLAN was not unlocked in rfkill!"
doas macchanger -A ${INTERFACE} && echo "[+] MAC address changed for interface '${INTERFACE}'." || echo "[-] ERROR! MAC address for interface '${INTERFACE}' was not changed!"
doas rm -rf /var/lib/dhcpcd/* && echo "[+] All leased addresses were removed in directory '/var/lib/dhcpcd/'." || echo "[-] ERROR! Lease addresses in directory '/var/lib/dhcpcd/' were not removed!"
doas rm -f /run/wpa_supplicant/${INTERFACE} && echo "[+] WPA_SUPPLICANT file '/run/wpa_supplicant/${INTERFACE}' was removed." || echo "[-] ERROR! WPA_SUPPLICANT file '/run/wpa_supplicant/${INTERFACE}' was not removed."
doas killall -9 wpa_supplicant && echo "[+] All instances of process 'wpa_supplicant' were killed." || echo "[*] Could not kill all instances of process 'wpa_supplicant'. There are no processes running."
doas ip l set ${INTERFACE} up && echo "[+] Interface '${INTERFACE}' state is UP." || echo "[-] ERROR! Interface '${INTERFACE}' state was not set to UP!"
doas systemctl start wpa_supplicant.service && echo "[+] Service 'wpa_supplicant.service' started." || echo "[-] ERROR! Service 'wpa_supplicant.service' was not started!"
doas systemctl start dhcpcd.service && echo "[+] Service 'dhcpcd.service' started." || echo "[-] ERROR! Sercice 'dhcpcd.service' was not started!"
doas wpa_supplicant -B -D wext -i ${INTERFACE} -c /etc/wpa_supplicant/wpa_supplicant.conf && echo "[+] Connected to AP with config file '/etc/wpa_supplicant/wpa_supplicant.conf'." || echo "[-] ERROR! Could not connect to AP with config file '/etc/wpa_supplicant/wpa_supplicant.conf'!"
doas dhcpcd ${INTERFACE} && echo "[+] DHCP started for interface '${INTERFACE}'." || echo "[-] ERROR! DHCP was not started for interface '${INTERFACE}'!"

## print when interface is rdy to communicate:
echo "[*] Establishing connection..."
while [[ -z $(ip r | grep "${INTERFACE}") ]]; do
    #echo "[*] Waiting for connection to be established"
    sleep 1
done

echo "[+] Connection was established for interface '${INTERFACE}'!"
exit
