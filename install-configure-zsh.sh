#!/bin/bash
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

# 1. Install zsh using Homebrew
echo -e "${GREEN}1. Installing Zsh via Homebrew${RESET}"

if ! command -v brew &> /dev/null
then
    echo -e "${RED}Homebrew not found. Please install Homebrew first.${RESET}"
    exit 1
fi

brew install zsh

# 2. Delete ~/.zsh_plugins if it exists and make a fresh new folder
echo -e "${GREEN}2. Creating new ~/.zsh_plugins directory${RESET}"

ZSH_PLUGINS_DIR="$HOME/.zsh_plugins"
if [ -d "$ZSH_PLUGINS_DIR" ]; then
    echo -e "${YELLOW}Removing existing ~/.zsh_plugins directory${RESET}"
    rm -rf "$ZSH_PLUGINS_DIR"
fi
mkdir -p "$ZSH_PLUGINS_DIR"

# 3. Get zsh plugins
echo -e "${GREEN}3. Get Zsh plugins${RESET}"

echo -e "${YELLOW}Installing starship promt${RESET}"
brew install starship

echo -e "${YELLOW}Cloning repository git@github.com:zsh-users/zsh-autosuggestions.git into $HOME/.zsh_plugins/zsh-autosuggestions${RESET}"
git clone git@github.com:zsh-users/zsh-autosuggestions.git $HOME/.zsh_plugins/zsh-autosuggestions

echo -e "${YELLOW}Cloning repository git@github.com:zsh-users/zsh-completions.git into $HOME/.zsh_plugins/zsh-compeletions${RESET}"
git clone git@github.com:zsh-users/zsh-completions.git $HOME/.zsh_plugins/zsh-completion.git

echo -e "${YELLOW}Cloning repository git@github.com:zsh-users/zsh-history-substring-search.git into $HOME/.zsh_plugins/zsh-history-substring-search${RESET}"
git clone git@github.com:zsh-users/zsh-history-substring-search.git $HOME/.zsh_plugins/zsh-history-substring-search

echo -e "${YELLOW}Cloning repository git@github.com:zsh-users/zsh-syntax-highlighting.git into $HOME/.zsh_plugins/zsh-syntax-highlighting${RESET}"
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git $HOME/.zsh_plugins/zsh-syntax-highlighting

# 4. GNU stow the configuration from ~/.dotfiles/zsh to the home folder
echo -e "${GREEN}4. Stowing Zsh configuration from ~/.dotfiles/zsh to home directory${RESET}"

DOTFILES_DIR="$HOME/.dotfiles/zsh"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Directory $DOTFILES_DIR does not exist. Make sure you have the correct path.${RESET}"
    exit 1
fi

brew install stow  # Ensure GNU Stow is installed
cd "$HOME/.dotfiles" && stow zsh

# 5. Make zsh the default shell
echo -e "${GREEN}5. Make Zsh the default shell${RESET}"

ZSH_PATH=$(which zsh)
if [ "$SHELL" != "$ZSH_PATH" ]; then
    if ! grep -Fxq "$ZSH_PATH" /etc/shells; then
        echo -e "$ZSH_PATH" | sudo tee -a /etc/shells
    fi
    chsh -s "$ZSH_PATH"
    echo -e "${YELLOW}Zsh is now the default shell. Restart your terminal for the changes to take effect.${RESET}"
else
    echo -e "${YELLOW}Zsh is already the default shell.${RESET}"
fi

# 6. Source zshrc
echo -e "${GREEN}6. Source .zshrc${RESET}"

zsh -c "source ~/.zshrc"

echo -e "${GREEN}Done!${RESET}"
