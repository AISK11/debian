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


#####################
# POST-INSTALLATION #
#####################
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

#####################
#      DRIVERS      #
#####################
## Driver for iwlwifi:
apt install firmware-iwlwifi -y &&
echo -e "\n[+] Installed firmware for iwlwifi" || echo -e "\n[-] Error while installing iwlwifi driver"

#####################
#       GRUB        #
#####################
## GRUB settings:
sed -i 's/GRUB_CMDLINE_LINUX=".*"/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub &&
sed -i 's/GRUB_DEFAULT=.*/GRUB_DEFAULT=0/g' /etc/default/grub &&
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=1/g' /etc/default/grub &&
sed -i 's/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/g' /etc/default/grub &&
sed -i 's/GRUB_DISABLE_RECOVERY=.*/GRUB_DISABLE_RECOVERY=true/g' /etc/default/grub &&
sed -i 's/#GRUB_DISABLE_RECOVERY/GRUB_DISABLE_RECOVERY/g' /etc/default/grub &&

## GRUB colors:
echo -e "set color_normal=white/black" > /boot/grub/custom.cfg &&
echo -e "set color_highlight=black/white" >> /boot/grub/custom.cfg &&
echo -e "set menu_color_normal=white/black" >> /boot/grub/custom.cfg &&
echo -e "set menu_color_highlight=black/white" >> /boot/grub/custom.cfg &&

## Update GRUB:
grub-mkconfig -o /boot/grub/grub.cfg &&
echo -e "\n[+] GRUB configuration updated." || echo -e "\n[-] Error while updating GRUB!"

#####################
#   Local Settings  #
#####################
## doas:
apt install doas -y &&
echo -e "permit nopass ${USER}" > /etc/doas.conf &&
echo -e "\n[+] User ${USER} added to '/etc/doas.conf'." || echo -e "\n[-] Error while adding user ${USER} to '/etc/doas.conf'!"

## hostname:
echo -e "${HOSTNAME}" > /etc/hostname &&
sed -i "s/127\.0\.1\.1.*/127\.0\.1\.1\t${HOSTNAME}/g" /etc/hosts &&
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

#####################
#     NETWORKING    #
#####################
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
sed -i 's/^slaac private/#&/g' /etc/dhcpcd.conf &&
sed -i 's/#slaac hwaddr/slaac hwaddr/g' /etc/dhcpcd.conf &&
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
apt install wpasupplicant wireless-tools ethtool -y
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

#####################
# TEXTEDITOR & SHELL#
#####################
## vim:
apt install vim bvi -y &&
update-alternatives --set editor /usr/bin/vim.basic &&
echo -e "\n[+] vim installed and set as default editor." || echo -e "\n[-] Error while setting up vim!"

## zsh:
apt install zsh zsh-autosuggestions zsh-syntax-highlighting -y &&
usermod -s /bin/zsh ${USER} &&
echo -e "\n[+] zsh installed and set for user '${USER}'" || echo -e "\n[-] Error while setting up zsh for user '${USER}'!"

#####################
#    WEB BROWSER    #
#####################
## Install firefox and set as default browser:
apt install firefox-esr -y &&
update-alternatives --set x-www-browser /usr/bin/firefox-esr &&
echo -e "\n[+] Firefox installed and set as default browser." || echo -e "\n[-] Error while installing and setting up Firefox!"

#####################
#       AUDIO       #
#####################
## Install audio control:
apt install alsa-utils -y &&
echo -e "\n[+] alsa-utils installed." || echo -e "\n[-] Error while installing alsa-utils!"

## To fix mic issue:
apt install pulseaudio -y &&
echo -e "\n[+] pulseaudio installed." || echo -e "\n[-] Error while installing pulseaudio!"

#####################
#        GIT        #
#####################
# Install git:
apt install git -y &&
echo -e "\n[+] git installed." || echo -e "\n[-] Error while installing git!"

#####################
#     Xorg + i3     #
#####################
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

#####################
#      DOTFILES     #
#####################
## If directory exists from previous git clone, then delete it:
DIRECTORY="${HOME}/debian"
if [[ -d "${DIRECTORY}" ]]; then
    rm -rf "${DIRECTORY}"
    echo "[*] removed ${DIRECTORY}."
else
    echo "[*] ${DIRECTORY} does not exists. Skipping."
fi

## Copy dotfiles from my github:
cd ${HOME} &&
git clone https://github.com/AISK11/debian &&
cp -r ${HOME}/debian/dotfiles/. ${HOME} &&
cp ${HOME}/debian/config_files/i3blocks.conf /etc/i3blocks.conf &&
cp ${HOME}/debian/config_files/xorg.conf /etc/X11/xorg.conf &&
chmod +x ${HOME}/.config/i3/scripts/* &&
tar xvjf .icons.tar.bz2 &&
rm -rf .icons.tar.bz2 &&
tar xvjf .themes.tar.bz2 &&
rm -rf .themes.tar.bz2 &&
rm -rf ${HOME}/debian &&
chown -R ${USER}:${USER} ${HOME} &&
chmod +x ${HOME}/scripts/* &&
echo -e "\n[+] custom dotfiles were applied." || echo -e "\n[-] Error while applying custom dotfiles!"

#####################
#       Nvidia      #
#####################
## Install Nvidia:
if [[ "${VIRTUAL}" -eq "0" ]]; then
	apt install intel-gpu-tools nvtop nvidia-detect linux-headers-amd64 nvidia-driver firmware-misc-nonfree -y &&
	echo -e "\n[+] Nvidia installed." || echo -e "\n[-] Error while installing Nvidia!"
else
	rm /etc/X11/xorg.conf
	echo -e "\n[*] VIRTUAL flag set, skipping installing of Nvidia driver."
fi

#####################
#Additional Packages#
#####################
## Process related:
apt install psmisc htop -y &&
echo -e "\n[+] Process related packages installed." || echo -e "\n[-] Error while installing process related packages!"

## Other system related:
apt install neofetch inxi -y &&
echo -e "\n[+] Other system related packages installed." || echo -e "\n[-] Error while installing other system related packages!"

## License related:
apt install vrms -y &&
echo -e "\n[+] License related packages installed." || echo -e "\n[-] Error while installing license related packages!"

## Password Manager:
apt install keepassxc -y &&
echo -e "\n[+] Password Manager packages installed." || echo -e "\n[-] Error while installing Package Manager packages!"

## Install support for MTP devices:
apt install mtp-tools jmtpfs -y &&
echo -e "\n[+] Installed support for MTP devices." || echo -e "\n[-] Error! MTP tools could not be installed!"

## Networking tools:
apt install ethtool macchanger iptables hping3 wireshark yafc putty mtr nmap dnsutils whois openvpn -y &&
echo -e "\n[+] Networking tools installed." || echo -e "\n[-] Error while installing network tools!"

## Multimedia:
apt install youtube-dl imagemagick zip -y &&
echo -e "\n[+] Multimedia packages installed." || echo -e "\n[-] Error while installing Multimedia packages!"

## KVM/QEMU
apt install qemu-system libvirt-clients libvirt-daemon-system virt-manager -y &&
usermod -aG libvirt ${USER} &&
usermod -aG libvirt-qemu ${USER} &&
cp -r /etc/libvirt/ ${HOME}/.config/libvirt/ &&
chown -R ${USER} ${HOME}/.config/libvirt/ &&
sed -i 's/#uri_default/uri_default/g' ${HOME}/.config/libvirt/libvirt.conf &&
systemctl start libvirtd.service &&
mkdir /var/lib/libvirt/iso/ &&
echo -e "[+] KVM/QEMU Installed" || echo -e "[-] Error while instlaling KVM/QEMU"

## Lightcord
## DEAD PROJECT!

#####################
#  System hardening #
#####################
## Add Kali repo:
apt install gnupg -y &&
bash -c 'echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list' &&
wget 'https://archive.kali.org/archive-key.asc' &&
apt-key add "./archive-key.asc" &&
## Assign low prio to kali pkgs:
touch '/etc/apt/preferences' &&
echo "Package: *" > '/etc/apt/preferences' &&
echo "Pin: release a=kali-rolling" >> '/etc/apt/preferences' &&
echo "Pin-Priority: 50" >> '/etc/apt/preferences' &&
rm "./archive-key.asc" &&
echo -e "\n[+] Kali repo added!" || echo -e "\n[-] Error while adding kali-repo!"

#### ANONYMITY ####
## Set blank MOTD:
echo "" > /etc/issue &&
echo -e "\n[+] MOTD was cleared!" || echo -e "\n[-] Error while clearing MOTD!"

## ICMP Firewall:
# https://stackoverflow.com/questions/4880290/how-do-i-create-a-crontab-through-a-script
apt install iptables-persistent -y
iptables -X LOG_AND_DROP
iptables -F
iptables -N LOG_AND_DROP &&
iptables -A LOG_AND_DROP -j LOG --log-prefix "iptables denied: " --log-level 4 &&
iptables -A INPUT -s 0.0.0.0/0 -p icmp --icmp-type 8 -j LOG_AND_DROP &&
iptables -A INPUT -s 0.0.0.0/0 -p icmp --icmp-type 13 -j LOG_AND_DROP &&
iptables -A INPUT -s 0.0.0.0/0 -p icmp --icmp-type 17 -j LOG_AND_DROP &&
iptables -A INPUT -s 0.0.0.0/0 -p icmp --icmp-type 30 -j LOG_AND_DROP &&
## Change rsyslog rule:
echo ":msg, contains, \"iptables denied: \" -/var/log/iptables.log" > /etc/rsyslog.d/iptables.conf &&
echo "& ~" >> /etc/rsyslog.d/iptables.conf &&
## Logrotate rule:
echo "/var/log/iptables.log" > /etc/logrotate.d/iptables &&
echo "{" >> /etc/logrotate.d/iptables &&
echo "    missingok" >> /etc/logrotate.d/iptables &&
echo "    notifempty" >> /etc/logrotate.d/iptables &&
echo "    rotate 4" >> /etc/logrotate.d/iptables &&
echo "    daily" >> /etc/logrotate.d/iptables &&
echo "    create 0600 root root" >> /etc/logrotate.d/iptables &&
echo "    compress" >> /etc/logrotate.d/iptables &&
echo "    delaycompress" >> /etc/logrotate.d/iptables &&
echo "    copytruncate" >> /etc/logrotate.d/iptables &&
echo "    nomail" >> /etc/logrotate.d/iptables &&
echo "    shred" >> /etc/logrotate.d/iptables &&
echo "}" >> /etc/logrotate.d/iptables &&
iptables-save > /etc/iptables/rules.v4 &&
ip6tables-save > /etc/iptables/rules.v6 &&
## Add to root's cron:
(crontab -l 2>/dev/null; echo "@reboot systemctl restart logrotate.service && systemctl restart rsyslog.service") | crontab - &&
(crontab -l 2>/dev/null; echo "@daily systemctl restart logrotate.service && systemctl restart rsyslog.service") | crontab - &&
systemctl restart logrotate.service &&
systemctl restart rsyslog.service &&
echo -e "[+] ICMP FW block applied." || echo -e "[-] Error while applying ICMP FW block rule!"

#### Hardening ####
apt install usbguard -y &&
systemctl enable usbguard.service &&
echo -e "\n[+] USBguard addedd." || echo -e "\n[-] Error while adding USBguard!"

#####################
#     FINISHING     #
#####################
## Update before restart:
apt update &&
apt full-upgrade -y &&
apt autoremove &&
echo -e "\n[+] System updated." || echo -e "\n[-] Error while updating system!"

## Restart:
init 6
