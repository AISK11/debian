#!/bin/bash

##################################################################
# Author: AISK11

# Packages installed:
# sudo apt install doas macchanger wpa_supplicant dhcpcd
# Usage: this is personal script that run wlan0 interface and require additional config to work
##################################################################

INTERFACE="wlan0"

# bring everything down in case of a restart
doas ip l set ${INTERFACE} down && echo "[+] ${INTERFACE} is DOWN." || echo "[-] ERROR while putting ${INTERFACE} DOWN!"
doas dhcpcd --release ${INTERFACE} && echo "[+] DHCP released for ${INTERFACE}." || echo "[-] ERROR while releasing DHCP!"
doas ip a flush ${INTERFACE} && echo "[+] IP flushed for ${INTERFACE}." || echo "[-] ERROR while flushing IP for ${INTERFACE}!"
doas systemctl stop dhcpcd.service && echo "[+] dhcpcd.service stopped." || echo "[-] ERROR while stopping dhcpcd.service!"
doas systemctl stop wpa_supplicant.service && echo "[+] wpa_supplicant.service stopped." || echo "[-] ERROR while stopping wpa_supplicant.service!"

# start everything
doas rfkill unblock wlan && echo "[+] wlan unblocked in rfkill." || echo "[-] ERROR while unblocking wlan in rfkill!"
doas macchanger -A ${INTERFACE} && echo "[+] MAC changed for ${INTERFACE}." || echo "[-] ERROR while changing MAC address for ${INTERFACE}!" 
doas rm -rf /var/lib/dhcpcd/* && echo "[+] All leased addresses were removed in '/var/lib/dhcpcd/'." || echo "[-] ERROR while removing leased addresses in '/var/lib/dhcpcd/'!"
doas ip l set ${INTERFACE} up && echo "[+] ${INTERFACE} is UP." || echo "[-] ERROR while putting ${INTERFACE} UP!"
doas rm -f /run/wpa_supplicant/${INTERFACE} && echo "[+] removed '/run/wpa_supplicant/${INTERFACE}." || echo "[-] ERROR while removing '/run/wpa_supplicant/${INTERFACE}!"
doas systemctl start wpa_supplicant.service && echo "[+] wpa_supplicant.service started." || echo "[-] ERROR while starting wpa_supplicant.service!"
doas systemctl start dhcpcd.service && echo "[+] dhcpcd.service started." || echo "[-] ERROR while starting dhcpcd.service!"
doas wpa_supplicant -B -D wext -i ${INTERFACE} -c /etc/wpa_supplicant/wpa_supplicant.conf && echo "[+] Connected to AP according to '/etc/wpa_supplicant/wpa_supplicant.conf'." || echo "[-] ERROR could not connect to AP according to '/etc/wpa_supplicant/wpa_supplicant.conf'!"
doas dhcpcd ${INTERFACE} && echo "[+] DHCP discovery for ${INTERFACE}." || echo "[-] ERROR while DHCP discovery for ${INTERFACE}!"

# print when interface is rdy to communicate:
while [[ -z $(ip r | grep "${INTERFACE}") ]]; do
    echo "[*] Waiting for connection to be established"
    sleep 1
done

echo "[+] Connection was establiehed!"
exit
