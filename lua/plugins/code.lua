return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      pyright = {},
      gopls = {},
      vtsls = {},
      eslint = {},
      clangd = {},
      zls = {},
      cspell = {},
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "x",
        },
      },
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "clangd",
        "prettier",
        "black",
        "cmake-language-server",
        "docker-compose-language-service",
        "docker-language-server",
        "nginx-language-server",
        "tailwindcss-language-server",
        "yaml-language-server",
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "ruff",
        "cspell",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      trim_scope = "outer",
      max_lines = 4,
      separator = nil,
      zindex = 20,
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        accept = {
          auto_brackets = { enabled = false },
        },
      },
    },
  },

  -- Disable auto-pairing
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    per_filetype = {
      ["html"] = {
        enable_close = false,
      },
    },
  },
}
