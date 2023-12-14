require("tokyonight").setup({
    style = "storm",
    styles = {
        comments = {
            italic = true,
        },
        keywords = {
            italic = true,
        },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
    },
    transparent = true,
})

require("gruvbox").setup({
    italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = true,
    },
    bold = false,
    transparent_mode = true,
    overrides = {
        String = { fg = "#aaaaaa" },
    },
})

vim.cmd.colorscheme("gruvbox")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
