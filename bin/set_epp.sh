#!/bin/bash

echo "balance_performance" | tee /sys/devices/system/cpu/cpu{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}/cpufreq/energy_performance_preference
exit 0
