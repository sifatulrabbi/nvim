return {
    {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                go = { "golint" },
                python = { "pyflake", "flake8" },
                vue = { "eslint", "volar" },
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

            local function run_linters()
                lint.try_lint()
                lint.try_lint("cspell")
            end

            local timer = assert(vim.uv.new_timer())
            local DEBOUNCE_MS = 500
            local aug = vim.api.nvim_create_augroup("Lint", { clear = true })

            vim.api.nvim_create_autocmd(
                { "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" },
                {
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
                                        run_linters()
                                    end)
                                end
                            end)
                        )
                    end,
                }
            )
        end,
    },
}
