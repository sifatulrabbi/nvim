require("tokyonight").setup({
    style = "storm",
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
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

vim.cmd.colorscheme("tokyonight")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
