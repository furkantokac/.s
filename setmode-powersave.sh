#!/bin/sh

mode="powersave"

numOfCores=`nproc`
numOfCores=`expr $numOfCores - 1`

for i in `seq 0 $numOfCores`
do
    sudo sh -c "echo $mode > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor"
done
