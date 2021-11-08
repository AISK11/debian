#!/bin/bash

## This script sets MOTD which is executed when logging in to be blank:

## Set blank MOTD:
echo "" > /etc/issue &&
echo -e "\n[+] MOTD was cleared in '/etc/issue'!" || echo -e "\n[-] ERROR! MOTD could not be cleared in '/etc/issue'!"
