-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.deprecation_warnings = true
vim.opt.clipboard = ""
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.colorcolumn = "80"

vim.opt.list = true
-- "» "
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }

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

vim.o.background = "dark"
