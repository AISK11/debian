#!/bin/bash

## Author AISK
## Description: This script install Xorg and xinit to be able to execute WM or DE.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###        Xorg        ###"
echo -e   "##########################"

## Install xorg and xinit packages:
apt install xorg x11-xserver-utils xinit -y &>/dev/null &&
echo -e "[+]   Packages 'x11-xserver-utils xinit' were installed." || echo -e "[-] ! ERROR! Packages 'x11-xserver-utils xinit' could not be installed!"

## Script end banner:
echo -e   "##########################"

