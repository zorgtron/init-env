#!/bin/bash

if [[ "$0" != "./install.sh" ]]; then
    echo "Please run $0 from its own directory."
    exit 1
fi

MY_SHELL="zsh"
SHELL_RC="~/.zshrc"

CONFIG_DIR=$PWD
DID_UPDATE_BREW="NO"

USAGE=$(cat <<-END
USAGE: $0 <package>|all

    This script bootstraps your shell environment by installing configs,
    installers (e.g., brew), and useful programs.  The following packages are
    supported:

    basics          tools like wget.
    configs         only install shell config files
    go              install the golang compiler
    python          install Python language tools
    vim             install vim and ~/.vimrc
END
)

# Base Functions #######################################################################################################


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
            which -s node || __install_node
            OPTS="-g"
        elif [[ "$InSTALLER" == "pip" ]]; then
            which -s python || __install_python
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


function __install_configs() {
    # switch to zsh instead of bash.
    sudo chsh -s "/bin/$MY_SHELL"
    chsh -s "/bin/$MY_SHELL"

    pushd $HOME >/dev/null
        echo "Installing standard config files..."

        for FILE in $(ls -A "$CONFIG_DIR/home"); do
            [[ -e "$FILE" ]] && rm -rf "$FILE"
            ln -sf "$CONFIG_DIR/home/$FILE" "$FILE"
        done

    popd >/dev/null
}

function __install_go() {
    __install_with brew go
}

function __install_python() {
    __install_with brew miniconda
    VERSION="3.10.4"
    echo "Installing Python $VERSION"

    conda update -y conda
    conda install -y python="$VERSION"
    conda init "$MY_SHELL"
    source "$SHELL_RC"

    pip install --upgrade pip
    __install_with pip jedi
    __install_with pip poetry
}

function __install_vim() {
    __update_brew

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
