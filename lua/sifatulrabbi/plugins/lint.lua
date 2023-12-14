require("lint").linters_by_ft = {
    go = { "golint" },
    python = { "flake8" },
    vue = { "eslint" },
    typescriptreact = { "eslint" },
    javascriptreact = { "eslint" },
    javascript = { "eslint" },
    typescript = { "eslint" },
    html = { "htmlhint" },
    css = { "stylelint" },
    scss = { "stylelint" },
    json = { "jsonlint" },
    dockerfile = { "hadolint" },
}

-- List of linters to ensure are installed
local linters = {
    "golint",
    "flake8",
    "eslint",
    "htmlhint",
    "stylelint",
    "jsonlint",
    "hadolint",
}

local mason_lspconfig = require("mason-lspconfig")
-- check for all the linters and if not available install them
for _, linter in ipairs(linters) do
    if not mason_lspconfig.is_installed(linter) then
        mason_lspconfig.install(linter)
    end
end
