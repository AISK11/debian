#!/bin/bash

## Author AISK
## Description: This script installs 'vim' and 'bvi' and sets 'vim' as default editor.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###         Vim        ###"
echo -e   "##########################"

## Install 'vim' and 'bvi':
apt install vim bvi -y &> /dev/null &&
echo -e "[+]   Packages 'vim' and 'bvi' were installed." || echo -e "[-] ! ERROR! Packages 'vim' and 'bvi' could not be installed!"

## Set 'vim' as default editor:
update-alternatives --set editor /usr/bin/vim.basic &> /dev/null &&
echo -e "[+]   Vim was set as default editor'." || echo -e "[-] ! ERROR! Vim could not be set as default editor!"

## Script end banner:
echo -e   "##########################"
