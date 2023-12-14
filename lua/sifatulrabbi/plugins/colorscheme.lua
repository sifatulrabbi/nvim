require("rose-pine").setup({
    variant = "main",
    dark_variant = "main",
    dim_nc_background = false,
    disable_background = true,
    disable_float_background = false,
    disable_italics = true,
})

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

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.cmd.colorscheme("tokyonight")
