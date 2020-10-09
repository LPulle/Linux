#!/bin/bash
## Variables for mail location, machine name, and date
mailpath=$(echo "/var/mail/root") #change this if your mail is in a different location
mailpathbkp=$(echo "/var/mail/rootbkp") #change this if your backup needs to go elsewhere
machine=$(echo "root@"$hostname".localdomain") #change this if the from address is a different format
today="$(date +"%a %b %e")" #change this if the date format is different
search="$(echo "$machine" ""  "$today")" #make the search string (note the padded spaces)

## Find the first row with the search string
mailstart=$(grep -n "$search" $mailpath | cut -d : -f 1 | head -1)

## Move mail to rename as backup (in case it goes wrong)
mv $mailpath $mailpathbkp

## Skip to the mailstart line and take every line from there
## Make a new mail file with this mail
tail -n +$mailstart $mailpathbkp > $mailpath
