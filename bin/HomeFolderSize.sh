#!/usr/bin/env bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_GB.UTF-8
SHELL=/bin/sh
export DISPLAY=:0.0
homesize=`sudo du -s /home/* | sort -hr | cut -f 1 | awk '{s+=$1} END {print s}'`
gibi=1024*1024
echo $((homesize/gibi))
