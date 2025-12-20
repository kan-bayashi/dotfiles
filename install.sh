#!/bin/bash -e

# Pyenv-pythons, Neovim, and Tmux installation script
# Copyright 2019 Tomoki Hayashi

PYTHON3_VERSION=3.10.16

# install zplug
if [ ! -e ~/.zplug ]; then
    echo "Installing zplug..."
    git clone https://github.com/zplug/zplug.git ~/.zplug
fi

# install tpm
if [ ! -e ~/.tmux/plugins/tpm ]; then
    echo "Installing tpm..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# install pyenv
if [ ! -e ~/.pyenv ]; then
    echo "Installing pyenv..."
    git clone https://github.com/yyuu/pyenv.git -b v2.5.4 ~/.pyenv
fi

# install fzf
if [ ! -e ~/.fzf ]; then
    echo "Installing fzf..."
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    workdir=${PWD}
    cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc && cd "${workdir}"
fi

# install volta
if [ ! -e ~/.volta ]; then
    echo "Installing volta..."
    curl https://get.volta.sh | bash
fi

# install lazygit
if [ ! -e ~/.local/bin/lazygit ]; then
    cwd=${PWD}
    echo "Installing lazygit..."
    cd ~/.local/
    mkdir -p src
    cd src
    wget https://github.com/jesseduffield/lazygit/releases/download/v0.54.0/lazygit_0.54.0_Linux_x86_64.tar.gz
    tar -xvf lazygit_0.54.0_Linux_x86_64.tar.gz
    cp lazygit ~/.local/bin
    cd "${cwd}"
fi

# install delta
if [ ! -e ~/.local/bin/delta ]; then
    cwd=${PWD}
    echo "Installing delta..."
    cd ~/.local/
    mkdir -p src
    cd src
    wget https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-x86_64-unknown-linux-musl.tar.gz
    tar -xvf delta-0.18.2-x86_64-unknown-linux-musl.tar.gz
    mv delta-0.18.2-x86_64-unknown-linux-musl/delta ~/.local/bin
    cd "${cwd}"
fi

# install bat
if [ ! -e ~/.local/bin/bat ]; then
    cwd=${PWD}
    echo "Installing delta..."
    cd ~/.local/
    mkdir -p src
    cd src
    wget https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-x86_64-unknown-linux-musl.tar.gz
    tar -xvf bat-v0.25.0-x86_64-unknown-linux-musl.tar.gz
    mv bat-v0.25.0-x86_64-unknown-linux-musl/bat ~/.local/bin
    cd "${cwd}"
fi

# install nsxiv
if [ ! -e ~/.local/bin/nsxiv ]; then
    cwd=${PWD}
    echo "Installing nsxiv..."
    cd ~/.local/
    mkdir -p src
    cd src
    git clone https://github.com/nsxiv/nsxiv.git
    cd nsxiv
    make
    cp nsxiv ~/.local/bin
    cd "${cwd}"
fi

# pyenv init
export PATH=${HOME}/.pyenv/bin:$PATH
eval "$(pyenv init -)"

# install enable-shared python using pyenv
if [ ! -e "${HOME}"/.pyenv/versions/${PYTHON3_VERSION} ]; then
    CONFIGURE_OPTS="--enable-shared" pyenv install ${PYTHON3_VERSION}
else
    echo "Python ${PYTHON3_VERSION} is already installed."
fi

# set python
pyenv shell --unset
pyenv global ${PYTHON3_VERSION}

# check python version
python3_version=$(python3 --version 2>&1)
if [ "${python3_version}" = "Python ${PYTHON3_VERSION}" ]; then
    echo "Python 3 version check is OK."
else
    echo "Python 3 version check is failed."
    exit 1
fi

# install python libraries
pyenv shell ${PYTHON3_VERSION}
python3 -m pip install -U pip
python3 -m pip install -U setuptools wheel
python3 -m pip install pipx
python3 -m pipx install poetry
python3 -m pipx install gpustat

# install uv
if [ ! -e "${HOME}"/.local/bin/uv ]; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# install nvim
if [ ! -e "${HOME}"/.local/bin/nvim ]; then
    echo "installing neovim..."
    cd "${HOME}"/.local/bin
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
    mv nvim-linux-x86_64.appimage nvim.appimage
    chmod u+x nvim.appimage
    if ./nvim.appimage --version >&/dev/null; then
        ln -sf ./nvim.appimage nvim
    else
        ./nvim.appimage --appimage-extract
        mv -v squashfs-root ../nvim
        ln -sf ../nvim/AppRun nvim
        rm nvim.appimage
    fi
fi

# clean up
cd "$ROOTDIR"
[ -e "$TMPDIR" ] && rm -fr "$TMPDIR"

export PATH=${HOME}/.local/bin:$PATH

echo ""
echo "Sucessfully installed essential tools."
echo "Please run following command \"exec zsh -l\" to run zsh."
