#!/bin/bash

if [[ "$0" != "./install.sh" ]]; then
    echo "Please run $0 from its own directory."
    exit 1
fi

PACKAGE_TOOL=""
MY_SHELL=""
SHELL_RC=""

OS="`uname`"
case $OS in
'Linux')
        OS='Linux'
        PACKAGE_TOOL="apt-get"
        MY_SHELL="zsh"
        SHELL_RC="~/.zshrc"
        ;;
'Darwin')
        OS='Mac'
        PACKAGE_TOOL="brew"
        MY_SHELL="bash"
        SHELL_RC="~/.bashrc"
        ;;
esac

CONFIG_DIR=$PWD
DID_UPDATE_PACKAGE_TOOL="NO"

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
        PRE_OPTS=""

        [[ "$CHECK" == "" ]] && CHECK="$PACKAGE"

        if ! which -s "$CHECK"; then
                if [[ "$INSTALLER" == "brew" ]]; then
                        __update_brew
                elif [[ "$INSTALLER" == "npm" ]]; then
                        which -s node || __install_node
                        OPTS="-g"
                elif [[ "$INSTALLER" == "apt_get" ]]; then
                        __update_apt_get
                        INSTALLER="apt-get"
                        PRE_OPTS="-y"
                elif [[ "$INSTALLER" == "pip" ]]; then
                        which -s python || __install_python
                fi
                $INSTALLER $PRE_OPTS install $OPTS $PACKAGE

        else
                echo "$CHECK was already installed"
        fi
}

function __update_apt_get() {
        if [[ "$DID_UPDATE_PACKAGE_TOOL" == "NO" ]]; then
                echo "Updating apt package list, one moment..."
                apt-get update
        fi

        DID_UPDATE_PACKAGE_TOOL="YES"
}
function __update_brew() {
        __install_brew

        if [[ "$DID_UPDATE_PACKAGE_TOOL" == "NO" ]]; then
                echo "Updating brew, one moment..."
                brew update
        fi

        DID_UPDATE_PACKAGE_TOOL="YES"
}

# Package Functions ####################################################################################################

function __install_basics() {
        __install_with $PACKAGE_TOOL ag
        __install_with $PACKAGE_TOOL ctags
        __install_with $PACKAGE_TOOL fswatch
        __install_with $PACKAGE_TOOL nodejs
        __install_with $PACKAGE_TOOL reattach-to-user-namespace
        __install_with $PACKAGE_TOOL tmux
        __install_with $PACKAGE_TOOL tmuxinator
        __install_with $PACKAGE_TOOL watch
        __install_with $PACKAGE_TOOL wget
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
        __install_with $PACKAGE_TOOL go
}

function __install_python() {
        __install_with $eACKAGE_TOOL miniconda
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
        __update_$PACKAGE_TOOL

        ls -l $(which vim) | grep "Cellar/vim" >/dev/null || __install_with $PACKAGE_TOOL vim
        vim +PlugClean +PlugInstall +CocInstall coc-go +CocInstall coc-html +CocInstall coc-jedi +CocInstall coc-tsserver +qall
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
