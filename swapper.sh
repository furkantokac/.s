#!/bin/bash


if [ $(/usr/bin/id -u) -ne 0 ]
then
    echo "Not running as root.";
    exit;
fi


swapOnAfter=5000 # in mb

while true
do
    usedRam=(`vmstat -s -SM | grep "M used memory"`)
    usedRam=${usedRam[0]}

    # ,f usedRam > swapOnAfter, swapoff.
    if [ $usedRam -gt $swapOnAfter ]
    then
        swapon -a;
    else
        swapoff -a;
    fi
    
    sleep 1;
done
