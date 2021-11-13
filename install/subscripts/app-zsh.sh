#!/bin/bash

## Author AISK
## Description: This script installs zsh and zsh related pkgs and set zsh as default shell for ${USER}.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###         ZSH        ###"
echo -e   "##########################"

## Get user from a command line:
USER="${1}"

## Install ZSH and ZSH related pkgs:
apt install zsh zsh-autosuggestions zsh-syntax-highlighting -y &> /dev/null &&
echo -e "[+]   Packages 'zsh zsh-autosuggestions zsh-syntax-highlighting' were installed." || echo -e "[-] ! ERROR. Packages 'zsh zsh-autosuggestions zsh-syntax-highlighting' could not be installed!"

## Set ZSH as default shell for ${USER}:
usermod -s /bin/zsh ${USER} &> /dev/null &&
echo -e "[+]   Set ZSH as default shell for '${USER}'." || echo -e "[-] ! ERROR! Could not set zsh as default shell for '${USER}'!"

## Script end banner:
echo -e   "##########################"
