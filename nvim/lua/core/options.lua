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
local undodir = vim.fn.expand("~/.cache/nvim/undo")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
vim.opt.ttimeoutlen = 10

-- Set NVIM environment variable for nvim --remote commands
vim.env.NVIM = vim.v.servername
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
vim.opt.guicursor = {
  "n-v-c:block-blinkon500-blinkoff500",
  "i-ci-ve:ver25-blinkon500-blinkoff500",
  "r-cr:hor20-blinkon500-blinkoff500",
  "o:hor50",
}
vim.opt.shortmess = "c"
vim.opt.signcolumn = "yes"
vim.opt.linebreak = true
vim.opt.fillchars = { eob = " " }

-- Diagnostic setting
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
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

-- 2-space indentation for specific filetypes
autocmd("Filetype", {
  pattern = { "yaml", "tf", "vim", "lua", "typescript", "typescriptreact", "javascript", "javascriptreact", "json", "html", "css" },
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
})

-- Filetype specific settings
autocmd("Filetype", { pattern = "yaml", command = "setlocal foldmethod=indent" })
autocmd("Filetype", { pattern = "json", command = "setlocal conceallevel=0" })
autocmd("Filetype", { pattern = "gitcommit", command = "setlocal spell" })
