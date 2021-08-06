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

source ~/bin/path.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
