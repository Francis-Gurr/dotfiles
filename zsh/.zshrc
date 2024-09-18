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

fpath=($HOME/.zsh_plugins/zsh-completions/src $fpath)

eval "$(starship init zsh)"
