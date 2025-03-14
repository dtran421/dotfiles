# dotfiles

Hey there 👋! These are my macOS/Linux config dotfiles

## Packages

- [ghostty](https://ghostty.org/docs/install/binary)
- [bat](https://github.com/sharkdp/bat?tab=readme-ov-file#installation)
  - [catppuccin](https://github.com/catppuccin/bat?tab=readme-ov-file#usage)
- [delta](https://dandavison.github.io/delta/installation.html)
- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
  - [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation)
  - [fzf-git](https://github.com/trapd00r/LS_COLORS?tab=readme-ov-file#installation)
- [eza](https://github.com/eza-community/eza?tab=readme-ov-file#installation)
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/?tab=readme-ov-file#basic-installation)
  - [fzf-tab](https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#install)
  - [LS_COLORS](https://github.com/trapd00r/LS_COLORS?tab=readme-ov-file#installation)
  - [zsh-completions](https://github.com/zsh-users/zsh-completions?tab=readme-ov-file#using-zsh-frameworks)
- [tmux](https://github.com/tmux/tmux/wiki/Installing)
  - [tpm](https://github.com/tmux-plugins/tpm?tab=readme-ov-file#installation)
  - [gitmux](https://github.com/arl/gitmux?tab=readme-ov-file#installing)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [yazi](https://yazi-rs.github.io/docs/installation)
  - [catppuccin](https://github.com/yazi-rs/flavors/tree/main/catppuccin-mocha.yazi#-installation)
- [aerospace](https://nikitabobko.github.io/AeroSpace/guide#installation)
  - [JankyBorders](https://nikitabobko.github.io/AeroSpace/guide#installation)
- [sketchybar](https://felixkratz.github.io/SketchyBar/setup#installation)

  - [SbarLua](https://github.com/FelixKratz/SbarLua?tab=readme-ov-file#lua-module)

  ```sh
    git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && \
    cd /tmp/SbarLua/ && \
    make install && \
    rm -rf /tmp/SbarLua/
  ```

  - [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font?tab=readme-ov-file#cli-usage)

  ```sh
    curl \
    -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.32/sketchybar-app-font.ttf \
    -o $HOME/Library/Fonts/sketchybar-app-font.ttf
  ```

- [spicetify](https://spicetify.app/docs/advanced-usage/installation)
  - [catppuccin](https://github.com/catppuccin/spicetify?tab=readme-ov-file#usage)

## Installation

### Prerequisities

Make sure you install the following:

#### Brew (or nix-env)

#### Git

```sh
brew install git
```

#### Stow

```sh
brew install stow
```

### MacOS

First, checkout this dotfiles repo in your $HOME directory using git

```sh
git clone git@github.com/dtran421/dotfiles.git
```

Use GNU Stow to create symlinks to $HOME directory

```sh
cd dotfiles
stow .
```

Run this command to install dependencies

```sh
brew bundle install
```

## Package Installation

Try to use `brew` for MacOS, otherwise look for download links.

### Linux

1. For x86_64 Linux, download the `musl` or `amd64` binary file
2. Move the file to the `/usr/local/bin/` directory
3. Reload `zsh` via `rld-zsh`

## Committing Changes

First, ensure you're in the dotfiles folder `$HOME/dotfiles`. Make changes to a dotfile.
Then, run the following commands:

```sh
git add <dotfile name>
```

```sh
git commit -m <commit message>
```

```sh
git push
```
