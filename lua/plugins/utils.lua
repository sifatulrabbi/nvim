return {
    "tpope/vim-fugitive",
    -- "tpope/vim-sleuth",

    { "numToStr/Comment.nvim", opts = {} },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    {
        "ThePrimeagen/harpoon",
        lazy = false,
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } },
        opts = {},
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = false,
                },
            })

            -- stylua: ignore start
            vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Add to harpoon list" })
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
            vim.keymap.set("n", "<A-5>", function() harpoon:list():select(5) end)
            vim.keymap.set("n", "<A-6>", function() harpoon:list():select(6) end)
            vim.keymap.set("n", "<A-7>", function() harpoon:list():select(7) end)
            vim.keymap.set("n", "<A-8>", function() harpoon:list():select(8) end)
            vim.keymap.set("n", "<A-9>", function() harpoon:list():select(9) end)
            vim.keymap.set("n", "<A-0>", function() harpoon:list():select(0) end)
        end,
    },
}
