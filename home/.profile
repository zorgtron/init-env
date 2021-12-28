# General Environment Variables
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=vim
export PS1='[\h:\w]\$ '
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# Aliases
alias l='ls -GhHl'
alias la='ls -aGhHl'
alias clear='clear && printf "\e[3J"'
alias tmux='TERM=xterm-256color /usr/local/bin/tmux'
alias mux='tmuxinator'

# Machine-Specific Configuration
[[ -e "$HOME/.profile.local" ]] && source $HOME/.profile.local

# Git Config
source ~/bin/git-completion.sh

# Java Config
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

# Go Config
export GOPATH=/src/go
export GOBIN=/src/go/bin
export PATH=$PATH:$GOBIN

# NodeJS Config
export PATH=$PATH:$HOME/node_modules/.bin
export NVM_DIR="$HOME/.nvm"
mkdir -p $NVM_DIR &>/dev/null
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Python Config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PYTHONSTARTUP="$(python -m jedi repl)"

# Ruby Config
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=$PATH:$HOME/.rvm/bin
