#!/bin/bash

## This script install Nvidia drivers and other Nvidia tools:

## Install Nvidia driver and Nvidia tools:
apt install intel-gpu-tools nvtop nvidia-detect linux-headers-amd64 nvidia-driver firmware-misc-nonfree -y &> /dev/null &&
echo -e "\n[+] Nvidia installed." || echo -e "\n[-] ERROR! Nvidia could not be installed!"
