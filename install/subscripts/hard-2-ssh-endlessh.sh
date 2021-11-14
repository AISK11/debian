#!/bin/bash

## Author AISK
## Description: This script installs and sets up SSH tarpit.
## Date Created: November 14, 2021
## Last Updated: November 14, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "###      Endlessh      ###"
echo -e   "##########################"


## Install endlessh:
apt install endlessh -y &> /dev/null &&
echo -e "[+]   Package 'endlessh' installed." || echo -e "[-] ! ERROR! Package 'endlessh' could not be installed!"

# Copy endlessh config:
cp ../config_files/Honeypot/endlessh/config /etc/endlessh/config &&
echo -e "[+]   Endlessh settings copied to '/etc/endlessh/config'." || echo -e "[-] ! ERROR! Endlessh settings could not be copied to '/etc/endlessh/config'!"

### Permit running Endlessh on private ports (< 1024):
## Find endlessh.service (on my system: "/lib/systemd/system/endlessh.service"):
SYSTEMD_SERVICE=$(find /usr/ -regex ".*endlessh\.service$" 2> /dev/null | grep -iv "wants" | head -n 1) &&
echo -e "[+]   Found Endlessh systemd service at '${SYSTEMD_SERVICE}'." || echo -e "[-] ! ERROR! No systemd service found for Endlessh!"

## Edit endlessh.service:
sed -i "s/^#AmbientCapabilities=CAP_NET_BIND_SERVICE/AmbientCapabilities=CAP_NET_BIND_SERVICE/" ${SYSTEMD_SERVICE} &> /dev/null &&
sed -i "s/^PrivateUsers=true/#&/" ${SYSTEMD_SERVICE} &> /dev/null &&
echo -e "[+]   Successfully edited settings in '${SYSTEMD_SERVICE} to be able to run on ports <1024'." || echo -e "[-] ! ERROR! Could not edit settings in '${SYSTEMD_SERVICE}. Endlessh will be able to run only on ports >= 1024!"

## Copy rsyslog rule:
cp ../config_files/Logging/Rsyslog/endlessh.conf /etc/rsyslog.d/endlessh.conf &&
echo -e "[+]   Logging for Endlessh were applied in '/etc/rsyslog.d/endlessh.conf'." || echo -e "[-] ! ERROR! Logging for Endlessh could not be applied in '/etc/rsyslog.d/endlessh.conf'!"

## Copy logrotate rule:
cp ../config_files/Logging/Logrotate/endlessh /etc/logrotate.d/endlessh &&
echo -e "[+]   Logrotate rule for Endlessh copied to '/etc/logrotate.d/endlessh'." || echo -e "[-] ! ERROR! Logrotate rule for Endlessh could not be copied to '/etc/logrotate.d/endlessh'!"

### Add crontab rules to root's cron:
## Note: grep returns 0 on match, 1 otherwise:
## On reboot:
if grep "^@reboot systemctl restart logrotate.service && systemctl restart rsyslog.service" /var/spool/cron/crontabs/root &> /dev/null; then
    echo "[*]   Reboot rule for services 'logrotate.service rsyslog.service' already exists."
else
    echo -e "@reboot systemctl restart logrotate.service && systemctl restart rsyslog.service" >> /var/spool/cron/crontabs/root &&
    echo -e "[+]   Reboot rule added for services 'logrotate.service rsyslog.service' added to '/var/spool/cron/crontabs/root'" || echo -e "[-] ! ERROR! Reboot rule for services 'logrotate.service rsyslog.service' could not be added to '/var/spool/cron/crontabs/root'!"
fi
## Daily:
if grep "^@daily systemctl restart logrotate.service && systemctl restart rsyslog.service" /var/spool/cron/crontabs/root &> /dev/null; then
    echo "[*]   Daily rule for services 'logrotate.service rsyslog.service' already exists."
else
    echo -e "@daily systemctl restart logrotate.service && systemctl restart rsyslog.service" >> /var/spool/cron/crontabs/root &&
    echo -e "[+]   Daily rule added for services 'logrotate.service rsyslog.service' added to '/var/spool/cron/crontabs/root'" || echo -e "[-] ! ERROR! Daily rule for services 'logrotate.service rsyslog.service' could not be added to '/var/spool/cron/crontabs/root'!"
fi
## Restart cron service:
systemctl restart cron.service &&
echo -e "[+]   Service 'cron.service' were restarted." || echo -e "[-] ! ERROR! Service 'cron.service' could not be restarted!"

## Restart services with updated config:
systemctl restart logrotate.service rsyslog.service &&
echo -e "[+]   Services 'logrotate.service rsyslog.service' were restarted". || echo -e "[-] ! ERROR! Services 'logrotate.service rsyslog.service' could not be restarted!"

## Kill current process instance on default port:
systemctl stop endlessh.service &> /dev/null &&
systemctl kill endlessh.service &> /dev/null &&
echo -e "[+]   Service 'endlessh.service' instance on default port 2222 was stopped." || echo -e "[-] ! ERROR! Could not stop service 'endlessh.service' instance on default port 2222!"

## Enable on startup:
systemctl enable endlessh.service &> /dev/null &&
echo -e "[+]   Service 'endlessh.service' enabled on startup." || echo -e "[-] ! ERROR! Service 'endlessh.service' could not be enabled on startup!"

## Script end banner:
echo -e   "##########################"
