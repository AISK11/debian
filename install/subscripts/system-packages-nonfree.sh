#!/bin/bash

## Author AISK
## Description: This script adds contrib and non-free packages to debian.
## Date Created: November 12, 2021
## Last Updated: November 12, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "### Add non-free pkgs  ###"
echo -e   "##########################"

## Add contrib and non-free packages to debian:
sed -i 's/^deb.*main$/& contrib non-free/g' /etc/apt/sources.list &&
echo -e "[+]   Added contrib and non-free packages to '/etc/apt/sources.list'." || echo -e "[-] ! ERROR! Could not add contrib and non-free packages to '/etc/apt/sources.list'!"

## Script end banner:
echo -e   "##########################"
