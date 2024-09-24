#!/bin/bash
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

# 1. Install packages using pacman
echo -e "${GREEN}1. Installing Zsh and plugins via pacman${RESET}"

zsh_packages=(
    zsh
    zsh-autosuggestions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
    starship
)

wezterm_packages=(
    wezterm
    ttf-nerd-fonts-symbols-mono
    ttf-firacode-nerd
)

git_packages=(
    git
    less
    difftastic
)

other_packages=(
    stow
    bat
    lsd
)

sudo pacman -S --noconfirm "${zsh_packages[@]}" "${wezterm_packages[@]}" "${git_packages[@]}" "${other_packages}" 

# 2. GNU stow the configuration from ~/.dotfiles/zsh to the home folder
echo -e "${GREEN}2. Stowing Zsh configuration from ~/.dotfiles/zsh to home directory${RESET}"

cd "$HOME/.dotfiles" && stow zsh

# 3. Make zsh the default shell
echo -e "${GREEN}3. Make Zsh the default shell${RESET}"

ZSH_PATH=$(which zsh)
if [ "$SHELL" != "$ZSH_PATH" ]; then
    if ! grep -Fxq "$ZSH_PATH" /etc/shells; then
        echo -e "$ZSH_PATH" | sudo tee -a /etc/shells
    fi
    chsh -s "$ZSH_PATH"
    echo -e "${YELLOW}Zsh is now the default shell.${RESET}"
else
    echo -e "${YELLOW}Zsh is already the default shell.${RESET}"
fi

zsh

# 4. Source zshrc
echo -e "${GREEN}4. Source .zshrc${RESET}"

zsh -c "source ~/.zshrc"

echo -e "${GREEN}Done!${RESET}"
