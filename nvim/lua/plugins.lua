local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })

	-- Library for other plugins
	use({ "MunifTanjim/nui.nvim" })
	use({ "nvim-lua/plenary.nvim" })

	---------------------------------
	--    Looks related plugins   --
	---------------------------------
	-- ColorScheme
	use({
		"kan-bayashi/nvim-jellybeans",
		requires = { "rktjmp/lush.nvim" },
		config = function()
			vim.cmd([[colorscheme jellybeans]])
		end,
	})
	-- Start screen
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local startify = require("alpha.themes.startify")
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
	})
	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "jellybeans",
				},
				sections = {
					lualine_b = {
						{ "branch" },
						{ "diff" },
						{
							"diagnostics",
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
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
				},
				tabline = {},
			})
		end,
	})
	-- Tab line
	use({
		"akinsho/bufferline.nvim",
		tag = "*",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					-- mode = 'tabs',
					numbers = "none",
					diagnostics = "nvim_lsp",
					show_buffer_close_icons = false,
					show_close_icon = false,
					show_tab_indicators = true,
					separator_style = "thick",
					always_show_bufferline = true,
					sort_by = "id",
				},
			})
			vim.api.nvim_set_keymap("n", "tl", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "th", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
		end,
	})
	-- Show indent line
	use({
		"echasnovski/mini.indentscope",
		branch = "stable",
		config = function()
			require("mini.indentscope").setup({
				symbol = "▏",
			})
		end,
	})
	-- Show scrollbar
	use({
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
		end,
	})
	-- Show counts of searched items
	use({
		"kevinhwang91/nvim-hlslens",
		event = { "BufRead", "BufNewFile" },
		requires = { "petertriho/nvim-scrollbar", opt = true },
		wants = { "nvim-scrollbar" },
		config = function()
			require("scrollbar.handlers.search").setup()
			local kopts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
				kopts
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
				kopts
			)
			vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>noh<CR>", kopts)
			vim.api.nvim_set_keymap("n", "<C-o><C-o>", "<Cmd>noh<CR>", kopts)
		end,
	})
	-- Show git modification status in columns
	use({
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufNewFile" },
		requires = { "petertriho/nvim-scrollbar", opt = true },
		wants = { "nvim-scrollbar" },
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
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
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
	})

	---------------------------------
	--     LSP related plugins     --
	---------------------------------
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
	use({ "onsails/lspkind.nvim" })
	use({ "neovim/nvim-lspconfig" })
	use({
		"williamboman/mason.nvim",
		requires = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"pyright",
					"yamlls",
					"jsonls",
					"lua_ls",
					"ruff",
					"shfmt",
					"shellcheck",
					"stylua",
					"prettierd",
					"prettier",
				},
			})
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,
			})
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						-- Disable global vim warning
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	})
	-- Cool LSP UI
	use({
		"nvimdev/lspsaga.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					enable = false,
				},
				symbol_in_winbar = {
					enable = false,
				},
				scroll_preview = {
					scroll_down = "<C-d>",
					scroll_up = "<C-u>",
				},
				ui = {
					border = "rounded",
					title = true,
				},
			})
		end,
	})
	-- Formmater
	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters = {
					shfmt = {
						inherit = false,
						command = "shfmt",
						args = { "-i", "4", "-ci", "-sr", "-fn", "-filename", "$FILENAME" },
					},
				},
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = function(bufnr)
						if require("conform").get_formatter_info("ruff_format", bufnr).available then
							return { "ruff_format", "ruff_fix", "ruff_organize_imports" }
						else
							return { "isort", "black" }
						end
					end,
					sh = { "shfmt" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			})
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_format = "fallback", range = range })
			end, { range = true })
		end,
	})

	---------------------------------
	--     LSP related plugins     --
	---------------------------------
	-- AI completion
	use({
		"github/copilot.vim",
		event = { "InsertEnter" },
		setup = function()
			vim.g.copilot_no_tab_map = true
			vim.api.nvim_set_keymap("i", "<c-]>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		end,
	})
	-- use({
	-- 	"sourcegraph/sg.nvim",
	-- 	config = function()
	-- 		require("sg").setup()
	-- 	end,
	-- })

	---------------------------------
	-- Treesitter related plugins  --
	---------------------------------
	-- Better syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"David-Kunz/treesitter-unit",
			"m-demare/hlargs.nvim",
			"nvim-treesitter/playground",
		},
		run = ":TSUpdate",
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
	})

	---------------------------------
	-- FuzzyFinder related plugins --
	---------------------------------
	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "*",
		cmd = { "Telescope" },
		module = { "telescope" },
		requires = {
			{ "nvim-lua/plenary.nvim", opt = true },
			{ "nvim-tree/nvim-web-devicons", opt = true },
			{ "nvim-telescope/telescope-file-browser.nvim", opt = true },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
		},
		wants = {
			"plenary.nvim",
			"nvim-web-devicons",
			"telescope-file-browser.nvim",
			"telescope-fzf-native.nvim",
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
			keymap("n", "<C-f>d", "<cmd>Telescope diagnostics bufnr=0 severity_bound=ERROR<CR>", keymap_opts)
			keymap("n", "<C-f><C-d>", "<cmd>Telescope diagnostics severity_bound=ERROR<CR>", keymap_opts)
			keymap("n", "<C-f>*", "<cmd>Telescope grep_string<CR>", keymap_opts)
			keymap(
				"n",
				"<C-f>/",
				':lua require("telescope.builtin").live_grep({search_dirs={vim.fn.expand("%:p")}, previewer=false, path_display={shorten=1}})<CR>',
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
					selection_caret = "  ",
					shorten_path = true,
					color_devicons = true,
					winblend = 10,
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
					find_files = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 }, hidden = true }),
					live_grep = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
					buffers = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
					git_status = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
					grep_string = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
					diagnostics = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
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
	})

	---------------------------------
	--  op & obj related plugins   --
	---------------------------------
	-- Multiple cursor support
	use({
		"mg979/vim-visual-multi",
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
		end,
	})
	-- Smart repeat
	use({
		"tpope/vim-repeat",
		event = { "InsertEnter" },
	})
	-- Auto close pairs
	use({
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		config = function()
			require("nvim-autopairs").setup()
		end,
	})
	-- Better commenting
	use({
		"numToStr/Comment.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("Comment").setup()
		end,
	})
	-- Surround text objects
	use({ "machakann/vim-sandwich", event = { "InsertEnter" } })
	-- Better asterisk
	use({
		"haya14busa/vim-asterisk",
		setup = function()
			vim.cmd([[let g:asterisk#keeppos = 1]])
			vim.keymap.set("", "*", "<Plug>(asterisk-z*)", { noremap = true })
		end,
	})
	-- Stop at the end of line with w & b
	use({
		"yutkat/wb-only-current-line.nvim",
		event = { "BufRead", "BufNewFile" },
	})

	---------------------------------
	--      Git related plugins    --
	---------------------------------
	-- Git integration
	use({
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
	})
	-- Change direcotry by detecting git files
	use({
		"ahmedkhalf/project.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("project_nvim").setup({
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package.json" },
			})
		end,
	})

	---------------------------------
	--  Filetype specific plugins  --
	---------------------------------
	-- Good folding for python
	use({ "tmhedberg/SimpylFold", ft = { "python" } })
	-- Automatically add appropriate indent when writing a new line
	use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })

	---------------------------------
	--        Other plugins        --
	---------------------------------
	-- Visualize and clean trailing whitespaces
	use({
		"ntpeters/vim-better-whitespace",
		event = { "InsertEnter" },
		setup = function()
			vim.g.better_whitespace_filetypes_blacklist = { "dashboard", "help" }
		end,
	})
	-- Replace lines in quickfix
	use({
		"gabrielpoca/replacer.nvim",
		module = { "replacer" },
		setup = function()
			vim.api.nvim_create_user_command("QFReplace", 'lua require("replacer").run()', {})
		end,
	})
	-- Reflect quickfix changes in buffer
	use({
		"stefandtw/quickfix-reflector.vim",
		event = { "InsertEnter" },
	})
	-- Yank with history
	use({
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
		end,
	})
	-- Seemless navigation between tmux panes and vim splits
	use({
		"christoomey/vim-tmux-navigator",
		setup = function()
			vim.g.tmux_navigator_disable_when_zoomed = 1
		end,
	})
	-- Show color or color code in buffer
	use({
		"norcalli/nvim-colorizer.lua",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("colorizer").setup()
		end,
	})
	-- Make folding faster
	use({
		"Konfekt/FastFold",
		event = { "BufRead", "BufNewFile" },
	})
	-- Emphasize TODO comments
	use({
		"folke/todo-comments.nvim",
		event = { "BufRead", "BufNewFile" },
		requires = "nvim-lua/plenary.nvim",
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
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
