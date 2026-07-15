#!/bin/sh
# GNOME defaults: dark mode + US keyboard layout (login screen and session).
set -eu

command -v gsettings >/dev/null 2>&1 || exit 0

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"

command -v localectl >/dev/null 2>&1 && sudo localectl set-x11-keymap us
