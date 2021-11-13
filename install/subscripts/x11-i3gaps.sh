#!/bin/bash

## Author AISK
## Description: This script compiles i3-gaps for Debian.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Manual: https://github.com/Airblader/i3/wiki/Building-from-source

## Script start banner:
echo -e "\n##########################"
echo -e   "###       i3-gaps      ###"
echo -e   "##########################"

### Compilation:
## Clone i3-gaps repo:
cd /etc/ &&
git clone https://www.github.com/Airblader/i3 i3-gaps &> /dev/null &&
echo -e "[+]   i3-gaps git clonned to '/etc/i3-gaps/'." || echo -e "[-] ! ERROR! i3-gaps could not be clonned to '/etc/i3-gaps/'!"

## Install dependency packages:
cd ./i3-gaps/ &&
apt install make meson dh-autoreconf libxcb-keysyms1-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libpango1.0-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev -y &> /dev/null &&
echo -e "[+]   Dependency packages 'make meson dh-autoreconf libxcb-keysyms1-dev libxcb-util0-dev xcb libxcb1-dev libxcb-ic    ccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-d    ev libxkbcommon-x11-dev libpango1.0-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0' were installed." || echo -e "[-] ! ERROR! Dependency packages 'make meson dh-autoreconf libxcb-keysyms1-dev libxcb-util0-dev xcb libxcb1-dev libxcb-ic    ccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-d    ev libxkbcommon-x11-dev libpango1.0-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0' could not be installed."

## Create directory in which compilation will take a place:
mkdir -p build && cd build &&
echo -e "[+]   Directory '/etc/i3-gaps/build/' was created." || echo -e "[-] ! ERROR! Directory '/etc/i3-gaps/build/' could not be created!"

## Compile i3-gaps:
meson --prefix /usr/local &> /dev/null &&
ninja &> /dev/null &&
ninja install &> /dev/null &&
echo -e "[+]   i3-gaps was compiled in '/etc/i3-gaps/build/'." || echo -e "[-] ! ERROR! i3-gaps could not be compiled in '/etc/i3-gaps/build/'!"

## Script end banner:
echo -e   "##########################"
