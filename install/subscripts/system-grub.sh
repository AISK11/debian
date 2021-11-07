#!/bin/bash

## This script customizes GRUB bootloader settings:

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
echo -e "\n[+] GRUB configuration updated." || echo -e "\n[-] ERROR! GRUB configuration did not successfully updated!"
