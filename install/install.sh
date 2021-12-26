#!/bin/bash

#################################################
# Script to autoconfigure my settings fo debian #
# Author: AISK11                                #
#################################################
## Fresh debian install required without DE!
## Execute this script with root privileges!

#######################
### EDIT VARIABLES: ###
#######################
### IMPORTANT! ###
## CHANGE TO 0 IF INSTALLING ON VM!
## Avoids installing drivers.
INSTALL_DRIVERS=1

## USER - MUST BE CHANGED!
## e.g. "aisk"
USER="changeme"

## Set Hardening level:
## 0 = no hardening
## 1 = light hardening
## 2 = mediocre hardening
## 3 = full hardening
HARDENING_LVL=3

### OPTIONAL ###
## New hostname can be specified:
HOSTNAME="$(hostname)"

## Domain name can specified:
## e.g. "net" -> HOSTNAME.net
DNSDOMAINNAME=""

## Change Timezone:
## e.g. "UTC"
## more timezones can be found in DIR '/usr/share/zoneinfo/'
TIMEZONE="Europe/Copenhagen"

# CHANGE to 1 if you want to automatically reboot after done:
REBOOT_AFTER_DONE=0

### DO NOT EDIT! ###
## PATH variable to execute sbin commands:
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin"
HOME="/home/${USER}"


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
echo -e "###############################"
echo -e "#    Installation started.    #"
echo -e "###############################"

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

####################
#     DRIVERS      #
####################
if [[ "${INSTALL_DRIVERS}" -ne 0 ]]; then
    ## Install iwlwifi driver:
    ## Requires 'bash ./subscripts/system-packages-nonfree.sh'.
    bash ./subscripts/driver-network-iwlwifi.sh

    ## Install Nvidia drivers and set X11 config file for Nvidia + Intel (Optimus):
    ## Requires 'bash ./subscripts/system-packages-nonfree.sh'.
    bash ./subscripts/driver-nvidia-optimus.sh
else
    echo -e "\n##########Driver##########"
    echo -e   "###       Drivers      ###"
    echo -e   "##########################"
    echo -e "[*]   Virtual Machine settings set, skipping installing 'iwlwifi' driver."
    echo -e "[*]   Virtual Machine settings set, skipping installing Nvidia driver and tools."
    echo -e   "##########################"
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
echo -e "\n##########################"
echo -e   "### Additional Packages###"
echo -e   "##########################"
## Process related:
apt install apt-file psmisc htop -y &> /dev/null &&
echo -e "[+]   Process related packages 'apt-file psmisc htop' installed." || echo -e "[-] ! ERROR! Process related packages 'apt-file psmisc htop' could not be installed!"

## Other system related:
apt install neofetch inxi ncdu -y &> /dev/null &&
echo -e "[+]   Other system related packages 'neofetch inxi ncdu' installed." || echo -e "[-] ! ERROR! Other system related packages 'neofetch inxi ncdu' could not be installed!"

## License related:
apt install vrms -y &> /dev/null &&
echo -e "[+]   License related packages 'vrms' installed." || echo -e "[-] ! ERROR! License related packages 'vrms' could not be installed!"

## Password Manager:
apt install keepassxc -y &> /dev/null &&
echo -e "[+]   Password Manager packages 'keepassxc' installed." || echo -e "[-] ! ERROR! Password Manager packages 'keepassxc' could not be installed!"

## Install support for MTP devices:
apt install mtp-tools jmtpfs -y &> /dev/null &&
echo -e "[+]   MTP support packages 'mtp-tools jmtpfs' installed." || echo -e "[-] ! ERROR! MTP support packages 'mtp-tools jmtpfs' could not be installed!"

## Networking tools:
apt install ethtool iptables nmap mtr hping3 arping dnsutils yafc putty whois openvpn curl ssh-audit -y &> /dev/null &&
echo -e "[+]   Networking packages 'ethtool iptables nmap mtr hping3 arping dnsutils yafc putty whois openvpn curl ssh-audit' installed." || echo -e "[-] ! ERROR! Networking packages 'ethtool iptables nmap mtr hping3 dnsutils yafc putty whois openvpn curl' could not be installed!"

## Dialog options:
apt install macchanger wireshark 2> /dev/null -y &&
echo -e "[+]   Networking tools requiring dialog 'macchanger wireshark' installed." || echo -e "[-] ! ERROR! Networking tools requiring dialog 'macchanger wireshark' could not be installed!"

## Multimedia:
apt install youtube-dl imagemagick zip unrar rar -y &> /dev/null &&
echo -e "[+]   Multimedia packages 'youtube-dl imagemagick zip unrar rar' installed." || echo -e "[-] ! ERROR! Multimedia packages 'youtube-dl imagemagick zip' could not be installed!"

## MISC:
apt install ascii tldr -y &> /dev/null &&
echo -e "[+]   Misc packages 'ascii tldr' installed." || echo -e "[-] ! ERROR! Could not install misc packages 'ascii tldr'!"

echo -e   "##########################"

## KVM/QEMU:
bash ./subscripts/app-virt-kvm_qemu.sh "${USER}"

## Lightcord:
## DEAD PROJECT!

## Steam
## Do it manually!

#####################
#  System hardening #
#####################
### LEVEL 1:
if [[ "${HARDENING_LVL}" -ge 1 ]]; then
    echo -e "\n###############################"
    echo -e   "#[H] Hardening LEVEL 1 begins #"
    echo -e   "###############################"

    ## Set blank MOTD:
    bash ./subscripts/hard-1-sys-motd.sh

    ## Install USB Guard:
    bash ./subscripts/hard-1-sys-usbguard.sh

    ## Add kali repository:
    bash ./subscripts/hard-1-sys-addkalirepo.sh
else
    echo "[*]   Hardening level is lower than 1. Skipping..."
fi

### LEVEL 2:
if [[ "${HARDENING_LVL}" -ge 2 ]]; then
    echo -e "\n###############################"
    echo -e   "#[H] Hardening LEVEL 2 begins #"
    echo -e   "###############################"

    ## Set persistent ICMP Firewall with custom logs in syslog:
    bash ./subscripts/hard-2-fw-icmp.sh

    ## Install OpenSSH server and apply hardening config,
    ## (this also sets SSH to be on port 2):
    bash ./subscripts/hard-2-ssh-openssh.sh "${USER}"

    ## Install and sets Endlessh (honeypot/tarpit) on port 22:
    bash ./subscripts/hard-2-ssh-endlessh.sh

    ## TODO: TigerVNC via SSH Tunnel.
else
    echo "[*]   Hardening level is lower than 2. Skipping..."
fi

### LEVEL 3:
    ## TODO: VPN, Tor, Proxy

## Some additional wanted sw:
## gimp, libreoffice, ksnip, openshot-qt obs-studio


#####################
#     FINISHING     #
#####################
echo -e "\n###############################"
echo -e   "#    Finishing Installation   #"
echo -e   "###############################"

## Again Update whole system:
bash ./subscripts/system-update.sh

#####################
#       REBOOT      #
#####################
## Remove 'debian' git directory:
cd ${HOME} &&
rm -rf "${HOME}/debian/" &&
echo -e "\n[+]   Cleared '${HOME}/debian/' directory." || echo -e "\n[-] ! ERROR! Directory '${HOME}/debian/' could not be removed!"

## Reboot after installation:
if [[ "${REBOOT_AFTER_DONE}" -eq 1 ]]; then
    echo -e "[*]   Installation completed. Rebooting..."
    sync && init 6
else
    echo -e "[*]   Installation completed. Please reboot."
    su -
fi
