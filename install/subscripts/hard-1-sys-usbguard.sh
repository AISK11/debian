#!/bin/bash

## Author AISK
## Description: This script installs USB Guard.
## Date Created: November 14, 2021
## Last Updated: November 14, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###      USB Guard     ###"
echo -e   "##########################"

## Install USB Guard:
apt install usbguard -y &> /dev/null &&
echo -e "[+]   Package 'usbguard' installed." || echo -e "[-] ! ERROR! Could not install package 'usbguard'."

## Enable usbguard on startup:
systemctl enable usbguard.service &> /dev/null &&
echo -e "[+]   Service 'usbguard.service' enabled on startup." || echo -e "[-] ! ERROR! Service 'usbguard.service' could not be enabled on startup!"

## Script end banner:
echo -e   "##########################"
