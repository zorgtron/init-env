#!/bin/bash

if [[ "$0" != "./install.sh" ]]; then
    echo "Please run $0 from its own directory."
    exit 1
fi

CONFIG_DIR=$PWD
DID_UPDATE_BREW="NO"

USAGE=$(cat <<< END
USAGE: $0
END
)

# Base Functions #######################################################################################################

function __configure_git() {
    echo "Setting up Git configuration..."
    NAME=$(git config --global user.name)
    read -p "Git full name ($NAME): " RESPONSE
    [[ "$RESPONSE" == "" ]] || NAME="$RESPONSE"
    git config --global user.name "$NAME"

    EMAIL=$(git config --global user.email)
    read -p "Git email address ($EMAIL): " RESPONSE
    [[ "$RESPONSE" == "" ]] || EMAIL="$RESPONSE"
    git config --global user.email "$EMAIL"
}

function __install_all() {
    __install_configs
    __configure_git

    __install_brew
    __install_basics
    __install_gcc
    __install_vim

    __install_coffeescript
    __install_go
    __install_heroku
    __install_node
    __install_python
    __install_ruby
    __install_webtools
    __install_typescript
}

function __install_brew() {
    if ! which -s brew; then
        echo "Brew is not installed. Installing now..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        __update_brew
    fi
}

function __update_brew() {
    __install_brew

    if [[ "$DID_UPDATE_BREW" == "NO" ]]; then
        echo "Updating brew, one moment..."
        brew update
    fi

    DID_UPDATE_BREW="YES"
}

# Package Functions ####################################################################################################

function __install_basics() {
    __update_brew

    which -s ag      || brew install ag
    which -s ctags   || brew install ctags
    which -s fswatch || brew install fswatch
    which -s tmux    || brew install tmux
    which -s watch   || brew install watch
    which -s wget    || brew install wget

    which -s reattach-to-user-namespace || brew install reattach-to-user-namespace
}

function __install_coffeescript() {
    __install_node

    which -s coffee || npm install -g coffeescript
}

function __install_configs() {
    pushd $HOME >/dev/null
      echo "Installing standard config files..."

      for FILE in $(ls -A "$CONFIG_DIR/home"); do
          [[ -e "$FILE" ]] && rm -rf "$FILE"
          ln -sf "$CONFIG_DIR/home/$FILE" "$FILE"
      done
    popd >/dev/null
}

function __install_gcc() {
    __update_brew

    which -s gcc || brew install gcc
}

function __install_go() {
    __update_brew

    which -s go || brew install go
}

function __install_heroku() {
    __update_brew

    which -s heroku || (brew tap heroku/brew && brew install heroku)
}

function __install_node() {
    __update_brew

    which -s node    || brew install node
    which -s nodemon || npm install -g nodemon
}

function __install_python() {
    __update_brew

    which -s pyenv || brew install pyenv
    pyenv install python3.9
    pyenv global python3.9
    pip install --upgrade pip
    pip install jedi
}

function __install_ruby() {
    which -s rbenv || brew install rbenv
}

function __install_webtools() {
    __install_node

    which -s browserify || npm install -g browserify
    which -s eslint     || npm install -g eslint
    which -s sass       || npm install -g node-sass
    which -s pug        || npm install -g pug-cli
}

function __install_typescript() {
    __install_node

    which -s tsc        || npm install -g typescript
    which -s tslint     || npm install -g tslint
    which -s ts-node    || npm install -g ts-node
    which -s tsserver   || npm install -g tsserver
}

function __install_vim() {
    __upgrade_brew

    ls -l $(which vim) | grep "Cellar/vim" >/dev/null || brew install vim
    vim +PlugClean +PlugInstall +qall
}

########################################################################################################################

DID_RUN="NO"
while [[ "$1" != "" ]]; do
    FUNC="__install_$1"
    if [[ $(type "$FUNC") == "function" ]]; then
        DID_RUN="YES"
        FUNC
    fi

    shift
done

if [[ "$DID_RUN" == "NO" ]]; then
    echo $USAGE
fi

echo
