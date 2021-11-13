#!/bin/bash

## Author AISK
## Description: This script copies user dotfiles to home directory from github.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###    User dotfiles   ###"
echo -e   "##########################"

## Global properties:
USER="${1}"
HOME="/home/${USER}"


### There is a chance, that these settings were not previously clonned from github - git clone in that case.
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


## Copy all files (even hidden) to user's HOME:
cp -rT ../dotfiles/ ${HOME} &&
echo -e "[+]   Dotfiles were copied to '${HOME}/'." || echo -e "[-] ! ERROR! Dotfiles could not be copied to '${HOME}/'!"

## Unzip icons and themes:
tar xvjf ${HOME}/.icons.tar.bz2 -C ${HOME} &> /dev/null &&
rm -rf ${HOME}/.icons.tar.bz2 &&
echo -e "[+]   Icons '${HOME}/.icons.tar.bz2' were extracted to '${HOME}/'." || echo -e "[-] ! ERROR! Icons '${HOME}/.icons.tar.bz2' could not be extracted to '${HOME}/'!"
tar xvjf ${HOME}/.themes.tar.bz2 -C ${HOME} &> /dev/null &&
rm -rf ${HOME}/.themes.tar.bz2 &&
echo -e "[+]   Themes '${HOME}/.themes.tar.bz2' were extracted to '${HOME}/'." || echo -e "[-] ! ERROR! Themes '${HOME}/.themes.tar.bz2' could not be extracted to '${HOME}/'!"

## Make scripts to be executable:
chmod +x ${HOME}/.config/i3/scripts/* &&
echo -e "[+]   Files in '${HOME}/.config/i3/scripts/' were made executable." || echo -e "[-] ! ERROR! Files in '${HOME}/.config/i3/scripts/' could not be made executable!"
chmod +x ${HOME}/scripts/* &&
echo -e "[+]   Files in '${HOME}/scripts/' were made executable." || echo -e "[-] ! ERROR! Files in '${HOME}/scripts/' could not be made executable!"

## Change ownership of all files in home to USER:
chown -R ${USER}:${USER} ${HOME} &> /dev/null &&
echo -e "[+]   User '${USER}' was set as an owner of all files in '${HOME}/'." || echo -e "[-] ! User '${USER}' could not be set as an owner of all files in '${HOME}/'!"

## Delete cloned git repo:
#rm -rf ${HOME}/debian &&

## Script end banner:
echo -e   "##########################"
