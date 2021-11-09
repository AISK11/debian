#!/bin/bash

## This script sets up persistent ICMP Firewall with custom logs in syslog:

## Install dependencies:
apt install iptables iptables-persistent -y 2> /dev/null &&

### Create IPv4 FW rules:
## Delete all rules:
iptables -F &&
## Delete all non-default chains:
iptables -X &&
## Zero all counters:
iptables -Z &&
## Copy persistent FW rules:
cp ../config_files/FW/iptables/rules.v4 /etc/iptables/rules.v4 &&
## Copy special logging:
cp ../config_files/Logging/Rsyslog/iptables.conf /etc/rsyslog.d/iptables.conf &&
cp ../config_files/Logging/Logrotate/iptables /etc/logrotate.d/iptables &&

## Create IPv6 FW rules:
## Delete all rules:
ip6tables -F &&
## Delete all non-default chains:
ip6tables -X &&
## Zero all counters:
ip6tables -Z &&
## Copy persistent FW rules:
cp ../config_files/FW/iptables/rules.v6 /etc/iptables/rules.v6 &&
## Copy special logging:
cp ../config_files/Logging/Rsyslog/ip6tables.conf /etc/rsyslog.d/ip6tables.conf &&
cp ../config_files/Logging/Logrotate/ip6tables /etc/logrotate.d/ip6tables &&

## Add crontab rules to root's cron:
(crontab -l &> /dev/null; echo "@reboot systemctl restart logrotate.service && systemctl restart rsyslog.service") | crontab - &&
(crontab -l &> /dev/null; echo "@daily systemctl restart logrotate.service && systemctl restart rsyslog.service") | crontab - &&
systemctl restart logrotate.service &&
systemctl restart rsyslog.service &&
echo -e "\n[+] FW rules for blocking ICMP successfully applied." || echo -e "\n[-] ERROR! FW rules for blocking ICMP could not be successfully applied!"
