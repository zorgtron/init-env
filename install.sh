#!/bin/bash

if [[ "$0" != "./install.sh" ]]; then
    echo "Please run $0 from its own directory."
    exit 1
fi

CONFIG_DIR=$PWD

if ! which -s brew; then
    echo "Brew is not installed. Installing now..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

pushd $HOME >/dev/null
  echo "Installing standard config files..."

  for FILE in $(ls -A "$CONFIG_DIR/home"); do
      [[ -e "$FILE" ]] && rm -rf "$FILE"
      ln -sf "$CONFIG_DIR/home/$FILE" "$FILE"
  done
popd >/dev/null

echo "Setting up Git configuration..."
NAME=$(git config --global user.name)
read -p "Git full name ($NAME): " RESPONSE
[[ "$RESPONSE" == "" ]] || NAME="$RESPONSE"
git config --global user.name "$NAME"

EMAIL=$(git config --global user.email)
read -p "Git email address ($EMAIL): " RESPONSE
[[ "$RESPONSE" == "" ]] || EMAIL="$RESPONSE"
git config --global user.email "$EMAIL"

echo "Updating brew, one moment..."
brew update

echo "Installing standard brew packages..."
which -s ag                         || brew install ag
which -s ctags                      || brew install ctags
which -s fswatch                    || brew install fswatch
which -s gcc                        || brew install gcc
which -s go                         || brew install go
which -s heroku                     || (brew tap heroku/brew && brew install heroku)
which -s node                       || brew install node
which -s pyenv                      || brew install pyenv
which -s rbenv                      || brew install rbenv
which -s tmux                       || brew install tmux
which -s watch                      || brew install watch
which -s wget                       || brew install wget
which -s reattach-to-user-namespace || brew install reattach-to-user-namespace

pyenv install python3.8.12
pyenv global python3.8.12
pip install --upgrade pip
pip install jedi

echo "Installing standard NPM packages..."
which -s browserify || npm install -g browserify
which -s coffee     || npm install -g coffeescript
which -s eslint     || npm install -g eslint
which -s grunt      || npm install -g grunt-cli
which -s sass       || npm install -g node-sass
which -s nodemon    || npm install -g nodemon
which -s pug        || npm install -g pug-cli
which -s tsc        || npm install -g typescript
which -s tslint     || npm install -g tslint
which -s ts-node    || npm install -g ts-node
which -s tsserver   || npm install -g typescript

echo "Installing standard Python packages..."
pip list --format=freeze | grep jedi >/dev/null || pip install jedi

echo "Installing vi plugins..."
vim +PlugClean +PlugInstall +qall

echo "Done."
echo
