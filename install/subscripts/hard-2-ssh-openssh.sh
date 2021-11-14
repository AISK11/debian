#!/bin/bash

## Author AISK
## Description: This script installs and sets up openssh-server.
## Date Created: November 14, 2021
## Last Updated: November 14, 2021

## Script start banner:
echo -e "\n##########################"
echo -e   "### OpenSSH-server conf###"
echo -e   "##########################"

## Install openssh-server and openssh-client:
apt install openssh-server openssh-client -y &> /dev/null &&
echo -e "[+]   Packages 'openssh-server openssh-client' installed." || echo -e "[-] ! ERROR! Packages 'openssh-server openssh-client' could not be installed!"

## Disable on startup:
systemctl disable ssh.service &> /dev/null &&
systemctl stop ssh.service &> /dev/null &&
echo -e "[+]   Service 'ssh.service' disabled on startup." || echo -e "[-] ! ERROR! Service 'ssh.service' could not be disabled on startup!"

## Copy SSHD settings:
cp ../config_files/SSH/sshd_config /etc/ssh/sshd_config &&
echo -e "[+]   SSH server config was copied to '/etc/ssh/sshd_config'." || echo -e "[-] ! ERROR! SSH server config could not be copied to '/etc/ssh/sshd_config'!"

## Change logging file:
cp ../config_files/Logging/Rsyslog/sshd.conf /etc/rsyslog.d/sshd.conf &&
echo -e "[+]   Logging for SSHD were applied in '/etc/rsyslog.d/sshd.conf'." || echo -e "[-] ! ERROR! Logging for SSHD could not be applied in '/etc/rsyslog.d/sshd.conf'!"

## Copy logrotate:
cp ../config_files/Logging/Logrotate/sshd /etc/logrotate.d/sshd
echo -e "[+]   Logrotate rule for SSHD copied to '/etc/logrotate.d/sshd'." || echo -e "[-] ! ERROR! Logrotate rule for SSHD could not be copied to '/etc/logrotate.d/sshd'!"

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
systemctl restart cron.service anacron.service &&
echo -e "[+]   Services 'cron.service anacron.service' were restarted." || echo -e "[-] ! ERROR! Services 'cron.service anacron.service' could not be restarted!"

## Restart services with updated config:
systemctl restart logrotate.service &&
systemctl restart rsyslog.service &&
echo -e "[+]   Services 'logrotate.service rsyslog.service' were restarted". || echo -e "[-] ! ERROR! Services 'logrotate.service rsyslog.service' could not be restarted!"

## Script end banner:
echo -e   "##########################"
