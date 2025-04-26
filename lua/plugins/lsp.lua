return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
            require("mason-lspconfig").setup()
            require("neodev").setup()

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

                -- start any available linters
                -- require("lint").try_lint()
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
                volar = {
                    filetypes = { "vue" },
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
                bashls = {},
                csharp_ls = { "csharp" },
            }

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities =
                require("cmp_nvim_lsp").default_capabilities(capabilities)

            -- Ensure the servers above are installed
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
            })

            mason_lspconfig.setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    })
                end,
            })
        end,
    },

    -- { "jose-elias-alvarez/typescript.nvim", opts = {} },
}
