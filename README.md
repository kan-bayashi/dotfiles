# Dotfiles

My dotfiles for vim-kaoriya in windows

![](./sample/gvim.jpg)

## Environment

Scripts are tested on following environments:
- Windows 10 home edition
- Windows 10 professional edition

## How-to-install

1. Get Cica fonts <https://github.com/miiton/Cica>

2. Install Python 3.6 [download](https://www.python.org/ftp/python/3.6.8/python-3.6.8-amd64.exe)

> - DO NOT FORGET TO CHECK `Add Python 3.6 to PATH`

3. Install Git [download](https://github.com/git-for-windows/git/releases/latest)

4. Run command prompt with administrator authorization & execute following commands

```
pip install pynvim jedi flake8 pycodestyle autopep8
```

5. Copy `vimfiles` to `$HOME` (default `$HOME` is `C:\Users\<user_name>`)

6. Copy `init.vim` and `ginit.vim` to `$HOME\AppData\Local\nvim` (if not exist, please make directory)

7. Download neovim [download](http://vim-jp.org/redirects/koron/vim-kaoriya/latest/win64/)

8. Run `nvim-qt.exe`

> Require time for the first time to install plugins

## References

- nerd font: [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
