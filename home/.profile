export EDITOR=vi
export PS1='[\h:\w]\$ '
export PATH=~/bin:~/node_modules/.bin:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:$PATH
export RAILS_ENV='development'

alias l='ls -Ghl'
alias la='ls -aGhl'

function count {
    find . -name "*.$1" | grep -v "node_modules" | xargs cat | grep -v '^$' | grep -v '^#' | wc -l
}

ssh-add ~/.ssh/id_rsa_andrewminer &>/dev/null

eval "$(rbenv init -)"


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

defaults write com.macromates.TextMate.preview volumeSettings '{ "/" = { extendedAttributes = 0; }; }'

if [[ -e "~/.profile.local" ]]; then
    source ~/.profile.local
fi
