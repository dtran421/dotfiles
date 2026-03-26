#!/usr/bin/env bash
set -e

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

log_header "Installing dotfiles"

# Install zsh on Linux if missing
if is_linux && ! command_exists zsh; then
	log_step "Installing zsh"
	sudo apt install -y zsh
fi

bash "$SCRIPTS_DIR/brew.sh"
bash "$SCRIPTS_DIR/stow.sh"
bash "$SCRIPTS_DIR/node.sh"
bash "$SCRIPTS_DIR/zsh.sh"
bash "$SCRIPTS_DIR/macos.sh"
bash "$SCRIPTS_DIR/misc.sh"

log_header "All done! 🎉"
log_warn "Don't forget: open tmux and install plugins with ctrl+space+I"

exec zsh
