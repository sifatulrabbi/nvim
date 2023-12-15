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

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    local ts_builtin = require("telescope.builtin")

    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("<leader>ds", ts_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", ts_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("gd", ts_builtin.lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", ts_builtin.lsp_references, "[G]oto [R]eferences")
    nmap("gi", ts_builtin.lsp_implementations, "[G]oto [I]mplementation")
    nmap("gD", ts_builtin.lsp_type_definitions, "Type [D]efinition")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")

    -- stylua: ignore
    vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, { desc = "Signature Documentation" })

    -- start any available linters
    require("lint").try_lint()
end

-- Enable the following language servers
local servers = {
    clangd = {},
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
    rust_analyzer = {},
    tsserver = {},
    eslint = {},
    html = { filetypes = { "html", "twig", "hbs" } },
    htmx = {},
    volar = {},
    cssls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    dockerls = {},
    docker_compose_language_service = {},
    jsonls = {},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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