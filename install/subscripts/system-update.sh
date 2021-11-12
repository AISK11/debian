#!/bin/bash

## Author AISK
## Description: This script updates system.
## Date Created: November 12, 2021
## Last Updated: November 12, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###    System update   ###"
echo -e   "##########################"

## Update system:
#apt clean -y &> /dev/null &&
apt autoclean -y &> /dev/null &&
echo -e "[+]   Cleaned." || echo -e "[-] ! ERROR! Could not clean!"

apt update -y &> /dev/null &&
echo -e "[+]   Updated." || echo -e "[-] ! ERROR! Could not update!"

apt upgrade -y &> /dev/null &&
echo -e "[+]   Upgraded." || echo -e "[-] ! ERROR! Could not upgrade!"

apt full-upgrade -y &> /dev/null &&
echo -e "[+]   Fully upgraded." || echo -e "[-] ! ERROR! Could not fully upgrade!"

apt autoremove -y &> /dev/null &&
echo -e "[+]   Removed no longer needed packages." || echo -e "[-] ! ERROR! Could not remove no longer needed packages!"

## Script end banner:
echo -e   "##########################"
