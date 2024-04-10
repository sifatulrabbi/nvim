return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c",
                    "cpp",
                    "go",
                    "lua",
                    "python",
                    "rust",
                    "tsx",
                    "javascript",
                    "typescript",
                    "vimdoc",
                    "vim",
                    "bash",
                    "vue",
                    "scss",
                    "css",
                    "go",
                    "make",
                    "sql",
                    "yaml",
                    "json",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<C-s>",
                        node_decremental = "<M-space>",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                    },
                },
                custom_captures = {
                    ["*.cql"] = "sql",
                },
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            max_lines = 7,
        },
        config = function()
            vim.cmd([[highlight TreesitterContext guibg=#2E3440]])
        end,
    },
}
