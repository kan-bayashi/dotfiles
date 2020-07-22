#!/bin/bash -e

# Pyenv-pythons, Vim8, Neovim, and Tmux installation script
# Copyright 2019 Tomoki Hayashi

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
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
fi

# install fzf
if [ ! -e ~/.fzf ];then
    echo "Installing fzf..."
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    workdir=${PWD}
    cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc && cd ${workdir}
fi

# pyenv init
export PATH=${HOME}/.pyenv/bin:$PATH
eval "$(pyenv init -)"

# install enable-shared python using pyenv
if [ ! -e "${HOME}"/.pyenv/versions/3.6.4 ];then
    CONFIGURE_OPTS="--enable-shared" pyenv install 3.6.4
else
    echo "Python 3.6.4 is already installed."
fi

# set python
pyenv shell --unset
pyenv global 3.6.4

# check python version
python3_version=$(python3 --version 2>&1)
if [ "${python3_version}" = "Python 3.6.4" ];then
    echo Python 3 version check is OK.
else
    echo Python 3 version check is failed.
    exit 1
fi

# install python libraries
pip3 install -r requirements.txt

# install nvim
mkdir -p ${HOME}/local/bin
if [ ! -e ${HOME}/local/bin/nvim ]; then
    echo "installing neovim..."
    cd ${HOME}/local/bin
    wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage
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

# install tmux
TMPDIR=$(mktemp -d /tmp/XXXXX)
if [ ! -e ${HOME}/local/bin/tmux ]; then
    echo "installing tmux..."
    cd "${TMPDIR}"
    wget --no-check-certificate https://sourceforge.net/projects/levent/files/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz/download
    mv download libevent-2.0.22-stable.tar.gz
    tar xvfz libevent-2.0.22-stable.tar.gz
    cd libevent-2.0.22-stable
    ./configure --prefix="${HOME}/local"
    make && make install
    cd "${TMPDIR}"
    wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
    tar -xvf tmux-2.6.tar.gz
    cd tmux-2.6
    ./configure --prefix="${HOME}"/local LDFLAGS="-L${HOME}/local/lib" CFLAGS="-I${HOME}/local/include"
    make -j && make install
fi

# clean up
cd "$ROOTDIR"
[ -e "$TMPDIR" ] && rm -fr "$TMPDIR"

# install vim plugins
echo "installing vim plugins..."
export PATH=${HOME}/local/bin:$PATH
[ ! -e ~/.cache/dein/repos/github.com/Shougo/dein.vim ] && \
    git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo/dein.vim
nvim -c "try | call dein#install() | finally | qall! | endtry" -N -u ${HOME}/.vim/init.vim -V1 -es
nvim -c "try | call dein#update() | finally | qall! | endtry" -N -u ${HOME}/.vim/init.vim -V1 -es

echo ""
echo "Sucessfully installed essential tools."
echo "Please run following command \"exec zsh -l\" to run zsh."
