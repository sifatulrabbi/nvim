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

            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set(
                        "n",
                        keys,
                        func,
                        { buffer = bufnr, desc = desc }
                    )
                end

                nmap("<leader>rn", vim.lsp.buf.rename, "Re[n]ame")
                nmap("<leader>ca", vim.lsp.buf.code_action, "Code [A]ction")
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("<leader>rr", ":LspRestart<CR>", "Restart LSP servers")
                -- stylua: ignore
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: " .. "Signature Documentation" })

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
                            goimports = true,
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
                            },
                        },
                    },
                },
                ruff = {
                    logLevel = "debug",
                },
                ts_ls = {
                    filetypes = {
                        "javascript",
                        "typescript",
                        "javascript.tsx",
                        "typescript.tsx",
                        "vue",
                        "jsx",
                        "html",
                        "twig",
                        "hbs",
                        "typescriptreact",
                        "javascriptreact",
                    },
                },
                html = {
                    filetypes = { "html", "twig", "hbs", "vue" },
                },
                cssls = {
                    filetypes = { "vue", "css", "scss" },
                },
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
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
                eslint = {},
                rust_analyzer = {},
                clangd = {},
                bashls = {
                    filetypes = { "bash", "shell", "zsh", "fish", "dotenv" },
                },
                csharp_ls = {
                    filetypes = { "csharp", "cs" },
                },
            }

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities =
                require("cmp_nvim_lsp").default_capabilities(capabilities)

            -- Ensure the servers above are installed
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                automatic_enable = false,
                ensure_installed = vim.tbl_keys(servers),
                automatic_installation = true,
            })

            -- Setting up each of the servers with configs
            local lspconfig = require("lspconfig")

            -- Setup each server individually
            for server_name, config in pairs(servers) do
                config.capabilities = capabilities
                config.on_attach = on_attach

                if lspconfig[server_name] then
                    local ok, err = pcall(lspconfig[server_name].setup, config)
                    if not ok then
                        vim.notify(
                            "Failed to setup LSP server: "
                                .. server_name
                                .. " - "
                                .. tostring(err),
                            vim.log.levels.ERROR
                        )
                    end
                else
                    vim.notify(
                        "LSP server not found: " .. server_name,
                        vim.log.levels.WARN
                    )
                end
            end
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
