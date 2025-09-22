return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      pyright = {},
      gopls = {},
      vtsls = {},
      ts_ls = {},
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
        "typescript-language-server",
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
}
