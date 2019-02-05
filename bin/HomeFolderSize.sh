#!/bin/bash                                                                                
homesize=`sudo du -s /home/* | sort -hr | cut -f 1 | awk '{s+=$1} END {print s}'`
gibi=1024*1024
echo $((homesize/gibi))
