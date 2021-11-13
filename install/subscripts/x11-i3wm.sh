#!/bin/bash

## Author AISK
## Description: This script installs i3wm.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###        i3-wm       ###"
echo -e   "##########################"

## Install i3-wm:
#apt install i3 --no-install-recommends &> /dev/null &&
apt install i3-wm &> /dev/null &&
echo -e "[+]   Package 'i3-wm' was installed." || echo -e "[-] ! ERROR! Package 'i3-wm' could not be installed!"

## Script end banner:
echo -e   "##########################"
