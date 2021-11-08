#!/bin/bash

## This script compiles i3-gaps for Debian:

## Manual: https://github.com/Airblader/i3/wiki/Building-from-source

## Compilation:
cd /etc/ &&
git clone https://www.github.com/Airblader/i3 i3-gaps &> /dev/null &&
cd ./i3-gaps/ &&
apt install make meson dh-autoreconf libxcb-keysyms1-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libpango1.0-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev -y &> /dev/null &&
mkdir -p build && cd build &&
meson --prefix /usr/local &> /dev/null &&
ninja &> /dev/null &&
ninja install &> /dev/null &&
echo -e "\n[+] i3-gaps compiled successfully." || echo -e "\n[-] ERROR! i3-gaps did not compile successfully!"
