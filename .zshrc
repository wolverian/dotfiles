# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
unsetopt correct_all

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="kennethreitz"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

export VIM_APP_DIR="~/Code/programs/macvim/src/MacVim/build/Release"

export RUBYOPT=rubygems

# replace system vi (which itself is a symlink to system vim) with homebrew vim
# "vim" will pick up from /usr/local/bin
alias vi=vim

export WTF_REPO_PATH="~/Code/shell/data/"

source $ZSH/oh-my-zsh.sh

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# Customize to your needs...
export NODE_PATH='.:/usr/local/lib/node'

# don't fork
export EDITOR='vim'
export LESSEDIT='vim'

# python path
# export PYTHONPATH="/Users/antti/Code/programs/dingus:/Users/antti/Code/programs/pystache"

export PATH=/Developer/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/local/nmh/bin:/usr/local/share/npm/bin:/usr/local/lib/php/bin:/usr/local/Cellar/python/2.7.1/bin:/usr/local/Cellar/chicken/4.6.0/bin:$PATH

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
