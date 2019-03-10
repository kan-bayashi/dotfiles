#!/bin/bash -e

# Dotfile setup script
# Copyright 2019 Tomoki Hayashi

# make symbolic link of dotfiles
for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [ -e ~/"$f" ] && mv ~/"$f" ~/"$f".bak
    ln -s "${PWD}"/"$f" ~/
    echo "Made symlink of $f"
done

# make symbolic link of vim setting files
if [ -e ~/.vim/rc ]; then
    mv ~/.vim ~/.vim.bak
fi
[ ! -e ~/.vim/rc ] && mkdir -p ~/.vim/rc
[ ! -e ~/.config ] && mkdir -p ~/.config
ln -s "${PWD}"/vim/dein.toml ~/.vim/rc
ln -s "${PWD}"/vim/dein_lazy.toml ~/.vim/rc
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
echo "Made symlink of vim related files."

# copy cool zsh theme
if [ ! -e ~/.zsh/themes/bullet-train.zsh-theme ];then
    mkdir -p ~/.zsh/themes
    ln -s "${PWD}"/themes/bullet-train.zsh-theme ~/.zsh/themes
    echo "Made symlink of zsh theme file."
fi

# make symbolic link of ipython setting file
[ ! -e ~/.ipython/profile_default ] && mkdir -p ~/.ipython/profile_default
[ -e ~/.ipython/profile_default/ipython_config.py ] && \
    mv ~/.ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py.bak
ln -s "${PWD}"/ipython/ipython_config.py ~/.ipython/profile_default/

[ ! -e ~/.ipython/profile_default/startup ] && mkdir -p ~/.ipython/profile_default/startup
[ -e ~/.ipython/profile_default/startup/keybidings.py ] && \
    mv ~/.ipython/profile_default/startup/keybidings.py ~/.ipython/profile_default/startup/keybidings.py.bak
ln -s "${PWD}"/ipython/startup/keybindings.py ~/.ipython/profile_default/startup
echo "Made symlink of ipython setting files."

echo "Sucessfully setup dotfiles."
echo "Next, please run install.sh to install essential tools."
