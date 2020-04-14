#!/bin/bash


if [ $(/usr/bin/id -u) -ne 0 ]
then
    echo "Not running as root.";
    exit;
fi


# If swapOn and swapOff be the same value, swapon-off may bounce too much which
# is not very nice situation.
swapOnAfter=5000    # in mb
swapOffBefore=4000  # in mb

isSwapOn=1


fun_swapon()
{
    # If already swap on, don't do it again.
    if [ $isSwapOn -eq 0 ]
    then
        swapon -a
        isSwapOn=1
        
        echo "Go swap -> on"
    fi
}


fun_swapoff()
{
    # If already swap off, don't do it again.
    if [ $isSwapOn -eq 1 ]
    then
        swapoff -a
        isSwapOn=0
        
        echo "Go swap -> off"
    fi
}


while true
do
    usedRam=(`vmstat -s -SM | grep "M used memory"`)
    usedRam=${usedRam[0]}

    
    # if usedRam > swapOnAfter, swap-on.
    if [ $usedRam -gt $swapOnAfter ]
    then
        fun_swapon
    fi
    
    
    # if usedRam < swapOffBefore, swap-off.
    if [ $usedRam -lt $swapOffBefore ]
    then
        fun_swapoff
    fi
    
    
    sleep 1;
done
