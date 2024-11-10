#!/bin/bash

VOLUME_OUTPUT=$(wpctl get-volume @DEFAULT_SOURCE@)
VOLUME=$(echo "$VOLUME_OUTPUT" | awk '{print int($2 * 100)}')
MUTED=$(echo "$VOLUME_OUTPUT" | awk '{print mkbool($3)}')
# wpctl get-volume @DEFAULT_SOURCE@ | gawk '{print ($3) ? "true" : "false"}'
DEVICE=$(wpctl inspect @DEFAULT_SOURCE@ | grep -oP '(?<=node.nick = ").*(?=")')

if [ "$MUTED" -eq 0 ]; then
    TEXT="$VOLUME%  "
else
    TEXT=" "
fi
TOOLTIP="$DEVICE"

printf '{"text": "%s", "tooltip": "%s"}\n' "$TEXT" "$TOOLTIP"

