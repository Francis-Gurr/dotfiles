#!/usr/bin/env bash

# ===============================
# Color codes
# ===============================
RESET='\033[0m'

BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# ===============================
# Functions
# ===============================

# Colored output: out "message" COLOR
out() {
    local msg="$1"
    local color="$2"

    # Default color to WHITE if none provided
    color="${color:-$WHITE}"

    echo -e "${color}${msg}${RESET}"
}

# Quick helpers for common colors
out_red() { out "$1" "$RED"; }
out_green() { out "$1" "$GREEN"; }
out_yellow() { out "$1" "$YELLOW"; }
out_blue() { out "$1" "$BLUE"; }
out_magenta() { out "$1" "$MAGENTA"; }
out_cyan() { out "$1" "$CYAN"; }
