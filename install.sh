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

  echo "Updating brew, one moment..."
  brew update

  echo "Installing standard brew packages..."
  which -s ag      || brew install ag
  which -s ctags   || brew install ctags
  which -s fswatch || brew install fswatch
  which -s gvim    || brew install macvim
  which -s node    || brew install node
  which -s rbenv   || brew install rbenv
  which -s watch   || brew install watch
  which -s wget    || brew install wget

  echo "Installing standard NPM packages..."
  which -s browserify || sudo npm install -g browserify
  which -s coffee     || sudo npm install -g coffee-script
  which -s grunt      || sudo npm install -g grunt-cli
  which -s sass       || sudo npm install -g node-sass
  which -s nodemon    || sudo npm install -g nodemon
  which -s pug        || sudo npm install -g pug-cli
  which -s tsc        || sudo npm install -g typescript
  which -s tslint     || sudo npm install -g tslint
  which -s ts-node    || sudo npm install -g ts-node
  which -s tsserver   || sudo npm install -g typescript

  echo "Installing vi plugins..."
  vim +PlugInstall +qall

popd >/dev/null

echo "Done."
echo
