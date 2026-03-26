#!/usr/bin/env bash

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

log_section "macOS-specific Setup"

if ! is_macos; then
	log_info "Not macOS, skipping"
	return 0 2>/dev/null || exit 0
fi

# SbarLua
if [[ -f "$HOME/.local/share/sketchybar_lua/sketchybar.so" ]]; then
	log_skip "SbarLua"
else
	log_step "Building SbarLua"
	git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua &&
		cd /tmp/SbarLua/ &&
		make install &&
		rm -rf /tmp/SbarLua/
fi

# Ghostty theme
log_step "Installing Ghostty catppuccin theme"
curl -fsSL -O --create-dirs --output-dir ~/.config/ghostty/themes \
	"https://raw.githubusercontent.com/catppuccin/ghostty/refs/heads/main/themes/catppuccin-mocha.conf"
log_info "Reload Ghostty with cmd+shift+,"

# Sketchybar app font
log_step "Installing sketchybar-app-font"
curl -fsSL -L \
	"https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.47/sketchybar-app-font.ttf" \
	-o "$HOME/Library/Fonts/sketchybar-app-font.ttf"

# Spicetify
if command_exists spicetify; then
	log_skip "Spicetify"
else
	log_step "Installing Spicetify"
	curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh

	# Spicetify catppuccin theme
	log_step "Installing Spicetify catppuccin theme"
	git clone --depth 1 https://github.com/catppuccin/spicetify.git /tmp/spicetify-catppuccin
	cp -r /tmp/spicetify-catppuccin/catppuccin ~/.config/spicetify/Themes/
	rm -rf /tmp/spicetify-catppuccin

	spicetify config current_theme catppuccin
	spicetify config color_scheme mocha
	spicetify config inject_css 1 inject_theme_js 1 replace_colors 1 overwrite_assets 1
	spicetify backup apply
fi

log_success "macOS setup complete"
