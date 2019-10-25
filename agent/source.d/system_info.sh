#!/bin/bash

hostfs="/hostfs"

output="{\"hostname\":\"$(cat $hostfs/etc/hostname)\"";


output="$output, \"loadavg\":$(cat $hostfs/proc/loadavg | awk '{print $1}')"

output="$output, \"mem_avail_kb\":$(cat $hostfs/proc/meminfo | grep MemAvailable | awk '{print $2}')"
output="$output, \"mem_total_kb\":$(cat $hostfs/proc/meminfo | grep MemTotal | awk '{print $2}')"

output="$output, \"fs_info\":\"$(df $hostfs | grep "/" | awk '{print $1}')\""
output="$output, \"fs_use_prct\":$(df $hostfs | grep "/" | awk '{print substr($5, 1, length($5)-1)}')"
output="$output, \"fs_total_kb\":$(df $hostfs | grep "/" | awk '{print $2}')"
output="$output, \"fs_used_kb\":$(df $hostfs | grep "/" | awk '{print $3}')"
output="$output, \"fs_avail_kb\":$(df $hostfs | grep "/" | awk '{print $4}')"


output="$output, \"fs_iuse_prct\":$(df -i $hostfs| grep "/" | awk '{print substr($5, 1, length($5)-1)}')"
output="$output, \"fs_total_inode\":$(df -i $hostfs| grep "/" | awk '{print $2}')"
output="$output, \"fs_used_inode\":$(df -i $hostfs| grep "/" | awk '{print $3}')"
output="$output, \"fs_avail_inode\":$(df -i $hostfs| grep "/" | awk '{print $4}')"

output="$output}";

echo $output;