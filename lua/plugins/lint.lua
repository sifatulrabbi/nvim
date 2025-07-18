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
                typescriptreact = { "eslint" },
                javascriptreact = { "eslint" },
                javascript = { "eslint" },
                typescript = { "eslint" },
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
            local spell_auggrp =
                vim.api.nvim_create_augroup("LintSpelling", { clear = true })

            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                group = aug,
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    timer:stop()
                    timer:start(
                        DEBOUNCE_MS,
                        0,
                        vim.schedule_wrap(function()
                            if
                                vim.api.nvim_buf_is_valid(bufnr)
                                and vim.bo[bufnr].modifiable
                            then
                                vim.api.nvim_buf_call(bufnr, function()
                                    vim.diagnostic.reset(
                                        lint.get_namespace(),
                                        bufnr
                                    )
                                    local ok, _ = pcall(lint.try_lint)
                                    if not ok then
                                        vim.notify(
                                            "Linting failed",
                                            vim.log.levels.WARN
                                        )
                                    end
                                end)
                            end
                        end)
                    )
                end,
            })

            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
                group = spell_auggrp,
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    timer:stop()
                    timer:start(
                        DEBOUNCE_MS / 2,
                        0,
                        vim.schedule_wrap(function()
                            if
                                vim.api.nvim_buf_is_valid(bufnr)
                                and vim.bo[bufnr].modifiable
                            then
                                vim.api.nvim_buf_call(bufnr, function()
                                    local ok, _ = pcall(lint.try_lint, "cspell")
                                    if not ok then
                                        -- Silently fail for spell check
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
