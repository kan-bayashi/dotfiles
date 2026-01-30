-- Keymaps
local map = vim.keymap.set
local opts = { silent = true }

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Escape
map("!", "<C-o>", "<Esc>", opts)
map("v", "<C-o>", "<Esc>", opts)
map("x", "<C-o>", "<Esc>", opts)

-- Remap jump
map("n", "{", "<C-o>", opts)
map("n", "}", "<C-i>", opts)
map("n", "<C-i>", "<Nop>", opts)
map("n", "<C-o>", "<Nop>", opts)

-- Disable items to avoid many typos
map("n", "<S-j>", "<Nop>", opts)
map("n", "<C-f>", "<Nop>", opts)
map("n", "<C-b>", "<Nop>", opts)

-- For US keyboard
map("n", ";", ":")

-- Useful mappings
map("n", "Y", "y$", opts)
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Window navigation
map("n", "<C-w>-", "<cmd>sp<CR>", opts)
map("n", "<C-w>|", "<cmd>vs<CR>", opts)

-- Tab and buffer navigation
map("n", "tt", "<cmd>tabnew<CR>", opts)

-- Reload file
map("n", "<Leader>e", "<cmd>e!<CR>", opts)

-- Save file
map("n", "<Leader>w", "<cmd>w<CR>", opts)

-- Close buffer
map("n", "<Leader>q", "<cmd>bdel<CR>", opts)

-- Force close buffer
map("n", "<Leader><C-q>", "<cmd>bdel!<CR>", opts)

-- Preserve annoying pop
map("n", "q:", "<cmd>q<CR>", opts)

-- Move selected lines up/down in visual mode
-- map("v", "J", ":m '>+1<CR>gv=gv", opts)
-- map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keep selection after indent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Insert current date with comment
map("n", "<Leader>id", function()
  local date = vim.fn.strftime("%Y/%m/%d")
  local commented = vim.bo.commentstring:gsub("%%s", date)
  vim.api.nvim_put({ commented }, "c", true, true)
end, { silent = true, desc = "Insert current date with comment" })
