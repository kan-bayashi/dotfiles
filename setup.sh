#!/bin/bash -e

# Dotfile setup script
# Copyright 2019 Tomoki Hayashi

# make symbolic link of dotfiles
for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".travis.yml" ]] && continue
    [ -e ~/"$f" ] && cp ~/"$f" ~/"$f".bak && rm -f ~/"$f"
    ln -s "$PWD"/"$f" ~/
    echo "Made symlink of $f"
done

# make symbolic link of vim setting files
[ -e ~/.vim ] && cp -r ~/.vim ~/.vim.bak && rm -rf ~/.vim
[ -e ~/.config/nvim ] && cp -r ~/.config/nvim ~/.config/nvim.bak && rm -rf ~/.config/nvim
[ ! -e ~/.vim/rc ] && mkdir -p ~/.vim/rc
[ ! -e ~/.config ] && mkdir -p ~/.config
ln -s "${PWD}"/vim/dein.toml ~/.vim/rc
ln -s "${PWD}"/vim/dein_lazy.toml ~/.vim/rc
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
echo "Made symlink of vim related files."

# copy cool zsh theme
[ -e ~/.zsh/themes/bullet-train.zsh-theme ] && \
    cp ~/.zsh/themes/bullet-train.zsh-theme ~/.zsh/themes/bullet-train.zsh-theme.bak && rm -f ~/.zsh/themes/bullet-train.zsh-theme
[ ! -e ~/.zsh/themes ] && mkdir -p ~/.zsh/themes
ln -s "$PWD"/themes/bullet-train.zsh-theme ~/.zsh/themes

# make symbolic link of ipython setting file
[ -e ~/.ipython/profile_default ] && cp -r ~/.ipython/profile_default ~/.ipython/profile_default.bak
[ ! -e ~/.ipython/profile_default/startup ] && mkdir -p ~/.ipython/profile_default/startup
ln -s "${PWD}"/ipython/ipython_config.py ~/.ipython/profile_default
ln -s "${PWD}"/ipython/startup/keybindings.py ~/.ipython/profile_default/startup
echo "Made symlink of ipython setting files."

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

# install fzf
if [ ! -e ~/.fzf ];then
    echo "####################################################"
    echo "#                   FZF INSTALL                    #"
    echo "####################################################"
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    cd ~/.fzf && ./install
fi

# install pyenv
if [ ! -e ~/.pyenv ];then
    echo "####################################################"
    echo "#                 PYENV INSTALL                    #"
    echo "####################################################"
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv

    # install pyenv python3.6
    export PATH=$HOME/.pyenv/bin:$PATH
    eval "$(pyenv init -)"
    env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.6.6
    pyenv shell 3.6.6
    $HOME/.pyenv/shims/pip install --upgrade pip
    $HOME/.pyenv/shims/pip install -r requirements.txt
fi

# start zsh
exec zsh -l
