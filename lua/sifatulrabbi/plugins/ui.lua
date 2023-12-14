-- document existing key chains
require("which-key").register({
    ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
    ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
    ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
    ["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
    ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
    ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
    ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})

-- See `:help gitsigns.txt`
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    on_attach = function(bufnr)
        vim.keymap.set(
            "n",
            "<leader>hp",
            require("gitsigns").preview_hunk,
            { buffer = bufnr, desc = "Preview git hunk" }
        )

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ "n", "v" }, "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ "n", "v" }, "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
    end,
})

require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
            { "diagnostics" },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        },
        lualine_x = {
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            },
        },
        lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
            function()
                return " " .. os.date("%R")
            end,
        },
    },
})

local ibl_highlight = {
    "CursorColumn",
    "Whitespace",
}
require("ibl").setup({
    indent = {
        highlight = ibl_highlight,
        char = "",
    },
    whitespace = {
        highlight = ibl_highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
})
