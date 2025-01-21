-- Basic options
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileformat = "unix"
vim.opt.syntax = "on"
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undo")
vim.opt.ttimeoutlen = 10
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.showmatch = true
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.showtabline = 2
vim.opt.cmdheight = 2
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.history = 1000
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.pumheight = 10
vim.opt.foldmethod = "marker"
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.shortmess = "c"
vim.opt.signcolumn = "yes"

-- Keymaps
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
keymap("n", "{", "<C-o>", keymap_opts)
keymap("n", "}", "<C-i>", keymap_opts)
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

-- Save file
keymap("n", "<Leader>w", ":w<CR>", keymap_opts)

-- Close buffer
keymap("n", "<Leader>q", ":bdel<CR>", keymap_opts)

-- Force close buffer
keymap("n", "<Leader>Q", ":bdel!<CR>", keymap_opts)

-- Preserve annoying pop
keymap("n", "q:", ":q<CR>", keymap_opts)

-- Copy to clipboard via osc52
-- ref: https://github.com/neovim/neovim/discussions/28010#discussioncomment-9877494
vim.o.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

-- Autocommands
local autocmd = vim.api.nvim_create_autocmd
autocmd("Filetype", {
  pattern = "yaml",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})
autocmd("Filetype", {
  pattern = "tf",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})
autocmd("Filetype", {
  pattern = "json",
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
  pattern = "typescriptreact",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})
autocmd("Filetype", {
  pattern = "gitcommit",
  command = "setlocal spell",
})
