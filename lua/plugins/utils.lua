return {
    "tpope/vim-fugitive",
    -- "tpope/vim-sleuth",

    { "numToStr/Comment.nvim", opts = {} },

    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.g.barbar_auto_setup = true

            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            -- Move to previous/next
            map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
            map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
            -- Re-order to previous/next
            map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
            map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
            -- Goto buffer in position...
            map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
            map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
            map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
            map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
            map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
            map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
            map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
            map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
            map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
            map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
            -- Pin/unpin buffer
            map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
            -- Goto pinned/unpinned buffer
            --                 :BufferGotoPinned
            --                 :BufferGotoUnpinned
            -- Close buffer
            map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
            -- Wipeout buffer
            --                 :BufferWipeout
            -- Close commands
            --                 :BufferCloseAllButCurrent
            --                 :BufferCloseAllButPinned
            --                 :BufferCloseAllButCurrentOrPinned
            --                 :BufferCloseBuffersLeft
            --                 :BufferCloseBuffersRight
            -- Magic buffer-picking mode
            -- map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
            -- Sort automatically by...
            -- map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
            -- map("n", "<Space>bn", "<Cmd>BufferOrderByName<CR>", opts)
            -- map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
            -- map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
            -- map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)
        end,
        opts = {
            animation = false,
            insert_at_start = false,
            auto_hide = true,
        },
        version = "^1.0.0",
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    -- {
    --     "ThePrimeagen/harpoon",
    --     lazy = false,
    --     branch = "harpoon2",
    --     requires = { { "nvim-lua/plenary.nvim" } },
    --     opts = {},
    --     config = function()
    --         local harpoon = require("harpoon")
    --         harpoon:setup({
    --             settings = {
    --                 save_on_toggle = true,
    --                 sync_on_ui_close = true,
    --             },
    --         })
    --
    --         -- stylua: ignore start
    --         vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to harpoon list" })
    --         vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    --
    --         vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
    --         vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
    --         vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
    --         vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
    --         vim.keymap.set("n", "<A-5>", function() harpoon:list():select(5) end)
    --         vim.keymap.set("n", "<A-6>", function() harpoon:list():select(6) end)
    --         vim.keymap.set("n", "<A-7>", function() harpoon:list():select(7) end)
    --         vim.keymap.set("n", "<A-8>", function() harpoon:list():select(8) end)
    --         vim.keymap.set("n", "<A-9>", function() harpoon:list():select(9) end)
    --         vim.keymap.set("n", "<A-0>", function() harpoon:list():select(0) end)
    --     end,
    -- },
}
