#!/bin/bash

## This script adds contrib and non-free packages to debian:

## Add contrib and non-free packages to debian:
sed -i 's/^deb.*main$/& contrib non-free/g' /etc/apt/sources.list &&
echo -e "\n[+] Added contrib and non-free packages to '/etc/apt/sources.list'." || echo -e "\n[-] ERROR! Could not add contrib and non-free packages to '/etc/apt/sources.list'!"
