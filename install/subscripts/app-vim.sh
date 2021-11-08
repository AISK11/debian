#!/bin/bash

## This script installs 'vim' and 'bvi' and sets 'vim' as default editor:

## Install 'vim' and 'bvi':
apt install vim bvi -y &> /dev/null &&
## Set 'vim' as default editor:
update-alternatives --set editor /usr/bin/vim.basic &> /dev/null &&
echo -e "\n[+] 'vim' and 'bvi' installed and 'vim' was set as a default editor." || echo -e "\n[-] ERROR! Either 'vim' and 'bvi' could not be installed or 'vim' was not set as default editor!"
