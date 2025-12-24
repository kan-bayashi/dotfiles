# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for macOS development environment featuring zsh + tmux + neovim.

## Setup Commands

```bash
# Initial setup (creates symlinks to home directory)
./setup.sh

# Install tools (zplug, tpm, fzf, brew packages, pyenv, python)
./install.sh

# Reload shell after installation
exec zsh -l
```

## Architecture

### Shell Environment (zsh)
- Plugin manager: zplug (installed in `~/.zplug`)
- Theme: bullet-train (from `themes/bullet-train.zsh-theme`)
- Key bindings: vi mode with `Ctrl+o` to switch to command mode
- History: Managed by atuin (fuzzy search with `Ctrl+r`)

### Terminal Multiplexer (tmux)
- Prefix key: `Ctrl+t` (not default `Ctrl+b`)
- Plugin manager: tpm (installed in `~/.tmux/plugins/tpm`)
- Key plugins: tmux-resurrect (session restore), tmux-continuum (auto-save)
- Pane navigation: `Ctrl+h/j/k/l` (vim-aware via vim-tmux-navigator)
- Split panes: `prefix + |` (horizontal), `prefix + -` (vertical)

### Editor (Neovim)
- Config location: `nvim/` directory, symlinked to `~/.config/nvim`
- Plugin manager: lazy.nvim
- Structure: `nvim/lua/core/` (base settings), `nvim/lua/plugins/` (plugin configs)
- LSP, Telescope, and Tree-sitter configured

### Application Configs
- `ghostty/` - Ghostty terminal config (theme: jellybeans-like)
- `lazygit/` - Lazygit config (uses nvim-remote, delta pager)
- `atuin/` - Shell history manager config (fuzzy search mode)

### Symlink Structure
`setup.sh` creates symlinks from this repo to home directory:
- All `.*` files (except .git, .gitignore, .DS_Store, .claude) -> `~/`
- `nvim/`, `ghostty/`, `lazygit/`, `atuin/` -> `~/.config/`
- `themes/*.zsh-theme` -> `~/.zsh/themes/`
