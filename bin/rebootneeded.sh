#!/bin/bash
LAST_KERNEL=$(rpm -q --last kernel | perl -pe 's/^kernel-(\S+).*/$1/' | head -1)
 CURRENT_KERNEL=$(uname -r)

 if [ $LAST_KERNEL != $CURRENT_KERNEL ]
 then 
    echo "It is time to Reboot!"
 else 
    echo "There is nothing to do!"
 fi
