return {
  -- Colorscheme
  {
    "kan-bayashi/nvim-jellybeans",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.cmd([[colorscheme jellybeans]])
      -- Get colorscheme background before overriding
      local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
      local colorscheme_bg = normal_hl.bg
      -- Use Ghostty background directly
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
      -- Set floating window background for winblend to work
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = colorscheme_bg })
      -- Set Telescope background for winblend to work
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colorscheme_bg })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = colorscheme_bg })
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = colorscheme_bg })
      vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = colorscheme_bg })
      local border_hl = vim.api.nvim_get_hl(0, { name = "TelescopeBorder" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_hl.fg, bg = colorscheme_bg })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = border_hl.fg, bg = colorscheme_bg })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = border_hl.fg, bg = colorscheme_bg })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = border_hl.fg, bg = colorscheme_bg })
    end,
  },
  -- Start screen
  {
    "goolord/alpha-nvim",
    event = { "VimEnter" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local startify = require("alpha.themes.startify")
      startify.file_icons.provider = "devicons"
      startify.section.header.val = {
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠁⠀⣀⠀⠀⠉⢻⣿⣿⣿⡿⠟⠛⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠈⠉⠙⠛⠿⣿⣿⣿⡿⠋⠁⠀⢀⠀⠀⠉⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⣴⣿⣿⣿⣦⠀⠀⠛⢛⣭⠤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⣤⡉⠛⠁⠀⣰⣿⣿⣿⣷⡀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⢿⣿⣿⣿⡿⠁⠀⠀⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠙⠀⠀⠀⠻⣿⣿⣿⣿⠃⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠉⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠋⠁⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡄⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣶⡄⠀⠀⠀⠀⠀⠀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⣼⣿⣿⡟⠈⢿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡏⠘⣿⣿⣿⡀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣧⣠⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣧⡰⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⡿⠋⠀⣀⣠⣤⣴⠶⠶⠶⣶⣦⣤⣄⡀⠈⠻⣿⣿⣿⣿⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠀⡀⠄⠠⢀⠀⠀⠀⠀⠀⠀⠈⠉⠀⣠⣶⣿⣾⣿⡏⠁⠀⠀⠀⠀⠙⣿⣿⣿⣷⣦⡀⠈⠉⠀⠀⠀⠀⠀⠀⢀⠀⠄⡀⢀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠠⠁⠄⡈⠄⠂⠈⠄⡀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣄⡀⠀⠀⣠⣼⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⢀⠐⠠⠈⠄⡐⠀⠂⠄⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠡⠈⠄⡐⠠⠀⠈⠄⠠⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡿⡿⠿⠟⠟⠛⠛⠋⣇⠀⠀⠀⠀⠠⠈⠄⡁⠂⠄⢈⠐⠠⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠡⠈⠄⠐⠀⠠⠁⠌⠀⠀⠀⠀⣿⡟⠟⠟⠛⠛⠛⠙⠉⠉⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⠀⠀⠀⠀⠄⡁⠂⠄⢁⠂⠄⡈⠐⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠡⠈⡀⢁⠂⠁⠀⠀⠀⠀⠀⢹⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⠀⠀⠀⠀⠀⠀⠡⠈⡀⠐⠠⠀⢴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣷⣦⣤⣀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⠿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣶⣷⣾⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿██║⣿╚████║⣿███████╗╚██████╔╝⣿⣿╚████╔╝⣿⣿██║⣿██║⣿╚═╝⣿██║⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿╚═╝⣿⣿╚═══╝⣿╚══════╝⣿╚═════╝⣿⣿⣿⣿╚═══╝⣿⣿⣿╚═╝⣿╚═╝⣿⣿⣿⣿⣿╚═╝⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
      }
      require("alpha").setup(startify.config)
    end,
  },
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local theme = require("lualine.themes.jellybeans")
      for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
        if theme[mode] and theme[mode].a then
          theme[mode].a.gui = ""
          theme[mode].b.bg = "#303030"
          theme[mode].b.fg = "#dadada"
        end
      end
      theme.insert.a.bg = "#87af5f"
      theme.normal.c.bg = "#131313"
      theme.normal.c.fg = "#dadada"

      require("lualine").setup({
        options = {
          theme = theme,
        },
        sections = {
          lualine_b = {
            { "branch" },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
              newfile_status = true,
              shorting_target = 24,
              symbols = { modified = "_󰷥", readonly = " ", newfile = "󰄛" },
            },
          },
          lualine_x = {
            { "searchcount" },
            { "filetype", colored = true, icon_only = false },
          }
        },
        tabline = {},
      })
    end,
  },
  -- Tab line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local bufferline = require("bufferline")
      require("bufferline").setup({
        options = {
          style_preset = bufferline.style_preset.minimal,
          numbers = "none",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = false,
          separator_style = { " ", " " },
          always_show_bufferline = true,
          sort_by = "id",
        },
        highlights = {
          fill = { bg = "NONE" },
          background = { bg = "NONE" },
          buffer_visible = { bg = "NONE" },
          buffer_selected = { bg = "NONE" },
          separator = { bg = "NONE" },
          separator_visible = { bg = "NONE" },
          separator_selected = { bg = "NONE" },
        },
      })
      vim.api.nvim_set_keymap("n", "tl", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "th", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
    end,
  },
  -- Show indent line
  {
    "echasnovski/mini.indentscope",
    branch = "stable",
    config = function()
      require("mini.indentscope").setup({
        symbol = "▏",
      })
    end,
  },
  -- Show scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = {
      "BufWinEnter",
      "CmdwinLeave",
      "TabEnter",
      "TermEnter",
      "TextChanged",
      "VimResized",
      "WinEnter",
      "WinScrolled",
    },
    config = function()
      require("scrollbar").setup()
      local scrollbar_groups = {
        "ScrollbarHandle",
        "ScrollbarCursor",
        "ScrollbarCursorHandle",
        "ScrollbarSearch",
        "ScrollbarSearchHandle",
        "ScrollbarError",
        "ScrollbarErrorHandle",
        "ScrollbarWarn",
        "ScrollbarWarnHandle",
        "ScrollbarInfo",
        "ScrollbarInfoHandle",
        "ScrollbarHint",
        "ScrollbarHintHandle",
        "ScrollbarMisc",
        "ScrollbarMiscHandle",
        "ScrollbarGitAdd",
        "ScrollbarGitAddHandle",
        "ScrollbarGitChange",
        "ScrollbarGitChangeHandle",
        "ScrollbarGitDelete",
        "ScrollbarGitDeleteHandle",
      }
      for _, group in ipairs(scrollbar_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = group })
        vim.api.nvim_set_hl(0, group, { fg = hl.fg, bg = "NONE" })
      end
      vim.api.nvim_set_hl(0, "ScrollbarCursor", { fg = "#ffffff", bg = "NONE" })
      vim.api.nvim_set_hl(0, "ScrollbarCursorHandle", { fg = "#ffffff", bg = "NONE" })
    end,
  },
  -- -- Show counts of searched items
  -- {
  --   "kevinhwang91/nvim-hlslens",
  --   event = { "BufRead", "BufNewFile" },
  --   dependencies = { "petertriho/nvim-scrollbar" },
  --   config = function()
  --     require("scrollbar.handlers.search").setup()
  --     local kopts = { noremap = true, silent = true }
  --     vim.api.nvim_set_keymap(
  --       "n",
  --       "n",
  --       [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
  --       kopts
  --     )
  --     vim.api.nvim_set_keymap(
  --       "n",
  --       "N",
  --       [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
  --       kopts
  --     )
  --     vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>noh<CR>", kopts)
  --     vim.api.nvim_set_keymap("n", "<C-o><C-o>", "<Cmd>noh<CR>", kopts)
  --   end,
  -- },
  -- Show git modification status in columns
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = { "petertriho/nvim-scrollbar" },
    config = function()
      require("gitsigns").setup({
        attach_to_untracked = false,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "<leader>[", function()
            if vim.wo.diff then
              return "<leader>["
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "<leader>]", function()
            if vim.wo.diff then
              return "<leader>]"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>ha", gs.stage_hunk)
          map("n", "<leader>hu", gs.reset_hunk)

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  -- Line color depending on the mode
  {
    "mvllow/modes.nvim",
    tag = "v0.2.1",
    config = function()
      require("modes").setup({
        colors = {
          insert = "#8bc34a", -- green (bright)
          visual = "#ffd43b", -- yellow (bright)
          -- delete = "#ef5350", -- red (bright)
          -- copy = "#ffd43b", -- yellow (bright)
        },
      })
    end,
  },
  -- Mini popup info
  {
    "b0o/incline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
          options = {
            winblend = 5,
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified

          -- Git status from gitsigns
          local gitsigns = vim.b[props.buf].gitsigns_status_dict
          local added = gitsigns and gitsigns.added or 0
          local changed = gitsigns and gitsigns.changed or 0
          local removed = gitsigns and gitsigns.removed or 0

          -- LSP diagnostics
          local clients = vim.lsp.get_clients({ bufnr = props.buf })
          local lsp_count = #clients
          local diag = vim.diagnostic.get(props.buf)
          local errors = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.ERROR end, diag)
          local warns = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.WARN end, diag)
          local infos = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.INFO end, diag)
          local hints = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.HINT end, diag)

          local result = {}
          if errors > 0 then
            table.insert(result, { "  " .. errors, guifg = "#ef5350" })
          end
          if warns > 0 then
            table.insert(result, { "  " .. warns, guifg = "#ffd43b" })
          end
          if infos > 0 then
            table.insert(result, { "  " .. infos, guifg = "#8bc34a" })
          end
          if hints > 0 then
            table.insert(result, { "  " .. hints, guifg = "#64b5f6" })
          end
          if errors + warns + infos + hints > 0 then
            table.insert(result, " |")
          end
          if added > 0 then
            table.insert(result, { "  " .. added, guifg = "#8bc34a" })
          end
          if changed > 0 then
            table.insert(result, { "  " .. changed, guifg = "#ffd43b" })
          end
          if removed > 0 then
            table.insert(result, { "  " .. removed, guifg = "#ef5350" })
          end
          if lsp_count > 0 then
            table.insert(result, { "  " .. lsp_count, guifg = "#64b5f6" })
          end
          if added + changed + removed + lsp_count > 0 then
            table.insert(result, " |")
          end
          table.insert(result, {
            ft_icon and { " ", ft_icon, " ", guifg = ft_color } or "",
            { filename, gui = modified and "bold,italic" or "bold" },
            modified and { " ●", guifg = "#ef5350" } or "",
          })
          table.insert(result, "  ")
          result.guibg = "#131313"
          return result
        end,
      })
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
  },
}
