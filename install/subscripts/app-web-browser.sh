#!/bin/bash

## Author AISK
## Description: This script install firefox and set as default browser.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###     Web Browser    ###"
echo -e   "##########################"

## Install firefox:
apt install firefox-esr -y &> /dev/null &&
echo -e "[+]   Package 'firefox-esr' was installed." || echo -e "[-] ! ERROR! Package 'firefox-esr' could not be installed!"

## Set firefox as default web browser:
update-alternatives --set x-www-browser /usr/bin/firefox-esr &> /dev/null &&
echo -e "[+]   Firefox was set as default x-www-browser." || echo -e "[-] ! ERROR! Could not set Firefox as default x-www-browser!"

## Script end banner:
echo -e   "##########################"
