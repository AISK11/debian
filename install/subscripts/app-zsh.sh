#!/bin/bash

## This script installs zsh and zsh related pkgs and set zsh as default shell for ${USER}:

## Get user from a command line:
USER="${1}"

## Install ZSH and ZSH related pkgs:
apt install zsh zsh-autosuggestions zsh-syntax-highlighting -y &> /dev/null &&
usermod -s /bin/zsh ${USER} &> /dev/null &&
echo -e "\n[+] ZSH related packages were installed and ZSH was set as default shell for user '${USER}'" || echo -e "\n[-] ERROR! Either ZSH related packages were not installed or ZSH was not set as default shell for user '${USER}'!"
