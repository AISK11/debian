#!/bin/bash

## Author AISK
## Description: This script customizes GRUB bootloader settings.
## Date Created: November 12, 2021
## Last Updated: November 12, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###   Configure GRUB   ###"
echo -e   "##########################"

## GRUB settings:
cp ../config_files/SYSTEM/GRUB/grub /etc/default/grub &&
echo -e "[+]   GRUB configured in '/etc/default/grub'." || echo -e "[-] ! ERROR! Could not configure GRUB in '/etc/default/grub'!"

## GRUB colors:
cp ../config_files/SYSTEM/GRUB/custom.cfg /boot/grub/custom.cfg &&
echo -e "[+]   GRUB menu colors in '/boot/grub/custom.cfg'." || echo -e "[-] ! ERROR! Could not configure GRUB menu colors in '/boot/grub/custom.cfg'!"

## Update GRUB:
grub-mkconfig -o /boot/grub/grub.cfg &> /dev/null &&
echo -e "[+] GRUB configuration updated to '/boot/grub/grub.cfg'." || echo -e "[-] ! ERROR! Could not update GRUB configuration to '/boot/grub/grub.cfg'!"

## Script end banner:
echo -e   "##########################"

