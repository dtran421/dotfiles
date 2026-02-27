#!/bin/zsh

OS_NAME=$(uname -s)

echo "Installing dotfiles"

if [[ "$OS_NAME" == "Darwin" ]]; then
  ./install-ghostty.sh
else
  echo "Ghostty is not supported on $OS_NAME"
fi

if [[ ! -f $HOME/.init.zsh ]]; then
  echo "Creating init.zsh"
  touch $HOME/.init.zsh
else
  echo "init.zsh already exists, re-using"
fi

echo "Initializing oh-my-zsh"

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Starting misc setup..."

wget https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -O ~/.config/scripts/fzf-git.sh

if [[ "$OS_NAME" == "Darwin" ]]; then
  echo "Installing fonts"
  curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.47/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
fi

echo "Done!"
