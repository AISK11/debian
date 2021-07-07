 #!/bin/bash
 
 # Author: AISK11
 # Description: This script shows current date and time with timezone in the end.
 # Created for: i3blocks
 
echo "$(date '+%Y-%m-%d %H:%M:%S') $(cat /etc/timezone)"
