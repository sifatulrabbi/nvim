return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"pyright",
				"vtsls",
				"gopls",
				"omnisharp",
				"clangd",
				"ruff",
				"eslint_d",
				"golangci-lint",
				"clang-format",
				"clangtidy",
				"cpplint",
				"csharpier",
				"prettierd",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local registry = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed or {}) do
				local ok, package = pcall(registry.get_package, tool)
				if ok and not package:is_installed() then
					package:install()
				end
			end
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noselect" },
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local servers = {
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "strict",
								autoImportCompletions = true,
							},
						},
					},
				},
				vtsls = {
					settings = {
						javascript = {
							inlayHints = {
								parameterNames = { enabled = "all" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
							},
						},
						typescript = {
							inlayHints = {
								parameterNames = { enabled = "all" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
							},
						},
					},
				},
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
								shadow = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				omnisharp = {},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
					},
				},
			}

			local function inlay_hint(buf, client)
				if not client.server_capabilities.inlayHintProvider then
					return
				end
				local has_new = type(vim.lsp.inlay_hint) == "table" and type(vim.lsp.inlay_hint.enable) == "function"
				if has_new then
					vim.lsp.inlay_hint.enable(true, { bufnr = buf })
				elseif vim.lsp.buf and type(vim.lsp.buf.inlay_hint) == "function" then
					vim.lsp.buf.inlay_hint(buf, true)
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client then
						inlay_hint(event.buf, client)
					end
				end,
			})

			local function get_omnisharp_cmd()
				local ok, registry = pcall(require, "mason-registry")
				if not ok then
					return { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) }
				end
				local ok_pkg, package = pcall(registry.get_package, "omnisharp")
				if ok_pkg and package:is_installed() then
					local install_path = package:get_install_path()
					local cmd = install_path .. "/OmniSharp"
					if vim.loop.os_uname().sysname:match("Windows") then
						cmd = cmd .. ".exe"
					end
					return { cmd, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) }
				end
				return { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) }
			end

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server)
						local opts = servers[server] or {}
						opts.capabilities = capabilities
						if server == "omnisharp" then
							opts.cmd = get_omnisharp_cmd()
							opts.settings = {
								FormattingOptions = {
									enableEditorConfigSupport = true,
								},
								Msbuild = {
									LoadProjectsOnDemand = false,
								},
								RoslynExtensionsOptions = {
									enableAnalyzersSupport = true,
									enableImportCompletion = true,
									documentAnalysisTimeoutMs = 5000,
								},
							}
						end
						lspconfig[server].setup(opts)
					end,
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local lint = require("lint")
		lint.linters.csharpier_check = {
			cmd = "csharpier",
			args = { "--check" },
			stdin = false,
			append_fname = true,
			ignore_exitcode = true,
			parser = function(output)
				local diagnostics = {}
				if output == "" then
					return diagnostics
				end
				for _, line in ipairs(vim.split(output, "\n", { trimempty = true })) do
					diagnostics[#diagnostics + 1] = {
						lnum = 0,
						col = 0,
						severity = vim.diagnostic.severity.WARN,
						message = line,
						source = "csharpier",
					}
				end
				return diagnostics
			end,
		}
			lint.linters_by_ft = {
				python = { "ruff" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				go = { "golangci_lint" },
				c = { "clangtidy", "cpplint" },
				cpp = { "clangtidy", "cpplint" },
				cs = { "csharpier_check" },
			}

			local lint_group = vim.api.nvim_create_augroup("LintOnSave", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_group,
				callback = function(event)
					local ft = vim.bo[event.buf].filetype
					if lint.linters_by_ft[ft] then
						lint.try_lint()
					end
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
				formatters_by_ft = {
					python = { "ruff_format" },
					typescript = { "prettierd", "prettier" },
					typescriptreact = { "prettierd", "prettier" },
					javascript = { "prettierd", "prettier" },
					javascriptreact = { "prettierd", "prettier" },
					go = { "goimports", "gofmt" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					cs = { "csharpier" },
				},
				format_on_save = function()
					return {
						lsp_fallback = true,
						timeout_ms = 5000,
					}
				end,
			},
	},
}
