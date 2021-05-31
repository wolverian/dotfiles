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

source ~/bin/path.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
