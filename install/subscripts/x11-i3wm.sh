#!/bin/bash

## This script installs i3wm:

## Install i3wm:
apt install i3 --no-install-recommends &> /dev/null &&
apt install i3-wm &> /dev/null &&
echo -e "[+] i3wm installed." || echo -e "ERROR! i3wm could not be installed!"
