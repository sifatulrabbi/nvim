-- See `:help vim.keymap.set()`
-- stylua: ignore start

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set( "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set( "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set( "n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set( "n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set( "n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set( "n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Movings a selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move HL line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move HL line up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "" })

vim.keymap.set("n", "<leader>l", function() vim.cmd("Lazy") end, { desc = "Open Lazy menu" })

vim.keymap.set( "n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open [l]azy" })
vim.keymap.set("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Open [m]ason" })

local function set_dap_keymaps(dap, dapui)
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set( "n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Debug: Set Breakpoint" })
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set( "n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
end

local function set_harpoon_keymaps(harpoon)
    vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Add to harpoon list" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-y>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-m>", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<C-k>", function() harpoon:list():select(5) end)
end

local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")
if dap_ok and dapui_ok then
    set_dap_keymaps(dap, dapui)
end

local harpoon_ok, harpoon = pcall(require, "harpoon")
if harpoon_ok then
    set_harpoon_keymaps(harpoon)
end
