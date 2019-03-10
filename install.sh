#!/bin/bash -eu

# Pyenv-pythons, Vim8, Neovim, and Tmux installation script
# Copyright 2019 Tomoki Hayashi

# check pyenv existence
if ! type "pyenv" > /dev/null 2>&1;then
    echo "ERROR: pyenv is not activated."
    exit 1
fi

# install dependencies
if [ -e /etc/lsb-release ];then
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
        xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
        ncurses-dev lua5.2 lua5.2-dev luajit libevent-dev xclip xsel
fi

# install enable-shared python using pyenv
if [ ! -e "${HOME}"/.pyenv/versions/2.7.14 ];then
    CONFIGURE_OPTS="--enable-shared" pyenv install 2.7.14
else
    echo "Python 2.7.14 is already installed."
fi
if [ ! -e "${HOME}"/.pyenv/versions/3.6.4 ];then
    CONFIGURE_OPTS="--enable-shared" pyenv install 3.6.4
else
    echo "Python 3.6.4 is already installed."
fi

# set python
eval "$(pyenv init -)"
pyenv shell --unset
pyenv global 2.7.14 3.6.4

# check python version
python2_version=$(python --version 2>&1)
python3_version=$(python3 --version 2>&1)
if [ "${python2_version}" = "Python 2.7.14" ];then
    echo Python 2 version check is OK.
else
    echo Python 2 version check is failed.
    exit 1
fi
if [ "${python3_version}" = "Python 3.6.4" ];then
    echo Python 3 version check is OK.
else
    echo Python 3 version check is failed.
    exit 1
fi

# install python libraries
pip install -r requirements.txt
pip3 install -r requirements.txt

# install nvim
cd "${HOME}/local/bin"
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
ln -s "${PWD}"/nvim.appimage nvim

# install vim
ROOTDIR=$PWD
TMPDIR=$(mktemp -d /tmp/XXXXX)
cd "$TMPDIR"
git clone https://github.com/vim/vim.git
cd vim
LDFLAGS="-Wl,-rpath=${HOME}/.pyenv/versions/2.7.14/lib:${HOME}/.pyenv/versions/3.6.4/lib" \
    ./configure \
    --enable-fail-if-missing \
    --enable-pythoninterp=dynamic \
    --enable-python3interp=dynamic \
    --with-features=huge \
    --enable-luainterp \
    --enable-cscope \
    --enable-fontset \
    --enable-multibyte \
    --prefix="${HOME}"/local
make && make install

# install tmux
cd "$TMPDIR"
wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
tar -xvf tmux-2.6.tar.gz
cd tmux-2.6
./configure --prefix="${HOME}"/local
make && make install

# clean up
cd "$ROOTDIR"
[ -e "$TMPDIR" ] && rm -fr "$TMPDIR"
