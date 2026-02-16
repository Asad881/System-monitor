#!/bin/bash

set -euo pipefail

cleanup() {
echo -e "\nSentinel shutting down"
exit 0
}

trap cleanup SIGINT SIGTERM



while true ;do

timestamp=$(date -Is)
ram=$(free -h | grep "Mem" | awk '{print $2}')
disk=$(df / -h | awk 'NR==2 {print $5}' | tr -d "%")
INTERVAL=${INTERVAL:-10}
disk_alert=10

if [ $disk -gt $disk_alert ]; then
printf "{\"INTERVAL\": \"$INTERVAL\",\"Monitor Name\": \"$MONITOR_NAME\",\"timestamp:\" \"$timestamp\",\"ram:\" \"$ram\",\"disk:\" \"$disk\" \"Status:\" \"CRITICAL\"}\n |" tee -a /app/logs/monitor.log
else
printf "{\"INTERVAL\": \"$INTERVAL\",\"Monitor Name\": \"$MONITOR_NAME\",\"timestamp:\" \"$timestamp\",\"ram:\" \"$ram\",\"disk:\" \"$disk\"}\n" | tee -a /app/logs/monitor.log
fi


sleep $INTERVAL

done
