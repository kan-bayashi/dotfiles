# Dotfiles

Personal dotfiles for Linux server (zsh + tmux + neovim)

![](./sample/terminal.png)

## Setup

1. Get Nerd fonts from <https://github.com/ryanoasis/nerd-fonts>
2. Setup dotfiles and install software as follows:

```bash
# Clone this repository
git clone https://github.com/kan-bayashi/dotfiles
cd dotfiles

# Setup dotfiles (creates symlinks)
./setup.sh

# Install essential tools
./install.sh

# Enable zsh environment
exec zsh -l
```

## References

- Nerd font: [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
- Zsh theme: [caiogondim/bullet-train.zsh](https://github.com/caiogondim/bullet-train.zsh)
