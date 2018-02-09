export EDITOR=vim
export PS1='[\h:\w]\$ '
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
export PATH=$PATH:$HOME/bin:$HOME/node_modules/.bin

alias l='ls -GhHl'
alias la='ls -aGhHl'
alias clear='clear && printf "\e[3J"'

[[ -e "$HOME/.profile.local" ]] && source $HOME/.profile.local

source ~/bin/git-completion.sh
