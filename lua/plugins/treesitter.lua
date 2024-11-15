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
                modules = {},
                ignore_install = {},
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    -- disable = function(_, buf)
                    --     local max_filesize = 100 * 1024
                    --     local ok, stats = pcall(
                    --         vim.loop.fs_stat,
                    --         vim.api.nvim_buf_get_name(buf)
                    --     )
                    --     if ok and stats and stats.size > max_filesize then
                    --         return true
                    --     end
                    --     return false
                    -- end,
                    -- indent = {
                    --     enable = true,
                    --     disable = function(_, buf)
                    --         local max_filesize = 100 * 1024
                    --         local ok, stats = pcall(
                    --             vim.loop.fs_stat,
                    --             vim.api.nvim_buf_get_name(buf)
                    --         )
                    --         if ok and stats and stats.size > max_filesize then
                    --             return true
                    --         end
                    --         return false
                    --     end,
                    -- },
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
        config = function()
            require("treesitter-context").setup({
                max_lines = 8,
                trim_scope = "outer",
                separator = "_",
            })
        end,
    },
}
