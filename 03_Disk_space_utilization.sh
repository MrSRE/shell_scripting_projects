#!/bin/bash

# Set a threshold for disk usage percentage
THRESHOLD=80

# Get disk usage for each filesystem
echo "Checking disk space utilization..."
echo "Filesystem      Size  Used  Avail  Use%  Mounted on"
echo "---------------------------------------------------"
df -h | awk 'NR>1 {print $1, $2, $3, $4, $5, $6}' | while read filesystem size used avail use_percent mount
do
    # Remove the '%' sign from use percentage for comparison
    usage=${use_percent%\%}

    # Print the disk usage info
    printf "%-15s %-5s %-5s %-5s %-5s %-5s\n" "$filesystem" "$size" "$used" "$avail" "$use_percent" "$mount"

    # Check if the usage exceeds the threshold
    if [ "$usage" -ge "$THRESHOLD" ]; then
        echo "WARNING: $filesystem on $mount is ${use_percent} full!"
    fi
done
