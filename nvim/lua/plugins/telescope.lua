return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      {
        "AckslD/nvim-neoclip.lua",
        event = "TextYankPost",
        opts = {},
      },
    },
    cmd = "Telescope",
    init = function()
      -- Keybindings
      local keymap = vim.api.nvim_set_keymap
      local keymap_opts = { noremap = true, silent = true }
      keymap("n", "<C-f>r", "<cmd>Telescope oldfiles<CR>", keymap_opts)
      keymap("n", "<C-f>f", "<cmd>Telescope find_files<CR>", keymap_opts)
      keymap("n", "<C-f><C-f>", "<cmd>Telescope find_files no_ignore=true<CR>", keymap_opts)
      keymap("n", "<C-f>g", "<cmd>Telescope grep_string<CR>", keymap_opts)
      keymap("n", "<C-f><C-g>", "<cmd>Telescope live_grep<CR>", keymap_opts)
      keymap("n", "<C-f>b", "<cmd>Telescope buffers<CR>", keymap_opts)
      keymap("n", "<C-f>d", "<cmd>Telescope diagnostics bufnr=0 severity_bound=ERROR<CR>", keymap_opts)
      keymap("n", "<C-f><C-d>", "<cmd>Telescope diagnostics severity_bound=ERROR<CR>", keymap_opts)
      keymap("n", "<C-f><space>", "<cmd>Telescope resume<CR>", keymap_opts)
      keymap(
        "n",
        "<C-f>y",
        "<cmd>Telescope neoclip theme=dropdown layout_config={height=0.3,width=0.85} initial_mode=normal<CR>",
        keymap_opts
      )
    end,
    config = function()
      -- General configuration
      local themes = require("telescope.themes")
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          prompt_prefix = " 󰄾 ",
          selection_caret = " ",
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
          oldfiles = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 }, initial_mode = "normal" }),
          find_files = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 }, hidden = true }),
          grep_string = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 } }),
          live_grep = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 } }),
          buffers = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 }, initial_mode = "normal" }),
          diagnostics = themes.get_dropdown({ layout_config = { height = 0.3, width = 0.85 } }),
        },
      })
      -- Add extentions
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("neoclip")
    end,
  },
}
