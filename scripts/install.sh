#!/bin/bash

#################################################
# Script to autoconfigure my settings fo debian #
# Author: AISK11                                #
#################################################
## Fresh debian install required without DE!
## Execute this script with root privileges!

## EDIT variables:
VIRTUAL=0	# change to 1 if installing on VM
USER="changeme"	# CHANGE
HOSTNAME="$(hostname)"
TIMEZONE="Europe/Copenhagen"
HOME="/home/${USER}"
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin"

if [[ "${USER}" = "changeme" ]]; then
	echo "You need to change variable for USER!"
	exit 1
fi


#################################################
## Disable speaker bell:
echo -e "set bell-style none" >> /etc/inputrc &&
echo -e "blacklist pcspkr" > /etc/modprobe.d/blacklist.conf &&
depmod -a &&
update-initramfs -u &&
echo -e "\n[+] pcspkr disabled." || echo -e "\n[-] Error while disabling pcspkr!"

## Add contrib and non-free packages to debian:
sed -i 's/deb.*main$/& contrib non-free/g' /etc/apt/sources.list &&
echo -e "\n[+] Added contrib and non-free packages to /etc/apt/sources.list." || echo -e "\n[-] Error, could not add contrib and non-free packages to /etc/apt/sources.list!"

## Update system:
apt clean &&
apt update &&
apt full-upgrade -y &&
apt install apt-file -y &&
apt-file update &&
echo -e "\n[+] System updated and also installed apt-file package!" || echo -e "\n[-] Error while updating system or installing apt-file package!"

## Driver for iwlwifi:
apt install firmware-iwlwifi -y &&
echo -e "\n[+] Installed firmware for iwlwifi" || echo -e "\n[-] Error while installing iwlwifi driver"

## GRUB settings:
sed -i 's/GRUB_CMDLINE_LINUX=".*"/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub &&
sed -i 's/GRUB_DEFAULT=.*/GRUB_DEFAULT=0/g' /etc/default/grub &&
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=1/g' /etc/default/grub &&
sed -i 's/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/g' /etc/default/grub &&
sed -i 's/GRUB_DISABLE_RECOVERY=.*/GRUB_DISABLE_RECOVERY=true/g' /etc/default/grub &&
## GRUB colors:
echo -e "set color_normal=white/black" > /boot/grub/custom.cfg &&
echo -e "set color_highlight=black/white" >> /boot/grub/custom.cfg &&
echo -e "set menu_color_normal=white/black" >> /boot/grub/custom.cfg &&
echo -e "set menu_color_highlight=black/white" >> /boot/grub/custom.cfg &&
grub-mkconfig -o /boot/grub/grub.cfg &&
echo -e "\n[+] GRUB configuration updated." || echo -e "\n[-] Error while updating GRUB!"

## doas:
apt install doas -y &&
echo -e "permit nopass ${USER}" > /etc/doas.conf &&
echo -e "\n[+] User ${USER} added to '/etc/doas.conf'." || echo -e "\n[-] Error while adding user ${USER} to '/etc/doas.conf'!" 

## hostname:
echo -e "${HOSTNAME}" > /etc/hostname &&
sed -i "s/127\.0\.1\.1.*/127\.0\.1\.1\t${HOSTNMAE}/g" /etc/hosts &&
echo -e "\n[+] Hostname updated with ${HOSTNAME}." || echo -e "\n[-] Error while changing hostname with ${HOSTNAME}!"

## timezone:
timedatectl set-timezone ${TIMEZONE} &&
echo -e "\n[+] Timezone ${TIMEZONE} updated." || echo -e "\n[-] Error. Timezone '${TIMEZONE}' could not be changed!"

## locale:
echo -e "LANG=en_US.UTF-8" > /etc/default/locale &&
echo -e "# First day in a week MON, not SUN:" >> /etc/default/locale &&
echo -e "#LC_TIME=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo -e "# Default paper size:" >> /etc/default/locale &&
echo -e "#LC_PAPER=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo -e "#LC_MEASUREMENT=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo -e "\n[+] Locales updated!" || echo -e "\n[-] Error while changing locales!"

## CLI Keyboard:
echo -e "XKBMODEL=\"pc105\"" > /etc/default/keyboard &&
echo -e "XKBLAYOUT=\"us\"" >> /etc/default/keyboard &&
echo -e "XKBVARIANT=\"\"" >> /etc/default/keyboard &&
echo -e "XKBOPTIONS=\"\"" >> /etc/default/keyboard &&
echo -e "BACKSPACE=\"guess\"" >> /etc/default/keyboard &&
echo -e "\n[+] CLI keyboard set." || echo -e "\n[-] Error while setting CLI keyboard!"

## Block bluetooth and unblock WiFi:
apt install rfkill -y &&
rfkill block bluetooth &&
rfkill unblock wlan &&
# dpkg --purge bluez bluetooth &&
echo -e "\n[+] Bluetooth was blocked and WiFi unblocked." || echo -e "\n[-] Error while setting up rfkill!"

## Disable networking service (is unnecessary):
systemctl disable networking.service &&
echo -e "\n[+] networking.service disabled." || echo -e "\n[-] Error while disabling networking.service!"

## Disable hotplug of interfaces and do not autoconnect to network:
echo -e "auto lo" > /etc/network/interfaces &&
echo -e "iface lo inet loopback" >> /etc/network/interfaces &&
echo -e "#allow-hotplug eth0" >> /etc/network/interfaces &&
echo -e "iface eth0 inet manual" >> /etc/network/interfaces &&
echo -e "#allow-hotplug wlan0" >> /etc/network/interfaces &&
echo -e "iface wlan0 inet manual" >> /etc/network/interfaces &&
echo -e "\n[+] Set up startup settings for network interfaces." || echo -e "\n[-] Error while setting up network interfaces!"

## Better DHCP client:
apt install dhcpcd5 -y &&
systemctl disable dhcpcd.service &&
sed -i 's/^hostname/#hostname/g' /etc/dhcpcd.conf &&
sed -i 's/^persistent/#persistent/g' /etc/dhcpcd.conf &&
sed -i 's/^option domain_name_servers,/#option domain_name_servers,/g' /etc/dhcpcd.conf &&
dpkg --purge isc-dhcp-client isc-dhcp-common &&
echo -e "\n[+] DHCPCD5 installed and set up." || echo -e "\n[-] Error while setting up DHCPCD5!"

## DNS:
echo -e "# Uncensored DNS - Denmark - Unicast" > /etc/resolv.conf &&
echo -e "nameserver 89.233.43.71" >> /etc/resolv.conf &&
echo -e "# CZ.NIC" >> /etc/resolv.conf &&
echo -e "nameserver 193.17.47.1" >> /etc/resolv.conf &&
echo -e "nameserver 185.43.135.1" >> /etc/resolv.conf &&
echo -e "# Quad9" >> /etc/resolv.conf &&
echo -e "nameserver 1.1.1.1" >> /etc/resolv.conf &&
echo -e "nameserver 1.0.0.1" >> /etc/resolv.conf &&
echo -e "\n[+] DNS servers updated." || echo -e "\n[-] Error while updating DNS servers!"

## WiFi wpasupplicant template:
apt install wpasupplicant -y
echo -e "# Basic settings and language for zones:" > /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "ctrl_interface=/run/wpa_supplicant" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "country=<2-LETTER-ISO-CODE>\n" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "# Password protected:" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tssid=\"<ESSID>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tscan_ssid=1 # Find hidden network" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tkey_mgmt=WPA-PSK WPA-EAP" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tpsk=\"<PLAINTEXT-PASSWD>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\t#psk=<32byte-HEX-NUMBER>" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tpriority=1 # To which WiFi connect first" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "}\n" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "# WPA-EAP protected::" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tssid=\"<ESSID>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tscan_ssid=1" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tkey_mgmt=WPA-EAP" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\t#eap=PEAP" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tidentity=\"<USERNAME>@<DOMAIN>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tpassword=\"<PLAINTEXT-PASSWD>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\t#psk=<32byte-HEX-NUMBER>" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\t#ca_cert=\"/etc/cert/ca.pem\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\t#phase1=\"peaplabel=0\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tphase2=\"auth=MSCHAPV2\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tpriority=2" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "}\n" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "# Unprotected:" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tssid=\"<ESSID>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tscan_ssid=1 # Find hidden network" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tkey_mgmt=NONE" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\tpriority=3 # To which WiFi connect first" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "}" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "\n[+] Added template for wpasupplicant" || echo -e "\n[-] Error while setting template for wpasupplicant!"

## vim:
apt install vim bvi -y &&
update-alternatives --set editor /usr/bin/vim.basic &&
echo -e "\n[+] vim installed and set as default editor." || echo -e "\n[-] Error while setting up vim!"

##! zsh:
apt install zsh zsh-autosuggestions zsh-syntax-highlighting -y &&
usermod -s /bin/zsh ${USER} &&
echo -e "\n[+] zsh installed and set for user '${USER}'" || echo -e "\n[-] Error while setting up zsh for user '${USER}'!"

## To fix mic issue:
apt install pulseaudio -y &&
echo -e "\n[+] pulseaudio installed." || echo -e "\n[-] Error while installing pulseaudio!"

# Install git:
apt install git -y &&
echo -e "\n[+] git installed." || echo -e "\n[-] Error while installing git!"

## X server with i3:
apt install xorg x11-xserver-utils xinit -y &&
cd /etc/ &&
git clone https://www.github.com/Airblader/i3 i3-gaps &&
cd ./i3-gaps/ &&
apt install make meson dh-autoreconf libxcb-keysyms1-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libpango1.0-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev -y &&
mkdir -p build && cd build &&
meson --prefix /usr/local &&
ninja &&
ninja install &&
echo -e "\n[+] i3 compiled successfully." || echo -e "\n[-] Error while compiling i3!"

## Install other X-utlities:
apt install i3blocks i3lock numlockx rofi feh scrot compton light xclip lxappearance -y &&
echo -e "\n[+] additional X utilities installed." || echo -e "\n[-] Error while installing other utilities!" 

## URXVT:
apt install rxvt-unicode-256color -y &&
update-alternatives --set x-terminal-emulator /usr/bin/urxvt &&
echo -e "\n[+] rxvt-unicode set as default X-terminal." || echo -e "\n[-] Error while setting up rxvt-unicode!"

## Copy dotfiles from my github:
cd ~ &&
git clone https://github.com/AISK11/debian &&
cp -r ~/debian/dotfiles/. ~ &&
cp ~/debian/config_files/i3blocks.conf /etc/i3blocks.conf &&
cp ~/debian/config_files/xorg.conf /etc/X11/xorg.conf &&
chmod +x ~/.config/i3/scripts/* &&
tar xvjf .icons.tar.bz2 &&
rm -rf .icons.tar.bz2 &&
tar xvjf .themes.tar.bz2 && 
rm -rf .themes.tar.bz2 &&
rm -rf ~/debian &&
chown -R ${USER}:${USER} ~
echo -e "\n[+] custom dotfiles were applied." || echo -e "\n[-] Error while applying custom dotfiles!"

## Install Nvidia:
if [[ "${VIRTUAL}" -eq "0" ]]; then
	apt install intel-gpu-tools nvtop nvidia-detect linux-headers-amd64 nvidia-driver firmware-misc-nonfree -y &&
	echo -e "\n[+] Nvidia installed." || echo -e "\n[-] Error while installing Nvidia!"
else
	echo -e "\n[*] VIRTUAL flag set, skipping installing of Nvidia driver"
fi

# Install Additional Packages:
apt install psmisc htop &&
echo -e "\n[+] Packages psmisc and htop installed." || echo -e "\n[-] Error while installing psmisc and htop!"

## Install support for MTP:
apt install mtp-tools jmtpfs -y &&
echo -e "\n[+] Installed support for MTP devices." || echo -e "\n[-] MTP tools could not be installed!"

## Update before restart:
apt update &&
apt full-upgrade -y &&
apt autoremove &&
echo -e "\n[+] System updated." || echo -e "\n[-] Error while updating system!"

## Restart:
init 6


#apt install macchanger nmap hping3 ethtool arping mtr arpspoof aircrack-ng
# htop imagemagick vrms
# keepassxc kvm 
#lightcord steam

