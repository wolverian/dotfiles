autoload -U compinit
compinit

autoload -U colors
colors

# Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
export LANG=fi_FI.UTF-8
export LC_TYPE="en_US.UTF-8"

# emacs bindings, -v for vi
bindkey -e

# of course
export EDITOR='nvim'
export LESSEDIT='nvim'
export PAGER='less'
export FZF_DEFAULT_COMMAND='fd --type f'
alias vi=nvim
alias vim=nvim
alias g="git"
alias t="tmux"
alias gd="g b | fzf | xargs git b -d"

# edit a file and jump to the last location (the " mark)
e () {
  nvim -c "'\"" "$@"
}

git-oldfiles() {
  local dir=$(pwd)
  nvim --headless -c ":lua vim.api.nvim_command('oldfiles')" -c ":q" 2>&1 |
    cut -w -s -f2 |
    grep $dir |
    sed "s%$dir/%%" |
    sed "s/\r//"
}

nvim-oldfiles () {
  zle reset-prompt
  LBUFFER="${LBUFFER}$((git-oldfiles && fd --type f) | fzf --reverse --multi --height 20)"
}

zle     -N            nvim-oldfiles
bindkey -M emacs '^x^f' nvim-oldfiles

_fzf_compgen_path() {
  fd --type f "$1"
}

git-branch-widget() {
  LBUFFER="${LBUFFER}$(git branch --all --sort=-committerdate | sed "s/.* //" | fzf --multi)"
}

zle     -N             git-branch-widget
bindkey -M emacs '^xb' git-branch-widget

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
