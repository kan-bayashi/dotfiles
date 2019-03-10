#!/bin/bash

# Hyper cool terminal setup script in takedalab's servers
# Copyright 2017 Tomoki Hayashi
set -e

# make symbolic link of dotfiles
for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [ -e ~/"$f" ] && mv ~/"$f" ~/"$f".bak
    ln -s "${PWD}"/"$f" ~/
    echo "make symlink of $f"
done

# make symbolic link of vim setting files
if [ -e ~/.vim/rc ]; then
    mv ~/.vim ~/.vim.bak
fi
mkdir -p ~/.vim/rc
ln -s "${PWD}"/vim/dein.toml ~/.vim/rc
ln -s "${PWD}"/vim/dein_lazy.toml ~/.vim/rc
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# copy cool zsh theme
if [ ! -e ~/.zsh/themes/bullet-train.zsh-theme ];then
    mkdir -p ~/.zsh/themes
    ln -s "${PWD}"/themes/bullet-train.zsh-theme ~/.zsh/themes
fi

# make symbolic link of vim setting files
if [ ! -e ~/.ipython/profile_default ];then
    mkdir -p ~/.ipython/profile_default
    ln -s "${PWD}"/ipython/ipython_config.py ~/.ipython/profile_default/
fi
if [ ! -e ~/.ipython/profile_default/startup ];then
    mkdir -p ~/.ipython/profile_default/startup
    ln -s "${PWD}"/ipython/startup/keybindings.py ~/.ipython/profile_default/startup
fi

# install zplug
if [ ! -e ~/.zplug ];then
    echo "####################################################"
    echo "#                    ZPLUG INSTALL                 #"
    echo "####################################################"
    git clone https://github.com/zplug/zplug ~/.zplug
fi

# install tpm
if [ ! -e ~/.tmux/plugins/tpm ];then
    echo "####################################################"
    echo "#           TMUX PLUGIN MANAGER INSTALL            #"
    echo "####################################################"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# install pyenv
if [ ! -e ~/.pyenv ];then
    echo "####################################################"
    echo "#                  PYENV INSTALL                   #"
    echo "####################################################"
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
fi

# install fzf
if [ ! -e ~/.fzf ];then
    echo "####################################################"
    echo "#                   FZF INSTALL                    #"
    echo "####################################################"
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    workdir=${PWD}
    cd ~/.fzf && ./install && cd ${workdir}
fi

# start zsh
exec zsh -l
