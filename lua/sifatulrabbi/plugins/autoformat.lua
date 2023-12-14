require("conform").setup({
    format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
    },
    formatters_by_ft = {
        go = { { "gofumpt", "goimports-reviser" } },
        python = { "black" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
    },
    formatters = {
        injected = { options = { ignore_errors = true } },
    },
})
