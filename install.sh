#!/bin/bash -e

# Dotfile install script
# Copyright 2019 Tomoki Hayashi

PYTHON3_VERSION=3.10.5

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

# install essential tools
for tool in pyenv zsh fd ripgrep tmux lsd bat shellcheck fzf; do
    ! brew ls --versions ${tool} > /dev/null && brew install ${tool}
done

# pyenv init
export PATH=/opt/homebrew/bin:$PATH
eval "$(pyenv init --path)"

# install enable-shared python using pyenv
if [ ! -e "${HOME}"/.pyenv/versions/${PYTHON3_VERSION} ];then
    pyenv install ${PYTHON3_VERSION}
else
    echo "Python ${PYTHON3_VERSION} is already installed."
fi

# set python
pyenv shell --unset
pyenv global ${PYTHON3_VERSION}

# check python version
python3_version=$(python3 --version 2>&1)
if [ "${python3_version}" = "Python ${PYTHON3_VERSION}" ];then
    echo Python 3 version check is OK.
else
    echo Python 3 version check is failed.
    exit 1
fi

# install python libraries
python -m pip install -U pip
python -m pip install -U setuptools
python -m pip install -r requirements.txt

if [ ! -e ~/local/bin/nvim ];then
    mkdir -p ~/local/bin
    cwd=$(pwd)
    cd ~/local
    wget wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim-macos.tar.gz
    tar xzvf nvim-macos.tar.gz
    cd ~/local/bin
    ln -s ../nvim-osx64/bin/nvim .
    cd "${cwd}"
fi

# install neovim
echo "Sucessfully finished installation."
echo "Please run exec zsh -l."
