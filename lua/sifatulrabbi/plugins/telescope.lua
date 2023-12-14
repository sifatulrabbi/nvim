-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

local ts_builtin = require("telescope.builtin")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
    -- Use the current buffer's path as the starting point for the git search
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    -- If the buffer is not associated with a file, return nil
    if current_file == "" then
        current_dir = cwd
    else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ":h")
    end

    -- Find the Git root directory from the current file's path
    local git_root = vim.fn.systemlist(
        "git -C "
            .. vim.fn.escape(current_dir, " ")
            .. " rev-parse --show-toplevel"
    )[1]
    if vim.v.shell_error ~= 0 then
        print("Not a git repository. Searching on current working directory")
        return cwd
    end
    return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        require("telescope.builtin").live_grep({
            search_dirs = { git_root },
        })
    end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- See `:help telescope.builtin`
-- stylua: ignore start
vim.keymap.set( "n", "<leader>fr", ts_builtin.oldfiles, { desc = "Find [r]ecently opened files" })
vim.keymap.set( "n", "<leader>fb", ts_builtin.buffers, { desc = "Find existing [b]uffers" })
vim.keymap.set("n", "<leader>/", function()
    ts_builtin.current_buffer_fuzzy_find( require("telescope.themes").get_dropdown({})
    )
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set( "n", "<leader>fg", ts_builtin.git_files, { desc = "Search [g]it files" })
vim.keymap.set( "n", "<leader>ff", ts_builtin.find_files, { desc = "Search [f]iles" })
vim.keymap.set( "n", "<leader>fh", ts_builtin.help_tags, { desc = "Search [h]elp" })
vim.keymap.set( "n", "<leader>fw", ts_builtin.grep_string, { desc = "Search current [w]ord" })

vim.keymap.set("n", "<leader>key", ts_builtin.keymaps, { desc = "Normal mode keymaps" })
vim.keymap.set("n", "<leader>spell", ts_builtin.spell_suggest, { desc = "Suggest spellings" })
vim.keymap.set("n", "<leader>gs", ts_builtin.git_status, { desc = "Git status" })
