#!/bin/sh
# Make zsh the default login shell.
set -eu

zsh_path="$(command -v zsh || true)"
[ -n "$zsh_path" ] || { echo "zsh not found; skipping default-shell change"; exit 0; }

grep -qx "$zsh_path" /etc/shells 2>/dev/null || echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null

login_shell="$(getent passwd "$(id -un)" 2>/dev/null | cut -d: -f7)"
[ -n "$login_shell" ] || login_shell="$(dscl . -read /Users/"$(id -un)" UserShell 2>/dev/null | awk '{print $NF}')"
[ "$login_shell" = "$zsh_path" ] || chsh -s "$zsh_path"
