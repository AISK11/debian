#!/bin/bash

## Author AISK
## Description: This script installs and sets KVM/QEMU virtualization.
## Date Created: November 13, 2021
## Last Updated: November 13, 2021

## Global properties:
USER=${1}
HOME="/home/${USER}"

## Script start banner:
echo -e "\n##########################"
echo -e   "###      KVM/QEMU      ###"
echo -e   "##########################"

## Install KVM/QEMU packages:
apt install qemu-system libvirt-clients libvirt-daemon-system virt-manager -y &> /dev/null &&
echo -e "[+]   KVM/QEMU packages 'qemu-system libvirt-clients libvirt-daemon-system virt-manager' installed." || echo -e "[-] ! ERROR! KVM/QEMU packages 'qemu-system libvirt-clients libvirt-daemon-system virt-manager' could not be installed!"

## Add ${USER} to KMV/QEMU groups:
/sbin/usermod -aG libvirt ${USER} &&
/sbin/usermod -aG libvirt-qemu ${USER} &&
echo -e "[+]   User '${USER}' was added to KVM/QEMU groups 'libvirt libvirt-qemu'." || echo -e "[-] ! User '${USER}' could not be added to KVM/QEMU groups 'libvirt libvirt-qemu'!"

## Copy libvirt config files to home dir so can be adjusted for ${USER}:
cp -r /etc/libvirt/ ${HOME}/.config/ &> /dev/null &&
echo -e "[+]   Libvirt config files copied to local '${HOME}/.config/'." || echo -e "[-] ! ERROR! Libvirt config files could not be copied to local '${HOME}/.config/'!"

## Edit config file to use virsh fully without root:
sed -i 's/^#uri_default/uri_default/g' ${HOME}/.config/libvirt/libvirt.conf &> /dev/null &&
echo -e "[+]   Config file '${HOME}/.config/libvirt/libvirt.conf' were updated." || echo -e "[-] ! ERROR! Config file '${HOME}/.config/libvirt/libvirt.conf' could not be updated!"

## Enable libvirtd.service for immediate start of app:
systemctl enable libvirtd.service &> /dev/null &&
echo -e "[+]   Service 'libvirtd.service' was enabled." || echo -e "[-] ! ERROR! Service 'libvirtd.service' could not be enabled!"

## Create directories for ISO files:
mkdir /var/lib/libvirt/iso/ &&
mkdir "${HOME}/.iso/" &&
echo -e "[+]   Directories for ISO files were created ('/var/lib/libvirt/iso/' and '${HOME}/.iso/')." || echo -e "[-] ! ERROR! Directories for ISO files could not be created ('/var/lib/libvirt/iso/' and '${HOME}/.iso/')!"

## Change ownership for these copied files:
chown -R ${USER}:${USER} ${HOME} &> /dev/null &&
echo -e "[+]   User '${USER}' was set as an owner of all files in '${HOME}/'." || echo -e "User '${USER}' could not be set as an owner of all files in '${HOME}/'!"

## Script end banner:
echo -e   "##########################"
