#!/bin/bash

## Author AISK
## Description: This script installs and sets up openssh-server.
## Date Created: November 14, 2021
## Last Updated: November 14, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "### OpenSSH-server conf###"
echo -e   "##########################"

## Install openssh-server and openssh-client:
apt install openssh-server openssh-client -y &> /dev/null &&
echo -e "[+]   Packages 'openssh-server openssh-client' installed." || echo -e "[-] ! ERROR! Packages 'openssh-server openssh-client' could not be installed!"

## Disable on startup:
systemctl disable ssh.service &> /dev/null &&
systemctl stop ssh.service &> /dev/null &&
echo -e "[+]   Service 'ssh.service' disabled on startup." || echo -e "[-] ! ERROR! Service 'ssh.service' could not be disabled on startup!"

## Copy SSHD settings:
cp ../config_files/SSH/sshd_config /etc/ssh/sshd_config &&
echo -e "[+]   SSH server config was copied to '/etc/ssh/sshd_config'." || echo -e "[-] ! ERROR! SSH server config could not be copied to '/etc/ssh/sshd_config'!"

## Script end banner:
echo -e   "##########################"
