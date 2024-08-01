return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = "|",
                section_separators = "",
                globalstatus = true,
            },
            sections = {
                lualine_c = {
                    { "filename", path = 1 },
                },
            },
        },
    },

    {
        "stevearc/oil.nvim",
        opts = {
            default_file_explorer = true,
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
                sort = {
                    -- sort order can be "asc" or "desc"
                    -- see :help oil-columns to see which columns are sortable
                    { "type", "asc" },
                    { "name", "asc" },
                },
                is_always_hidden = function(name, bufnr)
                    return name == ".git"
                end,
            },
            columns = {
                "icon",
                "permissions",
                "size",
                -- "mtime",
            },
            lsp_file_methods = {
                timeout_ms = 1000,
                autosave_changes = false,
            },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-S>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        configg = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require("ibl.hooks")
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup({ scope = { highlight = highlight } })
            hooks.register(
                hooks.type.SCOPE_HIGHLIGHT,
                hooks.builtin.scope_highlight_from_extmark
            )
        end,
    },

    {
        "folke/which-key.nvim",
        opts = {},
        -- config = function()
        --     require("which-key").register({
        --         ["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
        --     })
        -- end,
    },

    {
        "lewis6991/gitsigns.nvim",
        name = "gitsigns",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                on_attach = function(bufnr)
                    vim.keymap.set(
                        "n",
                        "<leader>hp",
                        require("gitsigns").preview_hunk,
                        { buffer = bufnr, desc = "Preview git hunk" }
                    )

                    -- don't override the built-in and fugitive keymaps
                    local gs = package.loaded.gitsigns
                    vim.keymap.set({ "n", "v" }, "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                        buffer = bufnr,
                        desc = "Jump to next hunk",
                    })
                    vim.keymap.set({ "n", "v" }, "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                        buffer = bufnr,
                        desc = "Jump to previous hunk",
                    })
                end,
            })
        end,
    },

    { "kyazdani42/nvim-web-devicons", opts = {} },

    { "echasnovski/mini.nvim", version = "*" },

    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 120,
                height = 1,
                options = {
                    wrap = true,
                },
            },
        },
        config = function()
            vim.api.nvim_set_keymap(
                "n",
                "<leader>z",
                "<cmd>ZenMode<CR>",
                { noremap = true, silent = true }
            )
        end,
    },
}
