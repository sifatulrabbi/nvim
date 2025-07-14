return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "leoluz/nvim-dap-go",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("nvim-dap-virtual-text").setup({})
            require("mason-nvim-dap").setup({
                automatic_installation = true,
                automatic_setup = true,
                handlers = {},
                ensure_installed = {
                    "delve",
                },
            })

            dapui.setup({
                icons = {
                    expanded = "▾",
                    collapsed = "▸",
                    current_frame = "*",
                },
                controls = {
                    icons = {
                        pause = "⏸",
                        play = "▶",
                        step_into = "⏎",
                        step_over = "⏭",
                        step_out = "⏮",
                        step_back = "b",
                        run_last = "▶▶",
                        terminate = "⏹",
                        disconnect = "⏏",
                    },
                },
            })

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            require("dap-go").setup()

            -- stylua: ignore start
            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>Bb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>BB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
                { desc = "Debug: Set Breakpoint" })
            -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
        end,
    },
}
