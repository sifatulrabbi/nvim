-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Movings a selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move HL line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move HL line up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "" })

vim.keymap.set("n", "<leader>l", function()
    vim.cmd("Lazy")
end, { desc = "Open Lazy menu" })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })

-- stylua: ignore
vim.keymap.set("n", "<leader>gf", function() vim.cmd("Git") end, { desc = "Open git fugitive" })
