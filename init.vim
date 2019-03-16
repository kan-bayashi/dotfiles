"------------------------------------
" dein setting
"------------------------------------
" {{{
" required
if !&compatible
  set nocompatible
endif

" set dein directory
let s:dein_dir = expand('~\.cache\dein')
let s:dein_repo_dir = s:dein_dir . '\repos\github.com\Shougo\dein.vim'

" if dein is not installed, install dein
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" toml file
let g:rc_dir = expand('~\vimfiles\rc')
let s:toml = g:rc_dir . '\dein.toml'
let s:toml_lazy = g:rc_dir . '\dein_lazy.toml'

" dein setting start
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" required
filetype plugin indent on
syntax enable

" check whether plugin is installed
if dein#check_install()
  call dein#install()
endif
" }}}

"------------------------------------
" basic vim setting
"------------------------------------
" {{{
" encoding and file format related
set encoding=utf-8                              " default encoding
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp " auto encoding select
set ffs=unix,mac,dos                            " auto file format select "
scriptencoding utf-8                            " setting for multi byte char

" search related
set incsearch  " enable incremental search
set hlsearch   " highlight search result
set ignorecase " do not care about catital char in search
set smartcase  " if query includes captial char, discriminate them
set wrapscan   " if search finished, re-search from the beginning

" backup file realted
set noswapfile " do not make swap file
set nobackup   " do not make backup file
set noundofile " do not make undo file

" key related
set ttimeoutlen=10             " minimum key strock time
set backspace=indent,eol,start " make backspace strong

" use space instead of tab
set tabstop=4    " tab width
set expandtab    " use space instead of tab
set shiftwidth=4 " shift width in auto indent
set autoindent   " enable auto indent
set showmatch    " highlight corresponding parentheses

" status line realted
set number       " show line number
set laststatus=2 " always show status number
set cmdheight=2  " command line height
set noshowmode   " do not show mode in command line

" cursor related
set cursorline   " highlight cursor line

" command line completion related
set wildmenu      " enable completion in command mode
set history=1000  " number of command history

" color related
set t_Co=256           " terminal
set background=dark    " background color
if (has("termguicolors"))
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
colorscheme jellybeans " colorscheme

" other
set foldmethod=marker " enable marker folding
set hidden            " change buffer without saving
set mouse=a           " enable mouse

" python path related
let g:python3_host_prog = expand('~\') . 'AppData\Local\Programs\Python\Python36\python.exe'
" }}}

"------------------------------------
" shortcut setting
"------------------------------------
" {{{
" set spalce as leader
let mapleader = "\<Space>"

" enable wrapping move
nnoremap j gj
nnoremap k gk

" jump search result and refresh window position
nnoremap n nzz
nnoremap N Nzz

" instead of esc
noremap <C-o> <ESC>
noremap! <C-o> <ESC>

" disable page scroll
nnoremap <C-f> <Nop>
nnoremap <C-b> <Nop>

" reopen current buffer file
nnoremap <leader>e :e!<CR>

" reload vimrc
nnoremap <leader>R :source ~\_vimrc<CR>

" D like yank function
nnoremap Y y$

" intuitive pane dividing
nnoremap <C-w>- :<C-u>sp<CR>
nnoremap <C-w>\| :<C-u>vs<CR>

" tab manipulation setting
nnoremap <silent>tt :tabnew<CR>
" }}}
