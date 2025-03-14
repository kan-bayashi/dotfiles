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

-- Sign definition
vim.fn.sign_define("DiagnosticSignError", { text = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "" })

-- Diagnostic setting
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = "rounded",
    title = "󰋡 Diagnostics",
    header = {},
    suffix = {},
    prefix = {},
    format = function(diag)
      if diag.code then
        return string.format(" [%s](%s): %s ", diag.source, diag.code, diag.message)
      else
        return string.format(" [%s]: %s ", diag.source, diag.message)
      end
    end,
  },
})

-- Show diagnostics on cursor hold
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

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
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2 foldmethod=indent",
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
