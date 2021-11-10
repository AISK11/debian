#!/bin/bash

## This script installs and sets up SSH tarpit.

## Install endlessh:
apt install endlessh -y &> /dev/null &&
## Disable on startup:
systemctl disable endlessh.service &> /dev/null &&
systemctl stop endlessh.service &> /dev/null &&
## Copy endlessh config:
cp ../config_files/Honeypot/endlessh/config /etc/endlessh/config &&
echo -e "\n[+] Endlessh installed and configured in '/etc/endlessh/config'." || echo -e "\n[-] ERROR! Endlessh could not be installed or configured in '/etc/endlessh/config'!"
