#!/bin/bash

## This script sets background according to datetime.
## USAGE:
## ./i3_wallpaper_24hour.sh [DIRECTORY]

## Image location directory
## Images should be in form: 00.png - 23.png:
DIRECTORY="${HOME}/.config/i3/images/24hour/forest"

### Add crontab rules to user's cron to execute each hour.
## Note: grep returns 0 on match, 1 otherwise, 2 if file does not exists.
## If crontab rule does not exist, create it:
if ! crontab -l 2> /dev/null; then
    (echo "0 * * * *  ${HOME}/.config/i3/scripts/i3_wallpaper_24hour.sh") | crontab -
elif crontab -l 2> /dev/null | grep "^0 * * * * ${HOME}/.config/i3/scripts/i3_wallpaper_24hour.sh" &> /dev/null; then
    (echo "0 * * * *  ${HOME}/.config/i3/scripts/i3_wallpaper_24hour.sh") | crontab -
fi
## Restart cron service:
#systemctl restart cron.service &&
#echo -e "[+]   Service 'cron.service' were restarted." || echo -e "[-] ! ERROR! Service 'cron.service' could not be restarted!"

## Get current hour:
HOUR=$(date "+%H") ## 00 - 23

## Set wallpaper:
if [[ -f "${DIRECTORY}/${HOUR}.png" ]]; then
    feh --bg-scale --force-aliasing "${DIRECTORY}/${HOUR}.png"
fi
