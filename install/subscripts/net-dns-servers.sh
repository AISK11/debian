#!/bin/bash

## This script sets DNS servers:

cp ./files/resolv.conf /etc/resolv.conf &&
echo -e "\n[+] DNS servers set in '/etc/resolv.conf'." || echo -e "ERROR! DNS servers could not be set in '/etc/resolv.conf'!"
