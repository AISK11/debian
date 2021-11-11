#!/bin/bash

## This script installs and sets up SSH tarpit.
echo -e "\n##########################"
echo -e   "###      Endlessh      ###"
echo -e   "##########################"

## Install endlessh:
echo -e "[*]   Installing Endlessh..."
apt install endlessh -y &> /dev/null &&
echo -e "[+]   Endlessh installed." || echo -e "[-] ! ERROR! Endlessh could not be installed!"

# Copy endlessh config:
echo -e "[*]   Copying configuration files from '../config_files/Honeypot/endlessh/config' to '/etc/endlessh/config'..."
cp ../config_files/Honeypot/endlessh/config /etc/endlessh/config &&
echo -e "[+]   Endlessh settings copied to '/etc/endlessh/config'." || echo -e "[-] ! ERROR! Endlessh settings could not be copied to '/etc/endlessh/config'!"

### Permit running Endlessh on private ports (< 1024):
echo -e "[*]   Setting up privileges to run Endlessh on private ports (< 1024)..."
## Find endlessh.service (on my system: "/lib/systemd/system/endlessh.service"):
SYSTEMD_SERVICE=$(find /usr/ -regex ".*endlessh\.service$" 2> /dev/null | grep -iv "wants" | head -n 1) &&
echo -e "[+]   Found Endlessh systemd service at '${SYSTEMD_SERVICE}'." || echo -e "[-] ! ERROR! No systemd service found for Endlessh!"
## Edit endlessh.service:
echo -e "[*]   Editing '${SYSTEMD_SERVICE}..."
sed -i "s/^#AmbientCapabilities=CAP_NET_BIND_SERVICE/AmbientCapabilities=CAP_NET_BIND_SERVICE/" ${SYSTEMD_SERVICE} &> /dev/null &&
sed -i "s/^PrivateUsers=true/#&/" ${SYSTEMD_SERVICE} &> /dev/null &&
echo -e "[+]   Successfully edited settings in '${SYSTEMD_SERVICE}'." || echo -e "[-] ! ERROR! Could not edit settings in '${SYSTEMD_SERVICE}"

## Kill current process instance on default port:
echo -e "[*]   Setting Endlessh for systemd..."
systemctl kill endlessh.service &> /dev/null &&
echo -e "[+] Service 'endlessh.service' instance on default port 2222 was killed." || echo -e "[-] ! ERROR! Could not kill service 'endlessh.service' instance on default port 2222!"
## Enable on startup:
systemctl enable endlessh.service &> /dev/null &&
echo -e "[+]   Service 'endlessh.service' enabled on startup." || echo -e "[-] ! ERROR! Service 'endlessh.service' could not be enabled to run on startup!"

## Finished:
echo -e "[*]   Endlessh installation finished."
echo -e   "##########################"
