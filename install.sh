#!/bin/bash -e

# Pyenv-pythons, Vim8, Neovim, and Tmux installation script
# Copyright 2019 Tomoki Hayashi

# check and install dependencies
if [ -e /etc/lsb-release ];then
    required_packages="build-essential libssl-dev zlib1g-dev libbz2-dev
        libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev
        xz-utils tk-dev liblzma-dev python-openssl lua5.2 liblua5.2-dev luajit libevent-dev
        make git zsh wget curl xclip xsel gawk"
    install_packages=""
    installed_packages=$(COLUMNS=200 dpkg -l | awk '{print $2}' | sed -e "s/\:.*$//g")
    for package in ${required_packages}; do
        echo -n "check ${package}..."
        # shellcheck disable=SC2086
        if echo "${installed_packages}" | grep -xq ${package}; then
            echo "OK."
        else
            echo "Not installed."
            install_packages="${install_packages} ${package}"
        fi
    done
    if [ -n "${install_packages}" ]; then
        echo "following packages will be installed: ${install_packages}"
        # shellcheck disable=SC2086
        sudo apt install -y ${install_packages}
    fi
elif [ -e /etc/redhat-release ]; then
    required_packages="gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel
        openssl-devel xz xz-devel findutils lua-devel luajit-devel ncurses-devel perl-ExtUtils-Embed
        ncurses-devel libevent-devel make git zsh wget curl xclip xsel"
    install_packages=""
    installed_packages=$(yum list installed | awk '{print $1}' | sed -e "s/\..*$//g")
    for package in ${required_packages}; do
        echo -n "check ${package}..."
        # shellcheck disable=SC2086
        if echo "${installed_packages}" | grep -xq ${package}; then
            echo "OK."
        else
            echo "Not installed."
            install_packages="${install_packages} ${package}"
        fi
    done
    if [ -n "${install_packages}" ]; then
        echo "following packages will be installed: ${install_packages}"
        # shellcheck disable=SC2086
        sudo yum install -y ${install_packages}
    fi
else
    echo "WARNING: It seems that your environment is not tested."
fi

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
    cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc && cd "${workdir}"
fi

# pyenv init
export PATH=${HOME}/.pyenv/bin:$PATH
eval "$(pyenv init -)"

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
pyenv shell --unset
pyenv global 3.6.4

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

# install vim
ROOTDIR=$PWD
TMPDIR=$(mktemp -d /tmp/XXXXX)
if [ ! -e "${HOME}"/local/bin/vim ]; then
    echo "installing vim 8..."
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
    make -j && make install
fi

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

# install tmux
if [ ! -e "${HOME}"/local/bin/tmux ]; then
    echo "installing tmux..."
    cd "$TMPDIR"
    wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
    tar -xvf tmux-2.6.tar.gz
    cd tmux-2.6
    ./configure --prefix="${HOME}"/local
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
vim -c "try | call dein#install() | finally | qall! | endtry" -N -u "${HOME}"/.vimrc -V1 -es
vim -c "try | call dein#update() | finally | qall! | endtry" -N -u "${HOME}"/.vimrc -V1 -es
nvim -c "try | call dein#install() | finally | qall! | endtry" -N -u "${HOME}"/.vim/init.vim -V1 -es
nvim -c "try | call dein#update() | finally | qall! | endtry" -N -u "${HOME}"/.vim/init.vim -V1 -es

echo ""
echo "Sucessfully installed essential tools."
echo "Please run following command \"exec zsh -l\" to run zsh."
