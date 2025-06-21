#!/usr/bin/env bash

# Create log file if it doesn't exist
if [[ ! -f ./resource_usage.log ]]; then
	touch ./resource_usage.log
fi

# RAM Usage Calculation
total_ram=$(free | awk '/Mem:/ {print $2}')
used_ram=$(free | awk '/Mem:/ {print $3}')
ram_usage=$((used_ram*100/total_ram))

# CPU Usage Calculation (100 - %idle)
cpu_usage_floating=$(mpstat | awk '/all/ {print 100 - $NF}')
# Converting floating point number to integer
cpu_usage=$(printf "%.0f" "$cpu_usage_floating")

# Disk Usage Calculation (Root partition)
disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/[^0-9]//g')

# Current Timestamp
date_time=$(date "+%F %H:%M")

# Message
main_info="$date_time CPU: ${cpu_usage}% | RAM: ${ram_usage}% | Disk: ${disk_usage}%"

# Status Check
if [[ "$ram_usage" -gt 80 || "$cpu_usage" -gt 80 || "${disk_usage}" -gt 80 ]]; then
	echo -e "\033[1;31m$main_info - ⚠️  WARNING: High usage!\033[0m" | tee -a ./resource_usage.log
else
	echo -e "\033[1;32m$main_info - ✅ Normal\033[0m" | tee -a ./resource_usage.log
fi

# Optional: Run with Cron
# To monitor your system every 5 minutes:
# crontab -e
# */5 * * * * /full/path/to/SysResourceMonitor.sh
