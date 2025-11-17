#!/bin/zsh

OS_NAME=$(uname -s)

echo "Installing dotfiles"

./install-ghostty.sh

echo "Misc setup"

if [[ "$OS_NAME" == "Darwin" ]]; then
  echo "Installing fonts"
  curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.47/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
fi

echo "Done!"
