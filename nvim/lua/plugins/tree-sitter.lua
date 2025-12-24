return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "David-Kunz/treesitter-unit",
      "m-demare/hlargs.nvim",
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-context",
    },
    event = { "BufRead", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      -- Tree-sitter
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        ensure_installed = {
          "python",
          "bash",
          "json",
          "toml",
          "yaml",
          "typescript",
          "javascript",
          "tsx",
          "make",
          "markdown",
          "vim",
          "lua",
        },
        additional_vim_regex_highlighting = false,
      })
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldlevel = 99
      vim.opt.foldnestmax = 2
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sh",
        command = "setlocal foldmethod=marker",
      })

      -- Treesitter-unit
      local ts_unit = require("treesitter-unit")
      vim.keymap.set("x", "iu", function() ts_unit.select() end, { silent = true })
      vim.keymap.set("x", "au", function() ts_unit.select(true) end, { silent = true })
      vim.keymap.set("o", "iu", function() ts_unit.select() end, { silent = true })
      vim.keymap.set("o", "au", function() ts_unit.select(true) end, { silent = true })

      -- HLargs
      require("hlargs").setup()

      -- Treesitter-context
      require("treesitter-context").setup({
        separator = "━",
      })
    end,
  },
}
