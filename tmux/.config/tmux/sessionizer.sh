#!/usr/bin/env bash
set -euo pipefail

DEV_DIR="$HOME/dev"
DOTFILES="$HOME/.dotfiles"
TMUXP_DIR="$HOME/.config/tmuxp"

declare -A REPO_PATHS

# Scan ~/dev
while read -r path; do
    repo=$(dirname "$path")
    repo_name=$(basename "$repo")
    if [[ $(basename "$path") == ".bare" ]]; then
        # Bare repo → list workspaces
        for ws in "$repo"/*/; do
            [[ -d "$ws" ]] || continue
            wsname=$(basename "$ws")
            [[ "$wsname" == .* ]] && continue
            key="$repo_name/$wsname"
            REPO_PATHS["$key"]="$ws"
        done
    else
        REPO_PATHS["$repo_name"]="$repo"
    fi
done < <(find "$DEV_DIR" -maxdepth 2 -type d \( -name ".git" -o -name ".bare" \) 2>/dev/null)

# Add dotfiles explicitly
REPO_PATHS[".dotfiles"]="$DOTFILES"

# Present choices to user
# selection=$(printf "%s\n" "${!REPO_PATHS[@]}" | sort | fzf --prompt="Select repo: ")
# Pick fzf frontend
choices=$(printf "%s\n" "${!REPO_PATHS[@]}" | sort)
if [[ -n "${TMUX:-}" ]] && command -v fzf-tmux >/dev/null; then
    selection=$(echo "$choices" | fzf-tmux -p 80%,60% --prompt="Select repo: ")
else
    selection=$(echo "$choices" | fzf --height=40% --layout=reverse --border --prompt="Select repo: ")
fi

[[ -z "$selection" ]] && exit 0

selected_path="${REPO_PATHS[$selection]}"
selected_repo_name=""
if [[ "$selection" == *"/"* ]]; then
    # Workspace selected
    selected_repo_name=$(basename "$(dirname "$selected_path")")
else
    selected_repo_name=$(basename "$selected_path")
fi

# Determine tmuxp config
tmuxp_config="default"
if [[ -f "$TMUXP_DIR/$selected_repo_name.yaml" ]]; then
    tmuxp_config="$selected_repo_name"
fi
echo "$selected_repo_name"
echo "$tmuxp_config"

# Load tmuxp YAML with env vars
export SESSION_NAME=$(echo "$selection" | sed 's/[^a-zA-Z0-9_/-]/_/g') # Replace . or whitespace with _
export START_DIR="$selected_path"
tmuxp load "$tmuxp_config" --yes 
