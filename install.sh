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

  ln -sf "$CONFIG_DIR/bin" bin

  for FILE in $(ls -A "$CONFIG_DIR/home"); do
      [[ -e "$FILE" ]] && rm -rf "$FILE"
      ln -sf "$CONFIG_DIR/home/$FILE" "$FILE"
  done
popd >/dev/null

echo "Updating brew, one moment..."
brew update

echo "Installing standard brew packages..."
which -s ag      || brew install ag
which -s ctags   || brew install ctags
which -s fswatch || brew install fswatch
which -s python  || brew install python # must preceed macvim
which -s gvim    || brew install macvim
which -s node    || brew install node
which -s rbenv   || brew install rbenv
which -s watch   || brew install watch
which -s wget    || brew install wget

pushd /usr/local/bin >/dev/null
    ln -sf pip2 pip
    ln -sf python2 python
popd >/dev/null

echo "Installing standard NPM packages..."
which -s browserify || npm install -g browserify
which -s coffee     || npm install -g coffee-script
which -s eslint     || npm install -g eslint
which -s grunt      || npm install -g grunt-cli
which -s sass       || npm install -g node-sass
which -s nodemon    || npm install -g nodemon
which -s pug        || npm install -g pug-cli
which -s tsc        || npm install -g typescript
which -s tslint     || npm install -g tslint
which -s ts-node    || npm install -g ts-node
which -s tsserver   || npm install -g typescript

echo "Installing vi plugins..."
vim +PlugClean +PlugInstall +qall

echo "Done."
echo
