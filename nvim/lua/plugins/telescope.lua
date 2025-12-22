return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    init = function()
      -- Keybindings
      local keymap = vim.api.nvim_set_keymap
      local keymap_opts = { noremap = true, silent = true }
      keymap("n", "<C-f>f", "<cmd>Telescope find_files<CR>", keymap_opts)
      keymap("n", "<C-f>F", "<cmd>Telescope find_files no_ignore=true<CR>", keymap_opts)
      keymap("n", "<C-f>g", "<cmd>Telescope git_status<CR>", keymap_opts)
      keymap("n", "<C-f><C-g>", "<cmd>Telescope live_grep<CR>", keymap_opts)
      keymap("n", "<C-f>b", "<cmd>Telescope buffers<CR>", keymap_opts)
      keymap("n", "<C-f>r", "<cmd>Telescope oldfiles<CR>", keymap_opts)
      keymap("n", "<C-f><Space>", "<cmd>Telescope file_browser<CR>", keymap_opts)
      keymap("n", "<C-f>d", "<cmd>Telescope diagnostics bufnr=0 severity_bound=ERROR<CR>", keymap_opts)
      keymap("n", "<C-f><C-d>", "<cmd>Telescope diagnostics severity_bound=ERROR<CR>", keymap_opts)
      keymap("n", "<C-f>*", "<cmd>Telescope grep_string<CR>", keymap_opts)
      keymap(
        "n",
        "<C-f>/",
        ':lua require("telescope.builtin").live_grep({search_dirs={vim.fn.expand("%:p")}, previewer=true, path_display={shorten=1}})<CR>',
        keymap_opts
      )
      keymap("n", "<C-f><C-f>", "<cmd>Telescope resume<CR>", keymap_opts)
    end,
    config = function()
      -- General configuration
      local themes = require("telescope.themes")
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          prompt_prefix = ">>> ",
          selection_caret = " ",
          shorten_path = true,
          color_devicons = true,
          winblend = 0,
          set_env = { ["COLORTERM"] = "truecolor" },
          mappings = {
            n = {
              ["t"] = actions.select_tab,
              ["q"] = actions.close,
              ["<C-o>"] = actions.close,
              ["<C-c>"] = actions.close,
              ["dd"] = actions.delete_buffer,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<S-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
            i = {
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<S-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
          },
        },
        pickers = {
          find_files = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 }, hidden = true }),
          live_grep = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 } }),
          buffers = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 }, initial_mode = "normal" }),
          oldfiles = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 }, initial_mode = "normal" }),
          git_status = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 }, initial_mode = "normal" }),
          grep_string = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 } }),
          diagnostics = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 } }),
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            cwd_to_path = true,
            files = true,
            hidden = { file_browser = true, folder_browser = true },
            mappings = {
              ["i"] = {
                ["<C-o>"] = false,
                ["<bs>"] = false,
              },
            },
          },
        },
      })
      -- Add extentions
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },
}
