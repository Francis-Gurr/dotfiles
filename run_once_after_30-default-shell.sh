#!/bin/sh
# Make zsh the default login shell.
set -eu

zsh_path="$(command -v zsh || true)"
[ -n "$zsh_path" ] || { echo "zsh not found; skipping default-shell change"; exit 0; }

grep -qx "$zsh_path" /etc/shells 2>/dev/null || echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null

case "${SHELL:-}" in
	*/zsh) ;;
	*) chsh -s "$zsh_path" ;;
esac
