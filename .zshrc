setopt promptsubst
autoload -U promptinit
promptinit

autoload -U compinit
compinit

# Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE

export RUBYOPT=rubygems

# replace system vi (which itself is a symlink to system vim) with homebrew vim
# "vim" will pick up from /usr/local/bin
alias vi=vim

export WTF_REPO_PATH="~/Code/shell/data/"

#source $ZSH/oh-my-zsh.sh

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# Customize to your needs...
export NODE_PATH='.:/usr/local/lib/node'

# don't fork
export EDITOR='vim'
export LESSEDIT='vim'

# homebrew override
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# xcode
export PATH=$PATH:/Developer/usr/bin
# npm
export PATH=$PATH:/usr/local/share/npm/bin
# PHP
export PATH=$PATH:/usr/local/lib/php/bin
# Python
export PATH=$PATH:/usr/local/Cellar/python/2.7.1/bin
# chicken
export PATH=$PATH:/usr/local/Cellar/chicken/4.6.0/bin

# alias t="~/Code/shell/todo.sh"
alias ls="ls -l"
alias la="ls -la"

# Git
alias g="git"

# Subversion
alias s="svn"
alias sup="svn up --ignore-externals"
alias sst="svn st --ignore-externals"

# taskwarrior
alias t=task

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
