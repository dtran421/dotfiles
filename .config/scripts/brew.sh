#!/usr/bin/env bash

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

log_section "Homebrew & Dependencies"

if ! command_exists brew; then
	log_step "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	is_linux && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
else
	log_skip "Homebrew"
fi

if is_macos; then
	log_step "Installing from Brewfile"
	brew bundle install --file=~/dotfiles/Brewfile
elif is_linux; then
	log_step "Installing from Brewfile.linux"
	brew bundle install --file=~/dotfiles/Brewfile.linux
fi

log_success "Brew dependencies installed"
