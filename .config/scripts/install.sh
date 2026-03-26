#!/usr/bin/env bash

OS_NAME=$(uname -s)

pretty_print() {
	printf "\n"
	printf "==================================================\n"
	printf "\n"
	printf "   %s\n" "$1"
	printf "\n"
	printf "==================================================\n"
	printf "\n"
}

pretty_print "Installing dotfiles"

if [[ "$OSTYPE" == "linux-gnu"* ]] && ! command -v zsh &>/dev/null; then
	sudo apt install zsh
fi

pretty_print "Installing brew and dependencies"

if ! command -v brew &>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
	fi
fi

if [[ "$OS_NAME" == "Darwin" ]]; then
	brew bundle install --file=~/dotfiles/Brewfile
elif [[ "$OS_NAME" == "Linux" ]]; then
	brew bundle install --file=~/dotfiles/Brewfile.linux
fi

pretty_print "Installing Nodejs and npm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
nvm install node

if [[ "$OS_NAME" == "Darwin" ]]; then
	pretty_print "Installing Ghostty"

	theme_url="https://raw.githubusercontent.com/catppuccin/ghostty/refs/heads/main/themes/catppuccin-mocha.conf"
	curl -O --create-dirs --output-dir ~/.config/ghostty/themes $theme_url

	echo "Done! Reload Ghostty with cmd+shift+,"
else
	echo "Ghostty is not supported on $OS_NAME"
fi

brew install stow
cd "$HOME/dotfiles" || exit
[[ -f $HOME/.zshrc ]] && mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
stow .

if [[ ! -f $HOME/.init.zsh ]]; then
	echo "Creating init.zsh"
	touch "$HOME/.init.zsh"
else
	echo "init.zsh already exists, re-using"
fi

pretty_print "Installing oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab"
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

pretty_print "Misc setup"

wget https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -O ~/.config/scripts/fzf-git.sh

if [[ "$OS_NAME" == "Darwin" ]]; then
	echo "Installing fonts"
	curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.47/sketchybar-app-font.ttf -o "$HOME/Library/Fonts/sketchybar-app-font.ttf"
fi

mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

echo "Don't forget to conf-tmux and install packages via ctrl+space+I"

pretty_print "Done! Reloading zsh..."

exec zsh
