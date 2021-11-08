#!/bin/bash

#################################################
# Script to autoconfigure my settings fo debian #
# Author: AISK11                                #
#################################################
## Fresh debian install required without DE!
## Execute this script with root privileges!

### EDIT VARIABLES:
## MUST BE CHANGED!
## e.g. "aisk"
USER="changeme"
HOME="/home/${USER}"
## New hostname can be specified:
HOSTNAME="$(hostname)"
## Domain name can specified:
## e.g. "net" -> HOSTNAME.net
DNSDOMAINNAME=""
## Change Timezone:
## e.g. "UTC"
## more timezones can be found in DIR '/usr/share/zoneinfo/'
TIMEZONE="Europe/Copenhagen"
## CHANGE IF INSTALLING ON VM!
## Avoids installing drivers.
ISVIRTUAL=0
## Set Hardening level:
## 0 = no hardening
## 1 = light hardening
## 2 = mediocre hardening
## 3 = full hardening
HARDENING_LVL=3
# CHANGE to 1 if you want to automatically reboot after done:
REBOOT_AFTER_DONE=0
## PATH variable to execute sbin commands:
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin"

## Check if valid USER variable was set.
if [[ "${USER}" = "changeme" ]]; then
    echo "You need to change variable for USER!"
    exit 1
## If exists, $? returns 0, otherwise returns 1:
elif ! $(id "${USER}" &>/dev/null); then
    echo "User '${USER}' does not exists!"
    exit 1
fi


#####################
# POST-INSTALLATION #
#####################
## Disable speaker bell:
bash ./subscripts/system-disable-pcspkr.sh

## Add contrib and non-free packages to debian:
bash ./subscripts/system-packages-nonfree.sh

## Update system:
bash ./subscripts/system-update.sh

#####################
#       GRUB        #
#####################
## Set up GRUB Bootloader:
bash ./subscripts/system-grub.sh

#####################
#   Local Settings  #
#####################
## Set up local settings:
## Hostname
## DNSDomainname
## Timezone
## Locale
## CLI Keyboard
bash ./subscripts/system-settings.sh "${HOSTNAME}" "${DNSDOMAINNAME}" "${TIMEZONE}"

#####################
#  User Privileges  #
#####################
## Add user to '/etc/doas.conf':
bash ./subscripts/user-privileges-doas.sh "${USER}"

####################
#    NETWORKING    #
####################
## Install iwlwifi driver:
## Requires 'bash ./subscripts/system-packages-nonfree.sh'.
if [[ "${ISVIRTUAL}" -eq 0 ]]; then
    bash ./subscripts/driver-network-iwlwifi.sh
else
    echo -e "\n[*] Virtual Machine settings set, skipping installing 'iwlwifi' driver."
fi

## Disable networking service (is unnecessary):
bash ./subscripts/net-disable-networking-service.sh

## Set up Rfkill (block bluetooth and unblock WiFi:
bash ./subscripts/net-rfkill.sh

## Disable network interface hotplug autostart and autoconnect:
## requires 'bash ./subscripts/system-grub.sh' for set up 'normal' interface names.
bash ./subscripts/net-disable-hotplug.sh

## Better DHCP client:
bash ./subscripts/net-dhcp-client.sh

## Set up DNS servers:
bash ./subscripts/net-dns-servers.sh

## Set wpasupplicant:
bash ./subscripts/net-wpasupplicant.sh

#####################
# TEXTEDITOR & SHELL#
#####################
## Install 'vim' and 'bvi' and set 'vim' as default editor:
bash ./subscripts/app-vim.sh

## Install zsh and zsh related pkgs and set zsh as default shell for ${USER}:
bash ./subscripts/app-zsh.sh "${USER}"

#####################
#    WEB BROWSER    #
#####################
## Install firefox and set as default browser:
bash ./subscripts/app-web-browser.sh

#####################
#       AUDIO       #
#####################
## Install audio control apps:
bash ./subscripts/app-audio.sh

#####################
#        GIT        #
#####################
# Install git:
bash ./subscripts/app-git.sh

#####################
#     Xorg + i3     #
#####################
## Install X11 Xorg server:
bash ./subscripts/x11-xorg.sh

## i3 OR i3-gaps - LET ONLY ONE OPTION UNCOMMENTED:
## Compile i3-gaps from source:
## Requires 'bash ./subscripts/app-git.sh'.
bash ./subscripts/x11-i3gaps.sh
## Install i3wm:
#bash ./subscripts/x11-i3wm.sh

## Other X11-utilites for i3:
bash ./subscripts/x11-i3-utils.sh

## Install URXVT Terminal Emulator:
bash ./subscripts/x11-urxvt.sh

#####################
#       Nvidia      #
#####################
## Install Nvidia drivers and set X11 config file for Nvidia + Intel (Optimus):
## Requires 'bash ./subscripts/system-packages-nonfree.sh'.
if [[ "${ISVIRTUAL}" -eq 0 ]]; then
    bash ./subscripts/driver-nvidia.sh &&
    cp ./files/xorg.conf /etc/X11/xorg.conf &&
    echo -e "\n[+] Nvidia driver and tools installed and X11 config file '/etc/X11/xorg.conf' updated." || echo -e "\n[-] ERROR! Either Nvidia driver and tools were not installed or X11 config file '/etc/X11/xorg.conf' could not be updated."
else
    echo -e "\n[*] Virtual Machine settings set, skipping installing 'Nvidia' driver and tools."
fi

#####################
#      DOTFILES     #
#####################
## Copy user specific settings from github:
## Requires 'bash ./subscripts/app-git.sh'.
bash ./subscripts/user-dotfiles.sh "${USER}"

#####################
#Additional Packages#
#####################
## Process related:
apt install psmisc htop -y &> /dev/null &&
echo -e "\n[+] Process related packages installed." || echo -e "\n[-] ERROR! Process related packages could not be installed!"

## Other system related:
apt install neofetch inxi -y &> /dev/null &&
echo -e "\n[+] Other system related packages installed." || echo -e "\n[-] ERROR! Other system related packages could not be installed!"

## License related:
apt install vrms -y &> /dev/null &&
echo -e "\n[+] License related packages installed." || echo -e "\n[-] ERROR! License related packages could not be installed!"

## Password Manager:
apt install keepassxc -y &> /dev/null &&
echo -e "\n[+] Password Manager packages installed." || echo -e "\n[-] ERROR! Password Manager packages could not be installed!"

## Install support for MTP devices:
apt install mtp-tools jmtpfs -y &> /dev/null &&
echo -e "\n[+] Installed support for MTP devices." || echo -e "\n[-] ERROR! MTP tools could not be installed!"

## Networking tools:
apt install ethtool iptables hping3 yafc putty mtr nmap dnsutils whois openvpn curl -y &> /dev/null &&
## Dialog options:
apt install macchanger wireshark 2> /dev/null -y &&
echo -e "\n[+] Networking tools installed." || echo -e "\n[-] ERROR! Network tools could not be installed!"

## Multimedia:
apt install youtube-dl imagemagick zip -y &> /dev/null &&
echo -e "\n[+] Multimedia packages installed." || echo -e "\n[-] ERROR! Multimedia packages could not be installed!"

## KVM/QEMU:
apt install qemu-system libvirt-clients libvirt-daemon-system virt-manager -y &> /dev/null &&
/sbin/usermod -aG libvirt ${USER} &&
/sbin/usermod -aG libvirt-qemu ${USER} &&
cp -r /etc/libvirt/ ${HOME}/.config/ &> /dev/null &&
chown -R ${USER}:${USER} ${HOME} &> /dev/null &&
sed -i 's/#uri_default/uri_default/g' ${HOME}/.config/libvirt/libvirt.conf &> /dev/null &&
systemctl enable libvirtd.service &> /dev/null &&
mkdir /var/lib/libvirt/iso/ &&
echo -e "\n[+] KVM/QEMU Installed" || echo -e "\n[-] ERROR! KVM/QEMU could not be installed successfully!"

## Lightcord:
## DEAD PROJECT!

#####################
#     FINISHING     #
#####################
## Again Update whole system:
bash ./subscripts/system-update.sh

#####################
#  System hardening #
#####################
### LEVEL 1:
if [[ "${HARDENING_LVL}" -ge 1 ]]; then
    ## Set blank MOTD:
    bash ./subscripts/hard-1-sys-motd.sh

    ## Install USB Guard:
    bash ./subscripts/hard-1-sys-usbguard.sh

    ## Add kali repository:
    bash ./subscripts/hard-1-sys-addkalirepo.sh
else
    echo "\n[*] Hardening level is lower than 1. Skipping..."
fi

### LEVEL 2:


### LEVEL 3:

#####################
#       REBOOT      #
#####################
## Reboot after installation:
if [[ "${REBOOT_AFTER_DONE}" -eq 1 ]]; then
    echo -e "\n[*] Installation completed. Rebooting..."
    sync && init 6
else
    echo -e "\n[*] Installation completed. Please reboot."
fi
