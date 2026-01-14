return {
  -- Colorscheme
  {
    "kan-bayashi/nvim-jellybeans",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.cmd([[colorscheme jellybeans]])
      -- Use Ghostty background directly
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
      -- Set floating window background for winblend to work
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      -- Set Telescope background for winblend to work
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
      local border_hl = vim.api.nvim_get_hl(0, { name = "TelescopeBorder" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_hl.fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = border_hl.fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = border_hl.fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = border_hl.fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsDiffAdd", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsDiffChange", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsDiffDelete", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "TelescopeResultsDiffUntracked", { bg = "NONE" })
    end,
  },
  -- Start screen
  {
    "folke/snacks.nvim",
    lazy = false,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "SnacksDashboardOpened",
        callback = function(ev)
          vim.b[ev.buf].miniindentscope_disable = true
          vim.o.laststatus = 3
        end,
      })
    end,
    ---@diagnostic disable: undefined-doc-name
    ---@type snacks.Config
    opts = {
      dashboard = {
        preset = {
          header = [[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠁⠀⣀⠀⠀⠉⢻⣿⣿⣿⡿⠟⠛⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠈⠉⠙⠛⠿⣿⣿⣿⡿⠋⠁⠀⢀⠀⠀⠉⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⣴⣿⣿⣿⣦⠀⠀⠛⢛⣭⠤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⣤⡉⠛⠁⠀⣰⣿⣿⣿⣷⡀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⢿⣿⣿⣿⡿⠁⠀⠀⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠙⠀⠀⠀⠻⣿⣿⣿⣿⠃⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠉⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠋⠁⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡄⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣶⡄⠀⠀⠀⠀⠀⠀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⣼⣿⣿⡟⠈⢿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡏⠘⣿⣿⣿⡀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣧⣠⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣧⡰⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⡿⠋⠀⣀⣠⣤⣴⠶⠶⠶⣶⣦⣤⣄⡀⠈⠻⣿⣿⣿⣿⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠀⡀⠄⠠⢀⠀⠀⠀⠀⠀⠀⠈⠉⠀⣠⣶⣿⣾⣿⡏⠁⠀⠀⠀⠀⠙⣿⣿⣿⣷⣦⡀⠈⠉⠀⠀⠀⠀⠀⠀⢀⠀⠄⡀⢀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠠⠁⠄⡈⠄⠂⠈⠄⡀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣄⡀⠀⠀⣠⣼⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⢀⠐⠠⠈⠄⡐⠀⠂⠄⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠡⠈⠄⡐⠠⠀⠈⠄⠠⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡿⡿⠿⠟⠟⠛⠛⠋⣇⠀⠀⠀⠀⠠⠈⠄⡁⠂⠄⢈⠐⠠⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠡⠈⠄⠐⠀⠠⠁⠌⠀⠀⠀⠀⣿⡟⠟⠟⠛⠛⠛⠙⠉⠉⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⠀⠀⠀⠀⠄⡁⠂⠄⢁⠂⠄⡈⠐⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠡⠈⡀⢁⠂⠁⠀⠀⠀⠀⠀⢹⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⠀⠀⠀⠀⠀⠀⠡⠈⡀⠐⠠⠀⢴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣷⣦⣤⣀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⠿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣶⣷⣾⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿██║⣿╚████║⣿███████╗╚██████╔╝⣿⣿╚████╔╝⣿⣿██║⣿██║⣿╚═╝⣿██║⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿╚═╝⣿⣿╚═══╝⣿╚══════╝⣿╚═════╝⣿⣿⣿⣿╚═══╝⣿⣿⣿╚═╝⣿╚═╝⣿⣿⣿⣿⣿╚═╝⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 0, padding = { 1, 0 } },
          { icon = " ", title = "Recent Files", section = "recent_files", cwd = true, indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
    },
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
      theme.normal.c.bg = nil
      theme.normal.c.fg = "#dadada"

      require("lualine").setup({
        options = {
          theme = theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = " ", right = " " },
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
          },
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
      bufferline.setup({
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
          tab = { bg = "NONE" },
          tab_selected = { bg = "NONE" },
          tab_separator = { bg = "NONE" },
          tab_separator_selected = { bg = "NONE" },
          tab_close = { bg = "NONE" },
          modified = { bg = "NONE" },
          modified_visible = { bg = "NONE" },
          modified_selected = { bg = "NONE" },
          duplicate = { bg = "NONE" },
          duplicate_visible = { bg = "NONE" },
          duplicate_selected = { bg = "NONE" },
          diagnostic = { bg = "NONE" },
          diagnostic_visible = { bg = "NONE" },
          diagnostic_selected = { bg = "NONE" },
          hint = { bg = "NONE" },
          hint_visible = { bg = "NONE" },
          hint_selected = { bg = "NONE" },
          info = { bg = "NONE" },
          info_visible = { bg = "NONE" },
          info_selected = { bg = "NONE" },
          warning = { bg = "NONE" },
          warning_visible = { bg = "NONE" },
          warning_selected = { bg = "NONE" },
          error = { bg = "NONE" },
          error_visible = { bg = "NONE" },
          error_selected = { bg = "NONE" },
          indicator_visible = { bg = "NONE" },
          indicator_selected = { bg = "NONE" },
          trunc_marker = { bg = "NONE" },
        },
      })
      vim.keymap.set("n", "tl", "<cmd>BufferLineCycleNext<CR>", { silent = true })
      vim.keymap.set("n", "th", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
    end,
  },
  -- Show indent line
  {
    "echasnovski/mini.indentscope",
    branch = "stable",
    config = function()
      require("mini.indentscope").setup({
        symbol = "┃",
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
      require("scrollbar").setup({
        marks = {
          GitAdd = { text = "┃" },
          GitChange = { text = "┃" },
          GitDelete = { text = "▁" },
        },
      })
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
    tag = "v0.3.0",
    config = function()
      require("modes").setup({
        colors = {
          insert = "#8bc34a", -- green (bright)
          visual = "#ffd43b", -- yellow (bright)
          -- delete = "#ef5350", -- red (bright)
          -- copy = "#ffd43b", -- yellow (bright)
        },
        line_opacity = 0.3,
      })
    end,
  },
  -- Cool cursor move
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
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
        highlight = {
          groups = {
            InclineNormal = { guibg = "NONE" },
            InclineNormalNC = { guibg = "NONE" },
          },
        },
        window = {
          padding = 0,
          margin = { horizontal = 0 },
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
          local errors = #vim.tbl_filter(function(d)
            return d.severity == vim.diagnostic.severity.ERROR
          end, diag)
          local warns = #vim.tbl_filter(function(d)
            return d.severity == vim.diagnostic.severity.WARN
          end, diag)
          local infos = #vim.tbl_filter(function(d)
            return d.severity == vim.diagnostic.severity.INFO
          end, diag)
          local hints = #vim.tbl_filter(function(d)
            return d.severity == vim.diagnostic.severity.HINT
          end, diag)

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
            table.insert(result, " ┃")
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
            table.insert(result, " ┃")
          end
          table.insert(result, {
            ft_icon and { " ", ft_icon, " ", guifg = ft_color } or "",
            { filename, gui = modified and "bold,italic" or "bold" },
            modified and { " ●", guifg = "#ef5350" } or "",
          })
          table.insert(result, "  ")
          result.guibg = nil
          return result
        end,
      })
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
  },
  -- Visual feebacks on undo/redo, yank, etc.
  {
    "y3owk1n/undo-glow.nvim",
    event = "VeryLazy",
    config = function()
      local ug = require("undo-glow")
      ug.setup({
        animation = {
          enabled = true,
          duration = 300,
          animation_type = "fade",
        },
      })
      -- Undo / Redo
      vim.keymap.set("n", "u", ug.undo, { desc = "Undo with glow" })
      vim.keymap.set("n", "<C-r>", ug.redo, { desc = "Redo with glow" })
      -- Paste
      vim.keymap.set("n", "p", ug.paste_below, { desc = "Paste below with glow" })
      vim.keymap.set("n", "P", ug.paste_above, { desc = "Paste above with glow" })
      -- Yank (autocmd)
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function() ug.yank() end,
      })
    end,
  },
}
