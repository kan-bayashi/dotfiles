local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  -- Library for other plugins
  use { 'MunifTanjim/nui.nvim' }
  use { 'nvim-lua/plenary.nvim' }

  ---------------------------------
  --    Looks related plugins   --
  ---------------------------------
  -- ColorScheme
  use {
    'kan-bayashi/nvim-jellybeans',
    requires = { 'rktjmp/lush.nvim' },
    config = function()
      vim.cmd [[colorscheme jellybeans]]
    end
  }
  -- Start screen
  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require('alpha.themes.startify')
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
      require('alpha').setup(startify.config)
    end
  }
  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'jellybeans',
        },
        sections = {
          lualine_b = {
            { 'branch' },
            { 'diff' },
            {
              'diagnostics',
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            }
          },
          lualine_c = {
            {
              'filename',
              path = 1,
              newfile_status = true,
              shorting_target = 24,
              symbols = { modified = '_󰷥', readonly = ' ', newfile = '󰄛' },
            }
          },
        },
        tabline = {},
      })
    end,
  }
  -- Tab line
  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline').setup({
        options = {
          -- mode = 'tabs',
          numbers = 'none',
          diagnostics = 'coc',
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = true,
          separator_style = 'thick',
          always_show_bufferline = true,
          sort_by = 'id',
        },
      })
      vim.api.nvim_set_keymap("n", "tl", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "th", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
    end,
  }
  -- Show indent line
  use {
    'echasnovski/mini.indentscope',
    branch = 'stable',
    config = function()
      require('mini.indentscope').setup({
        symbol = "▏",
      })
    end
  }
  -- Show scrollbar
  use {
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
    end
  }
  -- Show counts of searched items
  use {
    'kevinhwang91/nvim-hlslens',
    event = { "BufRead", "BufNewFile" },
    requires = { "petertriho/nvim-scrollbar", opt = true },
    wants = { "nvim-scrollbar" },
    config = function()
      require("scrollbar.handlers.search").setup()
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
        kopts)
      vim.api.nvim_set_keymap('n', '<Esc><Esc>', '<Cmd>noh<CR>', kopts)
      vim.api.nvim_set_keymap('n', '<C-o><C-o>', '<Cmd>noh<CR>', kopts)
    end
  }
  -- Show git modification status in columns
  use {
    'lewis6991/gitsigns.nvim',
    event = { "BufRead", "BufNewFile" },
    requires = { "petertriho/nvim-scrollbar", opt = true },
    wants = { "nvim-scrollbar" },
    config = function()
      require('gitsigns').setup({
        attach_to_untracked = false,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>ha', gs.stage_hunk)
          map('n', '<leader>hu', gs.reset_hunk)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
      require("scrollbar.handlers.gitsigns").setup()
    end
  }
  -- Cute command line UI
  use {
    'gelguy/wilder.nvim',
    event = { "CmdLineEnter" },
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':', '/', '?' } })
      wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          border = "rounded",
          pumblend = 10,
          highlights = { border = "CocBorder", default = "CocFloating" },
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        })
      ))
    end,
  }

  ---------------------------------
  --     LSP related plugins     --
  ---------------------------------
  -- LSP
  use {
    "neoclide/coc.nvim",
    branch = "release",
    event = { "InsertEnter" },
    requires = {
      { "honza/vim-snippets", event = "InsertEnter" },
      { "SirVer/ultisnips",   event = "InsertEnter" },
    },
    wants = { "vim-snippets", "ultisnips" },
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Nop>' -- Disable UltiSnips expansion
      vim.g.coc_global_extensions = {
        'coc-json',
        'coc-pyright',
        'coc-diagnostic',
        'coc-word',
        'coc-syntax',
        'coc-snippets',
        'coc-yaml',
        'coc-toml',
        'coc-tsserver',
        'coc-prettier',
      }

      local keyset = vim.keymap.set
      -- Autocomplete
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- Use Tab for trigger completion with characters ahead and navigate
      -- NOTE: There's always a completion item selected by default, you may want to enable
      -- no select by setting `"suggest.noselect": true` in your configuration file
      -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
      -- other plugins before putting this into your config
      local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
        opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      -- Make <CR> to accept selected completion item or notify coc.nvim to format
      -- <C-g>u breaks current undo, please make your own choice
      keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

      -- Use <c-j> to trigger snippets
      keyset("i", "<C-k>", "<Plug>(coc-snippets-expand-jump)")
      vim.g.coc_snippet_next = '<C-n>'
      vim.g.coc_snippet_prev = '<C-p>'

      -- Use `[g` and `]g` to navigate diagnostics
      -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
      keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
      keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

      -- GoTo code navigation
      keyset("n", "<leader>d", "<Plug>(coc-definition)", { silent = true })

      -- Use K to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end

      keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

      -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
      })

      -- Symbol renaming
      keyset("n", "<leader>r", "<Plug>(coc-rename)", { silent = true })

      -- Setup formatexpr specified filetype(s)
      vim.api.nvim_create_autocmd("FileType", {
        group = "CocGroup",
        pattern = "typescript,json",
        command = "setl formatexpr=CocAction('formatSelected')",
        desc = "Setup formatexpr specified filetype(s)."
      })

      -- Update signature help on jump placeholder
      vim.api.nvim_create_autocmd("User", {
        group = "CocGroup",
        pattern = "CocJumpPlaceholder",
        command = "call CocActionAsync('showSignatureHelp')",
        desc = "Update signature help on jump placeholder"
      })

      -- Remap <C-d> and <C-u> to scroll float windows/popups
      ---@diagnostic disable-next-line: redefined-local
      local opts = { silent = true, nowait = true, expr = true }
      keyset("n", "<C-d>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-d>"', opts)
      keyset("n", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', opts)
      keyset("i", "<C-d>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
      keyset("i", "<C-u>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
      keyset("v", "<C-d>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-d>"', opts)
      keyset("v", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', opts)

      -- Add `:Format` command to format current buffer
      vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

      -- " Add `:Fold` command to fold current buffer
      vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

      -- Add `:OR` command for organize imports of the current buffer
      vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
    end
  }
  -- AI completion
  use {
    'github/copilot.vim',
    event = { "InsertEnter" },
    setup = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('i', '<c-]>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end
  }

  ---------------------------------
  -- Treesitter related plugins  --
  ---------------------------------
  -- Better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'David-Kunz/treesitter-unit',
      'm-demare/hlargs.nvim',
    },
    run = ':TSUpdate',
    config = function()
      -- Tree-sitter
      require('nvim-treesitter.configs').setup({
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
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldlevel = 99
      vim.opt.foldnestmax = 2
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sh",
        command = "setlocal foldmethod=marker",
      })

      -- Treesitter-unit
      vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>',
        { noremap = true, silent = true })
      vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>',
        { noremap = true, silent = true })
      vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>',
        { noremap = true, silent = true })
      vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>',
        { noremap = true, silent = true })

      -- HLargs
      require('hlargs').setup()
    end
  }

  ---------------------------------
  -- FuzzyFinder related plugins --
  ---------------------------------
  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = "*",
    cmd = { "Telescope" },
    module = { "telescope" },
    requires = {
      { 'nvim-lua/plenary.nvim',                      opt = true },
      { 'nvim-tree/nvim-web-devicons',                opt = true },
      { 'fannheyward/telescope-coc.nvim',             opt = true },
      { 'nvim-telescope/telescope-file-browser.nvim', opt = true },
      { 'nvim-telescope/telescope-fzf-native.nvim',   run = 'make', opt = true },
    },
    wants = {
      'plenary.nvim',
      'nvim-web-devicons',
      'telescope-coc.nvim',
      'telescope-file-browser.nvim',
      'telescope-fzf-native.nvim'
    },
    setup = function()
      -- Keybindings
      local keymap = vim.api.nvim_set_keymap
      local keymap_opts = { noremap = true, silent = true }
      keymap("n", "<C-f>f", "<cmd>Telescope find_files<CR>", keymap_opts)
      keymap("n", "<C-f>g", "<cmd>Telescope git_status<CR>", keymap_opts)
      keymap("n", "<C-f><C-g>", "<cmd>Telescope live_grep<CR>", keymap_opts)
      keymap("n", "<C-f>b", "<cmd>Telescope buffers<CR>", keymap_opts)
      keymap("n", "<C-f><Space>", "<cmd>Telescope file_browser<CR>", keymap_opts)
      keymap("n", "<C-f>e", "<cmd>Telescope emoji<CR>", keymap_opts)
      keymap("n", "<C-f>q",
        '<cmd>Telescope coc diagnostics theme=dropdown layout_config={"height":0.25,"width":0.85}<CR>', keymap_opts)
      keymap("n", "<C-f>*", "<cmd>Telescope grep_string<CR>", keymap_opts)
      keymap("n", "<C-f>/",
        ':lua require("telescope.builtin").live_grep({search_dirs={vim.fn.expand("%:p")}, previewer=false, path_display={shorten=1}})<CR>',
        keymap_opts)
      keymap("n", "<C-f><C-f>", "<cmd>Telescope resume<CR>", keymap_opts)
    end,
    config = function()
      -- General configuration
      local themes = require("telescope.themes")
      local actions = require("telescope.actions")
      require("telescope").setup {
        defaults = {
          prompt_prefix = ">>> ",
          selection_caret = "  ",
          shorten_path = true,
          color_devicons = true,
          winblend = 10,
          set_env = { ['COLORTERM'] = 'truecolor' },
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
          find_files = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 }, hidden = true }),
          live_grep = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
          buffers = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
          git_status = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
          grep_string = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
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
        }
      }
      -- Add extentions
      require("telescope").load_extension("coc")
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end
  }

  ---------------------------------
  --  op & obj related plugins   --
  ---------------------------------
  -- Multiple cursor support
  use {
    'mg979/vim-visual-multi',
    event = { "InsertEnter" },
    setup = function()
      vim.cmd([[
        let g:VM_maps = {}
        let g:VM_maps['Find Under'] = '<space>n'
        let g:VM_maps['Find Subword Under'] = '<space>n'
        aug VMlens
          au!
          au User visual_multi_start lua require('vmlens').start()
          au User visual_multi_exit lua require('vmlens').exit()
        aug END
      ]])
    end
  }
  -- Smart repeat
  use {
    'tpope/vim-repeat',
    event = { "InsertEnter" },
  }
  -- Auto close pairs
  use {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = function()
      require("nvim-autopairs").setup()
    end
  }
  -- Better commenting
  use {
    'numToStr/Comment.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function()
      require('Comment').setup()
    end
  }
  -- Surround text objects
  use { 'machakann/vim-sandwich', event = { "InsertEnter" } }
  -- Next level movement
  use {
    'phaazon/hop.nvim',
    event = { "BufRead", "BufNewFile" },
    requires = { 'mfussenegger/nvim-treehopper', opt = true },
    wants = { 'nvim-treehopper' },
    config = function()
      require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
      end, { remap = true })
      vim.keymap.set('', '<Leader><Leader>', function()
        hop.hint_words()
      end, { noremap = true })
      vim.keymap.set('o', 'm', ':<C-U>lua require("tsht").nodes()<CR>', { silent = true })
      vim.keymap.set('x', 'm', ':lua require("tsht").nodes()<CR>', { silent = true })
    end
  }
  -- Better asterisk
  use {
    'haya14busa/vim-asterisk',
    setup = function()
      vim.cmd [[let g:asterisk#keeppos = 1]]
      vim.keymap.set('', '*', '<Plug>(asterisk-z*)', { noremap = true })
    end
  }
  -- Stop at the end of line with w & b
  use {
    'yutkat/wb-only-current-line.nvim',
    event = { "BufRead", "BufNewFile" },
  }
  -- Show matched pairs and smart move with %
  use {
    'andymass/vim-matchup',
    event = { "InsertEnter" },
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  }

  ---------------------------------
  --      Git related plugins    --
  ---------------------------------
  -- Git integration
  use {
    'tpope/vim-fugitive',
    event = { "VimEnter" },
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR><C-w>J', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ga', ':Gwrite<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fugitive",
        command = "nmap <buffer> q gq",
      })
    end
  }
  -- Change direcotry by detecting git files
  use {
    "ahmedkhalf/project.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("project_nvim").setup()
    end
  }

  ---------------------------------
  --  Filetype specific plugins  --
  ---------------------------------
  -- Good folding for python
  use { 'tmhedberg/SimpylFold', ft = { 'python' } }
  -- Automatically add appropriate indent when writing a new line
  use { 'Vimjas/vim-python-pep8-indent', ft = { 'python' } }

  ---------------------------------
  --        Other plugins        --
  ---------------------------------
  -- Visualize and clean trailing whitespaces
  use {
    'ntpeters/vim-better-whitespace',
    event = { "InsertEnter" },
    setup = function()
      vim.g.better_whitespace_filetypes_blacklist = { 'dashboard', 'help' }
    end
  }
  -- Replace lines in quickfix
  use {
    'gabrielpoca/replacer.nvim',
    module = { 'replacer' },
    setup = function()
      vim.api.nvim_create_user_command('QFReplace', 'lua require("replacer").run()', {})
    end
  }
  -- Reflect quickfix changes in buffer
  use {
    'stefandtw/quickfix-reflector.vim',
    event = { "InsertEnter" },
  }
  -- Yank with history
  use {
    "gbprod/yanky.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("yanky").setup({
        system_clipboard = {
          sync_with_ring = false,
        },
      })
      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleBackward)")
    end
  }
  -- Show the list of objects in the current buffer
  use {
    'stevearc/aerial.nvim',
    cmd = { "AerialToggle" },
    setup = function()
      vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>')
    end,
    config = function()
      require('aerial').setup({
        layout = {
          -- Determines the default direction to open the aerial window. The 'prefer'
          -- options will open the window in the other direction *if* there is a
          -- different buffer in the way of the preferred direction
          -- Enum: prefer_right, prefer_left, right, left, float
          default_direction = "prefer_left",
        },
      })
    end
  }
  -- Seemless navigation between tmux panes and vim splits
  use {
    'christoomey/vim-tmux-navigator',
    setup = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  }
  -- Show color or color code in buffer
  use {
    'norcalli/nvim-colorizer.lua',
    event = { "BufRead", "BufNewFile" },
    config = function()
      require('colorizer').setup()
    end
  }
  -- Make folding faster
  use {
    'Konfekt/FastFold',
    event = { "BufRead", "BufNewFile" },
  }
  -- Emphasize TODO comments
  use {
    "folke/todo-comments.nvim",
    event = { "BufRead", "BufNewFile" },
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
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
      }
    end
  }
  -- Automatic :noh
  -- use { 'romainl/vim-cool', event = { "BufRead", "BufNewFile" } }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
