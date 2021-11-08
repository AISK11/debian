#!/bin/bash

#################################################
# Script to autoconfigure my settings fo debian #
# Author: AISK11                                #
#################################################
## Fresh debian install required without DE!
## Execute this script with root privileges!

## EDIT VARIABLES:
USER="changeme" # CHANGE! e.g. 'aisk'
HOSTNAME="$(hostname)"
DNSDOMAINNAME="" # e.g. "net" -> HOSTNAME.net
TIMEZONE="Europe/Copenhagen"

ISVIRTUAL=0 # CHANGE if this is a virtual machine!

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


#####################
#  System hardening #
#####################


#####################
#     FINISHING     #
#####################

