local function get_fd_cmd()
  -- In Neovim, vim.fn.executable returns 1 if the command exists
  if vim.fn.executable("fd") == 1 then
    return "fd"
  end
  if vim.fn.executable("fdfind") == 1 then
    return "fdfind"
  end

  vim.notify("Neither 'fd' nor 'fdfind' was found in your PATH", vim.log.levels.ERROR)

  return "fd"
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
    },
    lazy = false,
    opts = {
      defaults = {
        layout_config = {},
      },
      pickers = {
        find_files = {
          find_command = {
            get_fd_cmd(),
            "-H",
            "-t",
            "f",
            "--exclude",
            ".git",
            "--exclude",
            "node_modules",
            "--exclude",
            ".venv",
          },
        },
        current_buffer_fuzzy_find = {
          theme = "dropdown",
        },
      },
      extensions = {
        fzf = {},
        lazygit = {},
      },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep (Root Dir)",
      },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      {
        "<leader><space>",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find Files (Root Dir)",
      },
      {
        "<leader>fb",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
        desc = "Buffers",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find Files (Root Dir)",
      },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() })
        end,
        desc = "Find Files (cwd)",
      },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>sG",
        function()
          require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
        end,
        desc = "Grep (cwd)",
      },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string({ word_match = "-w" })
        end,
        desc = "Word (Root Dir)",
      },
      {
        "<leader>sW",
        function()
          require("telescope.builtin").grep_string({ cwd = vim.fn.getcwd(), word_match = "-w" })
        end,
        desc = "Word (cwd)",
      },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string()
        end,
        mode = "v",
        desc = "Selection (Root Dir)",
      },
      {
        "<leader>sW",
        function()
          require("telescope.builtin").grep_string({ cwd = vim.fn.getcwd() })
        end,
        mode = "v",
        desc = "Selection (cwd)",
      },
      {
        "<leader>uC",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Colorscheme with Preview",
      },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
  },
}
