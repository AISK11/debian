#!/bin/bash

## Author AISK
## Description: This script installs iwlwifi drivers (Intel Wi-Fi).
## Date Created: November 13, 2021
## Last Updated: November 13, 2021
## Requires: non-free and contrib packages.

## Script start banner:
echo -e "\n##########################"
echo -e   "###Driver - Intel Wi-Fi###"
echo -e   "##########################"

## Driver for iwlwifi:
apt install firmware-iwlwifi -y &> /dev/null &&
echo -e "[+]   Package 'firmware-iwlwifi' (Intel Wi-Fi) installed." || echo -e "[-] ! ERROR! Package 'firmware-iwlwifi' (Intel Wi-Fi) could not be installed!"

## Script end banner:
echo -e   "##########################"
