#!/bin/bash

## This script disables unnecessary networking service:
systemctl disable networking.service &> /dev/null &&
echo -e "\n[+] 'networking.service' disabled." || echo -e "\n[-] ERROR! Could not disable 'networking.service'!"
