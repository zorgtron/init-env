export EDITOR=vi
export PS1='[\h:\w]\$ '
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
export PATH=$PATH:$HOME/bin:$HOME/node_modules/.bin

alias l='ls -Ghl'
alias la='ls -aGhl'

[[ -e "$HOME/.profile.local" ]] && source $HOME/.profile.local
