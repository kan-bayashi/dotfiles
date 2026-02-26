return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = {
      "m-demare/hlargs.nvim",
      "nvim-treesitter/nvim-treesitter-context",
    },
    event = { "BufRead", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
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
        "rust",
        "matlab",
      }, {
        force = false, -- force installation of already installed parsers
        generate = true, -- generate `parser.c` from `grammar.json` or `grammar.js` before compiling.
        max_jobs = 4, -- limit parallel tasks (useful in combination with {generate} on memory-limited systems).
        summary = false, -- print summary of successful and total operations for multiple languages.
      })

      -- Automatic syntax highlighting for all filetypes with available parser
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "*",
        callback = function()
          local ok = pcall(vim.treesitter.start)
          if ok then
            if vim.bo.filetype ~= "python" then
              vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- Folding with markers for shell scripts, Tree-sitter for others
      -- Python uses SimpylFold (def/class only)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldlevel = 99
      vim.opt.foldnestmax = 2
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sh",
        command = "setlocal foldmethod=marker",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        command = "setlocal foldlevel=0",
      })

      -- Highthlight arguments
      require("hlargs").setup()

      -- Treesitter-context
      require("treesitter-context").setup({
        separator = "━",
      })
    end,
  },
}
