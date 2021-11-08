#!/bin/bash

## This script installs iwlwifi drivers.
## Requires: non-free and contrib packages.

## Driver for iwlwifi:
apt install firmware-iwlwifi -y &> /dev/null &&
echo -e "\n[+] Installed firmware for iwlwifi." || echo -e "\n[-] ERROR! Could not  install iwlwifi driver!"
