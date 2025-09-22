#!/bin/zsh

echo "Installing ghostty"

theme_url="https://raw.githubusercontent.com/catppuccin/ghostty/refs/heads/main/themes/catppuccin-mocha.conf"
curl -O --create-dirs --output-dir ~/.config/ghostty/themes $theme_url

echo "Done! Reload ghostty with cmd+shift+,"

