setopt promptsubst
autoload -U promptinit
promptinit

autoload -U compinit
compinit

autoload -U colors
colors

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
export LANG=en_US.UTF-8

# emacs bindings, -v for vi
bindkey -e

export RUBYOPT=rubygems

# of course
export EDITOR='vim'
export LESSEDIT='vim'
export PAGER="/bin/sh -c \"col -b -x | vim -R -c 'set ft=man' -c 'nmap q :q<cr>' -c 'set nonumber' - \""

alias vi=vim
alias ls="ls --color=auto -l" # requires GNU ls
alias la="ls -la"
alias g="git"
alias s="svn"
alias sup="svn up --ignore-externals"
alias sst="svn st --ignore-externals"
alias t=tmux
alias d="dirs -v"
alias irc="tmux rename-window irc; ssh -e '[' mannerheim -t 'tmux at'"

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () {
    gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')

    if [[ $(echo ${gitstat} | grep -c "^# Changes to be committed:$") > 0 ]]; then
        echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
    fi

    if [[ $(echo ${gitstat} | grep -c "^\(# Untracked files:\|# Changed but not updated:\|# Changes not staged for commit:\)$") > 0 ]]; then
        echo -n "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
    fi 

    if [[ $(echo ${gitstat} | grep -v '^$' | wc -l | tr -d ' ') == 0 ]]; then
        echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
}

# Checks if there are commits ahead from remote
function git_prompt_ahead() {
    if $(echo "$(git log origin/$(current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
        echo "$ZSH_THEME_GIT_PROMPT_AHEAD"
    fi
}


# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo ${ref#refs/heads/}
}

function current_jobs() {
    JOBS=`jobs | cut -c6- | sed 's/^+ /A /' | sort -r | head -2 | cut -d' ' -f 4- | tr '\n' ',' | sed 's/,$//;s/,/, /'`
    if [[ "$JOBS" != "" ]]; then echo "with %{$fg[blue]%}$JOBS%{$reset_color%}"; fi
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) $(current_jobs)
%{$fg[yellow]%}>%{$reset_color%} '

acd() {
  if [ x$1 = x ]; then
    echo "Usage: acd <pattern>"
    return 1
  fi
  cd "$(qf $1 | sed 1q)"
}

# todo system
export TODO=~/.todo.txt
function todo() { if [ $# -eq "0" ]; then cat $TODO; else echo "• $@" >> $TODO; fi }
function todone() { sed -i -e "/$*/d" $TODO; }
function toedit() { vi $TODO; }

eval `dircolors ~/.dir_colors`

PATH=~/bin:$PATH
export PATH
source ~/bin/path.sh

