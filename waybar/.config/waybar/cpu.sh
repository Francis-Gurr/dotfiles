#!/bin/bash

CPU_USAGE=$(top -bn2 | grep "Cpu(s)" | tail -n 1 | awk '{print int(100-$8)}')
CPU_TEMPERATURE=$(cat /sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon6/temp1_input | awk '{print int($1 / 1000)}')

TEXT="$CPU_USAGE% $CPU_TEMPERATURE°C  "
TOOLTIP="CPU"
if [ "$CPU_TEMPERATURE" -ge 80 ]; then
    CLASS="critical"
elif [ "$CPU_TEMPERATURE" -ge 60 ]; then
    CLASS="warning"
else
    CLASS="normal"
fi

printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$TEXT" "$TOOLTIP" "$CLASS"
