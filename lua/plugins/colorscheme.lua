return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                terminal_colors = true,
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,
                contrast = "soft",
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
            vim.cmd.colorscheme("gruvbox")
        end,
    },

    -- {
    --     "sainnhe/gruvbox-material",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.g.gruvbox_material_enable_italic = 1
    --         vim.g.gruvbox_material_background = "soft"
    --         vim.g.gruvbox_material_disable_italic_comment = 1
    --         vim.g.gruvbox_material_better_performance = 1
    --
    --         vim.cmd.colorscheme("gruvbox-material")
    --         -- fix: gruvbox-material not showing visual bg
    --         -- vim.api.nvim_set_hl(0, "Visual", { bg = "#504945" })
    --     end,
    -- },

    -- {
    --     "rose-pine/neovim",
    --     as = "rose-pine",
    --     opts = {},
    --     config = function()
    --         require("rose-pine").setup({
    --             variant = "dawn",
    --             -- dim_nc_background = true,
    --             disable_background = true,
    --             disable_float_background = true,
    --
    --             enable = {
    --                 terminal = true,
    --                 legacy_highlights = true,
    --                 migrations = true,
    --             },
    --
    --             styles = {
    --                 bold = true,
    --                 italic = true,
    --                 transparency = true,
    --             },
    --         })
    --
    --         vim.cmd.colorscheme("rose-pine")
    --     end,
    -- },
}
