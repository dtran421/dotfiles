
# ╔══════════════════════════════════════════════════════════════════════╗
# ║                          🛠️  Environment                             ║
# ╚══════════════════════════════════════════════════════════════════════╝

export EDITOR=nvim
export PATH="$PATH:$HOME/.local/bin:$HOME/.spicetify:$HOME/go/bin"
export GO111MODULE=on

# Linuxbrew
if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

# Yarn
[[ -x "$(command -v yarn)" ]] && export PATH="$PATH:$(yarn global bin)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        💤  Oh My Zsh                                 ║
# ╚══════════════════════════════════════════════════════════════════════╝

export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' cheaper yes
zstyle ':omz:plugins:yarn' berry yes

ENABLE_CORRECTION="true"

plugins=(
  alias-finder
  extract
  fzf-tab
  git
  git-commit
  tmux
  yarn
  zsh-autosuggestions
  zsh-syntax-highlighting
)

fpath=(${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src $fpath)
autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        🎨  oh-my-posh                                ║
# ╚══════════════════════════════════════════════════════════════════════╝

[[ "$TERM_PROGRAM" != "Apple_Terminal" ]] && eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        🐍  conda                                     ║
# ╚══════════════════════════════════════════════════════════════════════╝

__conda_setup="$('/Users/dtran/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/Users/dtran/opt/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/Users/dtran/opt/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/Users/dtran/opt/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                       🔍  Completions                                ║
# ╚══════════════════════════════════════════════════════════════════════╝

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                       ⌨️  Key Bindings                               ║
# ║ - Delete word: ^w                                                    ║
# ║ - Delete to end of line: ^k                                          ║
# ║ - Delete to start of line: ^u                                        ║
# ║ - Undo: ^-                                                           ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Prevent shell from closing on ^D
set -o ignoreeof

# Open buffer in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Copy current command to clipboard (OSC 52 — works over SSH)
copy-command() {
  printf "\e]52;c;%s\a" "$(echo -n "$BUFFER" | base64 | tr -d '\n')"
  zle -M "Copied to clipboard"
}
zle -N copy-command
bindkey '^Xc' copy-command

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        📂  eza (better ls)                           ║
# ╚══════════════════════════════════════════════════════════════════════╝

export EZA_CONFIG_DIR="$HOME/.config/eza"
export LS_COLORS=
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        🔎  fzf                                       ║
# ╚══════════════════════════════════════════════════════════════════════╝

eval "$(fzf --zsh)"
source ~/.config/scripts/fzf-git.sh

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }
_fzf_compgen_dir() { fd --type=d --hidden --exclude .git . "$1"; }

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        🦇  bat (better less)                         ║
# ╚══════════════════════════════════════════════════════════════════════╝

export BAT_THEME="Catppuccin Mocha"

# Preview installed bat themes interactively
preview_bat() {
  bat --list-themes | fzf --preview="bat --theme={} --color=always $1"
}

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        📁  zoxide (better cd)                        ║
# ╚══════════════════════════════════════════════════════════════════════╝

eval "$(zoxide init zsh)"
alias cd="z"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        📁  yazi                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# cd to last visited dir on exit
yz() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        🖥️  fastfetch                                 ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Preview presets interactively
preview_fastfetch() {
  fastfetch --list-presets \
    | awk '/^examples\/$/{prefix="examples/"; next} /^\s*\|/{print prefix $NF; next} /^[^ |]/{prefix=""; print $1}' \
    | fzf --ansi --preview="fastfetch --config {}" --preview-window=right:60%
}

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        🤬  thefuck                                   ║
# ╚══════════════════════════════════════════════════════════════════════╝

eval $(thefuck --alias)

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        😎  lazygit                                   ║
# ╚══════════════════════════════════════════════════════════════════════╝

alias lg=lazygit

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        🏷️  Aliases                                   ║
# ╚══════════════════════════════════════════════════════════════════════╝

# config shortcuts
alias conf-zsh="nvim ~/.zshrc"
alias conf-init="nvim ~/.init.zsh"
alias conf-omp="nvim ~/.config/ohmyposh/config.toml"
alias conf-tmux="nvim ~/.config/tmux/tmux.conf"
alias conf-nvim="nvim ~/.config/nvim/lua/dtran/plugins.lua"
alias conf-ghostty="nvim ~/.config/ghostty/config"
alias conf-aero="nvim ~/.config/aerospace/aerospace.toml"
conf-install() { nvim ~/.config/scripts/${1:-install}.sh; }

# reload
alias rld-zsh="exec zsh"
alias rld-bat="bat cache --build"

# suffix aliases
alias -s md="bat"
alias -s json="jless"
alias -s html="open"
alias -s {yaml,yml}="bat -l yaml"

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                        🏁  Startup                                   ║
# ╚══════════════════════════════════════════════════════════════════════╝

fastfetch --config ~/.config/fastfetch/config.jsonc
source ~/.init.zsh

