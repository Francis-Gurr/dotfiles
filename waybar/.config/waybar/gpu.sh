#!/bin/bash

GPU_USAGE=$(radeontop -b 3 -d - -l 1 | grep -oP 'gpu\s+\K[0-9.]+' | awk '{print int($1)}')
GPU_TEMPERATURE=$(cat /sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.0/hwmon/hwmon3/temp1_input | awk '{print int($1 / 1000)}')

TEXT="$GPU_USAGE% $GPU_TEMPERATURE°C  "
TOOLTIP="GPU"
if [ "$GPU_TEMPERATURE" -ge 80 ]; then
    CLASS="critical"
elif [ "$GPU_TEMPERATURE" -ge 60 ]; then
    CLASS="warning"
else
    CLASS="normal"
fi

printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$TEXT" "$TOOLTIP" "$CLASS"
