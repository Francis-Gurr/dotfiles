# ----------------------------------------------------------------------------------------------------
# ALIASES

source $HOME/.zsh_aliases

# ----------------------------------------------------------------------------------------------------
# SECRETS

source $HOME/.zsh_secrets

# ----------------------------------------------------------------------------------------------------
# PLUGINS

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

fpath=(/usr/share/zsh/site-functions $fpath)

eval "$(starship init zsh)"

# ----------------------------------------------------------------------------------------------------
# OTHER

# Enable autocompletion
autoload -Uz compinit
compinit

# add npm global binaries to path

# pnpm
export PNPM_HOME="/home/francis/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
