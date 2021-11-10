#!/bin/bash

## This script installs and sets up openssh-server

## Install openssh-server and openssh-client:
apt install openssh-server openssh-client -y &> /dev/null &&
## Disable on startup:
systemctl disable ssh.service &> /dev/null &&
systemctl stop ssh.service &> /dev/null &&
## Copy SSHD settings:
cp ../config_files/SSH/sshd_config /etc/ssh/sshd_config &&
echo -e "\n[+] Open-SSH server was successfully installed and configured." || echo -e "\n[-] ERROR! Open-SSH server could not be successfully installed!"
