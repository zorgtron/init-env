# General Environment Variables
export EDITOR=vim
export PS1='[\h:\w]\$ '
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# Aliases
alias l='ls -GhHl'
alias la='ls -aGhHl'
alias clear='clear && printf "\e[3J"'
alias tmux='TERM=xterm-256color /usr/local/bin/tmux'

# Machine-Specific Configuration
[[ -e "$HOME/.profile.local" ]] && source $HOME/.profile.local

# Git Config
source ~/bin/git-completion.sh

# Go Config
export GOPATH=/src/go
export GOBIN=/src/go/bin
export PATH=$PATH:$GOBIN

# NodeJS Config
export PATH=$PATH:$HOME/node_modules/.bin

# Python Config
export PYTHONSTARTUP="$(python -m jedi repl)"

# Ruby Config
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=$PATH:$HOME/.rvm/bin
