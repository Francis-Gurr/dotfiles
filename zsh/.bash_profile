# If not already in Zsh, switch to it (only for interactive shells —
# non-interactive bash invocations like `bash -c '...'` must not hijack
# themselves into zsh, or tools that rely on a clean bash will hang).
if [ -z "$ZSH_VERSION" ] && [[ $- == *i* ]]; then
  exec zsh
fi

. "$HOME/.local/share/../bin/env"

# Created by `pipx` on 2026-04-30 09:20:44
export PATH="$PATH:/home/francis.gurr/.local/bin"
