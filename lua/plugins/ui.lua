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
      transparent_mode = false,
    },
  },

  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   opts = {
  --     variant = "auto", -- auto, main, moon, or dawn
  --     -- dark_variant = "main", -- main, moon, or dawn
  --     dim_inactive_windows = false,
  --     extend_background_behind_borders = true,
  --
  --     enable = {
  --       terminal = true,
  --       legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
  --       migrations = true, -- Handle deprecated options automatically
  --     },
  --
  --     styles = {
  --       bold = true,
  --       italic = false,
  --       transparency = false,
  --     },
  --
  --     groups = {
  --       border = "muted",
  --       link = "iris",
  --       panel = "surface",
  --
  --       error = "love",
  --       hint = "iris",
  --       info = "foam",
  --       note = "pine",
  --       todo = "rose",
  --       warn = "gold",
  --
  --       git_add = "foam",
  --       git_change = "rose",
  --       git_delete = "love",
  --       git_dirty = "rose",
  --       git_ignore = "muted",
  --       git_merge = "iris",
  --       git_rename = "pine",
  --       git_stage = "iris",
  --       git_text = "rose",
  --       git_untracked = "subtle",
  --
  --       h1 = "iris",
  --       h2 = "foam",
  --       h3 = "rose",
  --       h4 = "gold",
  --       h5 = "pine",
  --       h6 = "foam",
  --     },
  --
  --     palette = {
  --       -- Override the builtin palette per variant
  --       -- moon = {
  --       --     base = '#18191a',
  --       --     overlay = '#363738',
  --       -- },
  --     },
  --   },
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      watch_for_changes = true,
      skip_confirm_for_simple_edits = true,
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
      float = {
        max_width = 0.5,
        max_height = 0.7,
        border = "rounded",
        win_options = { winblend = 0 },
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
      picker = { enabled = false },
      quickfile = { enabled = true },
    },
    keys = {
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Oil: Open parent",
      },
      {
        "<leader>e",
        function()
          require("oil").open_float()
        end,
        desc = "Oil: Float",
      },
    },
  },
}
