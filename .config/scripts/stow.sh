#!/usr/bin/env bash

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

log_section "Stow & Symlinks"

if ! command_exists stow; then
	log_step "Installing stow"
	brew install stow
else
	log_skip "stow"
fi

cd "$HOME/dotfiles" || { log_error "dotfiles directory not found"; exit 1; }

if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
	log_warn "Backing up existing .zshrc → .zshrc.bak"
	mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

log_step "Running stow"
stow .

if [[ ! -f "$HOME/.init.zsh" ]]; then
	log_step "Creating ~/.init.zsh from template"
	cp "$HOME/dotfiles/.init.zsh.template" "$HOME/.init.zsh"
else
	log_skip "~/.init.zsh"
fi

log_success "Symlinks created"
