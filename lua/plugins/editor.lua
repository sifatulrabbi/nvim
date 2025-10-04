return {
    { "tpope/vim-fugitive" },
    -- "tpope/vim-sleuth",

    { "numToStr/Comment.nvim", opts = {} },

    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        version = false,
        init = function()
            vim.g.barbar_auto_setup = true
        end,
        opts = {
            animation = false,
            insert_at_start = false,
            auto_hide = false,
        },
        keys = {
            -- Move to previous/next
            { "g,",         "<Cmd>BufferPrevious<CR>",           noremap = true, silent = true },
            { "g.",         "<Cmd>BufferNext<CR>",               noremap = true, silent = true },
            -- Re-order to previous/next
            { "g<",         "<Cmd>BufferMovePrevious<CR>",       noremap = true, silent = true },
            { "g>",         "<Cmd>BufferMoveNext<CR>",           noremap = true, silent = true },
            -- Goto buffer in position...
            { "g1",         "<Cmd>BufferGoto 1<CR>",             noremap = true, silent = true },
            { "g2",         "<Cmd>BufferGoto 2<CR>",             noremap = true, silent = true },
            { "g3",         "<Cmd>BufferGoto 3<CR>",             noremap = true, silent = true },
            { "g4",         "<Cmd>BufferGoto 4<CR>",             noremap = true, silent = true },
            { "g5",         "<Cmd>BufferGoto 5<CR>",             noremap = true, silent = true },
            { "g6",         "<Cmd>BufferGoto 6<CR>",             noremap = true, silent = true },
            { "g7",         "<Cmd>BufferGoto 7<CR>",             noremap = true, silent = true },
            { "g8",         "<Cmd>BufferGoto 8<CR>",             noremap = true, silent = true },
            { "g9",         "<Cmd>BufferGoto 9<CR>",             noremap = true, silent = true },
            { "g0",         "<Cmd>BufferGoto 10<CR>",            noremap = true, silent = true },
            -- Pin/unpin buffer
            { "<leader>bp", "<Cmd>BufferPin<CR>",                noremap = true, silent = true },
            -- Close buffer
            { "<leader>bc", "<Cmd>BufferClose<CR>",              noremap = true, silent = true },
            -- Wipeout buffer
            --                 :BufferWipeout
            -- Other close commands
            --                 :BufferCloseAllButCurrent
            { "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", noremap = true, silent = true },
            --                 :BufferCloseAllButPinned
            --                 :BufferCloseAllButCurrentOrPinned
            --                 :BufferCloseBuffersLeft
            --                 :BufferCloseBuffersRight
            -- Magic buffer-picking mode
            { "<leader>fb", "<Cmd>BufferPick<CR>",               noremap = true, silent = true },
            -- Sort automatically by...
            -- { "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", silent = true, noremap = true }
            -- { "<leader>bn", "<Cmd>BufferOrderByName<CR>", silent = true, noremap = true }
            -- { "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", silent = true, noremap = true }
            -- { "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", silent = true, noremap = true }
            -- { "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", silent = true, noremap = true }
        },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        opts = {
            modes = {
                lsp = {
                    win = { position = "right" },
                },
            },
        },
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>xS",
                "<cmd>Trouble lsp toggle<cr>",
                desc = "LSP references/definitions/... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").prev({
                            skip_groups = true,
                            jump = true,
                        })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous Trouble/Quickfix Item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({
                            skip_groups = true,
                            jump = true,
                        })
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next Trouble/Quickfix Item",
            },
        },
    },

    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
}
