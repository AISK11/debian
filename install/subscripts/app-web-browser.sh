#!/bin/bash

## This script install firefox and set as default browser:

## Install firefox:
apt install firefox-esr -y &> /dev/null &&

## Set firefox as default web browser:
update-alternatives --set x-www-browser /usr/bin/firefox-esr &> /dev/null &&
echo -e "\n[+] Firefox installed and set as default browser." || echo -e "\n[-] ERROR! Either Firefox was not installed or was not set as default web browser!"
