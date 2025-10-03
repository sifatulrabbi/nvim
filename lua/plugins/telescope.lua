local function get_fd_cmd()
	-- In Neovim, vim.fn.executable returns 1 if the command exists
	if vim.fn.executable("fd") == 1 then
		return "fd"
	end
	if vim.fn.executable("fdfind") == 1 then
		return "fdfind"
	end

	vim.notify("Neither 'fd' nor 'fdfind' was found in your PATH", vim.log.levels.ERROR)

	return "fd"
end

return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				enabled = vim.fn.executable("make") == 1,
			},
		},
		lazy = false,
		opts = {
			defaults = {
				layout_config = {},
			},
			pickers = {
				find_files = {
					find_command = {
						get_fd_cmd(),
						"-H",
						"-t",
						"f",
						"--exclude",
						".git",
						"--exclude",
						"node_modules",
						"--exclude",
						".venv",
					},
				},
				current_buffer_fuzzy_find = {
					theme = "dropdown",
				},
			},
		},
		keys = {
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live [g]rep", noremap = true },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Search [f]iles", noremap = true },
			{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzily search in current buffer", noremap = true },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search [h]elp", noremap = true },
			{ "<leader>key", "<cmd>Telescope keymaps<cr>", desc = "Normal mode keymaps", noremap = true },
			{ "<leader>spl", "<cmd>Telescope spell_suggest<cr>", desc = "Suggest spellings", noremap = true },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git [s]tatus", noremap = true },
			{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP: Goto [D]efinition" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "LSP: Goto [R]eferences", noremap = true },
			{ "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP: Goto [I]mplementation", noremap = true },
			{ "gD", "<cmd>Telescope lsp_type_definitions<cr>", desc = "LSP: Type [D]efinition", noremap = true },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP: Document [S]ymbols", noremap = true },
			{ "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "LSP: Workspace [S]ymbols", noremap = true },
		},
		config = function()
			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "lazygit")
		end,
	},
}
