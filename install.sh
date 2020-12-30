#!/bin/bash -e

# Dotfile install script
# Copyright 2019 Tomoki Hayashi

PYTHON3_VERSION=3.6.8

# check brew installation
if ! command -v brew > /dev/null; then
    echo "brew is not installed. please run following command to install brew." 2>&1
    # shellcheck disable=SC2016
    echo '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"' 2>&1
    exit 1
fi

# install zplug
if [ ! -e ~/.zplug ];then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

# install tpm
if [ ! -e ~/.tmux/plugins/tpm ];then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# install fzf
if [ ! -e ~/.fzf ];then
    workdir=$(pwd)
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    cd ~/.fzf && ./install && cd "${workdir}"
fi

# install pyenv
if [ ! -e ~/.pyenv ];then
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
fi

# install essential tools
for tool in zsh fd ripgrep tmux; do
    ! brew ls --versions ${tool} > /dev/null && brew install ${tool}
done

if [ ! -e ~/local/bin/nvim ];then
    mkdir -p ~/local/bin
    cwd=$(pwd)
    cd ~/local
    wget wget https://github.com/neovim/neovim/releases/download/v0.4.4/nvim-macos.tar.gz
    tar xzvf nvim-macos.tar.gz
    cd ~/local/bin
    ln -s ../nvim-osx64/bin/nvim .
    cd "${cwd}"
fi

# install pyenv python3.6
if [ ! -e ~/.pyenv/versions/${PYTHON3_VERSION} ];then
    # install dependencies for pyenv python installation
    for tool in readline xz; do
        ! brew ls --versions ${tool} > /dev/null && brew install ${tool}
    done
    mac_version=$(sw_vers | grep ProductVersion | awk '{print $2}' | sed -e "s/\.[0-9]$//g")
    # need to install extra modules
    # https://github.com/pyenv/pyenv/wiki/common-build-problems
    [ "$(echo "${mac_version} >= 10.14" | bc)" -eq 1 ] && \
        sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /

    # install python3 through pyenv
    export PATH=$HOME/.pyenv/bin:$PATH
    eval "$(pyenv init -)"
    env PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install ${PYTHON3_VERSION}
    pyenv global ${PYTHON3_VERSION}
    ~/.pyenv/shims/pip install --upgrade pip
    ~/.pyenv/shims/pip install -r requirements.txt
fi

echo "Sucessfully finished installation."
echo "Please run exec zsh -l."
