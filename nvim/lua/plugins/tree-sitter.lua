return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "David-Kunz/treesitter-unit",
      "m-demare/hlargs.nvim",
      "nvim-treesitter/playground",
    },
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
      vim.api.nvim_set_keymap(
        "x",
        "iu",
        ':lua require"treesitter-unit".select()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "x",
        "au",
        ':lua require"treesitter-unit".select(true)<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "o",
        "iu",
        ':<c-u>lua require"treesitter-unit".select()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "o",
        "au",
        ':<c-u>lua require"treesitter-unit".select(true)<CR>',
        { noremap = true, silent = true }
      )

      -- HLargs
      require("hlargs").setup()
    end,
  },
}
