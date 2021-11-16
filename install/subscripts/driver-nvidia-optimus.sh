#!/bin/bash

## Author AISK
## Description: This script install Nvidia drivers and other Nvidia tools.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########Driver##########"
echo -e   "###   Nvidia Optimus   ###"
echo -e   "##########################"

## Install Nvidia driver and Nvidia tools:
apt install intel-gpu-tools nvtop nvidia-detect linux-headers-amd64 nvidia-driver firmware-misc-nonfree -y 2> /dev/null &&
echo -e "[+]   Packages 'intel-gpu-tools nvtop nvidia-detect linux-headers-amd64 nvidia-driver firmware-misc-nonfree' were installed." || echo -e "[-] ! ERROR! Packages 'intel-gpu-tools nvtop nvidia-detect linux-headers-amd64 nvidia-driver firmware-misc-nonfree' could not be installed!"

## Set Xorg config for Nvidia Optimus:
cp ../config_files/X11/xorg.conf /etc/X11/xorg.conf &&
echo -e "[+]   Xorg config file was set in '/etc/X11/xorg.conf'." || echo -e "[-] ! ERROR! Xorg config file could not be set in '/etc/X11/xorg.conf'!"

## Script end banner:
echo -e   "##########################"
