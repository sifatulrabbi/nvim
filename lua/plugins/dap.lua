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
                handlers = {
                    -- Custom handler for netcoredbg
                    netcoredbg = function(config)
                        dap.adapters.coreclr = {
                            type = "executable",
                            command = vim.fn.exepath("netcoredbg")
                                or "netcoredbg",
                            args = { "--interpreter=vscode" },
                        }

                        dap.configurations.cs = {
                            {
                                type = "coreclr",
                                name = "Launch .NET Core",
                                request = "launch",
                                program = function()
                                    local cwd = vim.fn.getcwd()
                                    -- Try to find the built DLL automatically
                                    local dll_pattern = cwd
                                        .. "/bin/Debug/net8.0/*.dll"
                                    local dlls =
                                        vim.fn.glob(dll_pattern, false, true)

                                    if #dlls > 0 then
                                        -- Filter out test DLLs and pick the main one
                                        for _, dll in ipairs(dlls) do
                                            if
                                                not dll:match("test")
                                                and not dll:match("Test")
                                            then
                                                return dll
                                            end
                                        end
                                        return dlls[1] -- fallback to first DLL
                                    else
                                        return vim.fn.input(
                                            "Path to dll: ",
                                            cwd .. "/bin/Debug/net8.0/",
                                            "file"
                                        )
                                    end
                                end,
                                cwd = "${workspaceFolder}",
                                stopAtEntry = false,
                                console = "integratedTerminal",
                            },
                            {
                                type = "coreclr",
                                name = "Launch .NET Core (with args)",
                                request = "launch",
                                program = function()
                                    local cwd = vim.fn.getcwd()
                                    local dll_pattern = cwd
                                        .. "/bin/Debug/net8.0/*.dll"
                                    local dlls =
                                        vim.fn.glob(dll_pattern, false, true)

                                    if #dlls > 0 then
                                        for _, dll in ipairs(dlls) do
                                            if
                                                not dll:match("test")
                                                and not dll:match("Test")
                                            then
                                                return dll
                                            end
                                        end
                                        return dlls[1]
                                    else
                                        return vim.fn.input(
                                            "Path to dll: ",
                                            cwd .. "/bin/Debug/net8.0/",
                                            "file"
                                        )
                                    end
                                end,
                                args = function()
                                    local args_string =
                                        vim.fn.input("Program arguments: ")
                                    return vim.split(
                                        args_string,
                                        " ",
                                        { trimempty = true }
                                    )
                                end,
                                cwd = "${workspaceFolder}",
                                stopAtEntry = false,
                                console = "integratedTerminal",
                            },
                            {
                                type = "coreclr",
                                name = "Attach to process",
                                request = "attach",
                                processId = function()
                                    return tonumber(
                                        vim.fn.input("Process ID: ")
                                    )
                                end,
                            },
                        }
                    end,
                },
                ensure_installed = {
                    "delve", -- Go debugger
                    "netcoredbg", -- .NET Core debugger
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
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks", size = 0.25 },
                            { id = "watches", size = 0.25 },
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = {
                            { id = "repl", size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        size = 10,
                        position = "bottom",
                    },
                },
            })

            -- Auto open/close DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            -- Setup Go debugging
            require("dap-go").setup()

            -- Custom function to build and debug C# projects
            local function debug_dotnet()
                -- Build the project first
                vim.fn.system("dotnet build")
                if vim.v.shell_error ~= 0 then
                    vim.notify(
                        "Build failed! Fix compilation errors first.",
                        vim.log.levels.ERROR
                    )
                    return
                end

                -- Start debugging
                dap.continue()
            end

            -- Custom function for C# test debugging
            local function debug_dotnet_test()
                local test_name =
                    vim.fn.input("Test name (leave empty for all): ")
                local build_cmd = "dotnet build"

                vim.fn.system(build_cmd)
                if vim.v.shell_error ~= 0 then
                    vim.notify(
                        "Build failed! Fix compilation errors first.",
                        vim.log.levels.ERROR
                    )
                    return
                end

                -- Configure test debugging
                local test_config = {
                    type = "coreclr",
                    name = "Debug .NET Tests",
                    request = "launch",
                    program = "dotnet",
                    args = test_name == "" and { "test" }
                        or { "test", "--filter", test_name },
                    cwd = vim.fn.getcwd(),
                    stopAtEntry = false,
                    console = "integratedTerminal",
                }

                dap.run(test_config)
            end
            
            -- Key mappings
            -- stylua: ignore start
            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>Bb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>BB", function() 
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) 
            end, { desc = "Debug: Set Conditional Breakpoint" })
            vim.keymap.set("n", "<leader>Bl", function() 
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) 
            end, { desc = "Debug: Set Log Point" })
            vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: Toggle DAP UI" })
            vim.keymap.set("n", "<F6>", dap.terminate, { desc = "Debug: Terminate" })
            vim.keymap.set("n", "<F8>", dap.restart, { desc = "Debug: Restart" })
            
            -- C# specific mappings
            vim.keymap.set("n", "<leader>dn", debug_dotnet, { desc = "Debug: Build and Debug .NET" })
            vim.keymap.set("n", "<leader>dt", debug_dotnet_test, { desc = "Debug: Debug .NET Tests" })
            vim.keymap.set("n", "<leader>dr", dap.run_last, { desc = "Debug: Run Last Configuration" })
            
            -- Evaluation mappings
            vim.keymap.set("n", "<leader>de", function()
                dapui.eval(nil, { enter = true })
            end, { desc = "Debug: Evaluate Expression" })
            vim.keymap.set("v", "<leader>de", function()
                dapui.eval()
            end, { desc = "Debug: Evaluate Selection" })
            -- stylua: ignore end

            -- Set up signs for breakpoints
            vim.fn.sign_define("DapBreakpoint", {
                text = "🔴",
                texthl = "DapBreakpoint",
                linehl = "",
                numhl = "",
            })
            vim.fn.sign_define("DapBreakpointCondition", {
                text = "🟡",
                texthl = "DapBreakpoint",
                linehl = "",
                numhl = "",
            })
            vim.fn.sign_define("DapLogPoint", {
                text = "💬",
                texthl = "DapLogPoint",
                linehl = "",
                numhl = "",
            })
            vim.fn.sign_define("DapStopped", {
                text = "▶️",
                texthl = "DapStopped",
                linehl = "DapStoppedLine",
                numhl = "",
            })
            vim.fn.sign_define("DapBreakpointRejected", {
                text = "❌",
                texthl = "DapBreakpoint",
                linehl = "",
                numhl = "",
            })
        end,
    },
}
