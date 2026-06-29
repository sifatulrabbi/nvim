local ensure_installed = {
  "pyright",
  "vtsls",
  "gopls",
  "omnisharp",
  "clangd",
  "ruff",
  "eslint_d",
  "golangci-lint",
  "clang-format",
  "cpplint",
  "csharpier",
  "prettierd",
  "black",
  "gofumpt",
  "goimports",
  "goimports-reviser",
  "prettier",
  "stylua",
  "cspell-lsp",
  "shfmt",
  "html-lsp",
  "yaml-language-server",
  "docker-compose-language-service",
  "css-lsp",
  "dockerfile-language-server",
  "lua-language-server",
  "marksman",
  "sqls",
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cspell = {},
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "x",
        },
      },
      ensure_installed = ensure_installed,
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
      },
      formatters = {
        clang_format = {
          prepend_args = {
            "--style={BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 80, UseTab: ForIndentation}",
          },
        },
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

  {
    "windwp/nvim-ts-autotag",
    enabled = false,
    -- opts = {
    --   -- Defaults
    --   enable_close = true, -- Auto close tags
    --   enable_rename = true, -- Auto rename pairs of tags
    --   enable_close_on_slash = false, -- Auto close on trailing </
    -- },
    -- -- Also override individual filetype configs, these take priority.
    -- -- Empty by default, useful if one of the "opts" global settings
    -- -- doesn't work well in a specific filetype
    -- per_filetype = {
    --   ["html"] = {
    --     enable_close = false,
    --   },
    -- },
  },
}
