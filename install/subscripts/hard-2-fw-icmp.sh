#!/bin/bash

## This script sets up persistent ICMP Firewall with custom logs in syslog:

## Install dependencies:
apt install iptables-persistent

### Create FW rules:
## Delete all rules:
iptables -F
## Delete all non-default chains:
iptables -X


