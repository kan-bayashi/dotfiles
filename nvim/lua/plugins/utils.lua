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
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<CR><C-w>J", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ga", ":Gwrite<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<CR>", { noremap = true, silent = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fugitive",
        command = "nmap <buffer> q gq",
      })
    end,
  },
  -- Change direcotry by detecting git files
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    event = { "BufRead", "BufNewFile" },
  },
  {
    "ahmedkhalf/project.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("project_nvim").setup({
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package.json" },
        detection_methods = { "pattern" },
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
  -- Replace lines in quickfix
  {
    "gabrielpoca/replacer.nvim",
    event = { "InsertEnter" },
    module = { "replacer" },
    init = function()
      vim.api.nvim_create_user_command("QFReplace", 'lua require("replacer").run()', {})
    end,
  },
  -- Reflect quickfix changes in buffer
  {
    "stefandtw/quickfix-reflector.vim",
    event = { "InsertEnter" },
  },
  -- Quickfix preview
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup()
    end,
  },
  -- Yank with history
  {
    "gbprod/yanky.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("yanky").setup({
        system_clipboard = {
          sync_with_ring = false,
        },
      })
      -- 2025/01/27 Does not work with neovim OSC52
      -- vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      -- vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      -- vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      -- vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
      -- vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleForward)")
      -- vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleBackward)")
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
}
