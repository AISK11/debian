#!/bin/bash

## This script installs git:

## Install git:
apt install git -y &> /dev/null &&
echo -e "\n[+] Git installed." || echo -e "\n[-] ERROR! Git was not installed!"
