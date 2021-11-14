#!/bin/bash

## Author AISK
## Description: This script installs and sets up SSH tarpit.
## Date Created: November 14, 2021
## Last Updated: November 14, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###      Endlessh      ###"
echo -e   "##########################"


## Install endlessh:
apt install endlessh -y &> /dev/null &&
echo -e "[+]   Package 'endlessh' installed." || echo -e "[-] ! ERROR! Package 'endlessh' could not be installed!"

# Copy endlessh config:
cp ../config_files/Honeypot/endlessh/config /etc/endlessh/config &&
echo -e "[+]   Endlessh settings copied to '/etc/endlessh/config'." || echo -e "[-] ! ERROR! Endlessh settings could not be copied to '/etc/endlessh/config'!"

### Permit running Endlessh on private ports (< 1024):
## Find endlessh.service (on my system: "/lib/systemd/system/endlessh.service"):
SYSTEMD_SERVICE=$(find /usr/ -regex ".*endlessh\.service$" 2> /dev/null | grep -iv "wants" | head -n 1) &&
echo -e "[+]   Found Endlessh systemd service at '${SYSTEMD_SERVICE}'." || echo -e "[-] ! ERROR! No systemd service found for Endlessh!"

## Edit endlessh.service:
sed -i "s/^#AmbientCapabilities=CAP_NET_BIND_SERVICE/AmbientCapabilities=CAP_NET_BIND_SERVICE/" ${SYSTEMD_SERVICE} &> /dev/null &&
sed -i "s/^PrivateUsers=true/#&/" ${SYSTEMD_SERVICE} &> /dev/null &&
echo -e "[+]   Successfully edited settings in '${SYSTEMD_SERVICE} to be able to run on ports <1024'." || echo -e "[-] ! ERROR! Could not edit settings in '${SYSTEMD_SERVICE}. Endlessh will be able to run only on ports >= 1024!"

## Kill current process instance on default port:
systemctl stop endlessh.service &> /dev/null &&
systemctl kill endlessh.service &> /dev/null &&
echo -e "[+]   Service 'endlessh.service' instance on default port 2222 was stopped." || echo -e "[-] ! ERROR! Could not stop service 'endlessh.service' instance on default port 2222!"

## Enable on startup:
systemctl enable endlessh.service &> /dev/null &&
echo -e "[+]   Service 'endlessh.service' enabled on startup." || echo -e "[-] ! ERROR! Service 'endlessh.service' could not be enabled on startup!"

## Script end banner:
echo -e   "##########################"
