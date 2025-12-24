#!/bin/bash

# Dotfile install script
# Copyright 2025 Tomoki Hayashi

set -eu

PYTHON_VERSION=3.12

# Check brew installation
if ! command -v brew > /dev/null; then
    echo "brew is not installed. Installing Homebrew..." >&2
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install zplug
if [ ! -e ~/.zplug ]; then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

# Install tpm
if [ ! -e ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install essential tools via brew
brew_packages=(
    pyenv
    uv
    zsh
    neovim
    tmux
    fzf
    fd
    ripgrep
    lsd
    bat
    atuin
    delta
    lazygit
    shellcheck
    timg
    gh
    jq
    yq
    btop
)

for pkg in "${brew_packages[@]}"; do
    brew ls --versions "$pkg" > /dev/null 2>&1 || brew install "$pkg"
done

# Setup fzf key bindings
if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

# pyenv init
export PATH="/opt/homebrew/bin:$PATH"
eval "$(pyenv init --path)"

# Install Python via pyenv
if ! pyenv versions | grep -q "$PYTHON_VERSION"; then
    pyenv install "$PYTHON_VERSION"
fi
pyenv global "$PYTHON_VERSION"

# Install Python packages for neovim
if [ -f requirements.txt ]; then
    python -m pip install --quiet --upgrade pip
    python -m pip install --quiet -r requirements.txt
fi

echo "Successfully finished installation."
echo "Please run: exec zsh -l"
