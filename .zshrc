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

# emacs bindings, -v for vi
bindkey -e

export RUBYOPT=rubygems
export RBENV_ROOT=/usr/local/var/rbenv

# of course
export EDITOR='vim'
export LESSEDIT='vim'
export PAGER="/bin/sh -c \"col -b -x | vim -R -c 'set ft=man' -c 'nmap q :q<cr>' -c 'set nonumber' - \""
export FZF_DEFAULT_COMMAND='fd --type f'

alias vi=nvim
alias la="fd"
alias g="git"
alias s="svn"
alias sup="svn up --ignore-externals"
alias sst="svn st --ignore-externals"
alias t="tmux"
alias d="dirs -v"
alias json-pretty="pbpaste | python -m json.tool | pbcopy"
alias git=hub

function current_jobs() {
    JOBS=`jobs | cut -c6- | sed 's/^+ /A /' | sort -r | head -2 | cut -d' ' -f 4- | tr '\n' ',' | sed 's/,$//;s/,/, /'`
    if [[ "$JOBS" != "" ]]; then echo "with %{$fg[blue]%}$JOBS%{$reset_color%}"; fi
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
