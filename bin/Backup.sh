#!/bin/bash
find /home -maxdepth 2 -type d -name .cache > /usr/local/bin/backupexclusions.txt
BACKUPTIME=`date +%Y%m%d%H%M%S` #get the current date/time
DESTINATION=/data/backup/Backup$BACKUPTIME.tar.gz #create a backup file using the current date in it's name
SOURCEFOLDER=/home #the folder that contains the files that we want to backup
tar -cpzf $DESTINATION $SOURCEFOLDER --exclude-from /usr/local/bin/backupexclusions.txt  #create the backup
cd /data/backup
ls -lt /data/backup/ | grep ^- | tr -s ' ' | cut -d ' ' -f 9 | grep -v '/$' | tail -n +7 | xargs -d '\n' -r rm --
