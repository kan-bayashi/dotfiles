-- Keymaps
local keymap_opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", keymap_opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
keymap("n", "<C-d>", "<C-d>zz", keymap_opts)
keymap("n", "<C-u>", "<C-u>zz", keymap_opts)
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
