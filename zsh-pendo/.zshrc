# ----------------------------------------------------------------------------------------------------
# PATH

path=(/bin /usr/bin /usr/local/bin .)
path+=(~/'bin')
path+=('/usr/local/opt/grep/libexec/gnubin')
path+=('/Users/francis.gurr/Library/Python/3.9/bin')
export PATH

# remove duplicate entries from $PATH
# zsh uses $path array along with $PATH
typeset -U PATH path

# ----------------------------------------------------------------------------------------------------
# ENVARS

export LOCAL_DEV_CERT=${HOME}/dev/local-ssl/local.pendo.io.crt
export LOCAL_DEV_KEY=${HOME}/dev/local-ssl/local.pendo.io.key

# pendo-appengine dev server setup
export PENDO_STORAGE=${HOME}/appengine.${USER}/

# code completion setup
autoload -Uz compinit
compinit -i
autoload -U +X bashcompinit && bashcompinit

# gcloud sdk setup
source "${HOME}/sdk/google-cloud-sdk/path.zsh.inc"
source "${HOME}/sdk/google-cloud-sdk/completion.zsh.inc"

if [ -f ${HOME}/.config/gcloud/application_default_credentials.json ]; then
  export GOOGLE_APPLICATION_CREDENTIALS=${HOME}/.config/gcloud/application_default_credentials.json
fi

# ----------------------------------------------------------------------------------------------------
# NVM Setup

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ----------------------------------------------------------------------------------------------------
# ALIASES

# Get bash aliases from .zsh_aliases
if [ -f ${HOME}/.zsh_aliases ]; then
  source ${HOME}/.zsh_aliases
fi

# ----------------------------------------------------------------------------------------------------
# PLUGINS

source $HOME/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source $HOME/.zsh_plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source $HOME/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

fpath=($HOME/.zsh_plugins/zsh-completions/src $fpath)

eval "$(starship init zsh)"
