#!/bin/bash

## Author AISK
## Description: This script updates system.
## Date Created: November 12, 2021
## Last Updated: November 12, 2021

## Update system:
#apt clean -y &> /dev/null &&
apt autoclean -y &> /dev/null &&
echo -e "[+]   Cleaned." || echo -e "[-] ! ERROR! Could not clean!"

apt update &> /dev/null &&
echo -e "[+]   Updated." || echo -e "[-] ! ERROR! Could not update!"

apt upgrade &> /dev/null &&
echo -e "[+]   Upgraded." || echo -e "[-] ! ERROR! Could not upgrade!"

apt full-upgrade -y &> /dev/null &&
echo -e "[+]   Fully upgraded." || echo -e "[-] ! ERROR! Could not fully upgrade!"

apt autoremove &> /dev/null &&
echo -e "\n[+]   Removed no longer needed packages." || echo -e "\n[-] ! ERROR! Could not remove no longer needed packages!"

## Script end banner:
echo -e   "##########################"
