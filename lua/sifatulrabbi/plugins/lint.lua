require("lint").linters_by_ft = {
    javascript = { "eslint" },
    typescript = { "eslint" },
    typescriptreact = { "eslint" },
    vue = { "eslint" },
    go = { "golint" },
    python = { "pylint" },
    html = { "tidy" },
    json = { "jq" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
