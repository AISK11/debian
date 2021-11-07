#!/bin/bash

## This script fully updates system.

## Update system:
apt clean &> /dev/null &&
apt update &> /dev/null &&
apt full-upgrade -y &> /dev/null &&
apt dist-upgrade -y &> /dev/null &&
apt install apt-file -y &> /dev/null &&
apt-file update &> /dev/null &&
apt autoremove &> /dev/null &&
echo -e "\n[+] Full system updated!" || echo -e "\n[-] ERROR! System could not be fully updated!"
