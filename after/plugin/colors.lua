require('rose-pine').setup({
    variant = 'main',
    dark_variant = 'main',
    dim_nc_background = false,
    disable_background = true,
    disable_float_background = true,
    disable_italics = true,
})

function ColorMyNvim()
    vim.cmd.colorscheme 'rose-pine'
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyNvim()
