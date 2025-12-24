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
    event = { "BufRead", "BufNewFile" },
    config = function()
      vim.fn["operator#sandwich#set"]("add", "block", "skip_space", 1)
      vim.g["sandwich#recipes"] = vim.list_extend(vim.deepcopy(vim.g["sandwich#default_recipes"]), {
        {
          buns = { 'substitute(&commentstring, "%s", "{{{", "")', 'substitute(&commentstring, "%s", "}}}", "")' },
          expr = 1,
          input = { "z" },
        },
      })
    end,
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
  },
  -- Nice conflict view
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    event = { "BufRead", "BufNewFile" },
  },
  -- Change directory by detecting git files
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
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gs",
        function()
          Snacks.lazygit()
        end,
        desc = "LazyGit",
      },
    },
    ---@type snacks.Config
    opts = {
      lazygit = {
        win = {
          width = 0.9,
          height = 0.85,
          border = "none",
          wo = {
            winblend = 0,
          },
        },
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      -- Disable nvim-tmux-navigator keybindings in lazygit buffer
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*lazygit*",
        callback = function(ev)
          local buf_opts = { buffer = ev.buf, silent = true }
          for _, lhs in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<C-\\>" }) do
            vim.keymap.set({ "t", "n" }, lhs, "<Nop>", buf_opts)
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
  -- Markdown preview
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    lazy = false,
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
  -- File explorer as a buffer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>-", "<cmd>Oil --float<cr>", desc = "Open parent directory" },
    },
    opts = {
      float = {
        max_width = 0.9,
        max_height = 0.5,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        preview_split = "right",
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
      local oil_group = vim.api.nvim_create_augroup("OilConfig", {})
      -- Fix relative path when leaving oil buffer
      vim.api.nvim_create_autocmd("BufLeave", {
        group = oil_group,
        pattern = "oil:///*",
        callback = function()
          vim.cmd("cd .")
        end,
      })
    end,
  },
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
  -- Seamless navigation between tmux panes and vim splits
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
    opts = {
      win = {
        border = "rounded",
        wo = {
          winblend = 0,
        },
      },
    },
  },
}
