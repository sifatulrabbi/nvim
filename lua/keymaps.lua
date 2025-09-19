-- stylua: ignore start
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

-- system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Add to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p", { desc = "Paste from clipboard" })

-- quick commands and toggles
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Open [l]azy" })
vim.keymap.set("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Open [m]ason" })
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP [i]nfo" })
vim.keymap.set("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })

vim.keymap.set("n", "<C-w>t", "<cmd>tabnew<CR>", { desc = "Create new empty tab" })
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save current buffer" })

-- move between windows using Ctrl+<move key>
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>")

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open Netrw/Oil", noremap = true, silent = true })

-- make 's' act as <C-w> in normal & visual
vim.keymap.set('n', 's', '<C-w>', { noremap = true })
vim.keymap.set('v', 's', '<C-w>', { noremap = true })
-- (optional) preserve substitute on 'S'
vim.keymap.set('n', 'S', 's', { noremap = true })
