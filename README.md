# Dotfiles

My dotfiles (zsh + tmux 2.6 + vim 8 or nvim)

![](./sample/terminal.png)

## Requirements

This scripts are tested on following envrionments:

- CentOS 7.5
- Ubuntu 16.04 and 18.04

## How-to-install (for Linux)

1. Get Nerd fonts from <https://github.com/ryanoasis/nerd-fonts>
2. If use iterm2, install `iterm2/jellybeans_like.itermcolors`
3. Setup dotfiles and install software as follow

```bash
# clone this repository
$ git clone https://github.com/kan-bayashi/dotfiles
$ cd dotfiles

# setup dotfiles
$ ./setup.sh

# install essential tools (required sudo)
$ ./install.sh

# enable zsh environment
$ exec zsh -l
```

If you do not have sudo, please contact your administrator to install dependencies.

## References

- nerd font: [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
- zsh theme: [caiogondim/bullet-train.zsh](https://github.com/caiogondim/bullet-train.zsh)
