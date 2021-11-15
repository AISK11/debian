#!/bin/bash

## This script sets background according to datetime:

## Image location directory
## Images should be in form: 00.png - 23.png:
DIRECTORY="${HOME}/.config/i3/24hour/forest"

## Set Lock screen:
LOCKSCREEN=0

if [[ LOCKSCREEN -ne 0 ]]; then
    bindsym $mod+l exec i3lock -efu -i "${HOME}/.config/i3/24hour/forest/default.png"
fi

### Add crontab rules to user's cron to execute each hour.
## Note: grep returns 0 on match, 1 otherwise.
## If crontab rule does not exist, create it:
if grep "^0 * * * * ${HOME}/.config/i3/scripts/i3_wallpaper_daytime.sh"
  /var/spool/cron/crontabs/$(whoami) &> /dev/null; then
    echo "[*]   Reboot rule for services 'logrotate.service rsyslog.service' already exists."
else
    echo -e "0 * * * * ${HOME}/.config/i3/scripts/i3_wallpaper_daytime.sh" >> /var/spool/cron/crontabs/$(whoami) &&
fi
## Restart cron service:
#systemctl restart cron.service &&
#echo -e "[+]   Service 'cron.service' were restarted." || echo -e "[-] ! ERROR! Service 'cron.service' could not be restarted!"

## Get current hour:
HOUR=$(date "+%H") ## 00 - 23

## Set wallpaper:
if [[ -f "${HOME}/.config/i3/24hour/forest/${HOUR}.png" ]]; then
    feh --bg-scale --force-aliasing "${HOME}/.config/i3/24hour/forest/${HOUR}.png"
fi
