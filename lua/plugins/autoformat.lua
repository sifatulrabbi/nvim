return {
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require("conform").setup({
                format_after_save = function(bufnr)
                    -- Disable autoformat on certain filetypes
                    local ignore_filetypes = { "sql" }
                    if
                        vim.tbl_contains(
                            ignore_filetypes,
                            vim.bo[bufnr].filetype
                        )
                    then
                        return
                    end

                    -- Disable with a global or buffer-local variable
                    if vim.g.disable_format or vim.b[bufnr].disable_format then
                        return
                    end

                    -- Disable autoformat for files in a certain path
                    local bufname = vim.api.nvim_buf_get_name(bufnr)
                    if
                        bufname:match("/node_modules/")
                        or bufname:match("/.venv/")
                        or bufname:match("/build/")
                        or bufname:match("/dist/")
                        or bufname:match("/.cache/")
                        or bufname:match("/__pycache__/")
                    then
                        return
                    end

                    local langtype = vim.bo[bufnr].filetype
                    if
                        langtype == "python"
                        and (bufname:match("/tambi%-backend/")) -- or bufname:match("/sequesto/")
                    then
                        return
                    end

                    return { lsp_fallback = true }
                end,

                formatters_by_ft = {
                    go = { "gofumpt", "goimports", "goimports-reviser" },
                    python = { "black" },
                    typescript = { "prettier" },
                    javascript = { "prettier" },
                    vue = { "prettier" },
                    typescriptreact = { "prettier" },
                    javascriptreact = { "prettier" },
                    json = { "prettier" },
                    jsonc = { "prettier" },
                    html = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    css = { "prettier" },
                    scss = { "prettier" },
                    lua = { "stylua" },
                    sh = { "shfmt" },
                    bash = { "shfmt" },
                    -- sql = { "sql-formatter" },
                },
            })

            local conform = require("conform")

            conform.formatters.stylua = {
                args = {
                    "--indent-type",
                    "Spaces",
                    "--indent-width",
                    "4",
                    "--column-width",
                    "80",
                    "--quote-style",
                    "ForceDouble",
                    "-",
                },
            }

            -- run conform with :Format command
            vim.api.nvim_create_user_command(
                "Format",
                require("conform").format,
                { nargs = 0 }
            )
        end,
    },
}
