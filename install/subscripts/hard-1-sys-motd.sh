#!/bin/bash

## Author AISK
## Description: This script sets MOTD which is executed when logging in to be blank.
## Date Created: November 14, 2021
## Last Updated: November 14, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###     Blank MOTD     ###"
echo -e   "##########################"

## Set blank MOTD:
echo "" > /etc/issue &&
echo -e "[+]   MOTD was cleared in '/etc/issue'!" || echo -e "[-] ! ERROR! MOTD could not be cleared in '/etc/issue'!"

## Script end banner:
echo -e   "##########################"
