#!/bin/bash

## This script copies user dotfiles to home directory from github.

## Global properties:
USER="${1}"
HOME="/home/${USER}"

## There is a chance, that these settings were not previously clonned from github.
## If directory exists from previous git clone, then delete it (because this directory MAY NOT contain dotfiles):
#DIRECTORY="${HOME}/debian"
#if [[ -d "${DIRECTORY}" ]]; then
#    rm -rf "${DIRECTORY}"
#    echo -e "\n[*] removed '${DIRECTORY}'."
#else
#    echo -e "\n[*] '${DIRECTORY}' does not exists. Skipping."
#fi

## Copy dotfiles from my github:
## Clone git repositroy containing dotfiles:
#git clone https://github.com/AISK11/debian &> /dev/null &&
## Copy all files (even hidden) to user HOME:
cp -r ../dotfiles/. ${HOME} &&
## Unzip icons and themes:
tar xvjf ${HOME}/.icons.tar.bz2 &> /dev/null &&
rm -rf ${HOME}/.icons.tar.bz2 &&
tar xvjf ${HOME}/.themes.tar.bz2 &> /dev/null &&
rm -rf ${HOME}/.themes.tar.bz2 &&
## Make scripts to be executable:
/sbin/chmod +x ${HOME}/.config/i3/scripts/* &&
/sbin/chmod +x ${HOME}/scripts/* &&
## Copy i3blocks config:
cp ./install/files/i3blocks.conf /etc/i3blocks.conf &&
## Change ownership of all files in home to USER:
chown -R ${USER}:${USER} ${HOME} &&
## Delete cloned git repo:
#rm -rf ${HOME}/debian &&
echo -e "[+] Custom dotfiles applied." || echo -e "[-] ERROR! Custom dotfiles were not applied!"

