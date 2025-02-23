#!/bin/bash

CHOICE=$(echo -e " Lock\n⏾ Sleep\n⏻ Shutdown\n Restart" | fuzzel --dmenu -p "⚡ " -l 4 -w 16)

case "$CHOICE" in
    " Lock") swaylock ;;
    "⏾ Sleep") systemctl suspend ;;
    "⏻ Shutdown") systemctl poweroff ;;
    " Restart") systemctl reboot ;;
esac

