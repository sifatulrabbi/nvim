vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.guicursor = ""
vim.o.background = "dark"
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.o.timeoutlen = 300
vim.o.timeout = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 250

vim.opt.colorcolumn = "80"

-- vim.o.spell = true
-- vim.o.spelllang = "en_us"

vim.wo.conceallevel = 0

-- for transparent bg support
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- whitespace rendering
vim.opt.list = true
-- "» "
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }

vim.cmd("highlight Whitespace guifg=#3a3a41")

-- netrw options
vim.api.nvim_set_var("netrw_banner", 0)

-- custom file types
vim.filetype.add({
    extension = {
        mdx = "mdx",
        log = "log",
        conf = "conf",
        env = "dotenv",
        cql = "sql",
    },
    filename = {
        ["tsconfig.json"] = "jsonc",
    },
    -- Detect and apply filetypes based on certain patterns of the filenames
    pattern = {
        ["%.env%.[%w_.-]+"] = "dotenv",
        ["*.cql"] = "sql",
    },
})

-- LSP Diagnostic Configuration
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        source = "if_many",
    },
    float = {
        source = true,
        border = "rounded",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- LSP diagnostic signs
local signs = { Error = "x ", Warn = "⚠ ", Hint = "󰌶 ", Info = "ℹ " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    vim.diagnostic.config({ virtual_text = true })
end
