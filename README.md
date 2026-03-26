# dotfiles

Hey there 👋! These are my macOS/Linux config dotfiles

## Packages

- [ghostty](https://ghostty.org/docs/install/binary)
- [neovim](https://neovim.io/)
- [bat](https://github.com/sharkdp/bat?tab=readme-ov-file#installation)
  - [catppuccin](https://github.com/catppuccin/bat?tab=readme-ov-file#usage)
- [git-delta](https://dandavison.github.io/delta/installation.html)
- [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)
- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
  - [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation)
  - [fzf-git](https://github.com/junegunn/fzf-git.sh?tab=readme-ov-file#installation)
- [eza](https://github.com/eza-community/eza?tab=readme-ov-file#installation)
- [zoxide](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation)
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/?tab=readme-ov-file#basic-installation)
  - [fzf-tab](https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#install)
  - [zsh-completions](https://github.com/zsh-users/zsh-completions?tab=readme-ov-file#using-zsh-frameworks)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
- [oh-my-posh](https://ohmyposh.dev/docs/installation/linux)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch?tab=readme-ov-file#installation)
- [thefuck](https://github.com/nvbn/thefuck?tab=readme-ov-file#installation)
- [gh](https://cli.github.com/)
- [tmux](https://github.com/tmux/tmux/wiki/Installing)
  - [tpm](https://github.com/tmux-plugins/tpm?tab=readme-ov-file#installation)
  - [gitmux](https://github.com/arl/gitmux?tab=readme-ov-file#installing)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [yazi](https://yazi-rs.github.io/docs/installation)
  - [catppuccin](https://github.com/yazi-rs/flavors/tree/main/catppuccin-mocha.yazi#-installation)
- [karabiner-elements](https://karabiner-elements.pqrs.org/) (macOS)
- [aerospace](https://nikitabobko.github.io/AeroSpace/guide#installation) (macOS)
  - [JankyBorders](https://nikitabobko.github.io/AeroSpace/guide#installation)
- [sketchybar](https://felixkratz.github.io/SketchyBar/setup#installation) (macOS)
  - [SbarLua](https://github.com/FelixKratz/SbarLua?tab=readme-ov-file#lua-module)
  - [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font?tab=readme-ov-file#cli-usage)
- [spicetify](https://spicetify.app/docs/advanced-usage/installation) (macOS)
  - [catppuccin](https://github.com/catppuccin/spicetify?tab=readme-ov-file#usage)

## Installation

Clone the repo into your home directory and run the install script:

```sh
git clone git@github.com:dtran421/dotfiles.git ~/dotfiles
bash ~/dotfiles/.config/scripts/install.sh
```

This handles everything: Homebrew, brew packages, stow symlinks, zsh plugins,
node, and macOS-specific setup.

To install just the brew dependencies separately:

```sh
brew bundle install --file=~/dotfiles/Brewfile
```
