#!/bin/bash

#################################################
# Script to autoconfigure my settings fo debian #
# Author: AISK11                                #
#################################################
## Fresh debian install required without DE!
## Execute this script with root privileges!

## EDIT variables:
USER=$(echo $HOME | cut -d "/" -f 3)
HOSTNAME=$(hostname)
TIMEZONE="Europe/Copenhagen"

#################################################
## Disable speaker bell:
echo "set bell-style none" >> /etc/inputrc &&
echo "blacklist pcspkr" > /etc/modprobe.d/blacklist.conf &&
depmod -a &&
update-initramfs -u &&
echo "[+] Bell disabled." || echo "[-] Error while disabling bell!"

## Add contrib and non-free packages to debian:
sed -i 's/deb.*main$/& contrib nonfree/g' /etc/apt/sources.list

## Driver for iwlwifi:
 apt install firmware-iwlwifi

## GRUB settings:
sed -i 's/GRUB_CMDLINE_LINUX=".*"/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub &&
sed -i 's/GRUB_DEFAULT=.*/GRUB_DEFAULT=1/g' /etc/default/grub &&
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=1/g' /etc/default/grub &&
sed -i 's/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/g' /etc/default/grub &&
sed -i 's/GRUB_DISABLE_RECOVERY=.*/GRUB_DISABLE_RECOVERY=true/g' /etc/default/grub &&
## GRUB colors:
echo "set color_normal=white/black" > /boot/grub/custom.cfg &&
echo "set color_highlight=black/white" >> /boot/grub/custom.cfg &&
echo "set menu_color_normal=white/black" >> /boot/grub/custom.cfg &&
echo "set menu_color_highlight=black/white" >> /boot/grub/custom.cfg &&
grub-mkconfig -o /boot/grub/grub.cfg &&
echo "[+] GRUB configuration updated." || echo "[-] Error while updating GRUB!"

## doas:
apt install doas &&
echo "permit nopass ${USER}" > /etc/doas.conf &&
echo "[+] User ${USER} added to '/etc/doas.conf'." || echo "[-] Error while adding user ${USER} to '/etc/doas.conf'!" 

## hostname:
echo "${HOSTNAME}" > /etc/hostname &&
sed -i 's/127\.0\.1\.1.*/127\.0\.1\.1\ttest/g' /etc/hosts &&
echo "[+] Hostname updated with ${HOSTNAME}." || echo "[-] Error while changing hostname with ${HOSTNAME}!"

## timezone:
timedatectl set-timezone ${TIMEZONE} &&
echo "[+] Timezone ${TIMEZONE} updated." || echo "[-] Error. Timezone '${TIMEZONE}' could not be changed!"

## locale:
echo "LANG=en_US.UTF-8" > /etc/default/locale &&
echo "# First day in a week MON, not SUN:" >> /etc/default/locale &&
echo "#LC_TIME=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo "# Default paper size:" >> /etc/default/locale &&
echo "#LC_PAPER=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo "#LC_MEASUREMENT=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo "[+] Locales updated!" || echo "[-] Error while changing locales!"

## CLI Keyboard:
echo "XKBMODEL=\"pc105\"" > /etc/default/keyboard &&
echo "XKBLAYOUT=\"us\"" >> /etc/default/keyboard &&
echo "XKBVARIANT=\"\"" >> /etc/default/keyboard &&
echo "XKBOPTIONS=\"\"" >> /etc/default/keyboard &&
echo "BACKSPACE=\"guess\"" >> /etc/default/keyboard &&
echo "[+] CLI keyboard set." || echo "[-] Error while setting CLI keyboard!"

## Block bluetooth and unblock WiFi:
apt install rfkill &&
rfkill block bluetooth &&
rfkill unblock wlan &&
# dpkg --purge bluez bluetooth &&
echo "[+] Bluetooth was blocked and WiFi unblocked." || echo "[-] Error while setting up rfkill!"

## Disable networking service (is unnecessary):
systemctl disable networking.service &&
echo "[+] networking.service disabled." || echo "[-] Error while disabling networking.service!"

## Disable hotplug of interfaces and do not autoconnect to network:
echo "auto lo" > /etc/network/interfaces &&
echo "iface lo inet loopback" >> /etc/network/interfaces &&
echo "#allow-hotplug eth0" >> /etc/network/interfaces &&
echo "iface eth0 inet manual" >> /etc/network/interfaces &&
echo "#allow-hotplug wlan0" >> /etc/network/interfaces &&
echo "iface wlan0 inet manual" >> /etc/network/interfaces &&
echo "[+] Set up startup settings for network interfaces." || echo "[-] Error while setting up network interfaces!"

## Better DHCP client:
apt install dhcpcd5 &&
systmectl disable dhcpcd.service &&
sed -i 's/^hostname/#hostname/g' /etc/dhcpcd.conf &&
sed -i 's/^persistent/#persistent/g' /etc/dhcpcd.conf &&
sed -i 's/^option domain_name_servers,/#option domain_name_servers,/g' /etc/dhcpcd.conf &&
dpkg --purge isc-dhcp-client isc-dhcp-common &&
echo "[+] DHCPCD5 installed and set up." || echo "[-] Error while setting up DHCPCD5!"

## DNS:
echo "# Uncensored DNS - Denmark - Unicast" > /etc/resolv.conf &&
echo "nameserver 89.233.43.71" >> /etc/resolv.conf &&
echo "# CZ.NIC" >> /etc/resolv.conf &&
echo "nameserver 193.17.47.1" >> /etc/resolv.conf &&
echo "nameserver 185.43.135.1" >> /etc/resolv.conf &&
echo "# Quad9" >> /etc/resolv.conf &&
echo "nameserver 1.1.1.1" >> /etc/resolv.conf &&
echo "nameserver 1.0.0.1" >> /etc/resolv.conf &&
echo "[+] DNS servers updated." || echo "[-] Error while updating DNS servers!"

## WiFi wpasupplicant template:
#!/bin/bash
#!/bin/bash
#!/bin/bash

#################################################
# Script to autoconfigure my settings fo debian #
# Author: AISK11                                #
#################################################
## Fresh debian install required without DE!
## Execute this script with root privileges!

## EDIT variables:
USER=$(echo $HOME | cut -d "/" -f 3)
HOSTNAME=$(hostname)
TIMEZONE="Europe/Copenhagen"

#################################################
## Disable speaker bell:
echo "set bell-style none" >> /etc/inputrc &&
echo "blacklist pcspkr" > /etc/modprobe.d/blacklist.conf &&
depmod -a &&
update-initramfs -u &&
echo "[+] Bell disabled." || echo "[-] Error while disabling bell!"

## Add contrib and non-free packages to debian:
sed -i 's/deb.*main$/& contrib non-free/g' /etc/apt/sources.list &&
echo "[+] Added contrib and non free packages." || echo "[-] Error, could not add contrib and non-free packages!"

## Update system:
apt clean &&
apt update &&
apt full-upgrade -y &&
apt install apt-file -y &&
apt-file update &&
echo "[+] System updated and also installed apt-file package!" || echo "[-] Error while updating system!"

## Driver for iwlwifi:
apt install firmware-iwlwifi -y

## GRUB settings:
sed -i 's/GRUB_CMDLINE_LINUX=".*"/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub &&
sed -i 's/GRUB_DEFAULT=.*/GRUB_DEFAULT=1/g' /etc/default/grub &&
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=1/g' /etc/default/grub &&
sed -i 's/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/g' /etc/default/grub &&
sed -i 's/GRUB_DISABLE_RECOVERY=.*/GRUB_DISABLE_RECOVERY=true/g' /etc/default/grub &&
## GRUB colors:
echo "set color_normal=white/black" > /boot/grub/custom.cfg &&
echo "set color_highlight=black/white" >> /boot/grub/custom.cfg &&
echo "set menu_color_normal=white/black" >> /boot/grub/custom.cfg &&
echo "set menu_color_highlight=black/white" >> /boot/grub/custom.cfg &&
grub-mkconfig -o /boot/grub/grub.cfg &&
echo "[+] GRUB configuration updated." || echo "[-] Error while updating GRUB!"

## doas:
apt install doas -y &&
echo "permit nopass ${USER}" > /etc/doas.conf &&
echo "[+] User ${USER} added to '/etc/doas.conf'." || echo "[-] Error while adding user ${USER} to '/etc/doas.conf'!" 

## hostname:
echo "${HOSTNAME}" > /etc/hostname &&
sed -i 's/127\.0\.1\.1.*/127\.0\.1\.1\ttest/g' /etc/hosts &&
echo "[+] Hostname updated with ${HOSTNAME}." || echo "[-] Error while changing hostname with ${HOSTNAME}!"

## timezone:
timedatectl set-timezone ${TIMEZONE} &&
echo "[+] Timezone ${TIMEZONE} updated." || echo "[-] Error. Timezone '${TIMEZONE}' could not be changed!"

## locale:
echo "LANG=en_US.UTF-8" > /etc/default/locale &&
echo "# First day in a week MON, not SUN:" >> /etc/default/locale &&
echo "#LC_TIME=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo "# Default paper size:" >> /etc/default/locale &&
echo "#LC_PAPER=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo "#LC_MEASUREMENT=\"en_GB.UTF-8\"" >> /etc/default/locale &&
echo "[+] Locales updated!" || echo "[-] Error while changing locales!"

## CLI Keyboard:
echo "XKBMODEL=\"pc105\"" > /etc/default/keyboard &&
echo "XKBLAYOUT=\"us\"" >> /etc/default/keyboard &&
echo "XKBVARIANT=\"\"" >> /etc/default/keyboard &&
echo "XKBOPTIONS=\"\"" >> /etc/default/keyboard &&
echo "BACKSPACE=\"guess\"" >> /etc/default/keyboard &&
echo "[+] CLI keyboard set." || echo "[-] Error while setting CLI keyboard!"

## Block bluetooth and unblock WiFi:
apt install rfkill -y &&
rfkill block bluetooth &&
rfkill unblock wlan &&
# dpkg --purge bluez bluetooth &&
echo "[+] Bluetooth was blocked and WiFi unblocked." || echo "[-] Error while setting up rfkill!"

## Disable networking service (is unnecessary):
systemctl disable networking.service &&
echo "[+] networking.service disabled." || echo "[-] Error while disabling networking.service!"

## Disable hotplug of interfaces and do not autoconnect to network:
echo "auto lo" > /etc/network/interfaces &&
echo "iface lo inet loopback" >> /etc/network/interfaces &&
echo "#allow-hotplug eth0" >> /etc/network/interfaces &&
echo "iface eth0 inet manual" >> /etc/network/interfaces &&
echo "#allow-hotplug wlan0" >> /etc/network/interfaces &&
echo "iface wlan0 inet manual" >> /etc/network/interfaces &&
echo "[+] Set up startup settings for network interfaces." || echo "[-] Error while setting up network interfaces!"

## Better DHCP client:
apt install dhcpcd5 -y &&
systmectl disable dhcpcd.service &&
sed -i 's/^hostname/#hostname/g' /etc/dhcpcd.conf &&
sed -i 's/^persistent/#persistent/g' /etc/dhcpcd.conf &&
sed -i 's/^option domain_name_servers,/#option domain_name_servers,/g' /etc/dhcpcd.conf &&
dpkg --purge isc-dhcp-client isc-dhcp-common &&
echo "[+] DHCPCD5 installed and set up." || echo "[-] Error while setting up DHCPCD5!"

## DNS:
echo "# Uncensored DNS - Denmark - Unicast" > /etc/resolv.conf &&
echo "nameserver 89.233.43.71" >> /etc/resolv.conf &&
echo "# CZ.NIC" >> /etc/resolv.conf &&
echo "nameserver 193.17.47.1" >> /etc/resolv.conf &&
echo "nameserver 185.43.135.1" >> /etc/resolv.conf &&
echo "# Quad9" >> /etc/resolv.conf &&
echo "nameserver 1.1.1.1" >> /etc/resolv.conf &&
echo "nameserver 1.0.0.1" >> /etc/resolv.conf &&
echo "[+] DNS servers updated." || echo "[-] Error while updating DNS servers!"

## WiFi wpasupplicant template:
echo "# Basic settings and language for zones:" > /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "ctrl_interface=/run/wpa_supplicant" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "country=<2-LETTER-ISO-CODE>\n" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "ctrl_interface=/run/wpa_supplicant" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "country=<2-LETTER-ISO-CODE>\n" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "# Password protected:" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tssid=\"<ESSID>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tscan_ssid=1 # Find hidden network" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tkey_mgmt=WPA-PSK WPA-EAP" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\t#psk=<32byte-HEX-NUMBER>" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\t#ca_cert=\"/etc/cert/ca.pem\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\t#phase1=\"peaplabel=0\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tphase2=\"auth=MSCHAPV2\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tpriority=2" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "}\n" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tidentity=\"<USERNAME>@<DOMAIN>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tpassword=\"<PLAINTEXT-PASSWD>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\t#psk=<32byte-HEX-NUMBER>" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\t#ca_cert=\"/etc/cert/ca.pem\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tidentity=\"<USERNAME>@<DOMAIN>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tpassword=\"<PLAINTEXT-PASSWD>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\t#psk=<32byte-HEX-NUMBER>" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\t#ca_cert=\"/etc/cert/ca.pem\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\t#phase1=\"peaplabel=0\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tphase2=\"auth=MSCHAPV2\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tpriority=2" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "}\n" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "# Unprotected:" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tssid=\"<ESSID>\"" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tscan_ssid=1 # Find hidden network" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tkey_mgmt=NONE" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "\tpriority=3 # To which WiFi connect first" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "}" >> /etc/wpa_supplicant/wpa_supplicant.conf &&
echo "[+] Added template for wpasupplicant" || echo "[-] Error while setting template for wpasupplicant!"

## vim:
apt install vim bvi -y &&
update-alternatives --set editor /usr/bin/vim.basic &&
echo "[+] vim installed and set as default editor." || echo "[-] Error while setting up vim!"

## zsh:
apt install zsh zsh-autosuggestions zsh-syntax-highlighting -y &&
usermod -s /bin/zsh ${USER} &&
echo "[+] zsh installed and set for user '${USER}'" || echo "[-] Error while setting up zsh for user '${USER}'!"

## To fix mic issue:
apt install pulseaudio -y &&
echo "[+] pulseaudio installed." || echo "[-] Error while installing pulseaudio!"

# Install git:
apt install git -y &&
echo "[+] git installed." || echo "[-] Error while installing git!"

## X server with i3:
apt install xorg x11-xserver-utils xinit -y &&
cd /etc/ &&
apt install pulseaudio -y &&
echo "[+] pulseaudio installed." || echo "[-] Error while installing pulseaudio!"

# Install git:
apt install git -y &&
echo "[+] git installed." || echo "[-] Error while installing git!"

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
echo "[+] i3 compiled successfully." || echo "[-] Error while compiling i3!"

## Install other X-utlities:
apt install i3blocks i3lock numlockx rofi feh scrot compton light xclip lxappearance -y &&
echo "[+] additional X utilities installed." || echo "[-] Error while installing other utilities!" 

## URXVT:
apt install rxvt-unicode-256color -y &&
update-alternatives --set x-terminal-emulator /usr/bin/urxvt &&
echo "[+] rxvt-unicode set as default X-terminal." || echo "[-] Error while setting up rxvt-unicode!"

# Copy dotfiles from my github:
cd ${HOME} &&
git clone https://github.com/AISK11/debian &&
cd ./debian
