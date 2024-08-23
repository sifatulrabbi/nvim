return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                show_end_of_buffer = true,
                no_bold = true,
                transparent_background = true,
            })

            -- vim.cmd.colorscheme("catppuccin")
        end,
    },

    {
        "rose-pine/neovim",
        as = "rose-pine",
        opts = {},
        config = function()
            require("rose-pine").setup({
                variant = "main",
                dark_variant = "main",
                dim_nc_background = true,
                disable_background = true,
                disable_float_background = false,
                disable_italics = false,
            })

            vim.cmd.colorscheme("rose-pine")
        end,
    },
}
