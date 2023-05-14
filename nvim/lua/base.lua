-- Basic options
-- {{{
local opt = vim.opt
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileformat = "unix"
opt.syntax = "on"
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 300
opt.undofile = true
opt.undodir = vim.fn.expand("~/.cache/nvim/undo")
opt.ttimeoutlen = 10
opt.backspace = { "indent", "eol", "start" }
opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.autoindent = true
opt.showmatch = true
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.number = true
opt.laststatus = 3
opt.showtabline = 2
opt.cmdheight = 2
opt.showmode = false
opt.showcmd = false
opt.cursorline = true
opt.wildmenu = true
opt.history = 1000
opt.background = "dark"
opt.termguicolors = true
opt.pumheight = 10
opt.foldmethod = "marker"
opt.hidden = true
opt.mouse = "a"
opt.shortmess = "c"
opt.signcolumn = "yes"
-- }}}

-- Keymaps
-- {{{
local keymap_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", keymap_opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Escape
keymap("!", "<C-o>", "<Esc>", keymap_opts)
keymap("v", "<C-o>", "<Esc>", keymap_opts)
keymap("x", "<C-o>", "<Esc>", keymap_opts)

-- Remap jump
keymap("n", "<Leader>]", "<C-i>", keymap_opts)
keymap("n", "<Leader>[", "<C-o>", keymap_opts)
keymap("n", "<C-i>", "<Nop>", keymap_opts)
keymap("n", "<C-o>", "<Nop>", keymap_opts)

-- Disable items to avoid many typos
keymap("n", "<S-j>", "<Nop>", keymap_opts)
keymap("n", "<C-f>", "<Nop>", keymap_opts)
keymap("n", "<C-b>", "<Nop>", keymap_opts)

-- For US keyboard
keymap("n", ";", ":", {})

-- Useful mappings
keymap("n", "Y", "y$", keymap_opts)
keymap("n", "n", "nzz", keymap_opts)
keymap("n", "N", "Nzz", keymap_opts)
keymap("n", "j", "gj", keymap_opts)
keymap("n", "k", "gk", keymap_opts)

-- Window navigation
keymap("n", "<C-w>-", ":sp<CR>", keymap_opts)
keymap("n", "<C-w>|", ":vs<CR>", keymap_opts)

-- Tab and buffer navigation
keymap("n", "tt", ":tabnew<CR>", keymap_opts)

-- Reload file
keymap("n", "<Leader>e", ":e!<CR>", keymap_opts)

-- Copy to clipboard
vim.cmd([[
  function! Yank(text) abort
    let escape = system('yank', a:text)
    if v:shell_error
      echoerr escape
    else
      call writefile([escape], '/dev/tty', 'b')
    endif
  endfunction
]])
keymap("", "<Leader>y", "y:<C-u>call Yank(@0)<CR>", keymap_opts)
-- }}}

-- Autocommands
-- {{{
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
autocmd("BufNewFile,BufRead", {
  pattern = "*.yaml",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})
autocmd("BufNewFile,BufRead", {
  pattern = "*.yml",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})
autocmd("BufNewFile,BufRead", {
  pattern = "*.tf",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})
autocmd("BufNewFile,BufRead", {
  pattern = "*.json",
  command = "set conceallevel=0",
})
autocmd("Filetype", {
  pattern = "vim",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})
autocmd("Filetype", {
  pattern = "lua",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})
autocmd("Filetype", {
  pattern = "gitcommit",
  command = "setlocal spell",
})
-- }}}
