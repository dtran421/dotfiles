# dotfiles
macOS config dotfiles

## Packages

- [bat](https://github.com/sharkdp/bat?tab=readme-ov-file#installation)
    - [tokyonight](https://github.com/folke/tokyonight.nvim?tab=readme-ov-file#-installation)
    > Use [this comment](https://github.com/folke/tokyonight.nvim/issues/23#issuecomment-1581586548) to install for `bat`
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

## Package Installation

### MacOSX

Run this command:

```
brew bundle install --file=.Brewfile
```

### Linux

1. For x86_64 Linux, download the `musl` or `amd64` binary file
2. Move the file to the `/usr/local/bin/` directory
3. Reload `zsh` via `reload-zsh`

## Committing Changes

First, ensure you're in the root folder `~/`. Make changes to a dotfile. Then, run the following commands:

```sh
    dotfiles <add/stage> <dotfile name>
```

```sh
    dotfiles commit -m <commit message>
```

```sh
    dotfiles push
```


## Appendix

- [Bitbucket Tutorial](https://www.atlassian.com/git/tutorials/dotfiles)

- [Medium Article](https://fwuensche.medium.com/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b)
