#!/usr/bin/env bash

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

log_section "Misc Setup"

log_step "Downloading fzf-git.sh"
curl -fsSL "https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh" -o "$SCRIPTS_DIR/fzf-git.sh"

log_step "Downloading eza catppuccin theme"
mkdir -p ~/.config/eza
curl -fsSL "https://raw.githubusercontent.com/eza-community/eza-themes/refs/heads/main/themes/catppuccin-mocha.yml" -o ~/.config/eza/theme.yml

log_success "Misc setup complete"
