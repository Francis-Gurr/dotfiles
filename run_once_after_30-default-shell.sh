#!/bin/sh
# Make zsh the default login shell (idempotent). Runs once.
set -eu

zsh_path="$(command -v zsh || true)"
if [ -z "$zsh_path" ]; then
	echo "zsh not found; skipping default-shell change"
	exit 0
fi

# Register zsh in /etc/shells if missing (required for chsh to accept it).
if ! grep -qx "$zsh_path" /etc/shells 2>/dev/null; then
	echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
fi

case "${SHELL:-}" in
	*/zsh) ;;
	*) chsh -s "$zsh_path" ;;
esac
