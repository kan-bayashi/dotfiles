#!/bin/bash -e

# Pyenv-pythons, Neovim, and Tmux installation script
# Copyright 2019 Tomoki Hayashi

MINICONDA_VERSION=miniconda3-latest
PYTHON3_VERSION=3.8.2

# install zplug
if [ ! -e ~/.zplug ];then
    echo "Installing zplug..."
    git clone https://github.com/zplug/zplug.git ~/.zplug
fi

# install tpm
if [ ! -e ~/.tmux/plugins/tpm ];then
    echo "Installing tpm..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# install pyenv
if [ ! -e ~/.pyenv ];then
    echo "Installing pyenv..."
    git clone https://github.com/yyuu/pyenv.git -b v2.0.6 ~/.pyenv
fi

# install fzf
if [ ! -e ~/.fzf ];then
    echo "Installing fzf..."
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    workdir=${PWD}
    cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc && cd "${workdir}"
fi

# pyenv init
export PATH=${HOME}/.pyenv/bin:$PATH
eval "$(pyenv init -)"

# install enable-shared python using pyenv
if [ ! -e "${HOME}"/.pyenv/versions/${MINICONDA_VERSION} ];then
    pyenv install ${MINICONDA_VERSION}
else
    echo "${MINICONDA_VERSION} is already installed."
fi

# set python
pyenv shell --unset
pyenv global ${MINICONDA_VERSION}

# install python via conda
conda install -y python=${PYTHON3_VERSION}
conda install -y pip setuptools numpy

# check python version
python3_version=$(python3 --version 2>&1)
if [ "${python3_version}" = "Python ${PYTHON3_VERSION}" ];then
    echo "Python 3 version check is OK."
else
    echo "Python 3 version check is failed."
    exit 1
fi

# install python libraries
pip3 install -r requirements.txt

# install other libraries
conda install -y lua nodejs

# install nvim
if [ ! -e "${HOME}"/local/bin/nvim ]; then
    echo "installing neovim..."
    cd "${HOME}"/local/bin
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x nvim.appimage
    if ./nvim.appimage --version >& /dev/null; then
        ln -s ./nvim.appimage nvim
    else
        ./nvim.appimage --appimage-extract
        mv -v squashfs-root ../nvim
        ln -s ../nvim/AppRun nvim
        rm nvim.appimage
    fi
fi

echo ""
echo "Sucessfully installed essential tools."
echo "Please run following command \"exec zsh -l\" to run zsh."
