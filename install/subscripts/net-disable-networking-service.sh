#!/bin/bash

## Author AISK
## Description: This script disables unnecessary networking service.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "### Networking.service ###"
echo -e   "##########################"

systemctl disable networking.service &> /dev/null &&
echo -e "[+]   Service 'networking.service' disabled." || echo -e "[-] ! ERROR! Service 'networking.service' could not be disabled!"

## Script end banner:
echo -e   "##########################"
