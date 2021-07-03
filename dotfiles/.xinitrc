##################################################################
# Author: AISK11

# Packages installed:
# sudo apt install xorg
# sudo apt install i3 --no-install-recommends
##################################################################

# Disable screen saver:
xset s off
xset s noblank
xset -dpms

# Execute i3 WM after X is started:
exec i3
