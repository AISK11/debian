#!/bin/bash

## Author AISK
## Description: This script install UnityHub.
## Date Created: November 28, 2021
## Last Updated: November 28, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###      UnityHub      ###"
echo -e   "##########################"

## Global properties:
if [[ ! -z ${1} ]]; then
    USER="${1}"
else
    USER=$(whoami)
fi
HOME="/home/${USER}"

doas apt install zenity -y &> /dev/null &&
echo -e "[+]   Package 'zenity' was installed." || echo -e "[-] ! ERROR! Package 'zenity' could not be installed!"

wget --quiet https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage -P ${HOME} &&
echo -e "[+] Downloaded UnityHub from 'https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage' to '${HOME}'." || echo -e "[-] ! UnityHub could not be downloaded from 'https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage' to '${HOME}'!"

chmod +x ./UnityHub.AppImage &&
echo -e "[+]   File './UnityHub.AppImage' made executable." || echo -e "[-] ! Could not make file './UnityHub.AppImage' executable!"

## Script end banner:
echo -e   "##########################"
