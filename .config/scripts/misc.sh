#!/usr/bin/env bash

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

log_section "Misc Setup"

log_step "Downloading fzf-git.sh"
curl -fsSL "https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh" -o "$SCRIPTS_DIR/fzf-git.sh"

log_step "Downloading eza catppuccin theme"
mkdir -p ~/.config/eza
curl -fsSL "https://raw.githubusercontent.com/eza-community/eza-themes/refs/heads/main/themes/catppuccin-mocha.yml" -o ~/.config/eza/theme.yml

log_step "Downloading catppuccin mocha yazi themes"
YAZI_THEMES_DIR="$HOME/.config/yazi/themes"
mkdir -p "$YAZI_THEMES_DIR"
MOCHA_ACCENTS=(blue flamingo green lavender maroon mauve peach pink red rosewater sapphire sky teal yellow)
for accent in "${MOCHA_ACCENTS[@]}"; do
  curl -fsSL "https://raw.githubusercontent.com/catppuccin/yazi/main/themes/mocha/catppuccin-mocha-${accent}.toml" \
    -o "$YAZI_THEMES_DIR/catppuccin-mocha-${accent}.toml"
done

log_step "Downloading catppuccin mocha tmTheme for yazi preview syntax highlighting"
curl -fsSL "https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme" \
  -o "$HOME/.config/yazi/Catppuccin-mocha.tmTheme"

log_step "Setting default yazi theme (mocha blue)"
cp "$YAZI_THEMES_DIR/catppuccin-mocha-blue.toml" "$HOME/.config/yazi/theme.toml"
echo "blue" >"$HOME/.config/yazi/.current-accent"

log_success "Misc setup complete"
