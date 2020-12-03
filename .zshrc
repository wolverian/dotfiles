setopt promptsubst
setopt PROMPT_SUBST
autoload -U promptinit
promptinit

autoload -U compinit
compinit

autoload -U colors
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green} ●%f" # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{red} ●%f" # default 'U'
zstyle ':vcs_info:*' use-simple true
# zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] ' # default ' (%s)-[%b]%c%u-'
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
export LANG=fi_FI.UTF-8
export LC_TYPE="en_US.UTF-8"
export PUREC_DIR="~/Code/purescript/purec"

# emacs bindings, -v for vi
bindkey -e

export RUBYOPT=rubygems
export RBENV_ROOT=/usr/local/var/rbenv

# of course
export EDITOR='nvim'
export LESSEDIT='nvim'
export PAGER='less'
export FZF_DEFAULT_COMMAND='fd --type f'

alias vi=nvim
alias vim=nvim
alias v='nvim $(fzf)'
alias vm='nvim -O $(fzf -m)'
alias la="fd"
alias g="git"
alias t="tmux"
alias d="dirs -v"
alias json-pretty="pbpaste | jq"
alias notes="cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/notes && vim"
alias clock="tty-clock -c -f %d.%m.%Y"
alias pp="mpc toggle"
alias clock="tty-clock -c -f %d.%m.%Y"
alias gd="g b | fzf | xargs git b -d"
alias f='vim $(fzf)'

# play an album
pa() {
  files=$(~/bin/album)
  if [[ $? == 0 ]]; then
    mpc clear
    echo $files | mpc add && (mpc play > /dev/null)
  fi
}

precmd () { vcs_info }

PS1='
%F{green}%~%f%F{yellow}%(1j. ●.)%f ${vcs_info_msg_0_}
%F{yellow}λ%f '

remove_merged_branches () {
  git branch --merged | egrep -v "(^\*|master|dev|production)" | xargs git branch -d
}

source ~/bin/path.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"
