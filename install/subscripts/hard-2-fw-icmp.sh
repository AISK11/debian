#!/bin/bash

## This script sets up persistent ICMP Firewall with custom logs in syslog:

## Install dependencies:
apt install iptables iptables-persistent -y 2> /dev/null &&

### Create IPv4 FW rules:
## Delete all rules:
iptables -F &&
## Delete all non-default chains:
iptables -X &&
## Copy persistent FW rules:
cp ../config_files/FW/iptables/rules.v4 /etc/iptables/rules.v4 &&
## Copy special logging:
cp ../config_files/Logging/Rsyslog/iptables.conf /etc/rsyslog.d/iptables.conf &&
cp ../config_files/Logging/Logrotate/iptables /etc/logrotate.d/iptables &&

## Add crontab rules to root's cron:
(crontab -l &> /dev/null; echo "@reboot systemctl restart logrotate.service && systemctl restart rsyslog.service") | crontab - &&
(crontab -l &> /dev/null; echo "@daily systemctl restart logrotate.service && systemctl restart rsyslog.service") | crontab - &&
systemctl restart logrotate.service &&
systemctl restart rsyslog.service &&
echo -e "\n[+] FW rules for blocking ICMP successfully applied." || echo -e "\n[-] ERROR! FW rules for blocking ICMP could not be successfully applied!"
