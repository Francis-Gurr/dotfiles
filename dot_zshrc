# ----------------------------------------------------------------------------------------------------
# ALIASES

source $HOME/.zsh_aliases

# ----------------------------------------------------------------------------------------------------
# SECRETS

source $HOME/.zsh_secrets

# ----------------------------------------------------------------------------------------------------
# PLUGINS

source $HOME/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $HOME/.zsh_plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source $HOME/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

fpath=($HOME/.zsh_plugins/zsh-completions/zsh-completions.git/src $fpath)

eval "$(starship init zsh)"

# ----------------------------------------------------------------------------------------------------
# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt INC_APPEND_HISTORY    # Update history file after each command
# ----------------------------------------------------------------------------------------------------
# OTHER

# Enable autocompletion
autoload -Uz compinit
compinit

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# add npm global binaries to path

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="$PATH:$HOME/.local/bin"
