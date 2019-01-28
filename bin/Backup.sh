#!/usr/bin/env bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_GB.UTF-8
SHELL=/bin/sh
export DISPLAY=:0.0
sudo find /home -maxdepth 2 -type d -name .cache > ~/bin/backupexclusions.txt
BACKUPTIME=`date +%Y%m%d%H%M%S` #get the current date/time
DESTINATION=/Backup/Backup$BACKUPTIME.tar.gz #create a backup file using the current date in it's name
SOURCEFOLDER=/home #the folder that contains the files that we want to backup
sudo tar -cpzf $DESTINATION $SOURCEFOLDER --exclude-from /usr/local/bin/backupexclusions.txt  #create the backup
# Cleanup - only keep the most recent 6 files
cd /Backup
sudo ls -lt /Backup/ | grep ^- | tr -s ' ' | cut -d ' ' -f 9 | grep -v '/$' | tail -n +7 | xargs -d '\n' -r rm --
