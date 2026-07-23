return {
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 },

	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					{ name = "Hex Lavender", colorscheme = "hex-lavender" },
					{ name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
					{ name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
					{ name = "Tokyo Night", colorscheme = "tokyonight-storm" },
					{ name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
					{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
					{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
					{ name = "Rose Pine", colorscheme = "rose-pine" },
				},
				livePreview = true,
			})
		end,
	},
}
