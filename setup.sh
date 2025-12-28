BOLD_BLUE='\033[1;34m'
RESET='\033[0m'

info() {
    echo -e "${BOLD_BLUE}${*}${RESET}"
}

if command -v dnf >/dev/null 2>&1; then
	info "Installing ansible-core and stow (Fedora detected)"
	sudo dnf upgrade
	sudo dnf install ansible-core stow
fi

if git -C "$DOTFILES_DIR" submodule status --recursive | grep -q "^[-+]"; then
	info "Updating submodules..."
        git -C "$DOTFILES_DIR" submodule update --init --recursive --depth 1
else
        info "Submodules are up to date."
fi

info "Running core playbooks"
ansible-playbook -K ~/.dotfiles/core-playbook.yml

if [ -n "$BASH_VERSION" ] && [ -f /usr/bin/zsh ]; then
    info "Setup complete. Switching to Zsh..."
    exec /usr/bin/zsh -l
fi
