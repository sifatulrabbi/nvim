return {
    {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                go = { "golangcilint" },
                python = { "flake8" },
                vue = { "volar" },
                typescriptreact = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                html = { "htmlhint" },
                css = { "stylelint" },
                scss = { "stylelint" },
                json = { "jsonlint" },
                jsonc = { "jsonlint" },
                dockerfile = { "hadolint" },
            }

            local timer = assert(vim.uv.new_timer())
            local DEBOUNCE_MS = 500
            local aug = vim.api.nvim_create_augroup("Lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                group = aug,
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    timer:stop()
                    timer:start(
                        DEBOUNCE_MS,
                        0,
                        vim.schedule_wrap(function()
                            if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].modifiable then
                                vim.api.nvim_buf_call(bufnr, function()
                                    vim.diagnostic.reset(lint.get_namespace(), bufnr)
                                    local ok, _ = pcall(lint.try_lint)
                                    if not ok then
                                        vim.notify("Linting failed", vim.log.levels.WARN)
                                    end
                                end)
                            end
                        end)
                    )
                end,
            })
        end,
    },
}
