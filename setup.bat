@echo off
set homedir=%homepath%
set workdir=%~dp0
echo home directory    = %homedir%
echo working directory = %workdir%

:: check backup existence
if exist %homedir%\vimfiles.bak (
    del %homedir%\vimfiles.bak
)

:: make backup
if exist %homedir%\vimfiles (
    rename %homedir%\vimfiles vimfiles.bak
)

:: make symlink
mklink %homedir%\vimfiles %workdir%vimfiles

:: check directory existence
if not exist %homedir%\AppData\Local\nvim (
    mkdir %homedir%\AppData\Local\nvim
)

:: check backup existence
if exist %homedir%\AppData\Local\nvim\init.vim.bak (
    del %homedir%\AppData\Local\nvim\init.vim.bak
)
if exist %homedir%\AppData\Local\nvim\ginit.vim.bak (
    del %homedir%\AppData\Local\nvim\ginit.vim.bak
)

:: make backup
if exist %homedir%\AppData\Local\nvim\init.vim (
    rename %homedir%\AppData\Local\nvim\init.vim init.vim.bak
)
if exist %homedir%\AppData\Local\nvim\ginit.vim (
    rename %homedir%\AppData\Local\nvim\ginit.vim ginit.vim.bak
)

:: make symlink
mklink %homedir%\AppData\Local\nvim\init.vim %workdir%init.vim
mklink %homedir%\AppData\Local\nvim\ginit.vim %workdir%ginit.vim
