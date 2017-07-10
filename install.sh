#!/bin/bash

if [[ "$0" != "./install.sh" ]]; then
    echo "Please run $0 from its own directory."
    exit 1
fi

CONFIG_DIR=$PWD

if ! which -s brew; then
    echo; echo; echo "Brew is not installed. Installing now..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

pushd $HOME >/dev/null

echo; echo; echo "Installing standard config files..."

for FILE in $(ls -A "$CONFIG_DIR/home"); do
    [[ -e "$FILE" ]] && rm -rf "$FILE"
    ln -s "$CONFIG_DIR/home/$FILE" "$FILE"
done

echo; echo; echo "Updating brew, one moment..."
brew update

echo; echo; echo "Installing standard brew packages..."
brew install fswatch
brew install macvim
brew install node
brew install rbenv
brew install watch
brew install wget

echo; echo; echo "Installing standard NPM packages..."
npm install -g browserify
npm install -g coffee-script
npm install -g grunt-cli
npm install -g node-sass
npm install -g nodemon
npm install -g pug-cli

echo; echo; read -p "Installing vi plugins, type \":qall\" when finished..."
vi -c ":PlugInstall"

popd >/dev/null
echo; echo; echo "Done."
echo
