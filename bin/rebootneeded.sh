#!/usr/bin/env bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_GB.UTF-8
SHELL=/bin/sh
export DISPLAY=:0.0
LAST_KERNEL=$(rpm -q --last kernel | perl -pe 's/^kernel-(\S+).*/$1/' | head -1)
 CURRENT_KERNEL=$(uname -r)

 if [ $LAST_KERNEL != $CURRENT_KERNEL ]
 then 
    echo "It is time to Reboot!"
 else 
    echo "There is nothing to do!"
 fi
