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
