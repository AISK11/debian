#!/bin/bash

## Author AISK
## Description: This script sets up persistent ICMP Firewall with custom logs in syslog.
## Date Created: November 14, 2021
## Last Updated: November 14, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###   Firewall Rules   ###"
echo -e   "##########################"

## Install dependencies:
apt install iptables iptables-persistent -y 2> /dev/null &&
echo -e "[+]   Packages 'iptables iptables-persistent' installed." || echo -e "[-]   Packages 'iptables iptables-persistent' could not be installed!"

### Create IPv4 FW rules:
## Delete all rules:
iptables -F &&
## Delete all non-default chains:
iptables -X &&
## Zero all counters:
iptables -Z &&
echo -e "[+]   IPv4 Firewall rules, policies and counters were deleted." || echo -e "[-]   IPv4 Firewall rules, policies and counters could not be deleted!"

## Copy persistent FW rules:
cp ../config_files/FW/iptables/rules.v4 /etc/iptables/rules.v4 &&
echo -e "[+]   Persistent IPv4 FW rules copied to '/etc/iptables/rules.v4'." || echo -e "[-] ! ERROR! Persistent IPv4 FW rules could not be copied to '/etc/iptables/rules.v4'!"

## Copy special logging:
cp ../config_files/Logging/Rsyslog/iptables.conf /etc/rsyslog.d/iptables.conf &&
echo -e "[+]   Logging for IPv4 FW were applied in '/etc/rsyslog.d/iptables.conf'." || echo -e "[-] ! ERROR! Logging for IPv4 FW could not be applied in '/etc/rsyslog.d/iptables.conf'!"

## Copy logrotating:
cp ../config_files/Logging/Logrotate/iptables /etc/logrotate.d/iptables &&
echo -e "[+]   Logrotate rule for IPv4 FW copied to '/etc/logrotate.d/iptables'." || echo -e "[-] ! ERROR! Logroate rule for IPv4 FW could not be copied to '/etc/logrotate.d/iptables'!"

## Create IPv6 FW rules:
## Delete all rules:
ip6tables -F &&
## Delete all non-default chains:
ip6tables -X &&
## Zero all counters:
ip6tables -Z &&
echo -e "[+]   IPv6 Firewall rules, policies and counters were deleted." || echo -e "[-]   IPv6 Firewall rules, policies and counters could not be deleted!"

## Copy persistent FW rules:
cp ../config_files/FW/iptables/rules.v6 /etc/iptables/rules.v6 &&
echo -e "[+]   Persistent IPv6 FW rules copied to '/etc/iptables/rules.v6'." || echo -e "[-] ! ERROR! Persistent IPv6 FW rules could not be copied to '/etc/iptables/rules.v6'!"

## Copy special logging:
cp ../config_files/Logging/Rsyslog/ip6tables.conf /etc/rsyslog.d/ip6tables.conf &&
echo -e "[+]   Logging for IPv6 FW were applied in '/etc/rsyslog.d/ip6tables.conf'." || echo -e "[-] ! ERROR! Logging for IPv6 FW could not be applied in '/etc/rsyslog.d/ip6tables.conf'!"

## Copy logrotating:
cp ../config_files/Logging/Logrotate/ip6tables /etc/logrotate.d/ip6tables &&
echo -e "[+]   Logrotate rule for IPv6 FW copied to '/etc/logrotate.d/ip6tables'." || echo -e "[-] ! ERROR! Logroate rule for IPv6 FW could not be copied to '/etc/logrotate.d/ip6tables'!"

## Add crontab rules to root's cron:
(crontab -l &> /dev/null; echo "@reboot systemctl restart logrotate.service && systemctl restart rsyslog.service") | crontab - &&
(crontab -l &> /dev/null; echo "@daily systemctl restart logrotate.service && systemctl restart rsyslog.service") | crontab - &&
echo -e "[+]   Added @reboot and @daily crontab rules for services 'logrotate.service rsyslog.service'." || echo -e "[-] ! ERROR! Crontab @reboot and @daily rules for services 'logrotate.service rsyslog.service' could not be added!"

## Restart services with updated config:
systemctl restart logrotate.service &&
systemctl restart rsyslog.service &&
echo -e "[+]   Services 'logrotate.service rsyslog.service' were restarted". || echo -e "[-] ! ERROR! Services 'logrotate.service rsyslog.service' could not be restarted!"

## Script end banner:
echo -e   "##########################"
