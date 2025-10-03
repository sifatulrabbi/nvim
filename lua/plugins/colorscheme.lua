return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- tell Neovim to use the light background
			vim.o.background = "dark"
			-- vim.o.background = "light"

			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true,
				contrast = "medium",
				-- flavour = "light",
				flavour = "dark",
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})

			-- apply the colorscheme
			vim.cmd("colorscheme gruvbox")
		end,
	},
}
