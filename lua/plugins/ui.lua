return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
        sort = {
          -- sort order can be "asc" or "desc"
          -- see :help oil-columns to see which columns are sortable
          { "type", "asc" },
          { "name", "asc" },
        },
        is_always_hidden = function(name, bufnr)
          -- Oil will display all the files of a directory
          return false
        end,
      },
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      lsp_file_methods = {
        timeout_ms = 1000,
        autosave_changes = false,
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-S>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      picker = { enabled = true },
      quickfile = { enabled = true },
    },
    keys = {
      { "<leader>e", "<cmd>Oil<CR>", desc = "File Explorer" },
    },
  },

  {
    "jameswolensky/marker-groups.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("marker-groups").setup({
        -- picker = "vim",
        picker = "telescope",
      })
    end,
  },
}
