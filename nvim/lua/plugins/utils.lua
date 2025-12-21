return {
  ---------------------------------
  --  op & obj related plugins   --
  ---------------------------------
  -- Multiple cursor support
  {
    "mg979/vim-visual-multi",
    event = { "InsertEnter" },
    init = function()
      vim.cmd([[
        let g:VM_maps = {}
        let g:VM_maps['Find Under'] = '<space>n'
        let g:VM_maps['Find Subword Under'] = '<space>n'
        aug VMlens
          au!
          au User visual_multi_start lua require('user.vmlens').start()
          au User visual_multi_exit lua require('user.vmlens').exit()
        aug END
      ]])
    end,
  },
  -- Smart repeat
  {
    "tpope/vim-repeat",
    event = { "InsertEnter" },
  },
  -- Auto close pairs
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  -- Better commenting
  {
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("Comment").setup()
    end,
  },
  -- Surround text objects
  {
    "machakann/vim-sandwich",
    event = { "InsertEnter" },
  },
  -- Better asterisk
  {
    "haya14busa/vim-asterisk",
    event = { "BufRead", "BufNewFile" },
    init = function()
      vim.cmd([[let g:asterisk#keeppos = 1]])
      vim.keymap.set("", "*", "<Plug>(asterisk-z*)", { noremap = true })
    end,
  },
  -- Stop at the end of line with w & b
  {
    "yutkat/wb-only-current-line.nvim",
    event = { "BufRead", "BufNewFile" },
  },

  ---------------------------------
  --      Git related plugins    --
  ---------------------------------
  -- Git integration
  {
    "tpope/vim-fugitive",
    event = { "VimEnter" },
    -- config = function()
    --   vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<CR><C-w>J", { noremap = true, silent = true })
    --   vim.api.nvim_set_keymap("n", "<leader>ga", ":Gwrite<CR>", { noremap = true, silent = true })
    --   vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<CR>", { noremap = true, silent = true })
    --   vim.api.nvim_create_autocmd("FileType", {
    --     pattern = "fugitive",
    --     command = "nmap <buffer> q gq",
    --   })
    -- end,
  },
  -- Nice conflict view
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    event = { "BufRead", "BufNewFile" },
  },
  -- Change direcotry by detecting git files
  {
    "ahmedkhalf/project.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("project_nvim").setup({
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package.json", "pyproject.toml" },
        detection_methods = { "pattern" },
      })
    end,
  },
  -- Lazygit in nvim
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gs", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    init = function()
      vim.g.lazygit_floating_window_winblend = 10
      vim.g.lazygit_floating_window_border_chars = { " ", " ", " ", " ", " ", " ", " ", " " }
    end,
    -- Disable nvim-tmux-navigator keybindings in lazygit buffer
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lazygit",
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          for _, lhs in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<C-\\>" }) do
            vim.keymap.set({ "t", "n" }, lhs, "<Nop>", opts)
          end
        end,
      })
    end,
  },

  ---------------------------------
  --  Filetype specific plugins  --
  ---------------------------------
  -- Good folding for python
  {
    "tmhedberg/SimpylFold",
    ft = { "python" },
  },
  -- Automatically add appropriate indent when writing a new line
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },
  -- Markdown preview in normal mode
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    after = { "nvim-treesitter" },
    dependencies = { "echasnovski/mini.icons", opt = true },
    config = function()
      require("render-markdown").setup({
        anti_conceal = { enabled = false },
      })
    end,
  },
  -- CSV viewer
  {
    "hat0uma/csvview.nvim",
    ft = { "csv" },
    config = function()
      require("csvview").setup()
    end,
  },

  ---------------------------------
  --        Other plugins        --
  ---------------------------------
  -- Visualize and clean trailing whitespaces
  {
    "ntpeters/vim-better-whitespace",
    event = { "InsertEnter" },
    init = function()
      vim.g.better_whitespace_filetypes_blacklist = { "dashboard", "help" }
    end,
  },
  -- Quickfix enhancements
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {},
  },
  -- Preview in quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        auto_enable = true,
        func_map = {
          vsplit = "",
        },
      })
    end,
  },
  -- Seemless navigation between tmux panes and vim splits
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  -- Show color or color code in buffer
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },
  -- Make folding faster
  {
    "Konfekt/FastFold",
    event = { "BufRead", "BufNewFile" },
  },
  -- Emphasize TODO comments
  {
    "folke/todo-comments.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        highlight = {
          before = "",
          keyword = "bg",
          after = "fg",
          pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
        },
      })
    end,
  },
  -- Key mapping helper
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
