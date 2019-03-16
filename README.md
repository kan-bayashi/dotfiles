# Dotfiles

My dotfiles (zsh + tmux 2.6 + neovim)

![](./sample/terminal.png)

## Requirements

- zsh
- git
- brew

## Setup

1. Get Nerd fonts from <https://github.com/ryanoasis/nerd-fonts>
2. If use iterm2, install `iterm2/jellybeans_like.itermcolors`
3. Setup dotfiles and install software as follow

  ```bash
  # clone this repository
  $ git clone https://github.com/kan-bayashi/dotfiles -b mac
  $ cd dotfiles

  # setup dotfiles
  $ ./setup.sh

  # install denpendencies
  $ brew install ripgrep
  $ brew install fd

  # install nvim
  $ brew install neovim
  ```

## References

- nerd font: [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
- zsh theme: [caiogondim/bullet-train.zsh](https://github.com/caiogondim/bullet-train.zsh)
