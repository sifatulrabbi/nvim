return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "x",
                    },
                },
            })

            local on_attach = function(client, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                end

                nmap("<leader>rn", vim.lsp.buf.rename, "Re[n]ame")
                nmap("<leader>ca", vim.lsp.buf.code_action, "Code [A]ction")
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("<leader>rr", ":LspRestart<CR>", "Restart LSP servers")
                -- stylua: ignore
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: " .. "Signature Documentation" })

                -- Enable inlay hints if supported
                if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    nmap("<leader>ih", function()
                        vim.lsp.inlay_hint.enable(
                            not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                            { bufnr = bufnr }
                        )
                    end, "Toggle [i]nlay [h]ints")
                end

                -- start any available linters after a small delay to avoid conflicts
                vim.defer_fn(function()
                    local ok, lint = pcall(require, "lint")
                    if ok then
                        lint.try_lint()
                    end
                end, 100)
            end

            -- Enable the following language servers
            local servers = {
                gopls = {
                    filetypes = { "go", "gomod", "gowork", "gotmpl" },
                    settings = {
                        gopls = {
                            completeUnimported = true,
                            usePlaceholders = true,
                            analyses = {
                                unusedparams = true,
                            },
                            staticcheck = true,
                            gofumpt = true,
                        },
                    },
                },
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "workspace",
                                useLibraryCodeForTypes = true,
                                typeCheckingMode = "basic",
                                autoImportCompletions = true,
                                indexing = true,
                            },
                        },
                    },
                },
                ts_ls = {
                    filetypes = {
                        "javascript",
                        "typescript",
                        "typescriptreact",
                        "javascriptreact",
                    },
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                    },
                },
                html = {
                    filetypes = { "html", "twig", "hbs", "vue" },
                },
                cssls = {
                    filetypes = {
                        "vue",
                        "css",
                        "scss",
                        "html",
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                        },
                    },
                },
                jsonls = {
                    filetypes = { "json", "jsonc" },
                },
                sqls = {
                    filetypes = { "sql", "cql" },
                },
                dockerls = {},
                docker_compose_language_service = {},
                rust_analyzer = {
                    filetypes = { "rust", "cargo" },
                },
                clangd = {},
                bashls = {
                    filetypes = { "bash", "shell", "zsh", "fish", "dotenv" },
                },
                omnisharp = {
                    filetypes = { "cs", "csharp" },
                    settings = {
                        FormattingOptions = {
                            OrganizeImports = true,
                        },
                        RoslynExtensionsOptions = {
                            EnableAnalyzersSupport = true,
                            EnableImportCompletion = true,
                        },
                    },
                    init_options = {
                        autoStart = true,
                    },
                },
                yamlls = {
                    filetypes = { "yaml", "yml" },
                },
                tailwindcss = {
                    filetypes = {
                        "html",
                        "css",
                        "scss",
                        "vue",
                        "typescriptreact",
                        "javascriptreact",
                    },
                },
                ruff = {
                    filetypes = { "python" },
                    init_options = {
                        settings = {
                            args = {
                                "--ignore=E501",
                            },
                        },
                    },
                },
                marksman = {
                    filetypes = { "markdown" },
                    settings = {
                        marksman = {
                            completion = {
                                wiki = {
                                    style = "title",
                                },
                            },
                        },
                    },
                },
                cspell = { filetypes = { "*" } }
            }

            local uv = vim.uv or vim.loop

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            -- Enable additional modern LSP capabilities
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.completion.completionItem.resolveSupport = {
                properties = { "documentation", "detail", "additionalTextEdits" },
            }
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
            if capabilities.textDocument.semanticTokens then
                capabilities.textDocument.semanticTokens.multilineTokenSupport = true
            end

            -- Ensure the servers above are installed
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
                automatic_installation = true,
            })

            -- Setup each server individually
            mason_lspconfig.setup_handlers({
                function(server_name)
                    local config = servers[server_name] or {}
                    config.on_attach = on_attach
                    config.capabilities = capabilities
                    require("lspconfig")[server_name].setup(config)
                end,
            })
        end,
    },

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
