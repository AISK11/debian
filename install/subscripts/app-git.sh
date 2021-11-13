#!/bin/bash

## Author AISK
## Description: This script installs git.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###         Git        ###"
echo -e   "##########################"

## Install git:
apt install git -y &> /dev/null &&
echo -e "[+]   Package 'git' was installed." || echo -e "[-] ! ERROR! Package 'git' could not be installed!"

## Script end banner:
echo -e   "##########################"
