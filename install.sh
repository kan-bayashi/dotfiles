#!/bin/bash

# Dotfile install script for Linux server
# Copyright 2025 Tomoki Hayashi

set -eu

PYTHON_VERSION=3.12
LAZYGIT_VERSION=0.57.0
DELTA_VERSION=0.18.2
BAT_VERSION=0.26.1
PYENV_VERSION=2.6.17

# Ensure ~/.local/bin exists
mkdir -p ~/.local/bin ~/.local/src

# Install zplug
if [ ! -e ~/.zplug ]; then
    echo "Installing zplug..."
    git clone https://github.com/zplug/zplug ~/.zplug
fi

# Install tpm
if [ ! -e ~/.tmux/plugins/tpm ]; then
    echo "Installing tpm..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install pyenv
if [ ! -e ~/.pyenv ]; then
    echo "Installing pyenv..."
    git clone https://github.com/pyenv/pyenv.git -b "v${PYENV_VERSION}" ~/.pyenv
fi

# Install fzf
if [ ! -e ~/.fzf ]; then
    echo "Installing fzf..."
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

# Install volta
if [ ! -e ~/.volta ]; then
    echo "Installing volta..."
    curl https://get.volta.sh | bash
fi

# Install lazygit
if [ ! -e ~/.local/bin/lazygit ]; then
    echo "Installing lazygit..."
    cd ~/.local/src
    wget -q "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar -xzf "lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" lazygit
    mv lazygit ~/.local/bin/
fi

# Install delta
if [ ! -e ~/.local/bin/delta ]; then
    echo "Installing delta..."
    cd ~/.local/src
    wget -q "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf "delta-${DELTA_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    mv "delta-${DELTA_VERSION}-x86_64-unknown-linux-musl/delta" ~/.local/bin/
fi

# Install bat
if [ ! -e ~/.local/bin/bat ]; then
    echo "Installing bat..."
    cd ~/.local/src
    wget -q "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    mv "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl/bat" ~/.local/bin/
fi

# Install atuin
if ! command -v atuin > /dev/null 2>&1; then
    echo "Installing atuin..."
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

# Install nsxiv
if [ ! -e ~/.local/bin/nsxiv ]; then
    echo "Installing nsxiv..."
    cd ~/.local/src
    if [ ! -d nsxiv ]; then
        git clone https://github.com/nsxiv/nsxiv.git
    fi
    cd nsxiv
    make -j"$(nproc)"
    cp nsxiv ~/.local/bin/
fi

# Install uv
if [ ! -e ~/.local/bin/uv ]; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Install neovim
if [ ! -e ~/.local/bin/nvim ]; then
    echo "Installing neovim..."
    cd ~/.local/bin
    wget -q https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
    mv nvim-linux-x86_64.appimage nvim.appimage
    chmod u+x nvim.appimage
    if ./nvim.appimage --version > /dev/null 2>&1; then
        ln -sf ./nvim.appimage nvim
    else
        ./nvim.appimage --appimage-extract
        mv squashfs-root ../nvim
        ln -sf ../nvim/AppRun nvim
        rm nvim.appimage
    fi
fi

# Setup Python via pyenv
export PATH="${HOME}/.pyenv/bin:${HOME}/.local/bin:$PATH"
eval "$(pyenv init -)"

if ! pyenv versions | grep -q "$PYTHON_VERSION"; then
    echo "Installing Python ${PYTHON_VERSION}..."
    CONFIGURE_OPTS="--enable-shared" pyenv install "$PYTHON_VERSION"
fi
pyenv global "$PYTHON_VERSION"

# Install Python packages
python -m pip install --quiet --upgrade pip
if [ -f requirements.txt ]; then
    python -m pip install --quiet -r requirements.txt
fi

echo ""
echo "Successfully finished installation."
echo "Please run: exec zsh -l"
