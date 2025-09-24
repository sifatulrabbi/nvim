-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.deprecation_warnings = true
vim.opt.clipboard = ""
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.colorcolumn = "80"
vim.o.background = "dark"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = { "shift:2" } -- 2 spaces extra
vim.opt.list = true
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }
vim.opt.spell = true
vim.opt.spelllang = "en_us"
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

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldenable = true
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
