#!/bin/bash

# Dotfile setup script
# Copyright 2025 Tomoki Hayashi

set -eu

# Helper function: backup existing file/dir and create symlink
make_symlink() {
    local src="$1"
    local dest="$2"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        rm -rf "${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi
    ln -s "$src" "$dest"
    echo "Made symlink: $dest -> $src"
}

# Make symbolic link of dotfiles
for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".claude" ]] && continue
    make_symlink "${PWD}/$f" ~/"$f"
done

# XDG config directories
mkdir -p ~/.config
for dir in nvim ghostty lazygit atuin; do
    [ -d "${PWD}/${dir}" ] && make_symlink "${PWD}/${dir}" ~/.config/"${dir}"
done

# Zsh theme
mkdir -p ~/.zsh/themes
make_symlink "${PWD}/themes/bullet-train.zsh-theme" ~/.zsh/themes/bullet-train.zsh-theme

echo "Successfully setup dotfiles."
echo "Next, please run install.sh to install essential tools."
