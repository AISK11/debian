#!/bin/bash

## Author AISK
## Description: This script sets DNS servers.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###     DNS servers    ###"
echo -e   "##########################"

## Copy DNS server list:
cp ../config_files/DNS/resolv.conf /etc/resolv.conf &&
echo -e "[+]   DNS servers set in '/etc/resolv.conf'." || echo -e "[-] ! ERROR! DNS servers could not be set in '/etc/resolv.conf'!"

## Script end banner:
echo -e   "##########################"
