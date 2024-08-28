return {
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
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
        end,
    },
}
