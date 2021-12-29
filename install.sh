#!/bin/bash

if [[ "$0" != "./install.sh" ]]; then
    echo "Please run $0 from its own directory."
    exit 1
fi

CONFIG_DIR=$PWD
DID_UPDATE_BREW="NO"

USAGE=$(cat <<-END
USAGE: $0 <package>|all

    This script bootstraps your shell environment by installing configs,
    installers (e.g., brew), and useful programs.  The following packages are
    supported:

    configs         only install shell config files
    coffeescript    install coffeescript language tools
    go              install go language tools
    heroku          install the Heroku CLI
    node            install NodeJS language tools
    python          install Python language tools
    ruby            install Ruby language tools
    typescript      install TypeScript language tools
    webtools        install tools for web development
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
    __install_typescript
    __install_webtools
}

function __install_brew() {
    if ! which -s brew; then
        echo "Brew is not installed. Installing now..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        __update_brew
    fi
}

function __install_with() {
    INSTALLER="$1"
    PACKAGE="$2"
    CHECK="$3"
    OPTS=""

    [[ "$CHECK" == "" ]] && CHECK="$PACKAGE"

    if ! which -s "$CHECK"; then
        if [[ "$INSTALLER" == "brew" ]]; then
            __update_brew
        elif [[ "$INSTALLER" == "npm" ]]; then
            __install_node
            OPTS="-g"
        elif [[ "$InSTALLER" == "pip" ]]; then
            __install_python
        fi

        $INSTALLER install $OPTS $PACKAGE
    else
        echo "$CHECK was already installed"
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
    __install_with brew ag
    __install_with brew ctags
    __install_with brew fswatch
    __install_with brew reattach-to-user-namespace
    __install_with brew tmux
    __install_with brew tmuxinator
    __install_with brew watch
    __install_with brew wget
}

function __install_coffeescript() {
    __install_with npm coffeescript
}

function __install_configs() {
    sudo chpass -s /bin/bash $USER
    pushd $HOME >/dev/null
        echo "Installing standard config files..."

        for FILE in $(ls -A "$CONFIG_DIR/home"); do
            [[ -e "$FILE" ]] && rm -rf "$FILE"
            ln -sf "$CONFIG_DIR/home/$FILE" "$FILE"
        done

        __configure_git
    popd >/dev/null
}

function __install_gcc() {
    __install_with brew gcc
}

function __install_go() {
    __install_with brew go
}

function __install_heroku() {
    (brew tap heroku/brew && __install_with brew heroku)
}

function __install_node() {
    __install_with brew node
    __install_with npm nodemon
}

function __install_python() {

    __install_with brew pyenv
    VERSION=$(pyenv install --list | sed 's/^ *//' | grep '^3.9' | tail -1)

    pyenv install -s "$VERSION"
    pyenv global "$VERSION"
    pyenv version

    pip install --upgrade pip
    __install_with pip jedi
}

function __install_ruby() {
    __install_with brew rbenv
}

function __install_webtools() {
    __install_node

    __install_with npm browserify
    __install_with npm eslint
    __install_with npm node-sass
    __install_with npm pug-cli
}

function __install_typescript() {
    __install_node

    __install_with npm typescript tsc
    __install_with npm tslint
    __install_with npm ts-node
    __install_with npm tsserver
}

function __install_vim() {
    __upgrade_brew

    ls -l $(which vim) | grep "Cellar/vim" >/dev/null || __install_with brew vim
    vim +PlugClean +PlugInstall +qall
}

########################################################################################################################

DID_RUN="NO"
while [[ "$1" != "" ]]; do
    FUNC="__install_$1"
    if [[ $(type "$FUNC") == *"function"* ]]; then
        DID_RUN="YES"
        $FUNC
    fi

    shift
done

if [[ "$DID_RUN" == "NO" ]]; then
    echo "$USAGE"
fi

echo
